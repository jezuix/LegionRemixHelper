---@class AddonPrivate
local Private = select(2, ...)

---@alias SettingsUtilsTypes
---|"BOOLEAN"
---| "NUMBER"
---| "STRING"

---@class SettingsDropdownOption
---@field key string
---@field text string

---@class SettingsUtils
---@field addon LegionRH
---@field category any
local settingsUtils = {
    addon = nil,
    category = nil,
}
Private.SettingsUtils = settingsUtils

local const = Private.constants
local typeConst = const.SETTINGS.TYPES

---@param funcType "GETTER" | "SETTER" | "GETTERSETTER"
---@param setting string
---@param default any
---@return function|nil, function|nil
function settingsUtils:GetDBFunc(funcType, setting, default)
    if funcType == "GETTER" then
        return function()
            return self.addon:GetDatabaseValue(setting, true) or default
        end
    elseif funcType == "SETTER" then
        return function(...)
            local newValue = select(3, ...)
            self.addon:SetDatabaseValue(setting, newValue)
        end
    elseif funcType == "GETTERSETTER" then
        return self:GetDBFunc("GETTER", setting, default), self:GetDBFunc("SETTER", setting)
    end
end

function settingsUtils:Init()
    local addon = Private.Addon
    self.addon = addon

    local category = Settings.RegisterVerticalLayoutCategory(addon.DisplayName)
    Settings.RegisterAddOnCategory(category)
    self.category = category

    self:CreatePanel(category, "BackdropTemplate", {}, 50, function(frame)
        ---@cast frame BackdropTemplate|Frame
        frame:SetBackdrop({
            bgFile = "interface/buttons/white8x8",
            edgeFile = "interface/buttons/white8x8",
            edgeSize = 2,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        frame:SetBackdropColor(0, 0, 0, 0.5)
        frame:SetBackdropBorderColor(1, 1, 1, 0.5)
        local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
        title:SetText(addon.DisplayName .. " v" .. tostring(addon.Version))

        local desc = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -5)
        desc:SetPoint("RIGHT", frame, "RIGHT", -10, 0)
        desc:SetJustifyH("LEFT")
        desc:SetJustifyV("TOP")
        desc:SetText("This is where the settings will be shown for " .. addon.DisplayName .. ".")
    end,
    function()
        print(addon.DisplayName .. " settings panel defaulted.")
    end)
end

---@param category any
---@param lookup string
---@param varType SettingsUtilsTypes
---@param title string
---@param tooltip string?
---@param default any
---@param getter fun(): any
---@param setter fun(newValue: any)
---@return table initializer, table options
function settingsUtils:CreateCheckbox(category, lookup, varType, title, tooltip, default, getter, setter)
    local setting = Settings.RegisterProxySetting(category, lookup,
        typeConst[varType], title, default, getter, setter)
    return Settings.CreateCheckbox(category, setting, tooltip)
end

---@param category any
---@param lookup string
---@param varType SettingsUtilsTypes
---@param title string
---@param tooltip string?
---@param default any
---@param minValue number
---@param maxValue number
---@param step number
---@param getter fun(): any
---@param setter fun(newValue: any)
---@return table initializer, table options
function settingsUtils:CreateSlider(category, lookup, varType, title, tooltip, default, minValue, maxValue, step, getter,
                                    setter)
    local setting = Settings.RegisterProxySetting(category, lookup,
        typeConst[varType], title, default, getter, setter)
    local options = Settings.CreateSliderOptions(minValue, maxValue, step)
    options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
    local initializer = Settings.CreateSlider(category, setting, options, tooltip)

    return initializer, options
end

---@param category any
---@param lookup string
---@param varType SettingsUtilsTypes
---@param title string
---@param tooltip string?
---@param default any
---@param options SettingsDropdownOption[]
---@param getter fun(): any
---@param setter fun(newValue: any)
---@return table initializer
function settingsUtils:CreateDropdown(category, lookup, varType, title, tooltip, default, options, getter, setter)
    local setting = Settings.RegisterProxySetting(category, lookup,
        typeConst[varType], title, default, getter, setter)

    local function getOptions()
        local container = Settings.CreateControlTextContainer()
        for _, option in ipairs(options) do
            container:Add(option.key, option.text)
        end
        return container:GetData()
    end
    return Settings.CreateDropdown(category, setting, getOptions, tooltip)
end

---@param category any
---@param initializer any
---@return table layout
function settingsUtils:AddToCategoryLayout(category, initializer)
    local layout = SettingsPanel:GetLayout(category)
    layout:AddInitializer(initializer)
    return layout
end

---@param category any
---@param title string
---@param text string
---@param onClick fun()
---@param tooltip string?
---@param addToSearch boolean?
---@return table initializer
function settingsUtils:CreateButton(category, title, text, onClick, tooltip, addToSearch)
    local initializer = CreateSettingsButtonInitializer(title, text, onClick, tooltip, addToSearch)
    settingsUtils:AddToCategoryLayout(category, initializer)
    return initializer
end

---@param category any
---@param title string
---@return table initializer
function settingsUtils:CreateHeader(category, title)
    local initializer = CreateSettingsListSectionHeaderInitializer(title)
    settingsUtils:AddToCategoryLayout(category, initializer)
    return initializer
end

---@return table category
function settingsUtils:GetCategory()
    return self.category
end

---@param category table
---@param template string?
---@param data table?
---@param height number?
---@param onInit fun(frame: Frame, data: table?)
---@param onDefaulted fun()?
---@return table initializer
function settingsUtils:CreatePanel(category, template, data, height, onInit, onDefaulted)
    local initializer = Settings.CreatePanelInitializer(template or "BackdropTemplate", data or {})

    function initializer:GetExtent()
        return self.height
    end

    function initializer:SetHeight(newHeight)
        self.height = newHeight
    end

    function initializer:InitFrame(frame)
        if self.onInit then
            self.onInit(frame, self.data)
        end
    end

    function initializer:SetOnInit(callback)
        self.onInit = callback
    end

    function initializer:TriggerOnDefaulted()
        if self.onDefaulted then
            self.onDefaulted()
        end
    end

    function initializer:SetOnDefaulted(callback)
        self.onDefaulted = callback
    end

    EventRegistry:RegisterCallback("Settings.Defaulted", function()
        initializer:TriggerOnDefaulted()
    end)
    EventRegistry:RegisterCallback("Settings.CategoryDefaulted", function(_, defaultedCategory)
        if defaultedCategory:GetID() == category:GetID() then
            initializer:TriggerOnDefaulted()
        end
    end)

    initializer:SetHeight(height or 200)
    initializer:SetOnInit(onInit)
    initializer:SetOnDefaulted(onDefaulted)

    self:AddToCategoryLayout(category, initializer)
    return initializer
end
