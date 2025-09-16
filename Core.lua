---@class AddonPrivate
local Private = select(2, ...)

local const = Private.constants
local addon = Private.Addon

function addon:OnInitialize(...)
    Private.ScrappingUtils:Init()
    Private.ArtifactTraitUtils:Init()
    Private.ResearchTaskUtils:Init()

    Private.CollectionsTabUI:Init()
end

function addon:OnEnable(...)
    -- On Enable
end

function addon:OnDisable(...)
    -- On Disable
end