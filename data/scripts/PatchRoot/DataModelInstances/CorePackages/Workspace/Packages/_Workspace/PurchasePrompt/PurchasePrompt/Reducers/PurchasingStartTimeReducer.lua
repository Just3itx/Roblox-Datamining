-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local StartPurchase = require(scriptParentParent.Actions.StartPurchase)

local function PurchasingStartTimeReducer(arg1, arg2)
    return if arg2.type == StartPurchase.name then arg2.purchasingStartTime else arg1 or -1
end

return PurchasingStartTimeReducer
