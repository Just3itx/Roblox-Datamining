-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local StartPurchase = require(PurchasePrompt.Actions.StartPurchase)
local PromptNativeUpsellSuggestions = require(PurchasePrompt.Actions.PromptNativeUpsellSuggestions)
local PromptState = require(PurchasePrompt.Enums.PromptState)

local createReducer = Rodux.createReducer
local None = PromptState.None
local tbl1 = {}
tbl1[SetPromptState.name] = function(_, arg1)
    return arg1.promptState
end

tbl1[CompleteRequest.name] = function(_, _)
    return PromptState.None
end

tbl1[ErrorOccurred.name] = function(_, _)
    return PromptState.Error
end

tbl1[StartPurchase.name] = function(_, _)
    return PromptState.PurchaseInProgress
end

tbl1[PromptNativeUpsellSuggestions.name] = function(_, _)
    return PromptState.RobuxUpsell
end

return (createReducer(None, tbl1))
