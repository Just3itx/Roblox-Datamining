-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local HttpService = game:GetService("HttpService")

local GamePlayButtonParent = GamePlayButton.Parent
local Url = require(GamePlayButtonParent.Http).Url

local function FiatPaidAccessPostPreparePurchaseRequest(arg1, rootPlaceId, expectedBasePriceId)
    return arg1(
        string.format("%s/fiat-paid-access-service/v1/purchase", Url.APIS_URL),
        "POST",
        {
            postBody = HttpService:JSONEncode({ expected_base_price_id = expectedBasePriceId, root_place_id = rootPlaceId })
        }
    )
end

return FiatPaidAccessPostPreparePurchaseRequest
