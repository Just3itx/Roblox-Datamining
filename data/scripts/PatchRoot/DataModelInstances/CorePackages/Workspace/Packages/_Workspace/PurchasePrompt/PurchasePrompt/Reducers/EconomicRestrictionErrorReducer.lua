-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetEconomicRestrictionError = require(PurchasePrompt.Actions.SetEconomicRestrictionError)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetEconomicRestrictionError.name] = function(_, arg1)
    return {
        timeoutMinutes = arg1.timeoutMinutes,
        violationType = arg1.violationType
    }
end

return createReducer({}, tbl1)
