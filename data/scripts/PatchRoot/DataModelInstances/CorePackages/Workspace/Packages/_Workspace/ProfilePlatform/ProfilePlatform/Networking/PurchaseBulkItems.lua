-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Http = require(ProfilePlatformParent.Http)
local myRoduxNetworkingImpl = require(ProfilePlatform.Networking.myRoduxNetworkingImpl)

local str1 = `{Http.Url.APIS_URL}cloud/v2/avatar-marketplace-orders`

local function PurchaseBulkItems(tbl1)
    local postBody = HttpService:JSONEncode({
        purchasingUser = `users/{tbl1.userId}`,
        context = { productSurface = "MARKETPLACE_UA" },
        fulfillmentGroups = {{
            strategy = "BEST_EFFORT",
            lineItems = tbl1.lineItems
        }}
    })

    local str3 = `{str1}?idempotencyKey.key={HttpService:GenerateGUID(false)}`
    return myRoduxNetworkingImpl(str3, "POST", { postBody = postBody })
end

return PurchaseBulkItems
