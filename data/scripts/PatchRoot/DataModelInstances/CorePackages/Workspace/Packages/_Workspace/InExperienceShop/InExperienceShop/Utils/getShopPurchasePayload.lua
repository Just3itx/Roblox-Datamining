-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local FFlagCategoryLoggingInShopPurchase = require(InExperienceShop.Flags.FFlagCategoryLoggingInShopPurchase)

local _Types = require(InExperienceShop.Types)

local str1 = HttpService:JSONEncode("__SHOP_PURCHASE_LOCATION__")

local tbl1 = {
    "categoryGroup",
    "categoryPosition",
    "gridPositionRow",
    "gridPositionColumn",
    "categoryName",
    "stableCategoryId"
}

local function encodeLocation(arg1): string
    local tbl2 = { `"locationType":{HttpService:JSONEncode("personalizedShop")}` }
    if arg1 ~= nil then
        for _, value in tbl1 do
            local input = arg1[value]
            if input ~= nil then
                table.insert(tbl2, `{HttpService:JSONEncode(value)}:{HttpService:JSONEncode(input)}`)
            end
        end
    end
    return "{" .. table.concat(tbl2, ",") .. "}"
end

local function encodePayload(arg1): string
    local str2 = HttpService:JSONEncode({
        surface = {
            scopeType = "inExperience",
            universeId = game.GameId,
            placeId = game.PlaceId,
            location = "__SHOP_PURCHASE_LOCATION__"
        }
    })

    local var1, var2 = string.find(str2, str1, 1, true)
    assert(not (var1 == nil) and var2 ~= nil, "location placeholder missing from shop purchase payload")
    return string.sub(str2, 1, var1 - 1) .. encodeLocation(arg1) .. string.sub(str2, var2 + 1)
end

local str2 = HttpService:JSONEncode({
    surface = {
        scopeType = "inExperience",
        universeId = game.GameId,
        placeId = game.PlaceId,
        location = { locationType = "personalizedShop" }
    }
})

local function getShopPurchasePayload(arg1)
    if FFlagCategoryLoggingInShopPurchase then
        return (encodePayload(arg1))
    end

    return str2
end

return getShopPurchasePayload
