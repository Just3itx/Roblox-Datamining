-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local Promise = require(GiftingParent.Promise)
local t = require(GiftingParent.t)

local CanGiftResponseModel = require(Gifting.Models.CanGiftResponseModel)
local GiftErrorModel = require(Gifting.Models.GiftErrorModel)
local fetchGifting = require(Gifting.WebApi.fetchGifting)
local Urls = require(Gifting.WebApi.Urls)
local _Types = require(Gifting.Types)

local var1 = t.strictInterface({ items = t.array(t.strictInterface({ itemType = t.string, itemId = t.string })) })

local function postCanGift(body, network)
    local var2, var3 = var1(body)
    if not var2 then
        return Promise.reject(GiftErrorModel.invalidRequest(var3))
    end

    return fetchGifting({
        network = network,
        method = "POST",
        url = Urls.canGift(),
        body = body,
        analyticsKey = "gifting.can-gift",
        decode = CanGiftResponseModel.format
    })
end

return postCanGift
