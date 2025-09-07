---@class AddonPrivate
local Private = select(2, ...)

---@class CollectionsTabUI
---@field contentFrame Frame
---@field tabSystem Frame|table
---@field contentTabs table<number, Frame>
local collectionsTabUI = {
    contentFrame = nil,
    tabSystem = nil,
    contentTabs = {},
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

    local collectionsTab = CreateFrame("Button", nil, CollectionsJournal, "CollectionsJournalTab")
    collectionsTab:SetID(const.COLLECTIONS_TAB.TAB_ID)
    collectionsTab:SetText("Legion Remix")
    collectionsTab:SetPoint("LEFT", CollectionsJournal.WarbandScenesTab, "RIGHT", 5, 0)
    PanelTemplates_TabResize(collectionsTab)

    function collectionsTab:GetTextYOffset(isSelected)
        return isSelected and -3 or 2
    end

    function collectionsTab:SetTabSelected(isSelected)
        self.Left:SetShown(not isSelected)
        self.Middle:SetShown(not isSelected)
        self.Right:SetShown(not isSelected)
        self.LeftActive:SetShown(isSelected)
        self.MiddleActive:SetShown(isSelected)
        self.RightActive:SetShown(isSelected)

        local selectedFontObject = GameFontHighlightSmall
        local unselectedFontObject = GameFontNormalSmall
        self:SetNormalFontObject(isSelected and selectedFontObject or unselectedFontObject)

        self.Text:SetPoint("CENTER", self, "CENTER", 0, self:GetTextYOffset(isSelected))
    end
    local content = CreateFrame("Frame", nil, CollectionsJournal, "CollectionsBackgroundTemplate")
    self.contentFrame = content

    local function onTabUpdate(tabID)
        local isSelected = tabID == collectionsTab:GetID()
        collectionsTab:SetTabSelected(isSelected)
        content:SetShown(isSelected)

        if isSelected then
            CollectionsJournal:SetTitle("Legion Remix")
            CollectionsJournal:SetPortraitToAsset(const.COLLECTIONS_TAB.TAB_ICON);
        end
    end

    hooksecurefunc("CollectionsJournal_SetTab", function(_, tabID)
        onTabUpdate(tabID)
        addon:SetDatabaseValue("collectionsTab.selected", tabID)
    end)
    onTabUpdate(PanelTemplates_GetSelectedTab(CollectionsJournal))

    local tabSys = CreateFrame("Frame", nil, content, "TabSystemTemplate")
    self.tabSystem = tabSys
    tabSys:SetPoint("TOPLEFT", 50, 30)

    tabSys:SetTabSelectedCallback(function(tabID)
        for id, tabContent in pairs(self.contentTabs) do
            tabContent:SetShown(id == tabID)
        end
        return false
    end)

    self:SetupTraitsTab()

    local selected = addon:GetDatabaseValue("collectionsTab.selected") or 1
    tabSys:SetTab(selected)
end

function collectionsTabUI:SetupTraitsTab()
    local tabContent = self:AddTopTab("Artifact Traits")

    local traitsUI = Private.ArtifactTraitsTabUI
    traitsUI:Init(tabContent)
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