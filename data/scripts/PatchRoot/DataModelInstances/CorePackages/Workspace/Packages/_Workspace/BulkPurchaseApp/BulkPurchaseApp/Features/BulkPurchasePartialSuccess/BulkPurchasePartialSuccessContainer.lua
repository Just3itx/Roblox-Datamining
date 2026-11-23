-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local BulkPurchasePartialSuccess = require(script.Parent.BulkPurchasePartialSuccess)
local useBulkPurchasePartialSuccessProps = require(script.Parent.useBulkPurchasePartialSuccessProps)

local function BulkPurchasePartialSuccessContainer()
    local var1 = useBulkPurchasePartialSuccessProps()
    return React.createElement(BulkPurchasePartialSuccess, var1)
end

return BulkPurchasePartialSuccessContainer
