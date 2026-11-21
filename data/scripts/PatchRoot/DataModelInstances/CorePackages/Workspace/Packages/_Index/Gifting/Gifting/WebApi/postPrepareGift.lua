-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")

local PrepareGiftResponseModel = require(Gifting.Models.PrepareGiftResponseModel)
local fetchGifting = require(Gifting.WebApi.fetchGifting)
local Urls = require(Gifting.WebApi.Urls)
local _Types = require(Gifting.Types)

local function postPrepareGift(body, network)
    return fetchGifting({
        network = network,
        method = "POST",
        url = Urls.prepare(),
        body = body,
        analyticsKey = "gifting.prepare",
        decode = PrepareGiftResponseModel.format
    })
end

return postPrepareGift
