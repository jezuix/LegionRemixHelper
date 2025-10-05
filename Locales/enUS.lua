---@class AddonPrivate
local Private = select(2, ...)

local locales = Private.Locales or {}
Private.Locales = locales
local L = {
    -- UI/Tabs/ArtifactTraitsTabUI.lua
    ["Tabs.ArtifactTraitsTabUI.AutoActivateForSpec"] = "Auto-Activate for Spec",

    -- UI/Tabs/CollectionTabUI.lua
    ["Tabs.CollectionTabUI.CtrlClickPreview"] = "Ctrl-Click to preview",
    ["Tabs.CollectionTabUI.ShiftClickToLink"] = "Shift-Click to Link",
    ["Tabs.CollectionTabUI.NoName"] = "No Name",
    ["Tabs.CollectionTabUI.AltClickVendor"] = "Alt-Click to set a Waypoint to the Vendor",
    ["Tabs.CollectionTabUI.AltClickAchievement"] = "Alt-Click to view the Achievement",
    ["Tabs.CollectionTabUI.FilterCollected"] = "Collected",
    ["Tabs.CollectionTabUI.FilterNotCollected"] = "Not Collected",
    ["Tabs.CollectionTabUI.FilterSources"] = "Sources",
    ["Tabs.CollectionTabUI.FilterCheckAll"] = "Check All",
    ["Tabs.CollectionTabUI.FilterUncheckAll"] = "Uncheck All",
    ["Tabs.CollectionTabUI.Type"] = "Type",
    ["Tabs.CollectionTabUI.Source"] = "Source",
    ["Tabs.CollectionTabUI.SearchInstructions"] = "Search",
    ["Tabs.CollectionTabUI.Progress"] = "%d / %d (%.2f%%)",

    -- UI/CollectionsTabUI.lua
    ["CollectionsTabUI.TabTitle"] = "Legion Remix",
    ["CollectionsTabUI.ResearchProgress"] = "Research: %s/%s",
    ["CollectionsTabUI.TraitsTabTitle"] = "Artifact Traits",
    ["CollectionsTabUI.CollectionTabTitle"] = "Collection",

    -- UI/QuickActionBarUI.lua
    ["QuickActionBarUI.QuickBarTitle"] = "Quick-Bar",
    ["QuickActionBarUI.SettingTitlePreview"] = "Action Title here",
    ["QuickActionBarUI.SettingsEditorTitle"] = "Editing Action",
    ["QuickActionBarUI.SettingsTitleLabel"] = "Action Title:",
    ["QuickActionBarUI.SettingsTitleInput"] = "Name of the action",
    ["QuickActionBarUI.SettingsIconLabel"] = "Icon:",
    ["QuickActionBarUI.SettingsIconInput"] = "Texture ID or Path",
    ["QuickActionBarUI.SettingsIDLabel"] = "Action ID:",
    ["QuickActionBarUI.SettingsIDInput"] = "Item/Spell name or ID",
    ["QuickActionBarUI.SettingsTypeLabel"] = "Action Type:",
    ["QuickActionBarUI.SettingsTypeInputSpell"] = "Spell",
    ["QuickActionBarUI.SettingsTypeInputItem"] = "Item",
    ["QuickActionBarUI.SettingsCheckUsableLabel"] = "Only when usable:",
    ["QuickActionBarUI.SettingsEditorSave"] = "Save Action",
    ["QuickActionBarUI.SettingsEditorNew"] = "New Action",
    ["QuickActionBarUI.SettingsEditorDelete"] = "Delete Action",
    ["QuickActionBarUI.SettingsNoActionSaveError"] = "No action to save.",
    ["QuickActionBarUI.SettingsEditorAction"] = "Action %s",
    ["QuickActionBarUI.SettingsGeneralActionSaveError"] = "Got an error while saving action: %s",

    -- UI/ScrappingUI.lua
    ["ScrappingUI.MaxScrappingQuality"] = "Max Scrapping Quality",
    ["ScrappingUI.MinItemLevelDifference"] = "Min Item Level Difference",
    ["ScrappingUI.MinItemLevelDifferenceInstructions"] = "x levels lower than equipped",
    ["ScrappingUI.AutoScrap"] = "Auto Scrap",
}
locales["enUS"] = L
