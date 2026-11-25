-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetPurchaseFlow = require(PurchasePrompt.Actions.SetPurchaseFlow)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)
local PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[CompleteRequest.name] = function(_, _)
    return PurchaseFlow.None
end

tbl1[SetPurchaseFlow.name] = function(_, arg1)
    return arg1.purchaseFlow
end

return createReducer(false, tbl1)
