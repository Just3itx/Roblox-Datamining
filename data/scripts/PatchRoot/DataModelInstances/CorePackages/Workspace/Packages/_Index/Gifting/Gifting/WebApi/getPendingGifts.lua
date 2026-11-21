-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local Promise = require(GiftingParent.Promise)
local t = require(GiftingParent.t)

local GiftErrorModel = require(Gifting.Models.GiftErrorModel)
local PendingGiftsResponseModel = require(Gifting.Models.PendingGiftsResponseModel)
local fetchGifting = require(Gifting.WebApi.fetchGifting)
local Urls = require(Gifting.WebApi.Urls)
local _Types = require(Gifting.Types)

local var1 = t.optional(t.intersection(t.integer, t.numberPositive))

local function getPendingGifts(num1: number?, str1: string?, network)
    local var2, var3 = var1(num1)
    if not var2 then
        return Promise.reject(GiftErrorModel.invalidRequest(`limit: {var3}`))
    end

    return fetchGifting({
        network = network,
        method = "GET",
        url = Urls.pending(num1, str1),
        analyticsKey = "gifting.pending",
        decode = PendingGiftsResponseModel.format
    })
end

return getPendingGifts
