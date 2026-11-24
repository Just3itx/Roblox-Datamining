-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommercePurchaseAppParent = script:FindFirstAncestor("CommercePurchaseApp").Parent
local React = require(CommercePurchaseAppParent.React)

local CommercePurchaseError = require(script.Parent.CommercePurchaseError)
local useCommercePurchaseErrorProps = require(script.Parent.useCommercePurchaseErrorProps)

local function CommercePurchaseErrorContainer()
    local var1 = useCommercePurchaseErrorProps()
    return React.createElement(CommercePurchaseError, var1)
end

return CommercePurchaseErrorContainer
