-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)

local function parseDevProductPurchaseError(arg1)
    if PurchaseError.isMember(arg1) then
        return arg1
    end

    if type(arg1) == "table" and arg1.errorCode == "PendingProductsLimitExceeded" then
        return PurchaseError.PendingProductsLimitExceeded
    end

    return arg1
end

return parseDevProductPurchaseError
