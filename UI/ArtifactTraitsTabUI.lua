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
    self.contentFrame = contentFrame
    print("Nature, Fel, Arcane, Storm, Holy")

    for index, row in pairs(const.REMIX_ARTIFACT_TRAITS.ROWS) do
        for traitIndex, trait in pairs(row) do
            local nature = components.RoundedIcon:CreateFrame(self.contentFrame, {
                width = 40,
                height = 40,
                anchors = {
                    { "TOPLEFT", self.contentFrame, "TOPLEFT", 10 + (40 * (traitIndex - 1)), -10 + (50 * (index - 1)) },
                },
                show_tooltip = true
            })

            local natureSpell = Spell:CreateFromSpellID(trait.SPELL_ID)
            natureSpell:ContinueOnSpellLoad(function()
                nature:SetLink(C_Spell.GetSpellLink(trait.SPELL_ID))
                nature:SetTexture(C_Spell.GetSpellTexture(trait.SPELL_ID))
            end)
        end
    end
end
