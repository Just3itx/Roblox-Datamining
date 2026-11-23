-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)
local PurchasableStateEnum = require(BulkPurchaseApp.Enums.PurchasableStateEnum)
local createPurchasableItem = require(script.Parent.createPurchasableItem)
local createOwnedItem = require(script.Parent.createOwnedItem)
local createUnpurchasableItem = require(script.Parent.createUnpurchasableItem)

local FFlagAXAddPlusUpsellToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddPlusUpsellToBulkPurchase)
local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)

local function selectBulkPurchaseRequestState(arg1)
    local items = {}
    local ownedItems = {}
    local unpurchasableItems = {}
    if arg1.itemData then
        for _, value in arg1.itemData do
            if value.purchasableState == PurchasableStateEnum.Purchasable then
                table.insert(items, createPurchasableItem(value))
                if value.ownedCount and value.ownedCount > 0 then
                    table.insert(ownedItems, createOwnedItem(value))
                end
            else
                table.insert(unpurchasableItems, createUnpurchasableItem(value))
            end
        end
    end

    return {
        totalCost = arg1.totalCost or 0,
        items = items,
        ownedItems = ownedItems,
        unpurchasableItems = unpurchasableItems,
        balance = arg1.balance or 0,
        discountInformation = arg1.discountInformation,
        offerData = if FFlagAXAddOffersToBulkPurchase then arg1.offerData else nil,
        disablePurchase = if FFlagAXAddPlusUpsellToBulkPurchase then arg1.disablePurchase else nil
    }
end

return selectBulkPurchaseRequestState
