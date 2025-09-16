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
            NAME = "Nature",
            ID = 1,
            ROOT_NODE_ID = 108114, -- Call of the Forest
        },
        FEL_ROW = {
            NAME = "Fel",
            ID = 2,
            ROOT_NODE_ID = 108113, -- Twisted Crusade
        },
        ARCANE_ROW = {
            NAME = "Arcane",
            ID = 3,
            ROOT_NODE_ID = 108111, -- Naran's Everdisc
        },
        STORM_ROW = {
            NAME = "Storm",
            ID = 4,
            ROOT_NODE_ID = 108112, -- Tempest Wrath
        },
        HOLY_ROW = {
            NAME = "Holy",
            ID = 5,
            ROOT_NODE_ID = 108875, -- Vindicator's Judgment
        },
    },
    FINAL_TRAIT = {
        NODE_ID = 108700,
    },
    JEWELRY_QUALITY_UPGRADES = {
        [Enum.ItemQuality.Uncommon] = 1,
        [Enum.ItemQuality.Rare] = 2,
        [Enum.ItemQuality.Epic] = 3,
        [Enum.ItemQuality.Legendary] = 4,
    },
    JEWELRY_ITEMS = {
        [245996] = 133485, -- Volatile Magics
        [245997] = 133491, -- Terror From Below
        [245998] = 133486, -- Arcane Aegis
        [245999] = 134248, -- Touch of Malice
        [246000] = 133491, -- Terror From Below
        [246190] = 134248, -- Touch of Malice
        [246191] = 133493, -- Highmountain Fortitude
        [246192] = 133489, -- Souls of the Caw
        [246193] = 133490, -- Temporal Retaliation
        [246194] = 133487, -- Storm Surger
        [246195] = 135715, -- Brewing Storm
        [246196] = 135326, -- Light's Vengeance
        [246197] = 133508, -- Arcane Ward
        [246198] = 133488, -- I am My Scars!
        [246199] = 133485, -- Volatile Magics
        [246200] = 133493, -- Highmountain Fortitude
        [246201] = 133490, -- Temporal Retaliation
        [246202] = 135715, -- Brewing Storm
        [246203] = 133489, -- Souls of the Caw
        [246204] = 133486, -- Arcane Aegis
        [246205] = 133487, -- Storm Surger
        [246206] = 133508, -- Arcane Ward
        [246207] = 135326, -- Light's Vengeance
        [246208] = 133488, -- I am My Scars!
    },
    JEWELRY_SLOTS = {
        {INV_TYPE = Enum.InventoryType.IndexFingerType, SLOT = 11, NAME = "FINGER"},
        {INV_TYPE = Enum.InventoryType.IndexFingerType, SLOT = 12, NAME = "FINGER"},
        {INV_TYPE = Enum.InventoryType.IndexTrinketType, SLOT = 13, NAME = "TRINKET"},
        {INV_TYPE = Enum.InventoryType.IndexTrinketType, SLOT = 14, NAME = "TRINKET"},
        {INV_TYPE = Enum.InventoryType.IndexNeckType, SLOT = 2, NAME = "NECK"},
    },
    CALLBACK_CATEGORY_SPEC = "ArtifactTraitSpecUpdate",
    CALLBACK_CATEGORY_CONFIG = "ArtifactTraitConfigUpdate",
    CALLBACK_CATEGORY_EQUIPPED = "ArtifactTraitEquippedUpdate",
    CALLBACK_CATEGORY_ROW = "ArtifactTraitRowUpdate",
    CALLBACK_CATEGORY_CURRENCY = "ArtifactTraitCurrencyUpdate",
}

constants.RESEARCH_TASKS = {
    WIDGET_ID = 7330,
    CALLBACK_CATEGORY = "ResearchTaskUpdate",
}