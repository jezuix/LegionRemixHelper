---@class AddonPrivate
local Private = select(2, ...)

local const = Private.constants
local addon = Private.Addon

function addon:OnInitialize(...)
    Private.SettingsUtils:Init()

    Private.CommsUtils:Init()
    Private.TooltipUtils:Init()
    Private.ScrappingUtils:Init()
    Private.ToastUtils:Init()
    Private.ArtifactTraitUtils:Init()
    Private.ResearchTaskUtils:Init()
    Private.CollectionUtils:Init()
    Private.QuickActionBarUtils:Init()
    Private.QuestUtils:Init()

    Private.CollectionsTabUI:Init()
    Private.ToastUI:Init()
end

function addon:OnEnable(...)
    Private.DatabaseUtils:LoadDefaultsForMissing()

    Private.TooltipUtils:CreateSettings()
    Private.QuickActionBarUtils:CreateSettings()

    Private.UpdateUtils:OnEnable()
end

function addon:OnDisable(...)
    Private.QuickActionBarUtils:OnDisable()
end
