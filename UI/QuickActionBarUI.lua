---@class AddonPrivate
local Private = select(2, ...)

---@class QuickActionBarUI
---@field frame Frame
---@field parent Frame
---@field defaultPanelInfo {area: string, pushable: number, whileDead: boolean, width: number}?
local quickActionBarUI = {
    frame = nil,
    parent = nil,
    defaultPanelInfo = nil,
}
Private.QuickActionBarUI = quickActionBarUI

local const = Private.constants
local components = Private.Components

function quickActionBarUI:Init(parentTab)
    self.parent = parentTab
end

function quickActionBarUI:CreateFrame()
    self.defaultPanelInfo = UIPanelWindows["CollectionsJournal"]

    local f = CreateFrame("Frame", nil, self.parent, "PortraitFrameFlatBaseTemplate")
    ButtonFrameTemplate_HidePortrait(f)
    f:SetWidth(85)
    f:SetPoint("TOPLEFT", CollectionsJournal, "TOPRIGHT", 5, 0)
    f:SetPoint("BOTTOMLEFT", CollectionsJournal, "BOTTOMRIGHT", 5, 0)
    f:SetScript("OnShow", function()
        local newWidth = self.defaultPanelInfo.width + f:GetWidth()
        UIPanelWindows["CollectionsJournal"] = {
            area = self.defaultPanelInfo.area,
            pushable = self.defaultPanelInfo.pushable,
            whileDead = self.defaultPanelInfo.whileDead,
            width = newWidth,
        }
        SetUIPanelAttribute(CollectionsJournal, "width", newWidth)
        UpdateScaleForFitForOpenPanels()
    end)
    f:SetScript("OnHide", function()
        UIPanelWindows["CollectionsJournal"] = self.defaultPanelInfo
        SetUIPanelAttribute(CollectionsJournal, "width", self.defaultPanelInfo.width)
        UpdateScaleForFitForOpenPanels()
    end)
    f:Hide()
    self.frame = f
    f:SetTitle("Quick-Bar")

    local scrollFrame = components.ScrollFrame:CreateFrame(f, {
        anchors = {
            with_scroll_bar = {
                { "TOPLEFT",     20,  -30 },
                { "BOTTOMRIGHT", -25, 20 }
            },
            without_scroll_bar = {
                { "TOPLEFT",     20,  -30 },
                { "BOTTOMRIGHT", -25, 20 }
            },
        },
        template = "InsecureActionButtonTemplate",
        element_height = 35,
        element_width = 35,
        element_padding = 5,
        elements_per_row = 1,
        type = "GRID",
        initializer = function(button, elementData)
            if not button.isInitialized then
                button.icon = button:CreateTexture(nil, "ARTWORK")
                button.icon:SetTexture(134414)
                button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
                button:RegisterForClicks("AnyUp", "AnyDown")

                button:SetScript("OnSizeChanged", function(btn)
                    local w, h = btn:GetSize()
                    local size = math.min(w, h)
                    btn.icon:ClearAllPoints()
                    btn.icon:SetSize(size, size)
                    btn.icon:SetPoint("CENTER")
                end)

                button.isInitialized = true
            end

            button:SetAttribute("type", "item")
            button:SetAttribute("item", elementData.itemloc)

            -- Force initial layout
            button:GetScript("OnSizeChanged")(button)
        end
    })
    local content = {}
    for i = 1, 100 do
        content[i] = {
            itemloc = "0 1",
        }
    end
    scrollFrame:UpdateContent(content)
end

function quickActionBarUI:Toggle()
    if not self.frame then
        self:CreateFrame()
    end

    self.frame:SetShown(not self.frame:IsShown())
end

function quickActionBarUI:IsVisible()
    return self.frame and self.frame:IsShown()
end
