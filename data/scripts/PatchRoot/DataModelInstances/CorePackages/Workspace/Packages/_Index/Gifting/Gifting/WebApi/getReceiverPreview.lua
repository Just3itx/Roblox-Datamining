-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local Promise = require(GiftingParent.Promise)

local GiftErrorModel = require(Gifting.Models.GiftErrorModel)
local GiftModelUtils = require(Gifting.Models.GiftModelUtils)
local ReceiverPreviewResponseModel = require(Gifting.Models.ReceiverPreviewResponseModel)
local fetchGifting = require(Gifting.WebApi.fetchGifting)
local Urls = require(Gifting.WebApi.Urls)
local _Types = require(Gifting.Types)

local function getReceiverPreview(str1: string, network)
    local var1, var2 = GiftModelUtils.nonEmptyString(str1)
    if not var1 then
        return Promise.reject(GiftErrorModel.invalidRequest(`giftId: {var2}`))
    end

    return fetchGifting({
        network = network,
        method = "GET",
        url = Urls.receiverPreview(str1),
        analyticsKey = "gifting.receiver-preview",
        decode = ReceiverPreviewResponseModel.format
    })
end

return getReceiverPreview
