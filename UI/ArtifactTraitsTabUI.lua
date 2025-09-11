---@class AddonPrivate
local Private = select(2, ...)

---@class ArtifactTraitsTabUI
---@field contentFrame Frame
local artifactTraitsTabUI = {
    contentFrame = nil,
}
Private.ArtifactTraitsTabUI = artifactTraitsTabUI

local const = Private.constants
local components = Private.Components

---@param contentFrame Frame
function artifactTraitsTabUI:Init(contentFrame) -- Only Placeholder for now
    local utils = Private.ArtifactTraitUtils
    local configID = utils:GetConfigID()
    self.contentFrame = contentFrame
    print("Nature, Fel, Arcane, Storm, Holy")

    for index, row in pairs(utils:GetRowTraits()) do
        local traitIndex = 0
        for _, nodeID in pairs(row) do
            local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID)
            if nodeInfo and nodeInfo.entryIDs then
                local entryID = nodeInfo.entryIDs[1]
                local entryInfo = C_Traits.GetEntryInfo(configID, entryID)
                if entryInfo and entryInfo.definitionID and (entryInfo.type == Enum.TraitNodeEntryType.SpendCircle or entryInfo.type == Enum.TraitNodeEntryType.SpendSquare) then
                    local definitionInfo = C_Traits.GetDefinitionInfo(entryInfo.definitionID)
                    if definitionInfo and definitionInfo.spellID then
                        traitIndex = traitIndex + 1
                        local circle = components.RoundedIcon:CreateFrame(self.contentFrame, {
                            width = 40,
                            height = 40,
                            anchors = {
                                { "TOPLEFT", self.contentFrame, "TOPLEFT", 10 + (40 * (traitIndex - 1)), -10 + (50 * (index - 1)) * -1 },
                            },
                            show_tooltip = true
                        })
                        local spell = Spell:CreateFromSpellID(definitionInfo.spellID)
                        spell:ContinueOnSpellLoad(function()
                            circle:SetLink(C_Spell.GetSpellLink(definitionInfo.spellID))
                            circle:SetTexture(C_Spell.GetSpellTexture(definitionInfo.spellID))
                        end)
                    end
                end
            end
        end
        index = index + 1
    end

    for i = 1, 5 do
        local jewelery = components.NodeIcon:CreateFrame(self.contentFrame, {
            anchors = {
                { "TOPLEFT", self.contentFrame, "TOPLEFT", 10 + (40 * 5) + 20, -10 + (50 * (i - 1)) * -1 + 5 },
            },
            show_tooltip = true
        })
    end
end

Comps = components