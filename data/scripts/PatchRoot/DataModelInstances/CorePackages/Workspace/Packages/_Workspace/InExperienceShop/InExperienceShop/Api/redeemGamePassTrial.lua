-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Url = require(InExperienceShopParent.Http).Url
local HttpClient = require(InExperienceShopParent.HttpClient)

local asPromise = HttpClient.asPromise
local createRequest = HttpClient.createRequest
local createRequestInternalNetwork = HttpClient.createRequestInternalNetwork
local decodeJson = HttpClient.decodeJson
local encodeRaw = HttpClient.encodeRaw

local getShopPurchasePayload = require(InExperienceShop.Utils.getShopPurchasePayload)

return {
    redeemGamePassTrial = function(num1: number)
        local request = createRequest({
            networkImpl = createRequestInternalNetwork(),
            method = "POST",
            url = `{Url.APIS_URL}game-passes/v1/game-passes/{num1}/trial:redeem`,
            body = getShopPurchasePayload(),
            headers = {},
            encode = encodeRaw("application/json"),
            decode = decodeJson(function<T>(arg1: T): T
                return arg1
            end),
            analyticsKey = "game-passes.redeem-trial"
        })

        return asPromise(request)
    end
}
