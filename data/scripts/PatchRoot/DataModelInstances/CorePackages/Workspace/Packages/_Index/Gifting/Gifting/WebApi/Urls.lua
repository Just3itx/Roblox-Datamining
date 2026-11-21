-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local UrlBuilder = require(GiftingParent.UrlBuilder)

local UrlBuilder2 = UrlBuilder.UrlBuilder
local urlBase = UrlBuilder.UrlBase.new("economy")

local module = {}

function module.canGift()
    return UrlBuilder2.new({ base = urlBase, path = "gifting/v1/gifts/can-gift" })()
end

function module.findRecipients()
    return UrlBuilder2.new({ base = urlBase, path = "gifting/v1/gifts/find-recipients" })()
end

function module.prepare()
    return UrlBuilder2.new({ base = urlBase, path = "gifting/v1/gifts/prepare" })()
end

function module.purchase()
    return UrlBuilder2.new({ base = urlBase, path = "gifting/v1/gifts/purchase" })()
end

function module.accept()
    return UrlBuilder2.new({ base = urlBase, path = "gifting/v1/gifts/accept" })()
end

function module.reject()
    return UrlBuilder2.new({ base = urlBase, path = "gifting/v1/gifts/reject" })()
end

function module.pending(num1: number?, cursor: string?)
    return UrlBuilder2.new({
        base = urlBase,
        path = "gifting/v1/gifts/pending",
        query = {
            { name = "limit", value = "{limit}", optional = true },
            { name = "cursor", value = "{cursor}", optional = true }
        }
    })(
        {
            limit = if num1 == nil then nil else tostring(num1),
            cursor = cursor
        }
    )
end

function module.receiverPreview(giftId: string)
    return UrlBuilder2.new({ base = urlBase, path = "gifting/v1/gifts/{giftId}/receiver-preview" })({ giftId = giftId })
end

return module
