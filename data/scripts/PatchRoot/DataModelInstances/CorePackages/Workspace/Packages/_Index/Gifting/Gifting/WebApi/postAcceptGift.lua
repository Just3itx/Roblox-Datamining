-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")

local fetchGifting = require(Gifting.WebApi.fetchGifting)
local Urls = require(Gifting.WebApi.Urls)
local _Types = require(Gifting.Types)

local function postAcceptGift(body, network)
    return fetchGifting({
        network = network,
        method = "POST",
        url = Urls.accept(),
        body = body,
        analyticsKey = "gifting.accept",
        decode = function()
            return {}
        end
    })
end

return postAcceptGift
