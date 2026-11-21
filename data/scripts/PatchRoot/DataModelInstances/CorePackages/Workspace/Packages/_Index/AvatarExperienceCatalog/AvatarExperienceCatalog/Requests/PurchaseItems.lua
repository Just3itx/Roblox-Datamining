-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local Http = require(AvatarExperienceCatalogParent.Http)
local FFlagAXMISEnableMultiShoppingUnifiedEvents = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXMISEnableMultiShoppingUnifiedEvents

local str1 = `{Http.Url.APIS_URL}cloud/v2/avatar-marketplace-orders`

local function purchaseItems(tbl1)
    local lookIds = {}
    if FFlagAXMISEnableMultiShoppingUnifiedEvents then
        if tbl1.lookId then
            table.insert(lookIds, tbl1.lookId)
        end
        if tbl1.makeupLookId then
            table.insert(lookIds, tbl1.makeupLookId)
        end
    end

    local postBody = HttpService:JSONEncode({
        purchasingUser = `users/{tbl1.userId}`,
        context = {
            productSurface = "MARKETPLACE_UA",
            lookId = tbl1.lookId,
            lookContext = FFlagAXMISEnableMultiShoppingUnifiedEvents and { lookIds = lookIds } or nil
        },
        fulfillmentGroups = {{
            strategy = "BEST_EFFORT",
            lineItems = tbl1.lineItems
        }}
    })

    local str3 = `{str1}?idempotencyKey.key={HttpService:GenerateGUID(false)}`
    return tbl1.networkImpl(str3, "POST", { postBody = postBody })
end

return purchaseItems
