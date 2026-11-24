-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local Errors = require(script.Parent.Errors)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)

local function getProductInfo(assetId: number, infoType: Enum.InfoType?)
    return Promise.new(function(callback, callback2)
        task.spawn(function()
            ShopDebugLogger.logLazy(function(): string
                return "getProductInfo: call id=" .. assetId .. " infoType=" .. tostring(infoType)
            end)
            local var1 = ShopDebugLogger.startTimer()
            local success, result = pcall(function()
                return MarketplaceService:GetProductInfoAsync(assetId, infoType)
            end)
            if success then
                ShopDebugLogger.logElapsedLazy(function(): string
                    return "getProductInfo: success id=" .. assetId
                end, var1)

                callback(result)
                return
            end
            ShopDebugLogger.logElapsedLazy(function(): string
                return "getProductInfo: error id=" .. assetId
            end, var1)

            ShopDebugLogger.logLazy(function(): string
                return "getProductInfo: error detail=" .. tostring(result)
            end)
            callback2(Errors.engineError("getProductInfo: GetProductInfoAsync raised", result))
        end)
    end)
end

return getProductInfo
