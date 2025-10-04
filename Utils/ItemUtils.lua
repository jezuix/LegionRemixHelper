---@class AddonPrivate
local Private = select(2, ...)

local const = Private.constants

---@class ItemUtils
local itemUtils = {}
Private.ItemUtils = itemUtils

---@param invType Enum.InventoryType
---@return number? minLevel
function itemUtils:GetMinLevelForInvType(invType)
    local equipmentSlot = const.ITEM_TO_INV_SLOT[invType]
    if not equipmentSlot then return end
    if type(equipmentSlot) == "number" then
        local equippedItemLoc = ItemLocation:CreateFromEquipmentSlot(equipmentSlot)
        if equippedItemLoc:IsValid() then
            return C_Item.GetCurrentItemLevel(equippedItemLoc)
        end
    elseif type(equipmentSlot) == "table" then
        local minLevel = nil
        for _, slot in ipairs(equipmentSlot) do
            local equippedItemLoc = ItemLocation:CreateFromEquipmentSlot(slot)
            if equippedItemLoc:IsValid() then
                local itemLevel = C_Item.GetCurrentItemLevel(equippedItemLoc)
                if not minLevel or itemLevel < minLevel then
                    minLevel = itemLevel
                end
            end
        end
        return minLevel
    end
end
