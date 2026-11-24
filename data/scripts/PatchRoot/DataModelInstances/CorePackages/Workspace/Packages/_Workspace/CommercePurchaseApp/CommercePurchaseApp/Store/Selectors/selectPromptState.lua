-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")

local _Types = require(CommercePurchaseApp.Store.Types)
local _CommercePurchasePromptStateEnum = require(CommercePurchaseApp.Enums.CommercePurchasePromptStateEnum)

local function selectPromptState(arg1)
    return arg1.commercePurchaseState.promptState
end

return selectPromptState
