---@class AddonPrivate
local Private = select(2, ...)

---@class ArtifactTraitsTabUI
---@field contentFrame Frame
---@field isUICreated boolean
local artifactTraitsTabUI = {
    contentFrame = nil,
    isUICreated = false,
}
Private.ArtifactTraitsTabUI = artifactTraitsTabUI

local const = Private.constants
local components = Private.Components

function artifactTraitsTabUI:CreateTabUI()
    local utils = Private.ArtifactTraitUtils
    local configID = utils:GetConfigID()

    local rowFrame = CreateFrame("Frame", nil, self.contentFrame)
    rowFrame:SetPoint("TOPLEFT")
    rowFrame:SetPoint("BOTTOMRIGHT", 0, 100)
    local WIDTH, HEIGHT = rowFrame:GetSize()

    local rowFrameBackground = rowFrame:CreateTexture(nil, "BACKGROUND")
    rowFrameBackground:SetAllPoints()
    rowFrameBackground:SetAtlas("spec-background")

    local specs = {}
    local activeRow = utils:GetPlayerRow()

    local function changeActive(newActive)
        if activeRow == newActive then return end
        if not specs[newActive] then return end

        local activeFrame = specs[activeRow]
        if activeFrame then
            ---@cast activeFrame SpecSelectComponentObject
            activeFrame:SetActive(false)
        end

        activeRow = newActive
        activeFrame = specs[activeRow]
        ---@cast activeFrame SpecSelectComponentObject
        activeFrame:SetActive(true)
    end

    for rowID, rowName in ipairs(utils:GetRowNames()) do
        local sW = WIDTH / 5
        local rowSelect = components.SpecSelect:CreateFrame(rowFrame, {
            name = rowName,
            onClick = function()
                changeActive(rowID)
                utils:SetRowForSpec(utils:GetSpecID(), rowID)
            end,
            onSettingsClick = function(obj)
                local ownerFrame = obj.frame
                local function GeneratorFunction(genOwner, rootDescription)
                    ---@cast rootDescription RootMenuDescriptionProxy
                    rootDescription:CreateTitle("Auto-Activate for Spec")

                    for _, specID in ipairs(utils:GetSpecs()) do
                        local specName = select(2, GetSpecializationInfoByID(specID))
                        rootDescription:CreateCheckbox(specName,
                            function()
                                return utils:GetRowForSpec(specID) == rowID
                            end,
                            function()
                                utils:SetRowForSpec(specID, rowID)
                            end
                        )
                    end
                end


                MenuUtil.CreateContextMenu(ownerFrame, GeneratorFunction);
            end,
            active = (rowID == activeRow),
            width = sW,
            height = HEIGHT,
            anchors = { { "TOPLEFT", (rowID - 1) * (sW), 0 } },
        })

        specs[rowID] = rowSelect
    end

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
                        local circle = components.RoundedIcon:CreateFrame(specs[index].frame, {
                            width = 40,
                            height = 40,
                            anchors = {
                                { "TOP", specs[index].sample, "BOTTOM", 0, (10 + (45 * (traitIndex - 1))) * -1 - 10 },
                            },
                            show_tooltip = true,
                            frame_strata = "FULLSCREEN_DIALOG"
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

    local bottomBar = self.contentFrame:CreateTexture()
    bottomBar:SetPoint("BOTTOMLEFT", 0, 0)
    bottomBar:SetPoint("TOPRIGHT", rowFrame, "BOTTOMRIGHT", 0, 0)
    bottomBar:SetAtlas("talents-background-bottombar", true)

    for i = 1, 5 do
        local jewelery = components.NodeIcon:CreateFrame(self.contentFrame, {
            anchors = {
                { "LEFT", bottomBar, "LEFT", (i - 1) * 70 + 15, 0 },
            },
            show_tooltip = true,
            onClick = function(jeweleryObj)
                local function GeneratorFunction(genOwner, rootDescription)
                    rootDescription:CreateButton("My Button", function(data)
                        -- Button handling here.
                    end);
                end;


                MenuUtil.CreateContextMenu(jeweleryObj.frame, GeneratorFunction);
            end,
        })
    end
end

---@param contentFrame Frame
function artifactTraitsTabUI:Init(contentFrame)
    self.contentFrame = contentFrame

    contentFrame:HookScript("OnShow", function()
        if not self.isUICreated then
            self:CreateTabUI()
            self.isUICreated = true
        end
    end)
end

Comps = components
