-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)

local function formatCurrencyAmountStr(currencySymbol: string, amount: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return currencySymbol .. string.format("%.2f", amount)
end

local function warnParseFailure(arg1, str1: string) -- Luacid: Inlined by compiler; 5 call sites recovered
    warn("[Shop] toRobuxPackageItem failed (" .. str1 .. ") id=" .. tostring(arg1.id))
end

local function parseBonusItem(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local bonusItem = arg1.bonusItem
    if bonusItem == nil then
        return nil
    end

    if bonusItem.type == "GamePass" then
        return bonusItem
    end

    warn(
        "[Shop] toRobuxPackageItem ignored bonusItem with invalid type=" .. tostring(bonusItem.type) .. " id=" .. tostring(arg1.id)
    )
    return nil
end

return {
    toRobuxPackageItem = function(arg1): {bonusItem: number, currencyAmountStr: number, id: number, mobileProductId: number, productId: number, robuxAmount: number, robuxImage: number}?
        if arg1.type ~= "Robux" then
            return nil
        end

        local info = arg1.info
        if info == nil then
            warnParseFailure(arg1, "missing info")
            return nil
        end

        local robux = info.robux
        local productId = info.productId
        local providerProductId = info.providerProductId
        local price = info.price
        if typeof(robux) ~= "number" or typeof(productId) ~= "number" then
            warnParseFailure(arg1, "invalid robux or productId")
            return nil
        end
        if typeof(providerProductId) ~= "string" or providerProductId == "" then
            warnParseFailure(arg1, "missing providerProductId")
            return nil
        end
        if price == nil or typeof(price.amount) ~= "number" then
            warnParseFailure(arg1, "missing price.amount")
            return nil
        end

        local currency = price.currency
        if currency == nil or typeof(currency.currencySymbol) ~= "string" or currency.currencySymbol == "" then
            warnParseFailure(arg1, "missing price.currency.currencySymbol")
            return nil
        end

        return {
            id = tostring(arg1.id),
            robuxAmount = robux,
            currencyAmountStr = formatCurrencyAmountStr(currency.currencySymbol, price.amount),
            robuxImage = Constants.ROBUX_PACKAGE_IMAGE,
            productId = productId,
            mobileProductId = providerProductId,
            bonusItem = parseBonusItem(arg1)
        }
    end
}
