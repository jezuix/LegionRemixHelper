---@class AddonPrivate
local Private = select(2, ...)

---@class CachedUnitPowerObject : CachedUnitPowerMixin

---@class CachedUnitPowerMixin
local cachedUnitPowerMixin = {
    ---@type WOWGUID
    guid = nil,
    ---@type number
    power = 0,
    ---@type number
    timestamp = 0,
}

---@param guid WOWGUID
---@param power number
---@param timestamp number
---@return table
local function CreateCachedUnitPowerObject(guid, power, timestamp)
    local obj = {}
    setmetatable(obj, { __index = cachedUnitPowerMixin })
    obj.guid = guid
    obj.power = power
    obj.timestamp = timestamp
    return obj
end

local const = Private.constants

---@class TooltipUtils
local tooltipUtils = {
    ---@type LegionRH
    addon = nil,
    ---@type table<WOWGUID, CachedUnitPowerObject>
    cachedPower = {},
    ---@type CommsUtils
    comms = nil,
    ---@type table<WOWGUID, number>
    lastRequestSent = {},
}
Private.TooltipUtils = tooltipUtils

---@param unit UnitToken.base
---@return AuraData?
function tooltipUtils:GetThreadsBuff(unit)
    return C_UnitAuras.GetAuraDataBySpellName(unit, const.TOOLTIP.THREADS_BUFF_NAME)
end

---@param unit UnitToken.base
---@return number totalThreads
function tooltipUtils:GetThreadsCount(unit)
    local threadsAura = self:GetThreadsBuff(unit)
    if not threadsAura then return 0 end
    local total = 0
    for _, threadCount in ipairs(threadsAura.points) do
        total = total + (threadCount or 0)
    end
    return total
end

---@param unit UnitToken.base
---@return number? cachedPower
function tooltipUtils:SendPowerRequest(unit)
    local timeNow = GetTime()
    local guid = UnitGUID(unit)
    if not guid then return end

    local cached = self.cachedPower[guid]
    if cached and cached.timestamp > timeNow - (600) then -- cache for 10 minutes
        return cached.power
    end

    local lastSent = self.lastRequestSent[guid] or 0
    local target = self.comms:GetTargetFromUnitToken(unit)
    if target and timeNow - lastSent > 600 then
        self.lastRequestSent[guid] = timeNow
        self.comms:SendMessage(const.TOOLTIP.COMMS_PREFIX.REQUEST_DATA, {}, "WHISPER", target)
    end
end

---@param data { power: number, unitGUID: WOWGUID }
function tooltipUtils:OnPowerRequestResponse(data)
    self.cachedPower[data.unitGUID] = CreateCachedUnitPowerObject(data.unitGUID, data.power, GetTime())
    if not GameTooltip:IsVisible() then return end
    local unit = select(2, GameTooltip:GetUnit())
    if not unit then return end
    if UnitGUID(unit) ~= data.unitGUID then return end

    self:RefreshTooltip()
end

---@param unit UnitToken.base
---@return number minEstimate, number maxEstimate
function tooltipUtils:GetInfinitePowerEstimate(unit)
    local minEstimate = 0
    local maxEstimate = const.TOOLTIP.POWER_VERS_START + const.TOOLTIP.POWER_PER_VERS

    local threadsAura = self:GetThreadsBuff(unit)
    if not threadsAura then return minEstimate, maxEstimate end
    local vers = threadsAura.points[const.TOOLTIP.VERS_INDEX] or 0
    if vers > 0 then
        minEstimate = maxEstimate + ((vers - 1) * const.TOOLTIP.POWER_PER_VERS)
        maxEstimate = maxEstimate + (vers * const.TOOLTIP.POWER_PER_VERS)
    end

    return minEstimate, maxEstimate
end

---@param mode "activate"|"threads"|"power"
function tooltipUtils:IsModeActive(mode)
    mode = mode or "activate"
    return self.addon:GetDatabaseValue("tooltip."..mode, true)
end

function tooltipUtils:RefreshTooltip()
    local tooltip = GameTooltip
    if not tooltip or not tooltip:IsVisible() then return end
    local unit = select(2, tooltip:GetUnit())
    if not unit then return end
    tooltip:SetUnit(unit)
end

---@return fun(tooltip: GameTooltip)
function tooltipUtils:GetTooltipPostCall()
    return function(tooltip)
        local generalActive = self:IsModeActive("activate")
        if not generalActive then return end
        local threadsActive = self:IsModeActive("threads")
        local powerActive = self:IsModeActive("power")
        if not (threadsActive or powerActive) then return end
        local unit = select(2, tooltip:GetUnit())
        if not unit then return end

        tooltip:AddLine(" ")
        if threadsActive then
            tooltip:AddDoubleLine("Threads", self:GetThreadsCount(unit))
        end
        if powerActive then
            local lineTitle = "Infinite Power"
            local powerText = ""
            local power = self:SendPowerRequest(unit)
            if not power then
                lineTitle = lineTitle .. " (Estimate)"
                local minEstimate, maxEstimate = self:GetInfinitePowerEstimate(unit)
                powerText = ("%s-%s"):format(AbbreviateNumbers(minEstimate), AbbreviateNumbers(maxEstimate))
            else
                powerText = AbbreviateNumbers(power)
            end
            tooltip:AddDoubleLine(lineTitle, powerText)
        end
    end
end

function tooltipUtils:Init()
    local playerGUID = UnitGUID("player")
    self.addon = Private.Addon
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, self:GetTooltipPostCall())
    self.comms = Private.CommsUtils

    self.comms:AddCallback(const.TOOLTIP.COMMS_PREFIX.SEND_DATA, function (data)
        self:OnPowerRequestResponse(data)
    end)
    self.comms:AddCallback(const.TOOLTIP.COMMS_PREFIX.REQUEST_DATA, function (data)
        if not (data and data.sender) then return end
        local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(const.TOOLTIP.POWER_CURRENCY_ID)
        if not currencyInfo then return end
        local response = {
            unitGUID = playerGUID,
            power = currencyInfo.quantity,
        }
        self.comms:SendMessage(const.TOOLTIP.COMMS_PREFIX.SEND_DATA, response, "WHISPER", data.sender)
    end)
end

function tooltipUtils:CreateSettings()
    local settingsUtils = Private.SettingsUtils
    local settingsCategory = settingsUtils:GetCategory()
    local settingsPrefix = "Tooltip-Power"

    settingsUtils:CreateHeader(settingsCategory, "Tooltip-Power", "Settings for the Tooltip-Power feature",
        { settingsPrefix })
    settingsUtils:CreateCheckbox(settingsCategory, "TOOLTIP_POWER_ACTIVATE", "BOOLEAN", "Activate Tooltip Information",
        "Show Tooltip-Power information", false,
        settingsUtils:GetDBFunc("GETTERSETTER", "tooltip.activate"))
    settingsUtils:CreateCheckbox(settingsCategory, "TOOLTIP_POWER_THREADS", "BOOLEAN", "Threads Information",
        "Show Tooltip-Power Threads information", false,
        settingsUtils:GetDBFunc("GETTERSETTER", "tooltip.threads"))
    settingsUtils:CreateCheckbox(settingsCategory, "TOOLTIP_POWER_POWER", "BOOLEAN", "Power Information",
        "Show Tooltip-Power Infinite Power information", false,
        settingsUtils:GetDBFunc("GETTERSETTER", "tooltip.power"))
end
