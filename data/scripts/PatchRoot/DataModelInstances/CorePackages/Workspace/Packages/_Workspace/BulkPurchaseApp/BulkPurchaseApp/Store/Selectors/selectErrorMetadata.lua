-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)

local function selectErrorMetadata(arg1)
    return arg1.errorMetadata
end

return selectErrorMetadata
