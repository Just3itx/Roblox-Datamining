-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetProductPayload = require(PurchasePrompt.Actions.SetProductPayload)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)
local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(PurchasePromptParent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs
local FFlagPromptPurchaseClearStateOnCompletion = require(PurchasePrompt.Flags.FFlagPromptPurchaseClearStateOnCompletion)

local tbl1 = {}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[SetProductPayload.name] = function(_, arg1)
    return arg1.productPayload
end

tbl2[CompleteRequest.name] = function(arg1, _)
    return if FFlagEnableUnifiedPurchaseFlowForDevSubs and arg1.kind == "DeveloperSubscription" then tbl1 elseif FFlagPromptPurchaseClearStateOnCompletion then tbl1 else arg1
end

return (createReducer(tbl1, tbl2))
