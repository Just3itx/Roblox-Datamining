-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local _HttpService = game:GetService("HttpService")
local PurchasePromptParent = PurchasePrompt.Parent

local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Http = require(PurchasePromptParent.Http)
local ArgCheck = require(PurchasePromptParent.ArgCheck)
local Promise = require(PurchasePrompt.Promise)
local IAPExperience = require(PurchasePromptParent.IAPExperience)
local Logging = require(PurchasePromptParent.AppCommonLib).Logging

local _Url = Http.Url
local _PerformFetch = Http.PerformFetch
local isEconomicRestrictionResponse = IAPExperience.Utility.isEconomicRestrictionResponse
local parseDevProductPurchaseError = require(PurchasePrompt.Utils.parseDevProductPurchaseError)

local FFlagEnableDevProductPendingProductsLimitExceededInUnifiedPurchase = require(PurchasePromptParent.SharedFlags).FFlagEnableDevProductPendingProductsLimitExceededInUnifiedPurchase
local _types = require(PurchasePrompt.types)

local tbl1 = {}

function tbl1.new()
    return {
        price = 0,
        productId = 0,
        purchased = false,
        receipt = "",
        success = false,
        transactionStatus = ""
    }
end

function tbl1.fromJsonData(tbl2)
    local tbl3 = tbl1.new()

    ArgCheck.isType(tbl2, "table", "PurchaseDeveloperProductModel.fromJsonData's jsonData")
    ArgCheck.isType(tbl2.price, "number", "PurchaseDeveloperProductModel.fromJsonData's jsonData.price")
    ArgCheck.isType(tbl2.productId, "number", "PurchaseDeveloperProductModel.fromJsonData's jsonData.productId")
    ArgCheck.isType(tbl2.purchased, "boolean", "PurchaseDeveloperProductModel.fromJsonData's jsonData.purchased")
    ArgCheck.isTypeOrNil(tbl2.receipt, "string", "PurchaseDeveloperProductModel.fromJsonData's jsonData.receipt")
    ArgCheck.isTypeOrNil(tbl2.success, "boolean", "PurchaseDeveloperProductModel.fromJsonData's jsonData.success")
    ArgCheck.isTypeOrNil(
        tbl2.transactionStatus,
        "string",
        "PurchaseDeveloperProductModel.fromJsonData's jsonData.transactionStatus"
    )

    tbl3.price = tbl2.price
    tbl3.productId = tbl2.productId
    tbl3.purchased = tbl2.purchased == true
    tbl3.receipt = tbl2.receipt
    tbl3.success = tbl2.success == true
    tbl3.transactionStatus = tbl2.transactionStatus

    return tbl3
end

local function performDevProductEdpPurchase(arg1, num1: number, arg2)
    return arg1.performDevProductEdpPurchase(num1, arg2):andThen(function(arg3)
        if type(arg3) ~= "table" then
            Logging.warn("Response from PurchaseDeveloperProduct is malformed!")
            return Promise.reject(PurchaseError.UnknownFailure)
        elseif isEconomicRestrictionResponse(arg3) then
            return Promise.reject(arg3)
        else
            if FFlagEnableDevProductPendingProductsLimitExceededInUnifiedPurchase then
                local var1 = parseDevProductPurchaseError(arg3)
                if var1 == PurchaseError.PendingProductsLimitExceeded then
                    return Promise.reject(var1)
                end
            end

            local jsonData = tbl1.fromJsonData(arg3)

            if jsonData.purchased then
                return Promise.resolve(jsonData)
            end

            return Promise.reject(PurchaseError.UnknownFailure)
        end
    end, function(arg3)
        return Promise.reject(arg3)
    end)
end

return performDevProductEdpPurchase
