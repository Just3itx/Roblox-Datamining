-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")

local _Types = require(CommercePurchaseApp.Store.Types)

local function selectCommerceProductId(arg1)
    return arg1.commercePurchaseState.commerceProductId
end

return selectCommerceProductId
