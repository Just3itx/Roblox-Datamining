-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local BulkPurchaseRequest = require(script.Parent.BulkPurchaseRequest)
local useBulkPurchaseRequestProps = require(script.Parent.useBulkPurchaseRequestProps)

local function BulkPurchaseRequestContainer()
    local var1 = useBulkPurchaseRequestProps()
    return React.createElement(BulkPurchaseRequest, var1)
end

return BulkPurchaseRequestContainer
