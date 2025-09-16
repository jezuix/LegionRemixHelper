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
    ---@enum Enum.ArtifactTraitJewelrySlot
    JEWELRY_SLOTS = {
        NECK = 1,
        RING = 2,
        TRINKET = 3,
    },
}

do
    local slots = constants.REMIX_ARTIFACT_TRAITS.JEWELRY_SLOTS

    -- (Uncommon + 1, Rare + 2, Epic + 3, Legendary + 4)
    constants.REMIX_ARTIFACT_TRAITS.JEWELRY_ITEMS = {
        [245996] = { ENTRY_ID = 133485, SLOT = slots.NECK },    -- Volatile Magics
        [245997] = { ENTRY_ID = 133491, SLOT = slots.RING },    -- Terror From Below
        [245998] = { ENTRY_ID = 133486, SLOT = slots.RING },    -- Arcane Aegis
        [245999] = { ENTRY_ID = 134248, SLOT = slots.TRINKET }, -- Touch of Malice
        [246000] = { ENTRY_ID = 133491, SLOT = slots.TRINKET }, -- Terror From Below
        [246190] = { ENTRY_ID = 134248, SLOT = slots.NECK },    -- Touch of Malice
        [246191] = { ENTRY_ID = 133493, SLOT = slots.NECK },    -- Highmountain Fortitude
        [246192] = { ENTRY_ID = 133489, SLOT = slots.NECK },    -- Souls of the Caw
        [246193] = { ENTRY_ID = 133490, SLOT = slots.NECK },    -- Temporal Retaliation
        [246194] = { ENTRY_ID = 133487, SLOT = slots.NECK },    -- Storm Surger
        [246195] = { ENTRY_ID = 135715, SLOT = slots.NECK },    -- Brewing Storm
        [246196] = { ENTRY_ID = 135326, SLOT = slots.NECK },    -- Light's Vengeance
        [246197] = { ENTRY_ID = 133508, SLOT = slots.RING },    -- Arcane Ward
        [246198] = { ENTRY_ID = 133488, SLOT = slots.RING },    -- I am My Scars!
        [246199] = { ENTRY_ID = 133485, SLOT = slots.RING },    -- Volatile Magics
        [246200] = { ENTRY_ID = 133493, SLOT = slots.RING },    -- Highmountain Fortitude
        [246201] = { ENTRY_ID = 133490, SLOT = slots.RING },    -- Temporal Retaliation
        [246202] = { ENTRY_ID = 135715, SLOT = slots.RING },    -- Brewing Storm
        [246203] = { ENTRY_ID = 133489, SLOT = slots.TRINKET }, -- Souls of the Caw
        [246204] = { ENTRY_ID = 133486, SLOT = slots.TRINKET }, -- Arcane Aegis
        [246205] = { ENTRY_ID = 133487, SLOT = slots.TRINKET }, -- Storm Surger
        [246206] = { ENTRY_ID = 133508, SLOT = slots.TRINKET }, -- Arcane Ward
        [246207] = { ENTRY_ID = 135326, SLOT = slots.TRINKET }, -- Light's Vengeance
        [246208] = { ENTRY_ID = 133488, SLOT = slots.TRINKET }, -- I am My Scars!
    }
end

constants.RESEARCH_TASKS = {
    WIDGET_ID = 7330,
    CALLBACK_CATEGORY = "ResearchTaskUpdate",
}