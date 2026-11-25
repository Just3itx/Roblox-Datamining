-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Http = require(PurchasePromptParent.Http)
local Promise = require(PurchasePrompt.Promise)
local _ItemType = require(PurchasePrompt.Enums.ItemType)
local IAPExperience = require(PurchasePromptParent.IAPExperience)
local Logging = require(PurchasePromptParent.AppCommonLib).Logging

local _PerformFetch = Http.PerformFetch
local isEconomicRestrictionResponse = IAPExperience.Utility.isEconomicRestrictionResponse
local _types = require(PurchasePrompt.types)
local _PurchaseItemsTypes = require(PurchasePromptParent.AvatarExperienceCommon.PurchaseItemsTypes)
local Constants = require(PurchasePrompt.Misc.Constants)

if not require(PurchasePrompt.Parent.SharedFlags).FFlagPurchasePromptFetchCartPricingForLooks then
    local function performLookPurchase(arg1, str1: string, arg2)
        return arg1.performLookPurchase(str1, arg2):andThen(function(arg3)
            if type(arg3) ~= "table" then
                Logging.warn("Response from performLookPurchase is malformed!")
                return Promise.reject(PurchaseError.UnknownFailure)
            elseif isEconomicRestrictionResponse(arg3) then
                return Promise.reject(arg3)
            elseif arg3.purchaseLookStatus == "Success" or arg3.purchaseLookStatus == "PartialSuccess" then
                return Promise.resolve(arg3)
            else
                return Promise.reject(PurchaseError.UnknownFailure)
            end
        end, function(arg3)
            return Promise.reject(arg3)
        end)
    end

    return performLookPurchase
end

local function toLegacyLookPurchaseResult(tbl1, tbl2)
    local assetPurchaseStatus = {}
    local bundlePurchaseStatus = {}
    local num1 = 0
    local num2 = 0

    for _, value in ipairs(tbl1.fulfillmentGroups or {}) do
        for _, value2 in ipairs(value.lineItems or {}) do
            local var1 = tbl2[value2.collectibleProductId]
            if var1 == nil then
                continue
            end

            local str1 = if value2.status == "SUCCEEDED" then "Success" else "Failure"

            num2 += 1
            if str1 == "Success" then
                num1 += 1
            end

            if var1.itemType == Constants.ProductType.Asset then
                assetPurchaseStatus[var1.itemId] = str1
            else
                bundlePurchaseStatus[var1.itemId] = str1
            end
        end
    end

    return {
        purchaseLookStatus = if num2 > 0 and num1 == num2 then "Success" elseif num1 > 0 then "PartialSuccess" else "Failure",
        assetPurchaseStatus = assetPurchaseStatus,
        bundlePurchaseStatus = bundlePurchaseStatus
    }
end

local function performLookPurchase(arg1, str1: string, arg2)
    local tbl1 = {}
    local tbl2 = {}
    for _, value in ipairs(arg2.bulkPurchaseLineItems or {}) do
        tbl1[value.collectibleProductId] = value
        local tbl3 = {
            collectibleProductId = value.collectibleProductId,
            collectibleItemId = value.collectibleItemId,
            agreedPriceRobux = value.agreedPriceRobux,
            rentalOption = if value.rentalDays and value.rentalDays > 0 then {
                durationDays = value.rentalDays
            } else nil,
            offerIds = value.offerIds
        }
        table.insert(tbl2, tbl3)
    end

    if #tbl2 == 0 then
        return Promise.reject(PurchaseError.UnknownFailure)
    end

    return arg1.performLookPurchaseBulkPurchase(str1, arg2.idempotencyKey, tbl2):andThen(function(arg3)
        if type(arg3) ~= "table" then
            Logging.warn("Response from performLookPurchase is malformed!")
            return Promise.reject(PurchaseError.UnknownFailure)
        elseif isEconomicRestrictionResponse(arg3) then
            return Promise.reject(arg3)
        else
            local tbl3 = toLegacyLookPurchaseResult(arg3, tbl1)

            if tbl3.purchaseLookStatus == "Success" or tbl3.purchaseLookStatus == "PartialSuccess" then
                return Promise.resolve(tbl3)
            end

            return Promise.reject(PurchaseError.UnknownFailure)
        end
    end, function(arg3)
        return Promise.reject(arg3)
    end)
end

return performLookPurchase
