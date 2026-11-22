-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Promise = require(RobloxSubscriptionPurchaseAppParent.Promise)
local UrlBuilder = require(RobloxSubscriptionPurchaseAppParent.UrlBuilder).UrlBuilder
local UrlBase = require(RobloxSubscriptionPurchaseAppParent.UrlBuilder).UrlBase

local Constants = require(RobloxSubscriptionPurchaseApp.Constants)
local HttpRequest = require(script.Parent.HttpRequest)
local _SubscriptionGrantType = require(RobloxSubscriptionPurchaseApp.Enums.SubscriptionGrantType)

local ROBLOX_SUBSCRIPTION_PRODUCT_TYPE = Constants.ROBLOX_SUBSCRIPTION_PRODUCT_TYPE

local urlBuilder = UrlBuilder.new({
    base = UrlBase.APIS,
    path = "subscriptions/v2/products",
    query = {
        { name = "productType", value = ROBLOX_SUBSCRIPTION_PRODUCT_TYPE, optional = false },
        { name = "includePurchased", value = "false", optional = false },
        { name = "grantType", value = "{grantType}", optional = false }
    }
})

local urlBuilder2 = UrlBuilder.new({
    base = UrlBase.APIS,
    path = "subscriptions/v2/products/" .. ROBLOX_SUBSCRIPTION_PRODUCT_TYPE .. "/{productId}/claim",
    query = {{ name = "grantType", value = "{grantType}", optional = false }}
})

return function(grantType)
    local httpRequest = HttpRequest.new()

    return httpRequest:get((urlBuilder({ grantType = grantType }))):andThen(function(arg1)
        local product = arg1 and arg1.products and arg1.products[1]
        local id = product and product.productKey and product.productKey.id
        if not id or id == "" then
            return Promise.reject("No eligible trial product found")
        end

        local var1 = urlBuilder2({ productId = id, grantType = grantType })

        return httpRequest:post(var1, {})
    end)
end
