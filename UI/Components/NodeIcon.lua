---@class AddonPrivate
local Private = select(2, ...)

Private.Components = Private.Components or {}

---@class NodeIconComponentObject: NodeIconComponentMixin

---@alias NodeIconState "DISABLED"|"EMPTY"|"SELECT"

local stateAtlas = {
    ["DISABLED"] = "talents-node-pvp-locked",
    ["EMPTY"] = "talents-node-pvp-green",
    ["SELECT"] = "talents-node-choice-yellow"
}

---@param self Frame|table
---@param mouseButton string
---@param isDown boolean
local function onClick(self, mouseButton, isDown)
    local obj = self.obj
    ---@cast obj NodeIconComponentObject

    if obj:GetOnClick() and not obj:IsDisabled() then
        obj:GetOnClick()(obj, mouseButton, isDown)
    end
end

---@class NodeIconComponentOptions
---@field frame_strata FrameStrata?
---@field width number?
---@field height number?
---@field anchors table?
---@field disabled boolean?
---@field onClick fun(self, mouseButton:string, isDown:boolean)?
local defaultOptions = {
    frame_strata = "HIGH",
    width = 58,
    height = 52,
    anchors = {
        { "CENTER" }
    },
    disabled = false,
    onClick = nil,
    state = "EMPTY",
}

---@class NodeIconComponent
---@field defaultOptions NodeIconComponentOptions
local nodeIconComponent = {
    defaultOptions = defaultOptions,
}
Private.Components.NodeIcon = nodeIconComponent

local componentsBase = Private.Components.Base

---@class NodeIconComponentMixin
---@field frame Frame|table
---@field bg Texture
---@field border Texture
---@field disabled boolean
---@field onClick fun(self, mouseButton:string, isDown:boolean)|nil
---@field state NodeIconState|nil
local nodeIconComponentMixin = {
    disabled = false,
    onClick = nil,
    state = nil,
}

---@param iconTexture number|string
function nodeIconComponentMixin:SetIconTexture(iconTexture)
    self.bg:SetTexture(iconTexture)
end

---@param atlas string
function nodeIconComponentMixin:SetIconAtlas(atlas)
    self.bg:SetAtlas(atlas)
end

---@param isDisabled boolean
function nodeIconComponentMixin:SetDisabled(isDisabled)
    self.disabled = isDisabled
end

---@return boolean
function nodeIconComponentMixin:IsDisabled()
    return self.disabled
end

---@param newOnClick fun(self, mouseButton:string, isDown:boolean)
function nodeIconComponentMixin:SetOnClick(newOnClick)
    self.onClick = newOnClick
end

---@return fun(self: any, mouseButton: string, isDown: boolean)|nil
function nodeIconComponentMixin:GetOnClick()
    return self.onClick
end

---@param state NodeIconState
function nodeIconComponentMixin:SetState(state)
    self:SetDisabled(state == "DISABLED")
    self.state = state

    self.border:SetAtlas(stateAtlas[state])
end

---@return NodeIconState|nil
function nodeIconComponentMixin:GetState()
    return self.state
end

---@param parent Frame?
---@param options NodeIconComponentOptions
---@return NodeIconComponentObject sampleFrame
function nodeIconComponent:CreateFrame(parent, options)
    parent = parent or UIParent
    if not options.frame_strata then
        options.frame_strata = parent:GetFrameStrata()
    end
    options = componentsBase:MixTables(defaultOptions, options)

    local frame = CreateFrame("Frame", nil, parent)
    frame:SetFrameStrata(options.frame_strata)
    frame:SetSize(options.width, options.height)

    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetPoint("CENTER")
    local function updateBgSize(w, h)
        local wScale = 36/58
        local hScale = 36/52
        bg:SetSize(w * wScale, h * hScale)
    end
    updateBgSize(options.width, options.height)
    bg:SetAtlas("talents-node-pvp-inspect-empty")

    local mask = frame:CreateMaskTexture()
    mask:SetAllPoints(bg)
    mask:SetTexture("interface/talentframe/talentsmasknodechoice", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    bg:AddMaskTexture(mask)

    local border = frame:CreateTexture(nil, "BORDER")
    border:SetAllPoints()
    border:SetAtlas(stateAtlas["EMPTY"])

    for _, anchor in ipairs(options.anchors) do
        frame:SetPoint(unpack(anchor))
    end

    frame:SetMouseClickEnabled(true)
    frame:SetScript("OnMouseDown", onClick)
    frame:SetScript("OnSizeChanged", function(_, w, h)
        updateBgSize(w, h)
    end)

    return self:CreateObject(frame, bg, border, options)
end

---@param frame Frame|table
---@param bg Texture
---@param border Texture
---@param options NodeIconComponentOptions
---@return NodeIconComponentObject
function nodeIconComponent:CreateObject(frame, bg, border, options)
    local obj = {}
    setmetatable(obj, { __index = nodeIconComponentMixin })
    ---@cast obj NodeIconComponentObject
    frame.obj = obj

    obj.frame = frame
    obj.bg = bg
    obj.border = border

    obj:SetDisabled(options.disabled)
    obj:SetOnClick(options.onClick)
    obj:SetState(options.state)

    return obj
end
