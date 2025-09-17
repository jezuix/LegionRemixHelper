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

function collectionTabUI:CreateTabUI()
    local utils = Private.CollectionUtils

    local itemsFrame = CreateFrame("Frame", nil, self.contentFrame)
    itemsFrame:SetPoint("TOPLEFT")
    itemsFrame:SetPoint("BOTTOMRIGHT", 0, 50)

    local bottomBar = self.contentFrame:CreateTexture()
    bottomBar:SetPoint("BOTTOMLEFT", 0, 0)
    bottomBar:SetPoint("TOPRIGHT", itemsFrame, "BOTTOMRIGHT", 0, 0)
    bottomBar:SetAtlas("talents-background-bottombar", true)

    local filterDropdown = components.Dropdown:CreateFrame(itemsFrame, {
        anchors = {
            {"RIGHT", bottomBar, "RIGHT", -15, 0},
        },
        width = 80,
        height = 20,
        template = "WowStyle1FilterDropdownTemplate",
    })

    local searchBar = components.TextBox:CreateFrame(itemsFrame, {
        anchors = {
            {"RIGHT", filterDropdown.dropdown, "LEFT", -5, 0},
        },
        onTextChanged = function(...)
            print(...)
        end,
        instructions = "Search",
    })

    local progress = components.ProgressBar:CreateFrame(itemsFrame, {
        anchors = {
            {"RIGHT", searchBar.editBox, "LEFT", -45, 0},
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
