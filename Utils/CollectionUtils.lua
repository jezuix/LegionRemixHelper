---@class AddonPrivate
local Private = select(2, ...)

---@class CollectionUtils
local collectionUtils = {
    cache = {},
    vendorCache = nil,
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

---@class CombinedCollectionReward
---@field REWARD_ID number
---@field REWARD_TYPE Enum.RHE_CollectionRewardType
---@field SOURCES { SOURCE_ID: number, SOURCE_TYPE: Enum.RHE_CollectionSourceType }[]
---@field PRICES? { TYPE: Enum.RHE_CollectionPriceType, AMOUNT: number }[]
---@field ILLUSION_ID number|nil

---@class NPCInfo
---@field ID number
---@field NAME string
---@field LOCATION { MAP_ID: number, X: number, Y: number }

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
function collectionRewardMixin:GetSourceTooltip()
    return self.tooltip
end

---@param tooltipText string
function collectionRewardMixin:SetSourceTooltip(tooltipText)
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
---@param sourceTooltip string
---@param isCollected boolean
---@param collectionCheckFunction fun():isCollected:boolean)
---@param itemID number|nil
---@return CollectionRewardObject
function collectionUtils:CreateCollectionObject(name, icon, sourceTooltip, isCollected, collectionCheckFunction, itemID)
    local obj = setmetatable({}, { __index = collectionRewardMixin })

    obj:SetName(name)
    obj:SetIcon(icon)
    obj:SetSourceTooltip(sourceTooltip)
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

function collectionUtils:CacheReverseVendorLookup()
    self.vendorCache = self.vendorCache or {}
    local npcs = const.NPC
    for _, npc in pairs(npcs) do
        self.vendorCache[npc.ID] = npc
    end
end

---@param npcID number
---@return NPCInfo|nil npcInfo
function collectionUtils:GetVendorByID(npcID)
    if not self.vendorCache then
        self:CacheReverseVendorLookup()
    end

    return self.vendorCache[npcID]
end

---@param reward CombinedCollectionReward
---@return string sourceTooltip
function collectionUtils:GetSourceTooltip(reward)
    local tooltip = "Sources:"

    for _, source in ipairs(reward.SOURCES) do
        if source.SOURCE_TYPE == const.COLLECTIONS.ENUM.SOURCE_TYPE.ACHIEVEMENT then
            local name = select(2, GetAchievementInfo(source.SOURCE_ID))
            tooltip = tooltip .. "\n" .. CONTENT_TRACKING_ACHIEVEMENT_FORMAT:format(name)
        elseif source.SOURCE_TYPE == const.COLLECTIONS.ENUM.SOURCE_TYPE.VENDOR then
            local vendorInfo = self:GetVendorByID(source.SOURCE_ID)
            local name = vendorInfo and vendorInfo.NAME or "Unknown Vendor"

            local bronzeAmount = 0
            for _, priceInfo in ipairs(reward.PRICES) do
                if priceInfo.TYPE == const.COLLECTIONS.ENUM.PRICE_TYPE.BRONZE then
                    bronzeAmount = bronzeAmount + (priceInfo.AMOUNT or 0)
                end
            end
            tooltip = tooltip .. "\n" .. CONTENT_TRACKING_VENDOR_COST_FORMAT:format(name, bronzeAmount)
        end
    end

    return tooltip
end

---@param reward CombinedCollectionReward
function collectionUtils:LoadReward(reward)
    if not reward or not reward.REWARD_ID then return end
    local rewardType = reward.REWARD_TYPE
    local rtEnum = const.COLLECTIONS.ENUM.REWARD_TYPE
    local tooltip = self:GetSourceTooltip(reward)

    if rewardType == rtEnum.TITLE then
        local titleID = reward.REWARD_ID
        local name = GetTitleName(titleID)
        if name then
            local icon = 134939
            tooltip = name
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

    local combinedRewards = {}
    for _, reward in ipairs(rewards) do
        local key = reward.REWARD_TYPE .. "_" .. reward.REWARD_ID
        if not combinedRewards[key] then
            combinedRewards[key] = {
                REWARD_ID = reward.REWARD_ID,
                REWARD_TYPE = reward.REWARD_TYPE,
                SOURCES = {},
                PRICES = reward.PRICES,
                ILLUSION_ID = reward.ILLUSION_ID
            }
        end
        if not combinedRewards[key].PRICES and reward.PRICES then
            combinedRewards[key].PRICES = reward.PRICES
        end
        tinsert(combinedRewards[key].SOURCES, { SOURCE_ID = reward.SOURCE_ID, SOURCE_TYPE = reward.SOURCE_TYPE })
    end

    for _, reward in pairs(combinedRewards) do
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

function collectionUtils:DEV_GetEverything()
    --- We should probably sort the rewards to keep things consistent
    local items = {}
    for rewardType, rewards in pairs(self.cache) do
        for _, reward in ipairs(rewards) do
            tinsert(items, reward)
        end
    end

    return items
end

rasuH = collectionUtils
