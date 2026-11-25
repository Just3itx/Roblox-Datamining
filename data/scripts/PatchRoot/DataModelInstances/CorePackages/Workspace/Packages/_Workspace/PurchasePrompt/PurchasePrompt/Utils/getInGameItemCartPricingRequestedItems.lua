-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local _types = require(PurchasePrompt.types)

local function getInGameItemCartPricingRequestedItems(arg1)
    if type(arg1) ~= "table" then
        return nil
    end

    local namespace = arg1.namespace
    local targetIdentifier = arg1.targetIdentifier

    if type(namespace) ~= "string" or namespace == "" then
        return nil
    end

    if type(targetIdentifier) ~= "string" or targetIdentifier == "" then
        return nil
    end

    return {{
        productIdentifier = { namespace = namespace, targetIdentifier = targetIdentifier }
    }}
end

return getInGameItemCartPricingRequestedItems
