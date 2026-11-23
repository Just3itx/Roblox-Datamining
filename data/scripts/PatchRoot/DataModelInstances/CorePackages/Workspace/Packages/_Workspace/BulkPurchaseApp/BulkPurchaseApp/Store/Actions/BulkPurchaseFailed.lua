-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local Rodux = require(BulkPurchaseAppParent.Rodux)

local _ErrorCodeEnum = require(BulkPurchaseApp.Enums.ErrorCodeEnum)

return Rodux.makeActionCreator("BulkPurchaseFailed", function(errorCode, errorMetadata)
    return { errorCode = errorCode, errorMetadata = errorMetadata }
end)
