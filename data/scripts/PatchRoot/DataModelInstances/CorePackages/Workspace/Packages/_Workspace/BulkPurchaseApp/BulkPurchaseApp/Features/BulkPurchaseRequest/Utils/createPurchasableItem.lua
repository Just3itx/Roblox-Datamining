-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)
local _BulkPurchaseRequestItem = require(script.Parent.Parent.BulkPurchaseRequestItem)
local getThumbnailUrl = require(BulkPurchaseApp.Utils.getThumbnailUrl)
local FFlagBulkPurchaseEnablePurchaseOptions = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseEnablePurchaseOptions)
local FFlagBulkPurchaseUsesPurchaseOptionDiscount = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseUsesPurchaseOptionDiscount)

local function getTimedOptionDays(purchaseOptions)
    for _, purchaseOption in purchaseOptions do
        if purchaseOption.purchaseOptionType == "timedOption" and purchaseOption.durationInSeconds then
            local num1 = math.floor(purchaseOption.durationInSeconds / 86400)
            return if num1 > 0 then num1 else nil
        end
    end
    return nil
end

local function createPurchasableItem(arg1)
    local timedOptionDays = if FFlagBulkPurchaseEnablePurchaseOptions and arg1.purchaseOptions then getTimedOptionDays(arg1.purchaseOptions) else nil
    local priceRobux = arg1.priceRobux
    local originalPrice = nil
    if FFlagBulkPurchaseUsesPurchaseOptionDiscount then
        if arg1.purchaseOptions then
            local purchaseOption = arg1.purchaseOptions[1]
            if purchaseOption then
                if purchaseOption.priceRobux ~= nil then
                    priceRobux = purchaseOption.priceRobux
                end
                if purchaseOption.discountInformation then
                    originalPrice = purchaseOption.discountInformation.originalPrice
                end
            end
        end
    else
        originalPrice = arg1.discountInformation and arg1.discountInformation.originalPrice
    end

    return {
        id = arg1.id,
        cost = priceRobux,
        name = arg1.name,
        image = getThumbnailUrl(arg1.id, arg1.type),
        originalPrice = originalPrice,
        timedOptionDays = timedOptionDays
    }
end

return createPurchasableItem
