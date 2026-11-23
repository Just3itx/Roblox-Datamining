-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local BulkPurchaseSuccess = require(script.Parent.BulkPurchaseSuccess)
local useBulkPurchaseSuccessProps = require(script.Parent.useBulkPurchaseSuccessProps)

local function BulkPurchaseSuccessContainer()
    local var1 = useBulkPurchaseSuccessProps()
    return React.createElement(BulkPurchaseSuccess, var1)
end

return BulkPurchaseSuccessContainer
