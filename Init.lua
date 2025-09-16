---@class AddonPrivate
local Private = select(2, ...)
local const = Private.constants

local defaultDatabase = {
    scrapping = {
        maxQuality = Enum.ItemQuality.Rare,
        minLevelDiff = 0,
        autoScrap = false,
    },
    collectionsTab = {
        selected = 1,
    },
    artifactTraits = {
        autoActive = {}
    }
}

---@class LegionRH : RasuAddonBase
local addon = LibStub("RasuAddon"):CreateAddon(
    const.ADDON_NAME,
    "LegionRemixHelperDB",
    defaultDatabase
)

Private.Addon = addon