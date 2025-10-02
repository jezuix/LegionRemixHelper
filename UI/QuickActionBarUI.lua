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

---@return fun(button:Button|table, elementData:QuickActionObject)
function quickActionBarUI:GetInitializer()
    return function(button, elementData)
        if not button.isInitialized then
            button.icon = button:CreateTexture(nil, "ARTWORK")
            button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            button:RegisterForClicks("AnyUp", "AnyDown")

            button:SetScript("OnSizeChanged", function(btn)
                local w, h = btn:GetSize()
                local size = math.min(w, h)
                btn.icon:ClearAllPoints()
                btn.icon:SetSize(size, size)
                btn.icon:SetPoint("CENTER")
            end)

            button:SetScript("PostClick", function()
                ---@type QuickActionObject?
                local data = button.data
                if not data then return end

                local codeStr = data:GetCustomCode()
                if not codeStr then return end

                pcall(function()
                    local loadedFunc = loadstring(codeStr)
                    if not loadedFunc then return end

                    loadedFunc()
                end)
            end)

            button.isInitialized = true
        end
        button.data = elementData

        local actionType = elementData:GetActionType()
        button:SetAttribute("type", actionType)
        button:SetAttribute(actionType, elementData:GetActionID())

        button.icon:SetTexture(elementData:GetIcon())

        button:GetScript("OnSizeChanged")(button)
    end
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
        initializer = self:GetInitializer()
    })

    for i = 1, 20 do
        Private.QuickActionBarUtils:CreateAction("spell", "Living Flame")
    end
    scrollFrame:UpdateContent(Private.QuickActionBarUtils:GetActions())
end

---@return fun(frame:Frame|BackdropTemplate|table, data:table)
function quickActionBarUI:GetTreeSettingsInitializer()
    return function(frame, data)
        if frame.isInitialized then
            return
        end
        frame.isInitialized = true
        NineSliceUtil.ApplyUniqueCornersLayout(frame, "OptionsFrame")

        local list = components.ScrollFrame:CreateFrame(frame, {
            anchors = {
                with_scroll_bar = {
                    { "TOPLEFT",    16, -15 },
                    { "BOTTOMLEFT", 16, 16 }
                },
                without_scroll_bar = {
                    { "TOPLEFT",    16, -16 },
                    { "BOTTOMLEFT", 16, 16 }
                },
            },
            width = 200,
            template = "BackdropTemplate",
            element_height = 35,
            element_padding = 5,
            elements_per_row = 1,
            type = "LIST",
            initializer = function(gridFrame)
                if gridFrame.isInit then return end
                gridFrame.isInit = true

                local tex = gridFrame:CreateTexture()
                tex:SetAllPoints()
                tex:SetColorTexture(math.random(), math.random(), math.random())
            end
        })
        local sampleData = {}
        for i = 1, 100 do
            tinsert(sampleData, {})
        end
        list:UpdateContent(sampleData)
    end
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
