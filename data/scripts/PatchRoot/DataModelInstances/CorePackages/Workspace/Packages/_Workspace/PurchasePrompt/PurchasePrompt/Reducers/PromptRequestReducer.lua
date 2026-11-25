-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local HttpService = game:GetService("HttpService")
local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local SharedFlags = require(PurchasePromptParent.SharedFlags)

local Rodux = PurchasePromptDeps.Rodux

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
local RequestVIPServerPurchase = require(PurchasePrompt.Actions.RequestVIPServerPurchase)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)
local RefreshExpectedPrice = require(PurchasePrompt.Actions.RefreshExpectedPrice)
local VIPServerCreated = require(PurchasePrompt.Actions.VIPServerCreated)
local VIPServerRenamed = require(PurchasePrompt.Actions.VIPServerRenamed)
local RequestType = require(PurchasePrompt.Enums.RequestType)

local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagLuaAppsEnablePromptVIPServerPurchase = SharedFlags.FFlagLuaAppsEnablePromptVIPServerPurchase

local FFlagStableIdempotencyKeyForProductAndGamePass = require(PurchasePrompt.Flags.FFlagStableIdempotencyKeyForProductAndGamePass)

local tbl1 = {
    requestType = RequestType.None
}
local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[RequestAssetPurchase.name] = function(_, arg1)
    local idempotencyKey = arg1.idempotencyKey
    if idempotencyKey == nil or idempotencyKey == "" then
        idempotencyKey = HttpService:GenerateGUID(false)
    end
    return {
        id = arg1.id,
        infoType = Enum.InfoType.Asset,
        requestType = RequestType.Asset,
        equipIfPurchased = arg1.equipIfPurchased,
        isRobloxPurchase = arg1.isRobloxPurchase,
        idempotencyKey = idempotencyKey,
        purchaseAuthToken = arg1.purchaseAuthToken or "",
        collectibleItemId = arg1.collectibleItemId or "",
        collectibleItemInstanceId = arg1.collectibleItemInstanceId or "",
        collectibleProductId = arg1.collectibleProductId or "",
        expectedPrice = arg1.expectedPrice or 0
    }
end

tbl2[RequestGamepassPurchase.name] = function(_, arg1)
    local tbl3 = {
        id = arg1.id,
        infoType = Enum.InfoType.GamePass,
        requestType = RequestType.GamePass,
        isRobloxPurchase = false
    }

    if FFlagStableIdempotencyKeyForProductAndGamePass then
        local idempotencyKey = arg1.idempotencyKey
        if idempotencyKey == nil or idempotencyKey == "" then
            idempotencyKey = HttpService:GenerateGUID(false)
        end
        tbl3.idempotencyKey = idempotencyKey
    end
    return tbl3
end

tbl2[RequestProductPurchase.name] = function(_, arg1)
    local tbl3 = {
        id = arg1.id,
        infoType = Enum.InfoType.Product,
        requestType = RequestType.Product,
        isRobloxPurchase = false
    }

    if FFlagStableIdempotencyKeyForProductAndGamePass then
        local idempotencyKey = arg1.idempotencyKey
        if idempotencyKey == nil or idempotencyKey == "" then
            idempotencyKey = HttpService:GenerateGUID(false)
        end
        tbl3.idempotencyKey = idempotencyKey
    end
    return tbl3
end

tbl2[RequestBundlePurchase.name] = function(_, arg1)
    local idempotencyKey = arg1.idempotencyKey
    if idempotencyKey == nil or idempotencyKey == "" then
        idempotencyKey = HttpService:GenerateGUID(false)
    end
    return {
        id = arg1.id,
        infoType = Enum.InfoType.Bundle,
        requestType = RequestType.Bundle,
        isRobloxPurchase = true,
        idempotencyKey = idempotencyKey,
        purchaseAuthToken = arg1.purchaseAuthToken or "",
        collectibleItemId = arg1.collectibleItemId or "",
        collectibleItemInstanceId = arg1.collectibleItemInstanceId or "",
        collectibleProductId = arg1.collectibleProductId or "",
        expectedPrice = arg1.expectedPrice or 0
    }
end

tbl2[RequestSubscriptionPurchase.name] = function(_, arg1)
    return {
        id = arg1.id,
        requestType = RequestType.Subscription
    }
end

tbl2[RequestAvatarCreationFeePurchase.name] = function(_, arg1)
    return {
        requestType = RequestType.AvatarCreationFee,
        humanoidModel = arg1.humanoidModel,
        id = arg1.guid
    }
end

tbl2[RequestExperiencePurchase.name] = function(_, arg1)
    return {
        requestType = RequestType.Experience,
        universeId = arg1.universeId
    }
end

tbl2[RequestLookPurchase.name] = function(_, arg1)
    return {
        requestType = RequestType.Look,
        lookId = arg1.lookId
    }
end
tbl2[RequestRobuxUpsellPurchase.name] = FFlagAXMISWithBlackbird and function(_, _)
    return {
        requestType = RequestType.RobuxUpsell
    }
end or nil

tbl2[RequestDeveloperSubscriptionPurchase.name] = function(_, arg1)
    return {
        requestType = RequestType.DeveloperSubscription,
        subscriptionId = arg1.subscriptionId,
        expectedPrice = arg1.expectedPrice
    }
end

tbl2[RequestVIPServerPurchase.name] = function(_, _)
    local tbl3 = {
        requestType = RequestType.VIPServer
    }
    if FFlagLuaAppsEnablePromptVIPServerPurchase then
        tbl3.idempotencyKey = HttpService:GenerateGUID(false)
    end
    return tbl3
end

tbl2[RefreshExpectedPrice.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.expectedPrice = arg2.expectedPrice
    return var1
end
tbl2[VIPServerCreated.name] = FFlagLuaAppsEnablePromptVIPServerPurchase and function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.vipServerId = arg2.vipServerId
    var1.vipServerName = arg2.vipServerName
    var1.vipServerAccessCode = arg2.vipServerAccessCode
    return var1
end or nil

tbl2[VIPServerRenamed.name] = FFlagLuaAppsEnablePromptVIPServerPurchase and function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.vipServerName = arg2.vipServerName
    return var1
end or nil

tbl2[CompleteRequest.name] = function(_, _)
    return tbl1
end

return (createReducer(tbl1, tbl2))
