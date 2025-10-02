---@class AddonPrivate
local Private = select(2, ...)

---@class QuickActionBarUI
---@field frame Frame
---@field parent Frame
---@field defaultPanelInfo {area: string, pushable: number, whileDead: boolean, width: number}?
---@field selectedEditSetting {button: Button|table, data: QuickActionObject}?
local quickActionBarUI = {
    frame = nil,
    parent = nil,
    defaultPanelInfo = nil,
    selectedEditSetting = nil
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

---@return fun(gridFrame:Frame|BackdropTemplate|table, elementData:table)
function quickActionBarUI:GetSettingsListInitializer()
    return function(gridFrame, elementData)
        if not gridFrame.isInit then
            gridFrame.isInit = true

            local btn = CreateFrame("Button", nil, gridFrame)
            btn:SetAllPoints()

            local tex = btn:CreateTexture()
            tex:SetPoint("CENTER")

            local label = btn:CreateFontString(nil, nil, "GameFontHighlight")
            label:SetPoint("TOPLEFT", 36, 1)
            label:SetPoint("BOTTOMRIGHT", 0, 1)
            label:SetJustifyH("LEFT")

            btn.Label = label
            btn.Texture = tex

            function btn:UpdateState()
                if quickActionBarUI.selectedEditSetting and quickActionBarUI.selectedEditSetting.data == self.data then
                    self.Texture:SetAtlas("Options_List_Active", true)
                    self.Texture:Show()
                else
                    self.Texture:SetShown(self.over)
                    if self.over then
                        self.Texture:SetAtlas("Options_List_Hover", true)
                    end
                end
            end

            function btn:SetHover(isHovered)
                if self:IsEnabled() then
                    self.over = isHovered
                    self:UpdateState()
                    return true
                end
                return false
            end

            function btn:OnEnter()
                return self:SetHover(true)
            end

            function btn:OnLeave()
                return self:SetHover(nil)
            end

            function btn:OnClick()
                local activeSelect = quickActionBarUI.selectedEditSetting
                if not activeSelect or activeSelect.data ~= self.data then
                    local oldBtn
                    if activeSelect and activeSelect.button.data == activeSelect.data then
                        oldBtn = activeSelect.button
                    end
                    quickActionBarUI.selectedEditSetting = { button = self, data = self.data }
                    if oldBtn then
                        oldBtn:UpdateState()
                    end
                end
                self:UpdateState()
            end

            btn:SetScript("OnEnter", btn.OnEnter)
            btn:SetScript("OnLeave", btn.OnLeave)
            btn:SetScript("OnClick", btn.OnClick)

            gridFrame.button = btn
        end

        local btn = gridFrame.button
        btn.data = elementData
        btn.Label:SetText(elementData.name)

        if quickActionBarUI.selectedEditSetting and quickActionBarUI.selectedEditSetting.data == elementData then
            quickActionBarUI.selectedEditSetting.button = btn
        end
        btn:UpdateState()
    end
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
            width = 175,
            element_height = 20,
            element_padding = 5,
            elements_per_row = 1,
            type = "LIST",
            initializer = self:GetSettingsListInitializer()
        })

        local editorTitle = components.Label:CreateFrame(frame, {
            anchors = {
                { "TOPLEFT", list.scrollBox, "TOPRIGHT", 50, -15 },
                { "TOPRIGHT", -150, -15 }
            },
            font = "GameFontNormalHuge",
            text = "Editing Action",
        })

        local titlePreview = components.Label:CreateFrame(frame, {
            anchors = {
                { "TOPLEFT", editorTitle.frame, "BOTTOMLEFT", 0, -5 },
                { "TOPRIGHT", editorTitle.frame, "BOTTOMRIGHT", 0, -5 },
            },
            text = "Action Title here",
            color = const.COLORS.YELLOW
        })

        local iconPreview = components.RoundedIcon:CreateFrame(frame, {
            anchors = {
                { "TOPRIGHT", -31, -30 },
            },
            height = 40,
            width = 40,
        })
        iconPreview:SetTexture(4622476)

        local titleLabel = components.Label:CreateFrame(frame, {
            anchors = {
                { "TOPLEFT", titlePreview.frame, "BOTTOMLEFT", 0, -25 }
            },
            color = const.COLORS.YELLOW,
            text = "Action Title:",
        })

        local titleInput = components.TextBox:CreateFrame(frame, {
            anchors = {
                { "TOPRIGHT", -31, -100 },
            },
            width = 200,
        })

        local iconLabel = components.Label:CreateFrame(frame, {
            anchors = {
                { "TOPLEFT", titleLabel.frame, "BOTTOMLEFT", 0, -15 }
            },
            color = const.COLORS.YELLOW,
            text = "Icon (ID or Path):",
        })

        local iconInput = components.TextBox:CreateFrame(frame, {
            anchors = {
                { "TOPRIGHT", titleInput.editBox, "BOTTOMRIGHT", 0, -15 },
                { "TOPLEFT", titleInput.editBox, "BOTTOMLEFT", 0, -15 },
            },
        })

        local actionIDLabel = components.Label:CreateFrame(frame, {
            anchors = {
                { "TOPLEFT", iconLabel.frame, "BOTTOMLEFT", 0, -15 }
            },
            color = const.COLORS.YELLOW,
            text = "Action ID (Name or ID):",
        })

        local actionIDInput = components.TextBox:CreateFrame(frame, {
            anchors = {
                { "TOPRIGHT", iconInput.editBox, "BOTTOMRIGHT", 0, -15 },
                { "TOPLEFT", iconInput.editBox, "BOTTOMLEFT", 0, -15 },
            },
        })

        local actionTypeLabel = components.Label:CreateFrame(frame, {
            anchors = {
                { "TOPLEFT", actionIDLabel.frame, "BOTTOMLEFT", 0, -15 }
            },
            color = const.COLORS.YELLOW,
            text = "Action Type:",
        })

        local actionTypeDropdown = components.Dropdown:CreateFrame(frame, {
            anchors = {
                { "TOPRIGHT", actionIDInput.editBox, "BOTTOMRIGHT", 0, -15 },
                { "TOPLEFT", actionIDInput.editBox, "BOTTOMLEFT", -5, -15 },
            },
            dropdownType = "RADIO",
            radioOptions = {
                { "Spell", "spell" },
                { "Item", "item" },
            }
        })

        local checkUsabilityLabel = components.Label:CreateFrame(frame, {
            anchors = {
                { "TOPLEFT", actionTypeLabel.frame, "BOTTOMLEFT", 0, -15 }
            },
            color = const.COLORS.YELLOW,
            text = "Only show when usable:",
        })

        local checkUsabilityInput = components.CheckBox:CreateFrame(frame, {
            anchors = {
                { "TOPLEFT", actionTypeDropdown.dropdown, "BOTTOMLEFT", 0, -12 }
            },
            width = 20,
            height = 20,
        })

        local saveButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        saveButton:SetPoint("BOTTOMRIGHT", -31, 31)
        saveButton:SetSize(80, 22)
        saveButton:SetText(SAVE)

        local newButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        newButton:SetPoint("BOTTOMRIGHT", saveButton, "BOTTOMLEFT", -5, 0)
        newButton:SetSize(80, 22)
        newButton:SetText(NEW)

        local sampleData = {}
        for i = 1, 35 do
            tinsert(sampleData, {
                name = "Sample Item " .. i
            })
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
