-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Promise = require(RobloxSubscriptionPurchaseAppParent.Promise)
local GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local _LuauPolyfill = require(RobloxSubscriptionPurchaseAppParent.LuauPolyfill)
local Constants = require(RobloxSubscriptionPurchaseApp.Constants)

local MarketplaceService = game:GetService("MarketplaceService")

return function()
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function()
            return MarketplaceService:GetAvailableSubscriptionProductsAsync(Constants.ROBLOX_SUBSCRIPTION_PRODUCT_TYPE)
        end)
        if success then
            callback((GetRobloxSubscriptionProductsModel.format(result or {})))
            return
        end
        callback2(tostring(result))
    end)
end
