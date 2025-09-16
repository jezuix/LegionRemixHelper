---@class AddonPrivate
local Private = select(2, ...)

---@class ArtifactTraitUtils
---@field callbackUtils CallbackUtils
---@field baseTraits number[]
---@field rowTraits table<number, number[]>
---@field configCache number|nil
---@field specsCache number[]
---@field addon LegionRH
local artifactTraitUtils = {
    callbackUtils = nil,
    baseTraits = {},
    rowTraits = {},
    configCache = nil,
    specsCache = {},
    addon = nil
}
Private.ArtifactTraitUtils = artifactTraitUtils

local const = Private.constants

function artifactTraitUtils:Init()
    self.callbackUtils = Private.CallbackUtils
    local addon = Private.Addon
    self.addon = addon
    addon:RegisterEvent("TRAIT_CONFIG_UPDATED", "artifactTraitUtils_TRAIT_CONFIG_UPDATED", function()
        local newConfigID = self:GetConfigID()
        if not newConfigID or self.configCache == newConfigID then return end
        self.configCache = newConfigID
        self:OnConfigUpdate()
    end)
    addon:RegisterEvent("WEAPON_SLOT_CHANGED", "artifactTraitUtils_WEAPON_SLOT_CHANGED", function()
        local newConfigID = self:GetConfigID()
        if not newConfigID or self.configCache == newConfigID then return end
        self.configCache = newConfigID
        self:OnWeaponUpdate()
    end)
    addon:RegisterEvent("TRAIT_TREE_CURRENCY_INFO_UPDATED", "artifactTraitUtils_TRAIT_TREE_CURRENCY_INFO_UPDATED",
        function(_, _, treeID)
            if treeID == const.REMIX_ARTIFACT_TRAITS.TREE_ID then
                self:OnPowerUpdate()
            end
        end)
    addon:RegisterEvent("PLAYER_ENTERING_WORLD", "artifactTraitUtils_PLAYER_ENTERING_WORLD", function()
        self.baseTraits = self:BuildBuyPath(const.REMIX_ARTIFACT_TRAITS.TREE_ID, self:GetRowRootNodes())

        for _, row in pairs(const.REMIX_ARTIFACT_TRAITS.ROWS) do
            local rowPath = self:BuildBuyPath(const.REMIX_ARTIFACT_TRAITS.TREE_ID, nil, row.ROOT_NODE_ID)
            self.rowTraits[row.ID] = rowPath
        end
        self:UpdateSpecs()
    end)
end

---@param configID number
---@param availableNodes number[]
---@return number|nil cheapestNodeID
---@return number|nil cheapestNodeIndex
function artifactTraitUtils:GetCheapestNode(configID, availableNodes)
    local cheapestCost, cheapestNodeID, cheapestNodeIndex = math.huge, nil, nil

    for nodeIndex, nodeID in ipairs(availableNodes) do
        local cost = C_Traits.GetNodeCost(configID, nodeID)
        if not cost or #cost <= 0 then cost = { { amount = 0, ID = 4039 } } end
        local costNum = cost[1].amount
        if costNum < cheapestCost then
            cheapestCost = costNum
            cheapestNodeIndex = nodeIndex
            cheapestNodeID = nodeID
        end
    end

    return cheapestNodeID, cheapestNodeIndex
end

---@param treeID number
---@param stopAtNodes table<number, boolean>|nil
---@param overwriteRootNode number|nil
---@return number[]|nil pathNodeIDs
function artifactTraitUtils:BuildBuyPath(treeID, stopAtNodes, overwriteRootNode)
    local configID = C_Traits.GetConfigIDByTreeID(treeID)
    if not configID then return end
    local treeInfo = C_Traits.GetTreeInfo(configID, treeID)
    if not treeInfo then return end
    ---@diagnostic disable-next-line: undefined-field
    local rootNodeID = treeInfo.rootNodeID
    if overwriteRootNode then rootNodeID = overwriteRootNode end
    stopAtNodes = stopAtNodes or {}

    local availableNodes = { rootNodeID }
    local pathNodes = {}
    local allNodes = { [rootNodeID] = true }

    while #availableNodes > 0 do
        local nextNodeID, nextNodeIndex = self:GetCheapestNode(configID, availableNodes)
        if not nextNodeID then break end

        tinsert(pathNodes, nextNodeID)
        tremove(availableNodes, nextNodeIndex)
        allNodes[nextNodeID] = true

        local nodeInfo = C_Traits.GetNodeInfo(configID, nextNodeID)
        if not nodeInfo then break end

        for _, edgeInfo in ipairs(nodeInfo.visibleEdges) do
            local targetNodeID = edgeInfo.targetNode
            if not allNodes[targetNodeID] and not stopAtNodes[targetNodeID] then
                tinsert(availableNodes, targetNodeID)
                allNodes[targetNodeID] = true
            end
        end
    end

    return pathNodes
end

---@return boolean[] rowRootNodes
function artifactTraitUtils:GetRowRootNodes()
    local rowRootNodes = {}
    for _, row in pairs(const.REMIX_ARTIFACT_TRAITS.ROWS) do
        rowRootNodes[row.ROOT_NODE_ID] = true
    end
    return rowRootNodes
end

---@return number[] indexedRowRootNodes
function artifactTraitUtils:GetIndexedRowRootNodes()
    local indexedRowRootNodes = {}
    for _, row in pairs(const.REMIX_ARTIFACT_TRAITS.ROWS) do
        indexedRowRootNodes[row.ID] = row.ROOT_NODE_ID
    end
    return indexedRowRootNodes
end

---@return table<number, number[]> rowTraits
function artifactTraitUtils:GetRowTraits()
    return CopyTableSafe(self.rowTraits)
end

function artifactTraitUtils:GetRowTraitsForRow(rowID)
    return CopyTableSafe(self:GetRowTraits()[rowID])
end

---@param treeID number|nil
---@return number configID
function artifactTraitUtils:GetConfigID(treeID)
    return C_Traits.GetConfigIDByTreeID(treeID or const.REMIX_ARTIFACT_TRAITS.TREE_ID)
end

---@return number[] entryIDs
function artifactTraitUtils:GetJewelryTraits()
    local jewelryTraits = {}
    for _, item in pairs(const.REMIX_ARTIFACT_TRAITS.JEWELRY_ITEMS) do
        tinsert(jewelryTraits, item.ENTRY_ID)
    end
    return jewelryTraits
end

---@param slot Enum.ArtifactTraitJewelrySlot
---@return number[] entryIDs
function artifactTraitUtils:GetJewelryTraitsBySlot(slot)
    local jewelryTraits = {}
    for _, item in pairs(const.REMIX_ARTIFACT_TRAITS.JEWELRY_ITEMS) do
        if item.SLOT == slot then
            tinsert(jewelryTraits, item.ENTRY_ID)
        end
    end
    return jewelryTraits
end

---@return table<number, string> rowNames
function artifactTraitUtils:GetRowNames()
    local rowNames = {}
    for _, row in pairs(const.REMIX_ARTIFACT_TRAITS.ROWS) do
        rowNames[row.ID] = row.NAME
    end
    return rowNames
end

---@param callbackFunction fun(update: table)
---@return CallbackObject|nil callbackObject
function artifactTraitUtils:AddCallback(category, callbackFunction)
    return self.callbackUtils:AddCallback(category, callbackFunction)
end

---@param callbackObj CallbackObject
function artifactTraitUtils:RemoveCallback(callbackObj)
    self.callbackUtils:RemoveCallback(callbackObj)
end

function artifactTraitUtils:TriggerCallbacks(category)
    local callbacks = self.callbackUtils:GetCallbacks(category)
    local update = {}
    for _, callback in ipairs(callbacks) do
        callback:Trigger(update)
    end
end

function artifactTraitUtils:OnConfigUpdate()
    self:TriggerCallbacks(const.REMIX_ARTIFACT_TRAITS.CALLBACK_CATEGORY_CONFIG)
end

function artifactTraitUtils:OnWeaponUpdate()
    local newRow = self:GetPlayerRow()
    if newRow then
        self:SwitchRowTraits(newRow)
    end

    self:TriggerCallbacks(const.REMIX_ARTIFACT_TRAITS.CALLBACK_CATEGORY_SPEC)
end

function artifactTraitUtils:OnPowerUpdate()
    self:TriggerCallbacks(const.REMIX_ARTIFACT_TRAITS.CALLBACK_CATEGORY_CURRENCY)
end

---@return number[] specIDs
function artifactTraitUtils:GetSpecs()
    local specs = self.specsCache
    if not specs then
        self:UpdateSpecs()
        specs = self.specsCache
    end
    return specs
end

---@return number? specID
function artifactTraitUtils:GetSpecID()
    return PlayerUtil.GetCurrentSpecID()
end

---@return number? classID
function artifactTraitUtils:GetClassID()
    return PlayerUtil.GetClassID()
end

function artifactTraitUtils:UpdateSpecs()
    self.specsCache = {}
    for i = 1, GetNumSpecializations() do
        self.specsCache[i] = C_SpecializationInfo.GetSpecializationInfo(i)
    end
end

---@param specID number|string
---@return number|nil activeRowID
function artifactTraitUtils:GetRowForSpec(specID)
    specID = tostring(specID)
    local specActivate = self.addon:GetDatabaseValue("artifactTraits.autoActive", true)
    if specActivate and specActivate[specID] then
        return specActivate[specID]
    end
end

---@param specID number|string
---@param rowID number|nil
function artifactTraitUtils:SetRowForSpec(specID, rowID)
    specID = tostring(specID)
    local rowActive = self:GetActiveRowID()
    if rowActive == rowID then
        rowID = nil
    end
    if rowID and specID == tostring(self:GetSpecID()) then
        self:SwitchRowTraits(rowID)
    end
    self.addon:SetDatabaseValue("artifactTraits.autoActive." .. specID, rowID)
end

---@return table<number, number>
function artifactTraitUtils:GetSpecRows()
    local specRows = {}
    for _, specID in ipairs(self:GetSpecs()) do
        local rowID = self:GetRowForSpec(specID)
        if rowID then
            specRows[specID] = rowID
        end
    end
    return specRows
end

---@return number|nil activeRowID
function artifactTraitUtils:GetPlayerRow()
    local specID = self:GetSpecID()
    if not specID then return end

    return self:GetRowForSpec(specID)
end

function artifactTraitUtils:ResetTree()
    local treeID = const.REMIX_ARTIFACT_TRAITS.TREE_ID
    C_Traits.ResetTree(self:GetConfigID(treeID), treeID)
end

function artifactTraitUtils:GetBaseTraits()
    return CopyTableSafe(self.baseTraits)
end

function artifactTraitUtils:GetActiveRowID()
    local rows = self:GetIndexedRowRootNodes()
    for rowID, nodeID in pairs(rows) do
        local rowInfo = C_Traits.GetNodeInfo(self:GetConfigID(), nodeID)
        if rowInfo and rowInfo.currentRank > 0 then
            return rowID
        end
    end
end

function artifactTraitUtils:SwitchRowTraits(newRowID)
    local configID = self:GetConfigID()
    local treeID = const.REMIX_ARTIFACT_TRAITS.TREE_ID
    self:ResetTree()
    self:PurchaseNodes(treeID, self:GetBaseTraits())
    self:PurchaseNodes(treeID, self:GetBaseTraits())
    local rowTraits = self:GetRowTraitsForRow(newRowID)
    C_Traits.TryPurchaseToNode(configID, rowTraits[#rowTraits])
    C_Traits.TryPurchaseAllRanks(configID, const.REMIX_ARTIFACT_TRAITS.FINAL_TRAIT.NODE_ID)
    C_Traits.CommitConfig(configID)

    self:TriggerCallbacks(const.REMIX_ARTIFACT_TRAITS.CALLBACK_CATEGORY_ROW)
end

local TRY_PURCHASE_RESULTS = {
    SUCCESS = 0,
    NOT_ENOUGH_CURRENCY = 1,
    ALREADY_PURCHASED = 2,
    NOT_AVAILABLE = 3,
}
function artifactTraitUtils:TryPurchase(treeID, nodeID)
    local configID = self:GetConfigID(treeID)
    local costInfo = C_Traits.GetNodeCost(configID, nodeID)
    local currencyInfo = C_Traits.GetTreeCurrencyInfo(configID, treeID, false)[1]
    local currencyLeft = currencyInfo and currencyInfo.quantity or 0
    local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID)
    if not nodeInfo.isAvailable then
        return TRY_PURCHASE_RESULTS.NOT_AVAILABLE
    end
    local nodeCost = costInfo and costInfo[1] and costInfo[1].amount * nodeInfo.maxRanks or 0
    if currencyLeft < nodeCost then
        return TRY_PURCHASE_RESULTS.NOT_ENOUGH_CURRENCY
    end
    if nodeInfo.ranksPurchased >= nodeInfo.maxRanks then
        return TRY_PURCHASE_RESULTS.ALREADY_PURCHASED
    end
    if #nodeInfo.entryIDs > 1 then
        local entryID = nodeInfo.entryIDs[1]
        local success = C_Traits.SetSelection(configID, nodeID, entryID)
        local entryInfo = C_Traits.GetEntryInfo(configID, entryID)
        for i = 1, entryInfo.maxRanks - 1 do
            success = C_Traits.PurchaseRank(configID, nodeID)
            if not success then
                return TRY_PURCHASE_RESULTS.NOT_AVAILABLE
            end
        end
        if not success then
            return TRY_PURCHASE_RESULTS.NOT_AVAILABLE
        end
    else
        for i = 1, nodeInfo.maxRanks do
            local success = C_Traits.PurchaseRank(configID, nodeID)
            if not success then
                return TRY_PURCHASE_RESULTS.NOT_AVAILABLE
            end
        end
    end
    return TRY_PURCHASE_RESULTS.SUCCESS
end

function artifactTraitUtils:PurchasePossibleRanks(treeID, nodeID)
    local configID = self:GetConfigID(treeID)
    local costInfo = C_Traits.GetNodeCost(configID, nodeID)
    local currencyInfo = C_Traits.GetTreeCurrencyInfo(configID, treeID, false)[1]
    local currencyLeft = currencyInfo and currencyInfo.quantity or 0
    local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID)
    if not nodeInfo.isAvailable then
        return TRY_PURCHASE_RESULTS.NOT_AVAILABLE
    end
    if not (costInfo and costInfo[1] and costInfo[1].amount) then
        return TRY_PURCHASE_RESULTS.NOT_AVAILABLE
    end
    local costPerRank = costInfo[1].amount
    local possibleRanks = math.floor(currencyLeft / costPerRank)

    for i = 1, possibleRanks do
        local success = C_Traits.PurchaseRank(configID, nodeID)
        if not success then
            return TRY_PURCHASE_RESULTS.NOT_AVAILABLE
        end
    end
end

function artifactTraitUtils:PurchaseNodes(treeID, nodes)
    local tries = 0
    local maxTries = (#nodes * 3) + 10
    while true do
        for i, nodeID in ipairs(nodes) do
            local result = self:TryPurchase(treeID, nodeID)
            if result == TRY_PURCHASE_RESULTS.NOT_ENOUGH_CURRENCY then
                return
            end
            if result == TRY_PURCHASE_RESULTS.ALREADY_PURCHASED or result == TRY_PURCHASE_RESULTS.SUCCESS then
                tremove(nodes, i)
            end
        end
        if #nodes == 0 then
            return
        end
        if tries >= maxTries then
            print("Max tries reached when purchasing nodes.")
            return
        end
        tries = tries + 1
    end
end

rasuF = artifactTraitUtils
