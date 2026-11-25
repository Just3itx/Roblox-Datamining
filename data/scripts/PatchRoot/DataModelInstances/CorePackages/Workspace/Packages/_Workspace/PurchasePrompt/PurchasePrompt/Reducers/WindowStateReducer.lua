-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:15Z
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
local SetWindowState = require(PurchasePrompt.Actions.SetWindowState)
local WindowState = require(PurchasePrompt.Enums.WindowState)
local PromptState = require(PurchasePrompt.Enums.PromptState)

local createReducer = Rodux.createReducer
local Hidden = WindowState.Hidden
local tbl1 = {}
tbl1[SetPromptState.name] = function(_, arg1)
    return if arg1.promptState == PromptState.None then WindowState.Hidden else WindowState.Shown
end

tbl1[SetWindowState.name] = function(_, arg1)
    return arg1.state
end

tbl1[ErrorOccurred.name] = function(_, _)
    return WindowState.Shown
end

tbl1[StartPurchase.name] = function(_, _)
    return WindowState.Shown
end

tbl1[PromptNativeUpsellSuggestions.name] = function(_, _)
    return WindowState.Shown
end

tbl1[CompleteRequest.name] = function(_, _)
    return WindowState.Hidden
end

return createReducer(Hidden, tbl1)
