-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent
local React = require(IAPExperienceParent.React)

local tbl1 = {
    ["IAPExperience.PurchasePrompt.Label.BlackbirdDiscount"] = "Sit amet ({discountPercentage}% elit)",
    ["IAPExperience.PurchasePrompt.Label.BlackbirdDiscountNoPercent"] = "Sit amet",
    ["IAPExperience.PurchasePrompt.Label.GenericDiscount"] = "... ({discountPercentage}% elit)",
    ["IAPExperience.PurchasePrompt.Label.GenericDiscountNoPercent"] = "...",
    ["IAPExperience.PurchasePrompt.Label.BlackbirdSummary"] = "Lorem {robuxIcon} {savingsAmount} ipsum dolor",
    ["IAPExperience.PurchasePrompt.Label.Subtotal"] = "Subtotal",
    ["IAPExperience.PurchasePrompt.Label.SubtotalWithItemCount"] = "Subtotal ({itemCount} items)",
    ["IAPExperience.PurchasePrompt.Label.Total"] = "Total"
}

local function usePlaceholderLocalization(tbl2)
    return React.useMemo(function()
        local result = ({})
        for k, value in pairs(tbl2) do
            local var1 = if typeof(value) == "table" then value[1] else value
            local var2 = tbl1[var1] or var1
            if typeof(value) == "table" then
                for k2, value2 in pairs(value) do
                    if typeof(k2) == "string" then
                        var2 = string.gsub(var2, "{" .. k2 .. "}", function(): string
                            return tostring(value2)
                        end)
                    end
                end
            end
            result[k] = var2
        end
        return result
    end, { tbl2 })
end

return usePlaceholderLocalization
