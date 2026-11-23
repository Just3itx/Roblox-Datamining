-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)
local _BulkPurchaseRequestUnpurchasableItem = require(script.Parent.Parent.BulkPurchaseRequestUnpurchasableItem)
local PurchasableStateToItemPurchaseStatusMap = require(BulkPurchaseApp.Enums.PurchasableStateToItemPurchaseStatusMap)
local getThumbnailUrl = require(BulkPurchaseApp.Utils.getThumbnailUrl)

local function createUnpurchasableItem(arg1)
    return {
        id = arg1.id,
        name = arg1.name,
        image = getThumbnailUrl(arg1.id, arg1.type),
        status = PurchasableStateToItemPurchaseStatusMap[arg1.purchasableState] or Enum.MarketplaceItemPurchaseStatus.SystemError
    }
end

return createUnpurchasableItem
