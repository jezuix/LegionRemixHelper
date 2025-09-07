local ADDON_NAME = ...
---@cast ADDON_NAME string

---@class AddonPrivate
local Private = select(2, ...)

local constants = {}

Private.constants = constants

constants.ADDON_NAME = ADDON_NAME
constants.ADDON_VERSION = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version")
constants.ADDON_MEDIA_PATH = [[Interface\AddOns\]] .. constants.ADDON_NAME .. [[\Media]]

constants.MEDIA = {
    TEXTURES = {
        LOGO = constants.ADDON_MEDIA_PATH .. [[\Textures\logo.tga]]
    }
}

constants.SCRAPPING_MACHINE = {
    MAX_SLOTS = 9,
}

constants.ITEM_QUALITY_BORDERS = {
    [Enum.ItemQuality.Poor] = "loottoast-itemborder-grey",
    [Enum.ItemQuality.Common] = "loottoast-itemborder-white",
    [Enum.ItemQuality.Uncommon] = "loottoast-itemborder-green",
    [Enum.ItemQuality.Rare] = "loottoast-itemborder-blue",
    [Enum.ItemQuality.Epic] = "loottoast-itemborder-purple",
    [Enum.ItemQuality.Legendary] = "loottoast-itemborder-orange",
    [Enum.ItemQuality.Artifact] = "loottoast-itemborder-artifact",
    [Enum.ItemQuality.Heirloom] = "loottoast-itemborder-heirloom",
}