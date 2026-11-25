-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:08Z
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
local _types = require(PurchasePrompt.types)

local tbl1 = {}

function tbl1.new()
    return {
        purchased = false,
        productId = 0,
        reason = "",
        title = "",
        showDivId = "",
        shortfallPrice = 0,
        statusCode = 0
    }
end

function tbl1.fromJsonData(tbl2)
    local tbl3 = tbl1.new()

    ArgCheck.isType(tbl2, "table", "PurchaseExperienceProduct.fromJsonData's jsonData")
    ArgCheck.isType(tbl2.purchased, "boolean", "PurchaseExperienceProduct.fromJsonData's jsonData.purchased")
    ArgCheck.isType(tbl2.productId, "number", "PurchaseExperienceProduct.fromJsonData's jsonData.productId")
    ArgCheck.isTypeOrNil(tbl2.reason, "string", "PurchaseExperienceProduct.fromJsonData's jsonData.reason")
    ArgCheck.isTypeOrNil(tbl2.title, "string", "PurchaseProduct.fromJsonData's jsonData.title")
    ArgCheck.isTypeOrNil(tbl2.showDivId, "string", "PurchaseProduct.fromJsonData's jsonData.showDivId")
    ArgCheck.isTypeOrNil(tbl2.shortfallPrice, "number", "PurchaseProduct.fromJsonData's jsonData.shortfallPrice")
    ArgCheck.isTypeOrNil(tbl2.statusCode, "number", "PurchaseProduct.fromJsonData's jsonData.statusCode")

    tbl3.purchased = tbl2.purchased == true
    tbl3.productId = tonumber(tbl2.productId)
    tbl3.reason = tbl2.reason
    tbl3.title = tbl2.title
    tbl3.showDivId = tbl2.showDivId
    tbl3.shortfallPrice = tbl2.shortfallPrice
    tbl3.statusCode = tbl2.statusCode

    return tbl3
end

local function performExperiencePurchase(arg1, num1: number, arg2)
    return arg1.performExperiencePurchase(num1, arg2):andThen(function(arg3)
        if type(arg3) ~= "table" then
            Logging.warn("Response from performExperiencePurchase is malformed!")
            return Promise.reject(PurchaseError.UnknownFailure)
        elseif isEconomicRestrictionResponse(arg3) then
            return Promise.reject(arg3)
        else
            local jsonData = tbl1.fromJsonData(arg3)

            if jsonData.purchased then
                return Promise.resolve(jsonData)
            elseif jsonData.reason and jsonData.reason == "InsufficientFunds" then
                return Promise.reject(PurchaseError.NotEnoughRobux)
            end

            return Promise.reject(PurchaseError.UnknownFailure)
        end
    end, function(arg3)
        return Promise.reject(arg3)
    end)
end

return performExperiencePurchase
