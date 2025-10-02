---@class AddonPrivate
local Private = select(2, ...)

---@class QuickActionBarUtils
---@field callbackUtils CallbackUtils
---@field actions QuickActionObject[]
local quickActionBarUtils = {
    callbackUtils = nil,
    actions = {},
}
Private.QuickActionBarUtils = quickActionBarUtils

local const = Private.constants
local qaConst = const.QUICK_ACTION_BAR

---@class QuickActionObject : QuickActionMixin

---@class QuickActionMixin
---@field actionType QA_ACTION_TYPE
---@field actionID number|nil
---@field customCode string|nil
---@field checkVisibility (fun(self:QuickActionObject):shouldShow:boolean)?
---@field icon number|string|?
local quickActionMixin = {
    actionType = qaConst.ACTION_TYPE.NONE,
    actionID = nil,
    customCode = nil,
    checkVisibility = nil,
    icon = nil,
}

---@return QA_ACTION_TYPE? actionType
function quickActionMixin:GetActionType()
    return self.actionType
end

---@param actionType QA_ACTION_TYPE?
function quickActionMixin:SetActionType(actionType)
    self.actionType = actionType
end

---@return number|nil actionID
function quickActionMixin:GetActionID()
    return self.actionID
end

---@param id number|string|?
function quickActionMixin:SetActionID(id)
    self.actionID = id
end

---@return string|nil customCode
function quickActionMixin:GetCustomCode()
    return self.customCode
end

---@param codeStr string|nil
function quickActionMixin:SetCustomCode(codeStr)
    self.customCode = codeStr
end

---@return string|number? icon
function quickActionMixin:GetIcon()
    if self.icon then
        return self.icon
    end

    local actionID = self:GetActionID()
    if not actionID then return end

    local actionType = self:GetActionType()

    if actionType == qaConst.ACTION_TYPE.ITEM then
        return C_Item.GetItemIconByID(actionID)
    elseif actionType == qaConst.ACTION_TYPE.SPELL then
        local icon = C_Spell.GetSpellTexture(actionID)
        return icon
    end
end

---@param icon string|number|?
function quickActionMixin:SetIconOverride(icon)
    self.icon = icon
end

---@return boolean shouldShow
function quickActionMixin:GetVisibility()
    if self.checkVisibility then
        return self:checkVisibility()
    end
    return true
end

---@param func (fun(self:QuickActionObject):shouldShow:boolean)?
function quickActionMixin:SetVisbilityFunc(func)
    self.checkVisibility = func
end

function quickActionBarUtils:Init()
    self.callbackUtils = Private.CallbackUtils
end

---@return function
function quickActionBarUtils:GetOnDefaulted()
    return function ()
        Private.Addon:Print("Addon Settings Defaulted [TODO: code Logic for this Placeholder]")
    end
end

function quickActionBarUtils:CreateSettings()
    local settingsUtils = Private.SettingsUtils
    local settingsCategory = settingsUtils:GetCategory()
    local settingsPrefix = "Quick Action Bar"

    settingsUtils:CreateHeader(settingsCategory, "Quick Action Bar", "Settings for the Quick Action Bar", {settingsPrefix})
    settingsUtils:CreatePanel(settingsCategory, nil, nil, 400, Private.QuickActionBarUI:GetTreeSettingsInitializer(), self:GetOnDefaulted(), {settingsPrefix})
end

---@return QuickActionObject[]
function quickActionBarUtils:GetActions()
    local visibleActions = {}

    for _, action in ipairs(self.actions) do
        if action:GetVisibility() then
            tinsert(visibleActions, action)
        end
    end

    return visibleActions
end

---@param actionType QA_ACTION_TYPE?
---@param actionID string|number|nil
---@param iconOverride string|number|nil
---@param visibilityFunc (fun(self:QuickActionObject):shouldShow:boolean)?
---@return QuickActionObject
function quickActionBarUtils:CreateAction(actionType, actionID, iconOverride, visibilityFunc)
    local obj = {}
    setmetatable(obj, { __index = quickActionMixin })
    ---@cast obj QuickActionObject

    obj:SetActionType(actionType)
    obj:SetActionID(actionID)
    obj:SetIconOverride(iconOverride)
    obj:SetVisbilityFunc(visibilityFunc)

    tinsert(self.actions, obj)
    return obj
end

---@param callbackFunction fun(actions: QuickActionObject[])
---@return CallbackObject|nil callbackObject
function quickActionBarUtils:AddCallback(callbackFunction)
    return self.callbackUtils:AddCallback(const.QUICK_ACTION_BAR.CALLBACK_CATEGORY, callbackFunction)
end

---@param callbackObj CallbackObject
function quickActionBarUtils:RemoveCallback(callbackObj)
    self.callbackUtils:RemoveCallback(callbackObj)
end

function quickActionBarUtils:TriggerCallbacks()
    local callbacks = self.callbackUtils:GetCallbacks(const.QUICK_ACTION_BAR.CALLBACK_CATEGORY)
    local actions = self:GetActions()
    for _, callback in ipairs(callbacks) do
        callback:Trigger(actions)
    end
end
