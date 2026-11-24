-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommercePurchaseAppParent = script:FindFirstAncestor("CommercePurchaseApp").Parent
return require(CommercePurchaseAppParent.Rodux).makeActionCreator("CommercePurchaseCheckout", function(checkoutSessionId: string)
    return { checkoutSessionId = checkoutSessionId }
end)
