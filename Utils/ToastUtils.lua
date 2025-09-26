---@class AddonPrivate
local Private = select(2, ...)

---@class ToastUtils
local toastUtils = {
    toastPool = {}
}
Private.ToastUtils = toastUtils

local const = Private.constants

function toastUtils:GetFromToastPool()
    local toastFrame tremove(self.toastPool)
    if not toastFrame then
        toastFrame = self:CreateToastFrame()
    end
    return toastFrame
end

function toastUtils:CreateToastFrame()
    local toastFrame = CreateFrame("Frame", nil, UIParent)
    toastFrame:Hide()
    return toastFrame
end

function toastUtils:Init()
    local addon = Private.Addon
end
