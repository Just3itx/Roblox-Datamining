-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local BulkPurchaseError = require(script.Parent.BulkPurchaseError)
local useBulkPurchaseErrorProps = require(script.Parent.useBulkPurchaseErrorProps)

local function BulkPurchaseErrorContainer()
    local var1 = useBulkPurchaseErrorProps()
    return React.createElement(BulkPurchaseError, var1)
end

return BulkPurchaseErrorContainer
