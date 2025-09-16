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

    local f = CreateFrame("Frame", nil, contentFrame)
    f:SetPoint("TOPLEFT")
    f:SetPoint("BOTTOMRIGHT", 0, 100)
    local WIDTH, HEIGHT = f:GetSize()

    local bg = f:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetAtlas("spec-background")

    local specs = {}
    local activeSpec = 0

    local function changeActive(newActive)
        if activeSpec == newActive then return end
        if not specs[newActive] then return end

        local activeFrame = specs[activeSpec]
        if activeFrame then
            for _, aFrame in pairs(activeFrame.activeFrames) do
                aFrame:Hide()
            end
            activeFrame.activeT:Hide()
            activeFrame.activeB:Show()
        end

        activeSpec = newActive
        activeFrame = specs[activeSpec]
        for _, aFrame in pairs(activeFrame.activeFrames) do
            aFrame:Show()
        end
        activeFrame.activeT:Show()
        activeFrame.activeB:Hide()
    end

    for i, specName in ipairs({ "Nature", "Fel", "Arcane", "Storm", "Holy" }) do
        local sW = WIDTH / 5
        local spec = CreateFrame("Frame", nil, f)
        spec:SetSize(sW, HEIGHT)
        spec:SetPoint("TOPLEFT", (i - 1) * (sW), 0)

        local hBG = spec:CreateTexture(nil, "BACKGROUND")
        hBG:SetAllPoints()
        hBG:SetAtlas("spec-hover-background")
        hBG:SetAlpha(.05)
        hBG:SetBlendMode("ADD")
        hBG:Hide()

        local name = spec:CreateFontString(nil, nil, "Game13Font")
        name:SetJustifyH("CENTER")
        name:SetTextColor(1, 1, 1)
        name:SetPoint("TOP", 0, -50)
        name:SetText(specName)

        local sample = spec:CreateFontString(nil, nil, "GameFontHighlightSmall2")
        sample:SetPoint("TOP", name, "BOTTOM", 0, -25)
        sample:SetText(SAMPLE_ABILITIES)

        local activeT = spec:CreateFontString(nil, nil, "GameFontNormalSmall2")
        activeT:SetPoint("BOTTOM", 0, 50)
        activeT:SetTextColor(0, 1, 0)
        activeT:SetText(SPEC_ACTIVE)
        local activeB = CreateFrame("Button", nil, spec, "SharedButtonTemplate")
        activeB:SetPoint("BOTTOM", 0, 50)
        activeB:SetSize(sW / 2, 25)
        activeB:SetText(TALENT_SPEC_ACTIVATE)
        local activeS = spec:CreateTexture()
        activeS:SetPoint("BOTTOM", 0, 15)
        activeS:SetAtlas("GM-icon-settings")
        activeS:SetSize(30, 30)

        local sep = spec:CreateTexture()
        sep:SetPoint("TOP", name, "BOTTOM", 0, -12)
        sep:SetAlpha(.2)
        sep:SetAtlas("spec-dividerline", true)
        sep:SetWidth(sW * 0.7)

        if i < 5 then
            local div = spec:CreateTexture()
            div:SetPoint("RIGHT", 3.5, 0)
            div:SetAtlas("spec-columndivider", true)
            div:SetHeight(HEIGHT)
        end

        local activeFrames = {}

        local aBG1 = spec:CreateTexture()
        aBG1:SetAllPoints()
        aBG1:SetAtlas("spec-selected-background1")
        aBG1:SetAlpha(.1)
        aBG1:SetBlendMode("ADD")
        tinsert(activeFrames, aBG1)
        local aBG2 = spec:CreateTexture()
        aBG2:SetAllPoints()
        aBG2:SetAtlas("spec-selected-background1")
        aBG2:SetAlpha(.1)
        aBG2:SetBlendMode("MOD")
        tinsert(activeFrames, aBG2)
        local aBGL1 = spec:CreateTexture()
        aBGL1:SetPoint("TOPLEFT", 3.5, 0)
        aBGL1:SetPoint("BOTTOMLEFT", 3.5, 0)
        aBGL1:SetAtlas("spec-selected-background2", true)
        aBGL1:SetBlendMode("ADD")
        tinsert(activeFrames, aBGL1)
        local aBGL2 = spec:CreateTexture()
        aBGL2:SetPoint("TOPLEFT", 3.5, 0)
        aBGL2:SetPoint("BOTTOMLEFT", 3.5, 0)
        aBGL2:SetAtlas("spec-selected-background3", true)
        aBGL2:SetAlpha(.1)
        aBGL2:SetBlendMode("ADD")
        tinsert(activeFrames, aBGL2)
        local aBGL3 = spec:CreateTexture()
        aBGL3:SetPoint("TOPLEFT", 3.5, 0)
        aBGL3:SetPoint("BOTTOMLEFT", 3.5, 0)
        aBGL3:SetAtlas("spec-selected-background4", true)
        aBGL3:SetAlpha(.1)
        aBGL3:SetBlendMode("ADD")
        tinsert(activeFrames, aBGL3)
        local aBGL4 = spec:CreateTexture()
        aBGL4:SetPoint("TOPLEFT", 3.5, 0)
        aBGL4:SetPoint("BOTTOMLEFT", 3.5, 0)
        aBGL4:SetAtlas("spec-selected-background5", true)
        aBGL4:SetAlpha(.1)
        aBGL4:SetBlendMode("ADD")
        tinsert(activeFrames, aBGL4)
        local aBGR1 = spec:CreateTexture()
        aBGR1:SetPoint("TOPRIGHT", -3.5, 0)
        aBGR1:SetPoint("BOTTOMRIGHT", -3.5, 0)
        aBGR1:SetAtlas("spec-selected-background2", true)
        aBGR1:SetTexCoord(1, 0, 0, 1)
        aBGR1:SetBlendMode("ADD")
        tinsert(activeFrames, aBGR1)
        local aBGR2 = spec:CreateTexture()
        aBGR2:SetPoint("TOPRIGHT", -3.5, 0)
        aBGR2:SetPoint("BOTTOMRIGHT", -3.5, 0)
        aBGR2:SetAtlas("spec-selected-background3", true)
        aBGR2:SetAlpha(.1)
        aBGR2:SetTexCoord(1, 0, 0, 1)
        aBGR2:SetBlendMode("ADD")
        tinsert(activeFrames, aBGR2)
        local aBGR3 = spec:CreateTexture()
        aBGR3:SetPoint("TOPRIGHT", -3.5, 0)
        aBGR3:SetPoint("BOTTOMRIGHT", -3.5, 0)
        aBGR3:SetAtlas("spec-selected-background4", true)
        aBGR3:SetTexCoord(1, 0, 0, 1)
        aBGR3:SetBlendMode("ADD")
        tinsert(activeFrames, aBGR3)
        local aBGR4 = spec:CreateTexture()
        aBGR4:SetPoint("TOPRIGHT", -3.5, 0)
        aBGR4:SetPoint("BOTTOMRIGHT", -3.5, 0)
        aBGR4:SetAtlas("spec-selected-background5", true)
        aBGR4:SetTexCoord(1, 0, 0, 1)
        aBGR4:SetBlendMode("ADD")
        tinsert(activeFrames, aBGR4)

        for _, aFrame in pairs(activeFrames) do
            aFrame:Hide()
        end

        spec:SetScript("OnEnter", function()
            hBG:Show()
        end)
        spec:SetScript("OnLeave", function()
            hBG:Hide()
        end)
        spec:SetScript("OnMouseUp", function()
            changeActive(i)
        end)
        activeB:SetScript("OnClick", function()
            changeActive(i)
        end)
        activeS:SetScript("OnMouseUp", function()
            local function GeneratorFunction(genOwner, rootDescription)
                ---@cast rootDescription RootMenuDescriptionProxy
                rootDescription:CreateTitle("Auto-Activate for Spec")
                rootDescription:CreateCheckbox("All Specs", function() return true end, function() end)
                rootDescription:CreateCheckbox("Balance", function() return false end, function() end)
                rootDescription:CreateCheckbox("Feral", function() return false end, function() end)
                rootDescription:CreateCheckbox("Guardian", function() return false end, function() end)
                rootDescription:CreateCheckbox("Restoration", function() return false end, function() end)
            end;


            MenuUtil.CreateContextMenu(spec, GeneratorFunction);
        end)

        specs[i] = {
            activeT = activeT,
            activeB = activeB,
            activeFrames = activeFrames,
            sample = sample,
            frame = f
        }
    end

    changeActive(1)

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

    local bottomBar = contentFrame:CreateTexture()
    bottomBar:SetPoint("BOTTOMLEFT", 0, 0)
    bottomBar:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", 0, 0)
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

Comps = components
