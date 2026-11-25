-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetPurchaseAnalyticsMetadata = require(PurchasePrompt.Actions.SetPurchaseAnalyticsMetadata)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)
local FFlagPassShopPurchaseSurfaceToBuyModal = require(PurchasePromptParent.SharedFlags).FFlagPassShopPurchaseSurfaceToBuyModal

local tbl1 = {}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[SetPurchaseAnalyticsMetadata.name] = function(_, arg1)
    return {
        purchaseFlowUUID = arg1.purchaseAnalyticsMetadata.purchaseFlowUUID,
        surface = arg1.purchaseAnalyticsMetadata.surface,
        productId = arg1.purchaseAnalyticsMetadata.productId,
        productType = arg1.purchaseAnalyticsMetadata.productType,
        productTargetId = arg1.purchaseAnalyticsMetadata.productTargetId,
        saleLocationUniverseId = arg1.purchaseAnalyticsMetadata.saleLocationUniverseId,
        productUniverseId = arg1.purchaseAnalyticsMetadata.productUniverseId,
        price = arg1.purchaseAnalyticsMetadata.price,
        userRobuxBalance = arg1.purchaseAnalyticsMetadata.userRobuxBalance,
        eventMetadata = arg1.purchaseAnalyticsMetadata.eventMetadata
    }
end

tbl2[CompleteRequest.name] = function(arg1, _)
    return if FFlagPassShopPurchaseSurfaceToBuyModal then tbl1 else arg1
end

return (createReducer(tbl1, tbl2))
