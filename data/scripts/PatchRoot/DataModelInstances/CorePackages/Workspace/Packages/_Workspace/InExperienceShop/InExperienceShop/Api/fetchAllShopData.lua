-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local _Promise = require(InExperienceShopParent.Promise)
local _Types = require(InExperienceShop.Types)
local fetchShopItemIds = require(script.Parent.fetchShopItemIds)
local multiGetProductInfo = require(script.Parent.multiGetProductInfo)
local buildShopDataFromWidgets = require(script.Parent.buildShopDataFromWidgets)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)

local function fetchAllShopData()
    local str1 = HttpService:GenerateGUID(false)
    local var1 = ShopDebugLogger.startTimer()
    ShopDebugLogger.logLazy(function(): string
        return "fetchAllShopData: start requestId=" .. str1
    end)
    local var2 = fetchShopItemIds(str1):andThen(function(arg1)
        return buildShopDataFromWidgets(arg1, multiGetProductInfo)
    end)
    return ShopDebugLogger.tracePromise(var2, {
        onSuccess = function(arg1)
            ShopDebugLogger.logElapsedLazy(function(): string
                return "fetchAllShopData: success requestId=" .. str1
            end, var1)
            ShopDebugLogger.logLazy(function(): string
                return "fetchAllShopData: result categories=" .. #arg1.categories .. " sections=" .. #arg1.sections .. " failedItems=" .. #(arg1.failedItems or {})
            end)
        end,
        onError = function(arg1)
            ShopDebugLogger.logElapsedLazy(function(): string
                return "fetchAllShopData: error requestId=" .. str1
            end, var1)
            ShopDebugLogger.logLazy(function(): string
                return "fetchAllShopData: error kind=" .. tostring(arg1 and arg1.kind) .. " msg=" .. tostring(arg1 and arg1.message)
            end)
        end
    })
end

return fetchAllShopData
