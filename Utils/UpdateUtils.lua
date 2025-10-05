---@class AddonPrivate
local Private = select(2, ...)

local const = Private.constants

---@class UpdateUtils
local updateUtils = {
    ---@type LegionRH
    addon = nil
}
Private.UpdateUtils = updateUtils

function updateUtils:OnEnable()
    local addon = Private.Addon
    self.addon = addon

    local dbVersion = addon:GetDatabaseValue("version", true)

    if dbVersion ~= const.ADDON_VERSION then
        addon:SetDatabaseValue("version", const.ADDON_VERSION)
        self:ShowPatchNotes(dbVersion, const.ADDON_VERSION)
    end
end

---@param oldVersion string|nil
---@param newVersion string|nil
function updateUtils:ShowPatchNotes(oldVersion, newVersion)
    oldVersion = oldVersion or "N/A"
    newVersion = newVersion or "N/A"
    self.addon:FPrint("Your Version changed from %s to Version %s. Check the Addon Discord for Patch Notes!", tostring(oldVersion), tostring(newVersion))
end