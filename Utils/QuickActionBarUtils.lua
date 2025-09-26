---@class AddonPrivate
local Private = select(2, ...)

---@class QuickActionBarUtils
---@field callbackUtils CallbackUtils
local quickActionBarUtils = {
    callbackUtils = nil
}
Private.QuickActionBarUtils = quickActionBarUtils

local const = Private.constants
local qaConst = const.QUICK_ACTION_BAR

---@class QuickActionObject : QuickActionMixin

---@class QuickActionMixin
---@field actionType QA_ACTION_TYPE
---@field actionID number|nil
---@field customCode string|nil
local quickActionMixin = {
    actionType = qaConst.ACTION_TYPE.NONE,
    actionID = nil,
    customCode = nil,
}

---@return QA_ACTION_TYPE actionType
function quickActionMixin:GetActionType()
    return self.actionType
end

---@param actionType QA_ACTION_TYPE
function quickActionMixin:SetActionType(actionType)
    self.actionType = actionType
end

---@return number|nil actionID
function quickActionMixin:GetActionID()
    return self.actionID
end

---@return string|nil customCode
function quickActionMixin:GetCustomCode()
    return self.customCode
end

function quickActionBarUtils:Init()
    self.callbackUtils = Private.CallbackUtils
end

function quickActionBarUtils:GetActions()
    return {}
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
