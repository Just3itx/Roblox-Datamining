-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _ErrorCodeEnum = require(BulkPurchaseApp.Enums.ErrorCodeEnum)
local _Types = require(BulkPurchaseApp.Store.Types)

local function selectErrorCode(arg1)
    return arg1.errorCode
end

return selectErrorCode
