---@class AddonPrivate
local Private = select(2, ...)

---@class CollectionsTabUI
---@field contentFrame Frame
---@field tabSystem Frame|table
---@field contentTabs table<number, Frame>
---@field researchBar ProgressBarComponentObject
local collectionsTabUI = {
    contentFrame = nil,
    tabSystem = nil,
    contentTabs = {},
    researchBar = nil,
}
Private.CollectionsTabUI = collectionsTabUI

local const = Private.constants
local components = Private.Components

function collectionsTabUI:Init()
    local addon = Private.Addon

    addon:RegisterEvent("ADDON_LOADED", "collectionsTabUI_AddonLoaded", function(_, _, loadedAddonName)
        if loadedAddonName == "Blizzard_Collections" then
            addon:UnregisterEventCallback("ADDON_LOADED", "collectionsTabUI_AddonLoaded")
            self:SetupTab()
        end
    end)
end

function collectionsTabUI:SetupTab()
    local addon = Private.Addon

    local content = CreateFrame("Frame", nil, CollectionsJournal)
    local bg = CreateFrame("Frame", nil, content, "CollectionsBackgroundTemplate")
    bg:SetPoint("TOPLEFT", 0, -50)
    bg:SetPoint("BOTTOMRIGHT", 0, 0)
    self.contentFrame = content
    content:Hide()

    local secureTabs = LibStub("SecureTabs-2.0")
    local tab = secureTabs:Add(CollectionsJournal, content, "Legion Remix")

    function tab.OnSelect()
        CollectionsJournal:SetPortraitToAsset(const.COLLECTIONS_TAB.TAB_ICON)
    end

    local tabSys = CreateFrame("Frame", nil, content, "TabSystemTemplate")
    self.tabSystem = tabSys
    tabSys:SetPoint("TOPLEFT", 50, 30)

    tabSys:SetTabSelectedCallback(function(tabID)
        for id, tabContent in pairs(self.contentTabs) do
            tabContent:SetShown(id == tabID)
        end

        addon:SetDatabaseValue("collectionsTab.selected", tabID)
        return false
    end)

    self:SetupTraitsTab()

    local selectedID = addon:GetDatabaseValue("collectionsTab.selected") or 1
    if not self.contentTabs[selectedID] then
        selectedID = 1
    end
    tabSys:SetTab(selectedID)

    --- MOVE THIS PART TO A NEW COMPONENT!!!
    local quickActionBar = CreateFrame("Button", nil, content)
    quickActionBar:SetPoint("TOPRIGHT", content, "TOPRIGHT", -5, 30)
    quickActionBar:SetSize(25, 25)
    quickActionBar:SetHighlightAtlas("RedButton-Highlight", "ADD")
    local function updateQuickActionBarState()
        if Private.QuickActionBarUI:IsVisible() then
            quickActionBar:SetNormalAtlas("RedButton-Condense")
            quickActionBar:SetPushedAtlas("RedButton-Condense-Pressed")
            quickActionBar:SetDisabledAtlas("RedButton-Condense-Disabled")
        else
            quickActionBar:SetNormalAtlas("RedButton-Expand")
            quickActionBar:SetPushedAtlas("RedButton-Expand-Pressed")
            quickActionBar:SetDisabledAtlas("RedButton-Expand-Disabled")
        end
    end
    Private.QuickActionBarUI:Init(content)
    quickActionBar:SetScript("OnClick", function()
        Private.QuickActionBarUI:Toggle()
        updateQuickActionBarState()
    end)
    updateQuickActionBarState()

    local researchBar = components.ProgressBar:CreateFrame(content, {
        anchors = {
            { "TOPRIGHT", quickActionBar, "TOPLEFT", -10, -5 }
        },
        tooltipTextGetter = function()
            return Private.ResearchTaskUtils:GetCurrentTooltipText()
        end,
    })
    self.researchBar = researchBar
    local callbackObj = Private.ResearchTaskUtils:AddCallback(function(progress, total)
        researchBar:SetMinMaxValues(0, total or 1)
        researchBar:SetValue(progress or 0)
        researchBar:SetLabelText(string.format("Research: %s/%s", progress or "?", total or "?"))
    end)
    if callbackObj then
        callbackObj:Trigger(Private.ResearchTaskUtils:GetTaskProgress())
    end
end

function collectionsTabUI:SetupTraitsTab()
    if const.INTERFACE_VERSION > 110200 then
        local artifactTraitsContent = self:AddTopTab("Artifact Traits")
        local traitsUI = Private.ArtifactTraitsTabUI
        traitsUI:Init(artifactTraitsContent)
    end

    local collectionContent = self:AddTopTab("Collection")
    local collectionUI = Private.CollectionTabUI
    collectionUI:Init(collectionContent)
end

---@return Frame contentFrame
function collectionsTabUI:GetContentFrame()
    return self.contentFrame
end

---@param name string
---@return Frame tabContent
---@return number tabID
function collectionsTabUI:AddTopTab(name)
    local tabSystem = self.tabSystem

    local tabID = tabSystem:AddTab(name)
    local tabButton = tabSystem:GetTabButton(tabID)
    tabButton.isTabOnTop = true
    tabButton:Init(tabID, name)

    local tabContent = CreateFrame("Frame", nil, self:GetContentFrame())
    tabContent:SetAllPoints()
    tabContent:Hide()

    self.contentTabs[tabID] = tabContent

    return tabContent, tabID
end
