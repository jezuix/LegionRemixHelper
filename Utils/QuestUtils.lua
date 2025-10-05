---@class AddonPrivate
local Private = select(2, ...)

---@class QuestUtils
---@field addon LegionRH
local questUtils = {
    addon = nil,
    ---@type table<any, string>
    L = nil,
}
Private.QuestUtils = questUtils

function questUtils:Init()
    self.L = Private.L
    local addon = Private.Addon
    self.addon = addon

    addon:RegisterEvent("GOSSIP_SHOW", "QuestUtils_GossipShow", function()
        self:OnGossipShow()
    end)

    addon:RegisterEvent("QUEST_COMPLETE", "QuestUtils_QuestComplete", function()
        self:OnQuestComplete()
    end)

    addon:RegisterEvent("QUEST_DETAIL", "QuestUtils_QuestDetail", function()
        self:OnQuestDetail()
    end)

    self:CreateSettings()
end

function questUtils:CreateSettings()
    local settingsUtils = Private.SettingsUtils
    local settingsCategory = settingsUtils:GetCategory()
    local settingsPrefix = self.L["QuestUtils.SettingsCategoryPrefix"]

    settingsUtils:CreateHeader(settingsCategory, settingsPrefix, self.L["QuestUtils.SettingsCategoryTooltip"],
        { settingsPrefix })
    settingsUtils:CreateCheckbox(settingsCategory, "AUTO_QUEST_TURN_IN", "BOOLEAN", self.L["QuestUtils.AutoTurnIn"],
        self.L["QuestUtils.AutoTurnInTooltip"], true,
        settingsUtils:GetDBFunc("GETTERSETTER", "quest.autoTurnIn"))
    settingsUtils:CreateCheckbox(settingsCategory, "AUTO_QUEST_ACCEPT", "BOOLEAN", self.L["QuestUtils.AutoAccept"],
        self.L["QuestUtils.AutoAcceptTooltip"], true,
        settingsUtils:GetDBFunc("GETTERSETTER", "quest.autoAccept"))
end

---@param functionType "autoAccept" | "autoTurnIn"
---@return boolean
function questUtils:IsActive(functionType)
    return self.addon:GetDatabaseValue("quest." .. functionType)
end

function questUtils:OnGossipShow()
    if self:IsActive("autoTurnIn") then
        local activeQuests = C_GossipInfo.GetActiveQuests()
        if activeQuests then
            for _, questInfo in ipairs(activeQuests) do
                if questInfo.isComplete then
                    C_GossipInfo.SelectActiveQuest(questInfo.questID)
                    break
                end
            end
        end
    end
    if self:IsActive("autoAccept") then
        local availableQuests = C_GossipInfo.GetAvailableQuests()
        if availableQuests then
            for _, questInfo in ipairs(availableQuests) do
                C_GossipInfo.SelectAvailableQuest(questInfo.questID)
                break
            end
        end
    end
end

function questUtils:OnQuestComplete()
    if self:IsActive("autoTurnIn") then
        if GetNumQuestRewards() > 0 then return end

        ---@diagnostic disable-next-line: param-type-mismatch
        GetQuestReward(nil)
    end
end

function questUtils:OnQuestDetail()
    if self:IsActive("autoAccept") then
        AcceptQuest()
    end
end
