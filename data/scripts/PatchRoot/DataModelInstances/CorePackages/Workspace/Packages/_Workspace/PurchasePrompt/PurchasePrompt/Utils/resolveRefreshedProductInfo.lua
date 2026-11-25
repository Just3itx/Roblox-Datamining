-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local mapCatalogDiscountInfoToPriceDiscountDetails = require(PurchasePrompt.Utils.mapCatalogDiscountInfoToPriceDiscountDetails)

local function resolveRefreshedProductInfo(arg1, arg2, collectibleItemInstanceId: string?, days: number?)
    if collectibleItemInstanceId and collectibleItemInstanceId ~= "" then
        local var1 = nil
        if arg2 ~= nil and arg2.data ~= nil then
            for _, value in ipairs(arg2.data) do
                if value.collectibleItemInstanceId == collectibleItemInstanceId then
                    var1 = value.price
                    break
                end
            end
        end

        if var1 == nil and arg1 ~= nil then
            var1 = arg1.lowestResalePrice
        end
        if var1 then
            return {
                refreshedExpectedPrice = var1,
                PriceInRobux = var1,
                UserBasePriceInRobux = nil,
                PriceDiscountDetails = nil
            }
        end
    elseif days and days ~= 0 then
        if arg1 ~= nil and arg1.timedOptions then
            for _, timedOption in ipairs(arg1.timedOptions) do
                if timedOption.days ~= days then
                    continue
                end

                local price = timedOption.price
                if timedOption.discountInformation and timedOption.discountInformation.originalPrice then
                    price = timedOption.discountInformation.originalPrice
                end
                return {
                    refreshedExpectedPrice = timedOption.price,
                    PriceInRobux = timedOption.price,
                    UserBasePriceInRobux = price,
                    PriceDiscountDetails = mapCatalogDiscountInfoToPriceDiscountDetails(timedOption.discountInformation)
                }
            end
        end
    elseif arg1 ~= nil then
        return {
            refreshedExpectedPrice = arg1.price
        }
    end

    return nil
end

return resolveRefreshedProductInfo
