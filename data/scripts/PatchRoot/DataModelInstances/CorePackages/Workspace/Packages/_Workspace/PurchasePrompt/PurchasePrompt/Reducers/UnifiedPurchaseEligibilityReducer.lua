-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetIsUserEligibleForUnifiedPurchaseFlow = require(PurchasePrompt.Actions.SetIsUserEligibleForUnifiedPurchaseFlow)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetIsUserEligibleForUnifiedPurchaseFlow.name] = function(_, arg1)
    return arg1.isUserEligibleForUnifiedPurchaseFlow
end

return (createReducer(false, tbl1))
