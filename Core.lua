---@class AddonPrivate
local Private = select(2, ...)

local const = Private.constants
local addon = Private.Addon

function addon:OnInitialize(...)
    Private.SettingsUtils:Init()

    Private.ScrappingUtils:Init()
    Private.ArtifactTraitUtils:Init()
    Private.ResearchTaskUtils:Init()
    Private.CollectionUtils:Init()
    Private.QuickActionBarUtils:Init()
    Private.QuestUtils:Init()

    Private.CollectionsTabUI:Init()
end

function addon:OnEnable(...)
    Private.QuickActionBarUtils:CreateSettings()
end

function addon:OnDisable(...)
    Private.QuickActionBarUtils:OnDisable()
end
