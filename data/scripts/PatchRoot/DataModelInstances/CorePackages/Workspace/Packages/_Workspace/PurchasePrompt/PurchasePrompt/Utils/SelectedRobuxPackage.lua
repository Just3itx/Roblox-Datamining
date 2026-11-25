-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getSelectedRobuxPackage(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    if arg1.robuxUpsellSuggestions and arg1.robuxUpsellSuggestions.products and arg1.robuxUpsellSuggestions.selection then
        return arg1.robuxUpsellSuggestions.products[arg1.robuxUpsellSuggestions.selection]
    end

    return nil
end

return {
    getRobuxProductId = function(arg1)
        local selectedRobuxPackage = getSelectedRobuxPackage(arg1)
        return if selectedRobuxPackage then selectedRobuxPackage.providerId else nil
    end,
    getProductId = function(arg1)
        local selectedRobuxPackage = getSelectedRobuxPackage(arg1)
        return if selectedRobuxPackage then selectedRobuxPackage.productId else nil
    end,
    getProductName = function(arg1)
        local selectedRobuxPackage = getSelectedRobuxPackage(arg1)
        return if selectedRobuxPackage then selectedRobuxPackage.productName else nil
    end,
    getRobuxPurchaseAmount = function(arg1)
        local selectedRobuxPackage = getSelectedRobuxPackage(arg1)
        return if selectedRobuxPackage then selectedRobuxPackage.robuxAmount else nil
    end,
    getRobuxAmountBeforeBonus = function(arg1)
        local selectedRobuxPackage = getSelectedRobuxPackage(arg1)
        return if selectedRobuxPackage then selectedRobuxPackage.robuxAmountBeforeBonus else nil
    end,
    getPrice = function(arg1)
        local selectedRobuxPackage = getSelectedRobuxPackage(arg1)
        return if selectedRobuxPackage then selectedRobuxPackage.price else nil
    end
}
