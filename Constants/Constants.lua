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
    BASE_TRAITS = {
        { -- Remix Time
            SPELL_ID = 1232427,
            ENTRY_ID = 133498,
            NODE_ID = 108115,
        },
        { -- Powerful Arcanocrystal Shard
            SPELL_ID = 1232426,
            ENTRY_ID = 133583,
            NODE_ID = 108182,
        },
        { -- Fortified Arcanocrystal Shard
            SPELL_ID = 1232425,
            ENTRY_ID = 133582,
            NODE_ID = 108181,
        },
        { -- Expedient Arcanocrystal Shard
            SPELL_ID = 1248795,
            ENTRY_ID = 134454,
            NODE_ID = 108878,
        },
        { -- Nostwin's Impatience
            SPELL_ID = 1242240,
            ENTRY_ID = 133581,
            NODE_ID = 108180,
        },
        { -- Expedient Arcanocrystal Shard
            SPELL_ID = 1248795,
            ENTRY_ID = 133564,
            NODE_ID = 108165,
        },
        { -- Fortified Arcanocrystal Shard
            SPELL_ID = 1232425,
            ENTRY_ID = 133571,
            NODE_ID = 108172,
        },
        { -- Expedient Arcanocrystal Shard
            SPELL_ID = 1248795,
            ENTRY_ID = 133691,
            NODE_ID = 108260,
        },
        { -- Fortified Arcanocrystal Shard
            SPELL_ID = 1232425,
            ENTRY_ID = 133565,
            NODE_ID = 108166,
        },
        { -- Momentu's Perseverance
            SPELL_ID = 1243005,
            ENTRY_ID = 133999,
            NODE_ID = 108523,
        },
        { -- Powerful Arcanocrystal Shard
            SPELL_ID = 1232426,
            ENTRY_ID = 134448,
            NODE_ID = 108874,
        },
        { -- Powerful Arcanocrystal Shard
            SPELL_ID = 1232426,
            ENTRY_ID = 134443,
            NODE_ID = 108869,
        },
        { -- Eternu's Ambition
            SPELL_ID = 1250687,
            ENTRY_ID = 134447,
            NODE_ID = 108873,
        },
        { -- Powerful Arcanocrystal Shard
            SPELL_ID = 1232426,
            ENTRY_ID = 134442,
            NODE_ID = 108868,
        },
        { -- Fortified Arcanocrystal Shard
            SPELL_ID = 1232425,
            ENTRY_ID = 133568,
            NODE_ID = 108169,
        },
        { -- Moratari's Calculation
            SPELL_ID = 1247702,
            ENTRY_ID = 134247,
            NODE_ID = 108701,
        },
        { -- Expendient Arcanocrystal Shard
            SPELL_ID = 1248795,
            ENTRY_ID = 133682,
            NODE_ID = 108251,
        },
        { -- Erus's Aggression
            SPELL_ID = 1245477,
            ENTRY_ID = 134444,
            NODE_ID = 108870,
        },
    },
    ROWS = {
        NATURE_ROW = {
            { -- Call of the Forest
                SPELL_ID = 1233577,
                ENTRY_ID = 133497,
                NODE_ID = 108114,
            },
        },
        FEL_ROW = {
            { -- Twisted Crusade
                SPELL_ID = 1237711,
                ENTRY_ID = 133496,
                NODE_ID = 108113,
            },
        },
        ARCANE_ROW = {
            { -- Naran's Everdisc
                SPELL_ID = 1233775,
                ENTRY_ID = 133494,
                NODE_ID = 108111,
            },
        },
        STORM_ROW = {
            { -- Tempest Wrath
                SPELL_ID = 1233181,
                ENTRY_ID = 133495,
                NODE_ID = 108112,
            },
        },
        HOLY_ROW = {
            { -- Vindicator's Judgment
                SPELL_ID = 1251045,
                ENTRY_ID = 134449,
                NODE_ID = 108875,
            },
        },
    },
    FINAL_TRAIT = {
        SPELL_ID = 1245947,
        ENTRY_ID = 134246,
        NODE_ID = 108700,
    }
}
