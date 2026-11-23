-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local selectRobuxSpent = require(BulkPurchaseApp.Store.Selectors.selectRobuxSpent)
local selectResultItems = require(BulkPurchaseApp.Store.Selectors.selectResultItems)
local _Types = require(BulkPurchaseApp.Store.Types)

local function selectPurchaseResults(arg1)
    return {
        RobuxSpent = selectRobuxSpent(arg1),
        Items = selectResultItems(arg1)
    }
end

return selectPurchaseResults
