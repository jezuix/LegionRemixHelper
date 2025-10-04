---@class AddonPrivate
local Private = select(2, ...)

---@class ToastUtils
---@field ui ToastUI
local toastUtils = {
    ui = nil
}
Private.ToastUtils = toastUtils

local const = Private.constants

function toastUtils:Init()
    self:CreateSettings()
end

function toastUtils:CreateSettings()
    local settingsUtils = Private.SettingsUtils
    local settingsCategory = settingsUtils:GetCategory()
    local settingsPrefix = "Toasts"

    settingsUtils:CreateHeader(settingsCategory, "Toasts", "Settings for the Toast feature",
        { settingsPrefix })
    settingsUtils:CreateCheckbox(settingsCategory, "ACTIVATE_TOAST", "BOOLEAN", "Activate Toast",
        "Show toast notifications.", true,
        settingsUtils:GetDBFunc("GETTERSETTER", "toast.activate"))
    settingsUtils:CreateButton(settingsCategory, "Test Toast",
        "Test Toast Notification",
        function()
            self:ShowToast("Test Toast", "This is a test toast notification.", 5228749)
        end,
        "Show a test toast notification",
        true)
end

---@param title string
---@param description string
---@param texture number|string
function toastUtils:ShowToast(title, description, texture)
    Private.ToastUI:ShowToast(title, description, texture)
end
