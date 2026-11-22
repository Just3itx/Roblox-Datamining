-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Url = require(RobloxSubscriptionPurchaseAppParent.Http).Url
local GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local Constants = require(RobloxSubscriptionPurchaseApp.Constants)
local HttpRequest = require(script.Parent.HttpRequest)

local var1 = Url.APIS_URL .. "subscriptions/v2/products?"

return function(num1: number?, bool1: boolean?)
    local var2 = var1
    local var3 = Url
    local tbl1 = {
        productType = Constants.ROBLOX_SUBSCRIPTION_PRODUCT_TYPE,
        includePurchased = "false",
        referrerId = tostring(num1 or 0),
        includeUpgrades = if bool1 == nil then nil else tostring(bool1)
    }
    local var4 = var2 .. var3:makeQueryString(tbl1)

    return HttpRequest.new():get(var4):andThen(function(arg1)
        return (GetRobloxSubscriptionProductsModel.formatFromRest(arg1 or {}))
    end)
end
