-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local DeveloperSubscription = require(BuildExperienceParent.DataHydration.DeveloperSubscription)
local Promise = require(BuildExperienceParent.Promise)

local FFlagBuildExperienceManageMonetizationTool = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceManageMonetizationTool

local _chatTypes = require(script.Parent.chatTypes)
local _localToolOverlay = require(script.Parent.localToolOverlay)
local createManageSubscriptionStore = require(script.Parent.createManageSubscriptionStore)
local createMonetizationToolController = require(script.Parent.createMonetizationToolController)
local toolControllerUtils = require(script.Parent.toolControllerUtils)

local ProductStatusType = DeveloperSubscription.ProductStatusType
local tbl1 = {
    consumable = DeveloperSubscription.DeveloperSubscriptionProductType.Consumable,
    currency = DeveloperSubscription.DeveloperSubscriptionProductType.Currency,
    durable = DeveloperSubscription.DeveloperSubscriptionProductType.Durable
}

local var1 = nil

local function getStore() -- Luacid: Inlined by compiler; 6 call sites recovered
    if var1 == nil then
        var1 = createManageSubscriptionStore()
    end
    return var1
end

local function deletionResult(id: string, arg1): {deleted: boolean, deletionAccepted: boolean, id: string, productStatusType: any} | {deleted: boolean, id: string}
    return if arg1 == nil or arg1.productStatusType == ProductStatusType.Deleted then {
        id = id,
        deleted = true
    } else {
        id = id,
        deleted = false,
        deletionAccepted = true,
        productStatusType = arg1.productStatusType
    }
end

local tbl2 = {
    tool = if FFlagBuildExperienceManageMonetizationTool then CreatorAgentChat.StudioManageMonetizationTool.forKind("subscription") else CreatorAgentChat.StudioManageSubscriptionTool,
    itemKind = "subscription",
    resultKey = "subscription",
    list = 0,
    mutate = 0,
    itemIdOf = 0,
    cardFields = 0
}

function tbl2.list(num1: number)
    return getStore().list(num1):andThen(function(arg1)
        return {
            count = #arg1.developerSubscriptions,
            subscriptions = arg1.developerSubscriptions,
            nextCursor = arg1.nextCursor,
            truncated = arg1.isIncomplete == true
        }
    end, function(arg1)
        if typeof(arg1) ~= "table" or arg1.code ~= "IncompleteDeveloperSubscriptionList" then
            return Promise.reject(arg1)
        end

        return {
            count = #arg1.developerSubscriptions,
            subscriptions = arg1.developerSubscriptions,
            nextCursor = arg1.nextCursor,
            truncated = true,
            truncatedReason = arg1.message
        }
    end)
end

function tbl2.mutate(num1: number, arg1)
    local subscriptionId = arg1.subscriptionId
    if arg1.action == "create" then
        return toolControllerUtils.withGeneratedImage(
            arg1.imageAssetId,
            "The subscription image could not be loaded. No subscription was created.",
            function(imageFile)
                return getStore().create(num1, {
                    name = arg1.name,
                    description = arg1.description,
                    productType = tbl1[arg1.productType],
                    currencyType = DeveloperSubscription.CurrencyType.Robux,
                    priceInRobux = arg1.priceInRobux,
                    isRegionalPricingEnabled = true,
                    imageFile = imageFile
                })
            end
        )
    elseif arg1.action == "update" then
        return toolControllerUtils.withGeneratedImage(
            arg1.imageAssetId,
            "The subscription image could not be loaded. No changes were made.",
            function(imageFile)
                return getStore().update(num1, subscriptionId, {
                    description = arg1.description,
                    currencyType = if arg1.priceInRobux == nil then nil else DeveloperSubscription.CurrencyType.Robux,
                    priceInRobux = arg1.priceInRobux,
                    isRegionalPricingEnabled = arg1.priceInRobux ~= nil or nil,
                    imageFile = imageFile
                })
            end
        )
    elseif arg1.action == "activate" then
        return getStore().activate(num1, subscriptionId)
    elseif arg1.action == "deactivate" then
        return getStore().deactivate(num1, subscriptionId, arg1.cancelRenewals == true)
    elseif arg1.action == "delete" then
        return getStore().delete(num1, subscriptionId):andThen(function(arg2)
            return (deletionResult(subscriptionId, arg2))
        end)
    end
    local reject = Promise.reject
    local tbl3 = { errorMessage = 0 }
    local action = arg1.action
    tbl3.errorMessage = ("Unsupported action '%s'."):format(tostring(action))
    return reject(tbl3)
end

function tbl2.itemIdOf(arg1)
    return arg1.subscriptionId
end

function tbl2.cardFields(arg1)
    return {
        productType = arg1.productType,
        cancelRenewals = arg1.cancelRenewals,
        imageAssetId = arg1.imageAssetId
    }
end

return function(arg1, tbl3, arg2, arg3)
    return createMonetizationToolController(tbl2, arg1, tbl3, arg2, arg3)
end
