---@class AddonPrivate
local Private = select(2, ...)

---@class CollectionUtils
local collectionUtils = {
    cache = {}
}
Private.CollectionUtils = collectionUtils

local const = Private.constants

---@class RawCollectionReward
---@field REWARD_ID number
---@field REWARD_TYPE Enum.RHE_CollectionRewardType
---@field SOURCE_ID number
---@field SOURCE_TYPE Enum.RHE_CollectionSourceType
---@field PRICES? { TYPE: Enum.RHE_CollectionPriceType, AMOUNT: number }[]
---@field ILLUSION_ID number|nil

---@class CollectionRewardObject : CollectionRewardMixin

---@class CollectionRewardMixin
---@field collected boolean
---@field collectionCheckFunction (fun():isCollected:boolean)|nil
---@field icon string|number|nil
---@field tooltip string
---@field name string
---@field itemID number|nil
local collectionRewardMixin = {
    collectionCheckFunction = nil,
    collected = false,
    icon = nil,
    tooltip = "",
    name = "",
    itemID = nil
}

---@return boolean isCollected
function collectionRewardMixin:IsCollected()
    return self.collected and true or false
end

---@param isCollected boolean
function collectionRewardMixin:SetCollected(isCollected)
    self.collected = isCollected
end

function collectionRewardMixin:CheckCollected()
    if self.collectionCheckFunction then
        self.collected = self.collectionCheckFunction()
    end
end

---@param func fun():isCollected:boolean
function collectionRewardMixin:SetCollectionCheckFunction(func)
    self.collectionCheckFunction = func
end

function collectionRewardMixin:Preview()
    if self.itemID then
        collectionUtils:PreviewByItemID(self.itemID)
    end
end

---@return string|number|nil icon
function collectionRewardMixin:GetIcon()
    return self.icon
end

---@param icon string|number|nil
function collectionRewardMixin:SetIcon(icon)
    self.icon = icon
end

---@return string tooltipText
function collectionRewardMixin:GetTooltip()
    -- We should Append our text here for the general info like CTRL + LEFT Click to preview and Shift + LEFT Click to link and Shift + Right Click to add to Wishlist and also the collected status
    return self.tooltip
end

---@param tooltipText string
function collectionRewardMixin:SetTooltip(tooltipText)
    self.tooltip = tooltipText
end

---@return string name
function collectionRewardMixin:GetName()
    return self.name
end

---@param name string
function collectionRewardMixin:SetName(name)
    self.name = name
end

---@return number itemID
function collectionRewardMixin:GetItemID()
    return self.itemID
end

---@param itemID number
function collectionRewardMixin:SetItemID(itemID)
    self.itemID = itemID
end

function collectionUtils:Init()
    self:LoadRewardInfos()
end

---@param name string
---@param icon string|number
---@param tooltip string
---@param isCollected boolean
---@param collectionCheckFunction fun():isCollected:boolean)
---@param itemID number|nil
---@return CollectionRewardObject
function collectionUtils:CreateCollectionObject(name, icon, tooltip, isCollected, collectionCheckFunction, itemID)
    local obj = setmetatable({}, { __index = collectionRewardMixin })

    obj:SetName(name)
    obj:SetIcon(icon)
    obj:SetTooltip(tooltip)
    obj:SetCollected(isCollected)
    obj:SetCollectionCheckFunction(collectionCheckFunction)
    obj:SetItemID(itemID)

    return obj
end

---@param titleID number
---@return fun():isCollected:boolean
function collectionUtils:GetTitleCollectionFunction(titleID)
    return function()
        return IsTitleKnown(titleID)
    end
end

---@param setID number
---@return fun():isCollected:boolean
function collectionUtils:GetSetCollectionFunction(setID)
    return function()
        local setInfo = C_TransmogSets.GetSetInfo(setID)
        if setInfo then
            return setInfo.collected and true or false
        end
        return false
    end
end

---@param collectionObject CollectionRewardObject
---@param rewardType Enum.RHE_CollectionRewardType
function collectionUtils:AddToCache(collectionObject, rewardType)
    if not self.cache[rewardType] then
        self.cache[rewardType] = {}
    end
    table.insert(self.cache[rewardType], collectionObject)
end

---@param reward RawCollectionReward
function collectionUtils:LoadReward(reward)
    if not reward or not reward.REWARD_ID then return end
    local rewardType = reward.REWARD_TYPE
    local rtEnum = const.COLLECTIONS.ENUM.REWARD_TYPE

    if rewardType == rtEnum.TITLE then
        local titleID = reward.REWARD_ID
        local name = GetTitleName(titleID)
        if name then
            local icon = 134939
            local tooltip = name
            local collectionFunc = self:GetTitleCollectionFunction(titleID)

            local titleObj = self:CreateCollectionObject(name, icon, tooltip, collectionFunc(), collectionFunc)
            self:AddToCache(titleObj, rewardType)
        end
    elseif rewardType == rtEnum.SET then
        local itemID = reward.REWARD_ID
        local item = Item:CreateFromItemID(itemID)
        item:ContinueOnItemLoad(function()
            local icon = item:GetItemIcon()
            local name = item:GetItemName()
            local tooltip = item:GetItemLink()
            local setID = C_Item.GetItemLearnTransmogSet(itemID)
            local collectionFunc = self:GetSetCollectionFunction(setID)

            local setObj = self:CreateCollectionObject(name, icon, tooltip, collectionFunc(), collectionFunc, itemID)
            self:AddToCache(setObj, rewardType)
        end)
    elseif rewardType == rtEnum.MOUNT then
        local itemID = reward.REWARD_ID
        local item = Item:CreateFromItemID(itemID)
        item:ContinueOnItemLoad(function()
        end)
    end
end

function collectionUtils:LoadRewardInfos()
    local rewards = const.COLLECTIONS.REWARDS

    for _, reward in ipairs(rewards) do
        self:LoadReward(reward)
    end
end

---Supports: Sets, Mounts, Pets and Appearances
---@param itemID any
function collectionUtils:PreviewByItemID(itemID)
    local item = Item:CreateFromItemID(itemID)
    item:ContinueOnItemLoad(function()
        DressUpLink(item:GetItemLink())
    end)
end

rasuH = collectionUtils
