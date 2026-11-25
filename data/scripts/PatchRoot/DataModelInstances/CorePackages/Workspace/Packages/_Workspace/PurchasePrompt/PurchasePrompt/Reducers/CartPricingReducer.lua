-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local _IAPExperience = require(PurchasePromptParent.IAPExperience)

local SetCartPricingResponse = require(PurchasePrompt.Actions.SetCartPricingResponse)
local SetCartPricingFetching = require(PurchasePrompt.Actions.SetCartPricingFetching)
local SetCartPricingFetchFailed = require(PurchasePrompt.Actions.SetCartPricingFetchFailed)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)

local RequestAssetPurchase = require(PurchasePrompt.Actions.RequestAssetPurchase)
local RequestBundlePurchase = require(PurchasePrompt.Actions.RequestBundlePurchase)
local RequestGamepassPurchase = require(PurchasePrompt.Actions.RequestGamepassPurchase)
local RequestProductPurchase = require(PurchasePrompt.Actions.RequestProductPurchase)
local RequestSubscriptionPurchase = require(PurchasePrompt.Actions.RequestSubscriptionPurchase)
local RequestAvatarCreationFeePurchase = require(PurchasePrompt.Actions.RequestAvatarCreationFeePurchase)
local RequestExperiencePurchase = require(PurchasePrompt.Actions.RequestExperiencePurchase)
local RequestLookPurchase = require(PurchasePrompt.Actions.RequestLookPurchase)
local RequestRobuxUpsellPurchase = require(PurchasePrompt.Actions.RequestRobuxUpsellPurchase)
local RequestDeveloperSubscriptionPurchase = require(PurchasePrompt.Actions.RequestDeveloperSubscriptionPurchase)

local tbl1 = { response = nil, isFetching = false, requestId = nil }

local function clear()
    return tbl1
end

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[SetCartPricingFetching.name] = function(tbl3, arg1)
    return {
        response = tbl3.response,
        isFetching = true,
        requestId = arg1.requestId
    }
end

tbl2[SetCartPricingResponse.name] = function(tbl3, arg1)
    return {
        response = arg1.response,
        isFetching = false,
        requestId = tbl3.requestId
    }
end

tbl2[SetCartPricingFetchFailed.name] = clear
tbl2[CompleteRequest.name] = clear
tbl2[RequestAssetPurchase.name] = clear
tbl2[RequestBundlePurchase.name] = clear
tbl2[RequestGamepassPurchase.name] = clear
tbl2[RequestProductPurchase.name] = clear
tbl2[RequestSubscriptionPurchase.name] = clear
tbl2[RequestAvatarCreationFeePurchase.name] = clear
tbl2[RequestExperiencePurchase.name] = clear
tbl2[RequestLookPurchase.name] = clear
tbl2[RequestRobuxUpsellPurchase.name] = clear
tbl2[RequestDeveloperSubscriptionPurchase.name] = clear
return (createReducer(tbl1, tbl2))
