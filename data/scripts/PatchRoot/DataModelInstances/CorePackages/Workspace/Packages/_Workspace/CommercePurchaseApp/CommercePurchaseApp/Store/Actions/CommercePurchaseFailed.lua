-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")
local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local Rodux = require(CommercePurchaseAppParent.Rodux)

local _ErrorCodeEnum = require(CommercePurchaseApp.Enums.ErrorCodeEnum)

return Rodux.makeActionCreator("CommercePurchaseFailed", function(errorCode)
    return { errorCode = errorCode }
end)
