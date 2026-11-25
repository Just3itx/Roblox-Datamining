-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local DiscountType = require(PurchasePromptParent.IAPExperience).DiscountType
local FFlagNormalizePriceDiscountAcceptLowercase = require(PurchasePrompt.Flags.FFlagNormalizePriceDiscountAcceptLowercase)

local tbl1 = {
    [DiscountType.BlackbirdSubscription] = true,
    [DiscountType.RobloxPlusSubscription] = true
}

local function isValidRawDiscount(arg1)
    if type(arg1) ~= "table" then
        return false
    end

    if FFlagNormalizePriceDiscountAcceptLowercase then
        local var1 = arg1.Type or arg1.type
        local var2 = arg1.AmountInRobux or arg1.amountInRobux
        local var3 = arg1.Percent or arg1.percent

        if type(var1) ~= "string" or var1 == "" then
            return false
        end
        if type(var2) ~= "number" then
            return false
        end
        if type(var3) ~= "number" then
            return false
        end
    else
        if type(arg1.Type) ~= "string" or arg1.Type == "" then
            return false
        end
        if type(arg1.AmountInRobux) ~= "number" then
            return false
        end
        if type(arg1.Percent) ~= "number" then
            return false
        end
    end

    return true
end

local function normalizePriceDiscountDetails(tbl2)
    if type(tbl2) ~= "table" or #tbl2 == 0 then
        return {}
    end

    local result = {}
    for _, value in ipairs(tbl2) do
        if not isValidRawDiscount(value) then
            return {}
        end

        if FFlagNormalizePriceDiscountAcceptLowercase then
            local var1 = value.Type or value.type
            local amountInRobux = value.AmountInRobux or value.amountInRobux
            local percent = value.Percent or value.percent

            local tbl3 = {
                type = 0,
                amountInRobux = 0,
                percent = 0,
                localizedDiscountAttribution = 0
            }

            if not tbl1[var1] then
                var1 = DiscountType.Uncategorized
            end

            tbl3.type = var1
            tbl3.amountInRobux = amountInRobux
            tbl3.percent = percent
            tbl3.localizedDiscountAttribution = value.LocalizedDiscountAttribution
            table.insert(result, tbl3)
        else
            table.insert(result, {
                type = if tbl1[value.Type] then value.Type else DiscountType.Uncategorized,
                amountInRobux = value.AmountInRobux,
                percent = value.Percent,
                localizedDiscountAttribution = value.LocalizedDiscountAttribution
            })
        end
    end
    return result
end

return normalizePriceDiscountDetails
