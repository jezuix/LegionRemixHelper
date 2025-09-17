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

constants.REMIX_HUB_MAP_ID = 627

constants.NPC = {
    MYTHIC_KEYSTONES = {
        ID = 244792,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.54,
            Y = 68.43,
        }
    },
    WORLD_APPAREL_AND_TRANSMOG = {
        ID = 241191,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.47,
            Y = 68.42,
        }
    },
    EXCLUSIVE_ENSEMBLES = {
        ID = 246026,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.50,
            Y = 68.41,
        }
    },
    DUNGEON_APPAREL = {
        ID = 241147,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.43,
            Y = 68.05,
        }
    },
    LFR_APPAREL = {
        ID = 241145,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.42,
            Y = 67.97,
        }
    },
    NORMAL_APPAREL = {
        ID = 241143,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.43,
            Y = 67.92,
        }
    },
    HEROIC_APPAREL = {
        ID = 246028,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.47,
            Y = 67.86,
        }
    },
    MYTHIC_APPAREL = {
        ID = 241168,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.49,
            Y = 67.83,
        }
    },
    LOST_AND_FOUND_APPAREL = {
        ID = 241184,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.45,
            Y = 67.71,
        }
    },
    DISCOUNT_CLOAK_DEALER = {
        ID = 246030,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.39,
            Y = 67.78,
        }
    },
    HOUSING_VENDOR = {
        ID = 251042,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.91,
            Y = 67.75,
        }
    },
    RARE_COLLECTIONS = {
        ID = 241167,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.84,
            Y = 68.18,
        }
    },
    CLASS_MOUNTS = {
        ID = 241186,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.84,
            Y = 68.25,
        }
    },
    OTHER_MOUNTS = {
        ID = 241182,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.81,
            Y = 68.30,
        }
    },
    NOSTWIN = {
        ID = 241179,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.97,
            Y = 67.85,
        }
    },
    ETERNUS = {
        ID = 241748,
        LOCATION = {
            MAP_ID = constants.REMIX_HUB_MAP_ID,
            X = 45.69,
            Y = 68.53,
        }
    },
}

constants.COLLECTIONS = {
    ENUM = {
        REWARD_TYPE = {
            TITLE = 1,
            SET = 2, -- We will use the Item ID for this cause we can get the set by doing: C_Item.GetItemLearnTransmogSet(itemID)
            PET = 3, -- We will use the Item ID for this cause we can get the Pet by doing: C_PetJournal.GetPetInfoByItemID(itemID)
            ILLUSION = 4, -- has ILLUSION_ID as extra Field to check
            APPEARANCE = 5, -- We will use the ITEM ID for this cause we can get the Appareance by doing: C_TransmogCollection.GetItemInfo(itemID)
            MOUNT = 6, -- We will use the ITEM ID for this cause we can get the Mount by doing: C_MountJournal.GetMountFromItem(itemID)
            TOY = 7, -- We will use the ITEM ID for this cause we can get the Toy by doing: C_ToyBox.GetToyInfo(itemID)
        },
        SOURCE_TYPE = {
            ACHIEVEMENT = 1,
            VENDOR = 2,
        },
        PRICE_TYPE = { -- If a reward is buyable it will have indexed PRICES as extra field with { TYPE = PRICE_TYPE, AMOUNT = number }
            BRONZE = 1,
            HORNS_OF_THE_FIRST_SATYR = 2,
            EVERFLAME_OF_HATRED = 3,
            COSMIC_SOULSILVER = 4,
        },
    },
}

do
    local enums = constants.COLLECTIONS.ENUM

    constants.COLLECTIONS.PRICE_INFO = {
        [enums.PRICE_TYPE.BRONZE] = {
            CURRENCY_ID = 2778,
        },
        [enums.PRICE_TYPE.HORNS_OF_THE_FIRST_SATYR] = {
            ITEM_ID = 242370,
        },
        [enums.PRICE_TYPE.EVERFLAME_OF_HATRED] = {
            ITEM_ID = 253306,
        },
        [enums.PRICE_TYPE.COSMIC_SOULSILVER] = {
            ITEM_ID = 253304,
        },
    }

    local npcs = constants.NPC

    constants.COLLECTIONS.REWARDS = {
        {
            -- Timerunner %s
            REWARD_ID = 551,
            REWARD_TYPE = enums.REWARD_TYPE.TITLE,
            SOURCE_ID = 42301,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Chronoscholar %s
            REWARD_ID = 646,
            REWARD_TYPE = enums.REWARD_TYPE.TITLE,
            SOURCE_ID = 60935,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- %s of the Infinite Chaos
            REWARD_ID = 659,
            REWARD_TYPE = enums.REWARD_TYPE.TITLE,
            SOURCE_ID = 61079,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- %s the Infernal
            REWARD_ID = 658,
            REWARD_TYPE = enums.REWARD_TYPE.TITLE,
            SOURCE_ID = 42691,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Ensemble: Sargerei Commander's Felscorned Regalia
            REWARD_ID = 253343,
            REWARD_TYPE = enums.REWARD_TYPE.SET,
            SOURCE_ID = 61337,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Ensemble: Sargerei Commander's Voidscarred Regalia
            REWARD_ID = 257104,
            REWARD_TYPE = enums.REWARD_TYPE.SET,
            SOURCE_ID = 61070,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Ensemble: Sargerei Commander's Lightbound Regalia
            REWARD_ID = 257106,
            REWARD_TYPE = enums.REWARD_TYPE.SET,
            SOURCE_ID = 61078,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Ensemble: Sargerei Commander's Hellforged Regalia
            REWARD_ID = 257105,
            REWARD_TYPE = enums.REWARD_TYPE.SET,
            SOURCE_ID = 42690,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Warden's Companion
            REWARD_ID = 252301,
            REWARD_TYPE = enums.REWARD_TYPE.PET,
            SOURCE_ID = 42319,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Illusion: Felshatter
            ILLUSION_ID = 98,
            REWARD_ID = 253353,
            REWARD_TYPE = enums.REWARD_TYPE.ILLUSION,
            SOURCE_ID = 42630,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Duskytooth Fel Snooter
            REWARD_ID = 246339,
            REWARD_TYPE = enums.REWARD_TYPE.PET,
            SOURCE_ID = 42541,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Sinister Fel Arsenal: Sinister Feldirk
            REWARD_ID = 246793,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42582,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Sinister Fel Arsenal: Sinister Felstaff
            REWARD_ID = 246991,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42582,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Sinister Fel Arsenal: Sinister Felblade
            REWARD_ID = 246786,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42582,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Sinister Fel Arsenal: Sinister Felwand
            REWARD_ID = 246997,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42582,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Kaldorei Queen's Royal Vestments: Kaldorei Queen's Robe
            REWARD_ID = 253346,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42605,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Kaldorei Queen's Royal Vestments: Kaldorei Queen's Sarong
            REWARD_ID = 253344,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42605,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Kaldorei Queen's Royal Vestments: Kaldorei Queen's Anklets
            REWARD_ID = 253348,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42605,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Kaldorei Queen's Royal Vestments: Kaldorei Queen's Crown
            REWARD_ID = 253345,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42605,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Kaldorei Queen's Royal Vestments: Kaldorei Queen's Bangles
            REWARD_ID = 253349,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42605,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Kaldorei Queen's Royal Vestments: Kaldorei Queen's Sash
            REWARD_ID = 253347,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42605,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Fallen King's Corrupted Blades
            REWARD_ID = 253231,
            REWARD_TYPE = enums.REWARD_TYPE.SET,
            SOURCE_ID = 42666,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Bulwark of Mannoroth: Shield
            REWARD_ID = 253219,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42549,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Bulwark of Mannoroth: Back
            REWARD_ID = 253220,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42549,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Felscorned Scythe of the Unmaker
            REWARD_ID = 253285,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = 42583,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- The First Satyr's Spaulders
            REWARD_ID = 242368,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = npcs.MYTHIC_APPAREL.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.HORNS_OF_THE_FIRST_SATYR, AMOUNT = 20 },
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 30000 },
            }
        },
        {
            -- Taeshalach
            REWARD_ID = 255006,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = npcs.MYTHIC_APPAREL.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.EVERFLAME_OF_HATRED, AMOUNT = 20 },
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 30000 },
            }
        },
        {
            -- Scythe of the Unmaker
            REWARD_ID = 253273,
            REWARD_TYPE = enums.REWARD_TYPE.APPEARANCE,
            SOURCE_ID = npcs.MYTHIC_APPAREL.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.COSMIC_SOULSILVER, AMOUNT = 20 },
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 30000 },
            }
        },
        {
            -- Felscorned Reins of the Vilebrood Vanquisher
            REWARD_ID = 252954,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Felscorned Reins of the Vilebrood Vanquisher
            REWARD_ID = 252954,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 42685,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Slayer's Reins of the Felscorned Shrieker
            REWARD_ID = 253013,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Slayer's Reins of the Felscorned Shrieker
            REWARD_ID = 253013,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 61087,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Feldruid's Scornwing Idol
            REWARD_ID = 253024,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Feldruid's Scornwing Idol
            REWARD_ID = 253024,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 61086,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Reins of the Felscorned Wolfhawk
            REWARD_ID = 253025,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Reins of the Felscorned Wolfhawk
            REWARD_ID = 253025,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 42687,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Archmage's Felscorned Disc
            REWARD_ID = 253026,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Archmage's Felscorned Disc
            REWARD_ID = 253026,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 61089,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Felscorned Grandmaster's Bell
            REWARD_ID = 253027,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Felscorned Grandmaster's Bell
            REWARD_ID = 253027,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 61085,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Reins of the Highlord's Felscorned Charger
            REWARD_ID = 253028,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Reins of the Highlord's Felscorned Charger
            REWARD_ID = 253028,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 42504,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Felscorned Seeker's Whistle
            REWARD_ID = 253029,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Felscorned Seeker's Whistle
            REWARD_ID = 253029,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 61088,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Shadowblade's Reins of Felscorned Portent
            REWARD_ID = 253030,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Shadowblade's Reins of Felscorned Portent
            REWARD_ID = 253030,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 61084,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Felscorned Tempest Totem
            REWARD_ID = 253031,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Felscorned Tempest Totem
            REWARD_ID = 253031,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 42686,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Felscorned Reins of the Netherlord's Dreadsteed
            REWARD_ID = 253032,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Felscorned Reins of the Netherlord's Dreadsteed
            REWARD_ID = 253032,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 61090,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Iron Reins of the Felscorned War Wrym
            REWARD_ID = 253033,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.CLASS_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Iron Reins of the Felscorned War Wrym
            REWARD_ID = 253033,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = 42684,
            SOURCE_TYPE = enums.SOURCE_TYPE.ACHIEVEMENT,
        },
        {
            -- Reins of the Illidari Dreadstalker
            REWARD_ID = 250428,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Illidari Blightstalker
            REWARD_ID = 250427,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Highland Elderhorn
            REWARD_ID = 250429,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Treetop Highmountain Eagle
            REWARD_ID = 250723,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Snowy Highmountain Eagle
            REWARD_ID = 250721,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Wretched Fel Bat
            REWARD_ID = 239687,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Ashplague Fel Bat
            REWARD_ID = 239667,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Bloodhunter Fel Bat
            REWARD_ID = 239665,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Gloomdark Nightmare
            REWARD_ID = 250757,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Turquoise Courser
            REWARD_ID = 250756,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Golden Sunrunner
            REWARD_ID = 250752,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Twilight Courser
            REWARD_ID = 250751,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Brimstone Courser
            REWARD_ID = 251795,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Chestnut Courser
            REWARD_ID = 251796,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Leystone Basilisk
            REWARD_ID = 250424,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Felslate Basilisk
            REWARD_ID = 250425,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Slag Basilisk
            REWARD_ID = 250423,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Aquamarine Basilisk
            REWARD_ID = 250426,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Arcberry Manasaber
            REWARD_ID = 250728,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Bonesteed of Triumph
            REWARD_ID = 250761,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Bonesteed of Bloodshed
            REWARD_ID = 250760,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Bonesteed of Plague
            REWARD_ID = 250759,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Bonesteed of Oblivion
            REWARD_ID = 250758,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Ghastly Ur'zul
            REWARD_ID = 250192,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Luminous Mana Ray
            REWARD_ID = 250748,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Albino Mana Ray
            REWARD_ID = 250747,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Bloodtooth Mana Ray
            REWARD_ID = 250746,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Fel-Scarred Mana Ray
            REWARD_ID = 250745,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Garnet Ruinstrider
            REWARD_ID = 250803,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Longhorned Beryl Talbuk
            REWARD_ID = 250806,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Longhorned Argussian Talbuk
            REWARD_ID = 250805,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Longhorned Bleakhoof Talbuk
            REWARD_ID = 250804,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Longhorned Sable Talbuk
            REWARD_ID = 250802,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 10000 },
            }
        },
        {
            -- Reins of the Long-Forgotten Hippogryph
            REWARD_ID = 138258,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Fathom Dweller
            REWARD_ID = 138201,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Cloudwing Hippogryph
            REWARD_ID = 147806,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Highmountain Elderhorn
            REWARD_ID = 147807,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Leywoven Flying Carpet
            REWARD_ID = 143764,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Valarjar Stormwing
            REWARD_ID = 147805,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Wild Dreamrunner
            REWARD_ID = 147804,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Blessed Felcrusher
            REWARD_ID = 153043,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Avenging Felcrusher
            REWARD_ID = 153044,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Glorious Felcrusher
            REWARD_ID = 153042,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 20000 },
            }
        },
        {
            -- Spirit of Eche'ro
            REWARD_ID = 131734,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Biletooth Gnasher
            REWARD_ID = 152903,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Acid Belcher
            REWARD_ID = 152904,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Crimson Slavermaw
            REWARD_ID = 152905,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Vile Fiend
            REWARD_ID = 152790,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Darkspore Mana Ray
            REWARD_ID = 152843,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Lambent Mana Ray
            REWARD_ID = 152844,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Felglow Mana Ray
            REWARD_ID = 152841,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Scintillating Mana Ray
            REWARD_ID = 152840,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Vibrant Mana Ray
            REWARD_ID = 152842,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Maddened Chaosrunner
            REWARD_ID = 152814,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 40000 },
            }
        },
        {
            -- Arcadian War Turtle
            REWARD_ID = 141713,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 100000 },
            }
        },
        {
            -- Midnight's Eternal Reins
            REWARD_ID = 142236,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 100000 },
            }
        },
        {
            -- Living Infernal Core
            REWARD_ID = 137574,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 100000 },
            }
        },
        {
            -- Fiendish Hellfire Core
            REWARD_ID = 137575,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 100000 },
            }
        },
        {
            -- Abyss Worm
            REWARD_ID = 143643,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 100000 },
            }
        },
        {
            -- Antoran Charhound
            REWARD_ID = 152816,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 100000 },
            }
        },
        {
            -- Shackled Ur'zul
            REWARD_ID = 152789,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 100000 },
            }
        },
        {
            --
            REWARD_ID = 000000,
            REWARD_TYPE = enums.REWARD_TYPE.MOUNT,
            SOURCE_ID = npcs.OTHER_MOUNTS.ID,
            SOURCE_TYPE = enums.SOURCE_TYPE.VENDOR,
            PRICES = {
                { TYPE = enums.PRICE_TYPE.BRONZE, AMOUNT = 100000 },
            }
        },
    }
end