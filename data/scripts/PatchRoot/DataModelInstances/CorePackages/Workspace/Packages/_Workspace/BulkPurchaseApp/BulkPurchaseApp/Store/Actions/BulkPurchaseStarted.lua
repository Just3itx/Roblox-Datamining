-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
return require(BulkPurchaseAppParent.Rodux).makeActionCreator("BulkPurchaseStarted", function(balance: number)
    return { balance = balance }
end)
