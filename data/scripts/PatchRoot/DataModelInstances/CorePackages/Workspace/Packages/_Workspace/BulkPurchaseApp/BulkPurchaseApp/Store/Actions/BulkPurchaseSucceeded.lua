-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local Rodux = require(BulkPurchaseAppParent.Rodux)

local _BulkPurchasePromptStateEnum = require(BulkPurchaseApp.Enums.BulkPurchasePromptStateEnum)

return Rodux.makeActionCreator("BulkPurchaseSucceeded", function(promptState, itemStatuses)
    return { promptState = promptState, itemStatuses = itemStatuses }
end)
