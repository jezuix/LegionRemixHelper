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

constants.COLLECTIONS_TAB = {
    TAB_ID = 7,
    TAB_ICON = 5228749,
}

constants.REMIX_ARTIFACT_TRAITS = {
    TREE_ID = 1161,
    ROWS = {
        NATURE_ROW = {
            ID = 1,
            ROOT_NODE_ID = 108114, -- Call of the Forest
        },
        FEL_ROW = {
            ID = 2,
            ROOT_NODE_ID = 108113, -- Twisted Crusade
        },
        ARCANE_ROW = {
            ID = 3,
            ROOT_NODE_ID = 108111, -- Naran's Everdisc
        },
        STORM_ROW = {
            ID = 4,
            ROOT_NODE_ID = 108112, -- Tempest Wrath
        },
        HOLY_ROW = {
            ID = 5,
            ROOT_NODE_ID = 108875, -- Vindicator's Judgment
        },
    },
    FINAL_TRAIT = {
        NODE_ID = 108700,
    },
    JEWELRY_ITEMS = { -- Map Items to Entry ID's for Jewelry Slots + Slotnums to later identify them (Uncommon + 1, Rare + 2, Epic + 3, Legendary + 4)

    }
}
