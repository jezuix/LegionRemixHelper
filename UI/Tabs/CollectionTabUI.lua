---@class AddonPrivate
local Private = select(2, ...)

---@class CollectionTabUI
---@field contentFrame Frame
---@field isUICreated boolean
local collectionTabUI = {
    contentFrame = nil,
    isUICreated = false,
}
Private.CollectionTabUI = collectionTabUI

local const = Private.constants
local components = Private.Components

--- MOVE TO EXTRA COMPONENT!!!!
local function createCollectionItemFrame()
    local f = CreateFrame("Button", nil, UIParent)
    f:SetSize(50, 50)

    local iconTexture = f:CreateTexture()

    local borderCollected = f:CreateTexture()

    local name = f:CreateFontString(nil, nil, "GameFontNormal")
    name:SetPoint("LEFT", f, "RIGHT", 9, 3)
    name:SetWidth(135)
    name:SetJustifyH("LEFT")

    local pushed = f:CreateTexture()
    pushed:SetTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    pushed:SetSize(42, 42)
    pushed:SetPoint("CENTER", 0, 1)
    f:SetPushedTexture(pushed)

    local highlight = f:CreateTexture()
    highlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
    highlight:SetSize(48, 48)
    highlight:SetPoint("CENTER", 0, 2)
    highlight:SetBlendMode("ADD")
    f:SetHighlightTexture(highlight)

    function f:SetCollected(isCollected)
        if isCollected then
            iconTexture:SetPoint("CENTER", 0, 1)
            iconTexture:SetSize(42, 42)
            iconTexture:SetTexCoord(.04347826, .95652173, .04347826, .95652173)
            iconTexture:SetDesaturated(false)
            iconTexture:SetAlpha(1)
            borderCollected:SetPoint("CENTER")
            borderCollected:SetSize(56, 56)
            borderCollected:SetAtlas("collections-itemborder-collected")
            name:SetTextColor(1, 0.82, 0, 1)
            name:SetShadowColor(0, 0, 0, 1)
        else
            iconTexture:SetPoint("CENTER", 0, 2)
            iconTexture:SetSize(42, 41)
            iconTexture:SetTexCoord(.063, .938, .063, .917)
            iconTexture:SetDesaturated(true)
            iconTexture:SetAlpha(.18)
            borderCollected:SetPoint("CENTER", 0, 2)
            borderCollected:SetSize(50, 50)
            borderCollected:SetAtlas("collections-itemborder-uncollected")
            name:SetTextColor(0.33, 0.27, 0.20, 1)
            name:SetShadowColor(0, 0, 0, 0.33)
        end
    end

    function f:SetItem(itemID, customName)
        self.itemID = itemID
        if self.itemID then
            local item = Item:CreateFromItemID(self.itemID)
            item:ContinueOnItemLoad(function()
                name:SetText(item:GetItemName())
                iconTexture:SetTexture(item:GetItemIcon())
            end)
        else
            self.name = customName
            name:SetText(self.name or "")
            iconTexture:SetTexture(134939)
        end
    end

    f:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.itemID then
            GameTooltip:SetItemByID(self.itemID)

            local cleanTooltip = C_TooltipInfo.GetItemByID(self.itemID)
            local lastCleanLine = _G["GameTooltipTextLeft" .. #cleanTooltip.lines]
            if lastCleanLine then
                local prevText = lastCleanLine:GetText()

                lastCleanLine:SetText(prevText .. "\n\n|cFFFFFFFF" .. self:GetParent().data:GetSourceTooltip())
            end
        else
            GameTooltip:SetText(self.name or "No Name")
        end


        GameTooltip:Show()

        f:SetScript("OnUpdate", function()
            if IsModifiedClick("DRESSUP") then
                ShowInspectCursor()
            else
                ResetCursor()
            end
        end)
    end)

    f:SetScript("OnLeave", function()
        GameTooltip:Hide()
        ResetCursor()
        f:SetScript("OnUpdate", nil)
    end)

    f:SetScript("OnClick", function(self)
        if IsModifiedClick("DRESSUP") then
            rasuH:PreviewByItemID(self.itemID)
        end
    end)

    return f
end

function collectionTabUI:CreateTabUI()
    local utils = Private.CollectionUtils

    local itemsFrame = CreateFrame("Frame", nil, self.contentFrame)
    itemsFrame:SetPoint("TOPLEFT")
    itemsFrame:SetPoint("BOTTOMRIGHT", 0, 50)

    local bottomBar = self.contentFrame:CreateTexture()
    bottomBar:SetPoint("BOTTOMLEFT", 0, 0)
    bottomBar:SetPoint("TOPRIGHT", itemsFrame, "BOTTOMRIGHT", 0, 0)
    bottomBar:SetAtlas("talents-background-bottombar", true)

    local scrollFrame = components.ScrollFrame:CreateFrame(itemsFrame, {
        anchors = {
            with_scroll_bar = {
                { "TOPLEFT",     itemsFrame, "TOPLEFT",     25,  -25 },
                { "BOTTOMRIGHT", itemsFrame, "BOTTOMRIGHT", -25, 25 },
            },
            without_scroll_bar = {
                { "TOPLEFT",     itemsFrame, "TOPLEFT",     25,  -25 },
                { "BOTTOMRIGHT", itemsFrame, "BOTTOMRIGHT", -25, 25 },
            },
        },
        element_height = 55,
        element_width = 200,
        elements_per_row = math.floor((itemsFrame:GetWidth() - 50) / 205),
        type = "GRID",
        element_padding = 5,
        initializer = function(frame, data)
            ---@cast data CollectionRewardObject
            if not frame.initialized then
                local icon = createCollectionItemFrame()
                icon:SetParent(frame)
                icon:SetPoint("LEFT", frame, "LEFT", 0, 0)

                frame.icon = icon
                frame.initialized = true
            end

            frame.data = data
            frame.icon:SetItem(data:GetItemID(), data:GetName())
            frame.icon:SetCollected(data:IsCollected())
        end
    })
    scrollFrame:UpdateContent(utils:DEV_GetEverything())

    local filterDropdown = components.Dropdown:CreateFrame(itemsFrame, {
        anchors = {
            { "RIGHT", bottomBar, "RIGHT", -15, 0 },
        },
        width = 80,
        height = 20,
        template = "WowStyle1FilterDropdownTemplate",
    })

    local searchBar = components.TextBox:CreateFrame(itemsFrame, {
        anchors = {
            { "RIGHT", filterDropdown.dropdown, "LEFT", -5, 0 },
        },
        onTextChanged = function(...)
            print(...)
        end,
        instructions = "Search",
    })

    local progress = components.ProgressBar:CreateFrame(itemsFrame, {
        anchors = {
            { "RIGHT", searchBar.editBox, "LEFT", -45, 0 },
        },
        width = 200,
        height = 12,
        barColor = CreateColor(0.2, 0.6, 0.2, 1),
    })
end

---@param contentFrame Frame
function collectionTabUI:Init(contentFrame)
    self.contentFrame = contentFrame

    contentFrame:HookScript("OnShow", function()
        if not self.isUICreated then
            self.isUICreated = true
            self:CreateTabUI()
        end
    end)
end

Comps = components
