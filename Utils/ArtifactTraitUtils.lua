---@class AddonPrivate
local Private = select(2, ...)

---@class ArtifactTraitUtils
---@field ui ScrappingUI
local artifactTraitUtils = {
    baseTraits = {},
    rowTraits = {},
}
Private.ArtifactTraitUtils = artifactTraitUtils

local const = Private.constants

function artifactTraitUtils:Init()
    self.baseTraits = self:BuildBuyPath(const.REMIX_ARTIFACT_TRAITS.TREE_ID, self:GetRowRootNodes())

    for _, row in pairs(const.REMIX_ARTIFACT_TRAITS.ROWS) do
        local rowPath = self:BuildBuyPath(const.REMIX_ARTIFACT_TRAITS.TREE_ID, nil, row.ROOT_NODE_ID)
        self.rowTraits[row.ID] = rowPath
    end
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

---@return table<number, boolean> rowRootNodes
function artifactTraitUtils:GetRowRootNodes()
    local rowRootNodes = {}
    for _, row in pairs(const.REMIX_ARTIFACT_TRAITS.ROWS) do
        rowRootNodes[row.ROOT_NODE_ID] = true
    end
    return rowRootNodes
end

---@return table<number, number[]> rowTraits
function artifactTraitUtils:GetRowTraits()
    return self.rowTraits
end

---@param treeID number|nil
---@return number configID
function artifactTraitUtils:GetConfigID(treeID)
    return C_Traits.GetConfigIDByTreeID(treeID or const.REMIX_ARTIFACT_TRAITS.TREE_ID)
end

rasuF = artifactTraitUtils