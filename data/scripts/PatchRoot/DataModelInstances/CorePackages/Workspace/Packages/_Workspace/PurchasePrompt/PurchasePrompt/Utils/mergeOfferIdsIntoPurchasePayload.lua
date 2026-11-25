-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local _types = require(PurchasePrompt.types)

local function mergeOfferIdsIntoPurchasePayload(str1: string?, arg1)
    if arg1 == nil or arg1.Offers == nil then
        return str1
    end

    local discounts = {}
    for _, offer in arg1.Offers do
        if type(offer) == "table" and type(offer.Id) == "string" and offer.Id ~= "" then
            table.insert(discounts, { source = "Offer", discountId = offer.Id })
        end
    end

    if #discounts == 0 then
        return str1
    end

    local result

    if type(str1) == "string" and str1 ~= "" then
        local jsonDecode = HttpService.JSONDecode
        local success
        success, result = pcall(jsonDecode, HttpService, str1)
        if not success or type(result) ~= "table" then
            return str1
        end
    else
        result = {}
    end

    result.discounts = discounts

    local success, result2 = pcall(HttpService.JSONEncode, HttpService, result)
    return if success and type(result2) == "string" then result2 else str1
end

return mergeOfferIdsIntoPurchasePayload
