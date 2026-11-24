-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local _Promise = require(InExperienceShopParent.Promise)
local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)
local buildShopDataFromWidgets = require(InExperienceShop.Api.buildShopDataFromWidgets)
local fetchRobuxWidgetsAfterPurchase = require(InExperienceShop.Api.fetchRobuxWidgetsAfterPurchase)
local multiGetProductInfo = require(InExperienceShop.Api.multiGetProductInfo)
local MockShopItemIds = require(InExperienceShop.Mocks.MockShopItemIds)
local MockMultiGetProductInfo = require(InExperienceShop.Mocks.MockMultiGetProductInfo)
local FFlagShopUseMockMultiGetProductInfo = require(InExperienceShop.Flags.FFlagShopUseMockMultiGetProductInfo)

local module = {}

function module.fetchAllShopData(num1: number?)
    local var1 = if num1 == nil then 0.5 else num1
    return MockShopItemIds.getShopItemIds(var1):andThen(function(arg1)
        return buildShopDataFromWidgets(arg1, function(arg2)
            if FFlagShopUseMockMultiGetProductInfo then
                return MockMultiGetProductInfo.multiGetProductInfo(arg2, var1)
            end
            return multiGetProductInfo(arg2)
        end)
    end)
end

function module.fetchShopWidgetsOnly(num1: number?)
    return MockShopItemIds.getShopItemIds(if num1 == nil then 0.5 else num1):andThen(function(arg1)
        return buildShopDataFromWidgets(arg1, nil)
    end)
end

function module.fetchRobuxWidgetsAfterPurchase(num1: number?)
    local var1 = if num1 == nil then 0.5 else num1
    return MockShopItemIds.getShopItemIds(var1):andThen(function(arg1)
        local var2 = nil
        for _, value in ipairs(arg1.categories) do
            if value.name == Constants.ROBUX_CATEGORY_NAME then
                var2 = value
                break
            end
        end

        return fetchRobuxWidgetsAfterPurchase.buildFromWidgetResponse({ category = var2 }, function(arg2)
            if FFlagShopUseMockMultiGetProductInfo then
                return MockMultiGetProductInfo.multiGetProductInfo(arg2, var1)
            end
            return multiGetProductInfo(arg2)
        end)
    end)
end

return module
