---@class AddonPrivate
local Private = select(2, ...)

---@class ToastUtils
---@field addon LegionRH
local toastUtils = {
    addon = nil,
    notifiedUpgrades = {}
}
Private.ToastUtils = toastUtils

local const = Private.constants

function toastUtils:Init()
    local addon = Private.Addon
    self.addon = addon
    self:CreateSettings()

    addon:RegisterEvent("BAG_UPDATE_DELAYED", "ToastUtils_OnBagUpdateDelayed", function()
        local upgradeItem = self:GetHighestUpgradeItem()
        if upgradeItem then
            local itemLink = C_Item.GetItemLink(upgradeItem)
            if itemLink then
                self:ShowUpgradeToast(itemLink, upgradeItem)
            end
        end
    end)

    addon:RegisterEvent("ITEM_COUNT_CHANGED", "ToastUtils_OnItemCountChanged", function(_, _, itemID)
        if not itemID then return end
        if const.TOASTS.ARTIFACT.ITEM_IDS[itemID] and C_Item.GetItemCount(itemID) > 0 then
            self:ShowArtifactToast()
        end
    end)

    addon:RegisterEvent("CURRENCY_DISPLAY_UPDATE", "ToastUtils_OnQuestAccepted", function(_, _, currencyID, _, quantityChange)
        if not currencyID then return end
        if currencyID == const.TOASTS.BRONZE.CURRENCY_ID then
            local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
            local current = currencyInfo.quantity
            local percentage = (current / currencyInfo.maxQuantity) * 100
            local previous = current - (quantityChange or 0)
            local previewPercentage = (previous / currencyInfo.maxQuantity) * 100
            for _, milestone in ipairs(const.TOASTS.BRONZE.MILESTONES) do
                if previous < milestone and current >= milestone then
                    self:ShowBronzeToast(current, percentage)
                    break
                end
            end
            for _, milestone in ipairs(const.TOASTS.BRONZE.PERCENTAGE_MILESTONES) do
                if previewPercentage < milestone and percentage >= milestone then
                    self:ShowBronzeToast(current, percentage)
                    break
                end
            end
        end
    end)
end

---@return ItemLocationMixin?
function toastUtils:GetHighestUpgradeItem()
    local highestLoc, highestLevel = nil, 0
    for bagID = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
        for slotID = 1, C_Container.GetContainerNumSlots(bagID) do
            local itemLoc = ItemLocation:CreateFromBagAndSlot(bagID, slotID)
            if itemLoc:IsValid() then
                local itemGUID = C_Item.GetItemGUID(itemLoc)
                if not self.notifiedUpgrades[itemGUID] and C_Item.IsEquippableItem(C_Item.GetItemID(itemLoc)) then
                    local bagItemLevel = C_Item.GetCurrentItemLevel(itemLoc)
                    local equippedItemLevel = Private.ItemUtils:GetMinLevelForInvType(C_Item.GetItemInventoryType(itemLoc)) or 0
                    if equippedItemLevel < bagItemLevel and bagItemLevel > highestLevel then
                        highestLoc = itemLoc
                        highestLevel = bagItemLevel
                    end
                end
            end
        end
    end
    if highestLoc then
        local itemGUID = C_Item.GetItemGUID(highestLoc)

        self.notifiedUpgrades[itemGUID] = true
        return highestLoc
    end
end

function toastUtils:CreateSettings()
    local settingsUtils = Private.SettingsUtils
    local settingsCategory = settingsUtils:GetCategory()
    local settingsPrefix = "Toasts"

    settingsUtils:CreateHeader(settingsCategory, "Toasts", "Settings for the Toast feature",
        { settingsPrefix })
    settingsUtils:CreateCheckbox(settingsCategory, "ACTIVATE_TOAST_GENERAL", "BOOLEAN", "Activate Toast",
        "Show toast notifications.", true,
        settingsUtils:GetDBFunc("GETTERSETTER", "toast.activate"))
    settingsUtils:CreateCheckbox(settingsCategory, "ACTIVATE_TOAST_SOUND", "BOOLEAN", "Sound Toasts",
        "Play a sound when a toast is shown.", true,
        settingsUtils:GetDBFunc("GETTERSETTER", "toast.sound"))
    settingsUtils:CreateCheckbox(settingsCategory, "ACTIVATE_TOAST_BRONZE", "BOOLEAN", "Bronze Toasts",
        "Show toast notifications when you reach certain milestones.", true,
        settingsUtils:GetDBFunc("GETTERSETTER", "toast.bronze"))
    settingsUtils:CreateCheckbox(settingsCategory, "ACTIVATE_TOAST_ARTIFACT", "BOOLEAN", "Artifact Toasts",
        "Show toast notifications when you loot an artifact upgrade.", true,
        settingsUtils:GetDBFunc("GETTERSETTER", "toast.artifact"))
    settingsUtils:CreateCheckbox(settingsCategory, "ACTIVATE_TOAST_UPGRADE", "BOOLEAN", "Upgrade Toasts",
        "Show toast notifications when you loot a general item upgrade.", true,
        settingsUtils:GetDBFunc("GETTERSETTER", "toast.upgrade"))
    settingsUtils:CreateCheckbox(settingsCategory, "ACTIVATE_TOAST_TRAIT", "BOOLEAN", "Trait Toasts",
        "Show toast notifications when you unlocked a new trait.", true,
        settingsUtils:GetDBFunc("GETTERSETTER", "toast.trait"))
    settingsUtils:CreateButton(settingsCategory, "Test Toast",
        "Test Toast Notification",
        function()
            self:ShowToast("Test Toast", "This is a test toast notification.", const.TOASTS.PLACEHOLDER_ICON)
        end,
        "Show a test toast notification",
        true)
end

---@param toastType "activate"|"bronze"|"artifact"|"upgrade"|"trait"|"sound"
---@return boolean
function toastUtils:IsTypeActive(toastType)
    return self.addon:GetDatabaseValue("toast." .. toastType)
end

---@param title string
---@param description string
---@param texture number|string
---@param func fun(self: AlertComponentObject, button: string, down: boolean)?
function toastUtils:ShowToast(title, description, texture, func)
    if not self:IsTypeActive("activate") then
        return
    end
    Private.ToastUI:ShowToast(title, description, texture, func)

    if self:IsTypeActive("sound") then
        PlaySound(const.TOASTS.SOUND_ID, "MASTER")
    end
end

---@param amount number
function toastUtils:ShowBronzeToast(amount, percentage)
    if not self:IsTypeActive("bronze") then
        return
    end
    self:ShowToast(
        "New Bronze Milestone!",
        string.format("You have reached %d bronze! (%.2f%% to cap)", amount, percentage or 0),
        const.TOASTS.BRONZE.ICON
    )
end

function toastUtils:ShowArtifactToast()
    if not self:IsTypeActive("artifact") then
        return
    end
    self:ShowToast(
        "Artifact Upgrade found!",
        "Check your Inventory or Quick Action Bar.",
        const.TOASTS.ARTIFACT.ICON
    )
end

---@param itemLink string
---@param location ItemLocationMixin
function toastUtils:ShowUpgradeToast(itemLink, location)
    if not self:IsTypeActive("upgrade") then
        return
    end
    local icon = C_Item.GetItemIconByID(itemLink)
    self:ShowToast(
        "Item Upgrade found!",
        itemLink or "Unknown Item",
        icon or const.TOASTS.FALLBACK_ICON,
        function()
            C_Container.PickupContainerItem(location:GetBagAndSlot())
            AutoEquipCursorItem()
        end
    )
end

function toastUtils:ShowTraitToast(name, icon)
    if not self:IsTypeActive("trait") then
        return
    end
    self:ShowToast(
        "New Trait Unlocked!",
        string.format("New trait: %s", name or "Unknown Trait"),
        icon or const.TOASTS.FALLBACK_ICON
    )
end
