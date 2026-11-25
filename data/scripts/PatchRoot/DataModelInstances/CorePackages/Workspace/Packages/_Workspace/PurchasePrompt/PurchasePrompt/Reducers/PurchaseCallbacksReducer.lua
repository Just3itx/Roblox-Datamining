-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetPurchaseCallbacks = require(PurchasePrompt.Actions.SetPurchaseCallbacks)

local FFlagAddOnRobloxSubscriptionUpsellSuccessCallbackToUnifiedPurchaseModal = require(PurchasePrompt.Parent.SharedFlags).FFlagAddOnRobloxSubscriptionUpsellSuccessCallbackToUnifiedPurchaseModal
local FFlagEnableLaunchAfterPurchase = require(PurchasePrompt.Parent.SharedFlags).FFlagEnableLaunchAfterPurchase

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetPurchaseCallbacks.name] = function(_, arg1)
    return {
        onFlowComplete = arg1.purchaseCallbacks.onFlowComplete,
        onPurchaseSuccess = arg1.purchaseCallbacks.onPurchaseSuccess,
        onBuyItemButtonMounted = arg1.purchaseCallbacks.onBuyItemButtonMounted,
        onPurchaseAttempt = arg1.purchaseCallbacks.onPurchaseAttempt,
        onRobloxSubscriptionUpsellSuccess = if FFlagAddOnRobloxSubscriptionUpsellSuccessCallbackToUnifiedPurchaseModal then arg1.purchaseCallbacks.onRobloxSubscriptionUpsellSuccess else nil,
        fetchProductInfo = arg1.purchaseCallbacks.fetchProductInfo,
        onLaunchAfterPurchase = if FFlagEnableLaunchAfterPurchase then arg1.purchaseCallbacks.onLaunchAfterPurchase else nil
    }
end

return (createReducer({}, tbl1))
