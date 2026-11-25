-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ErrorOccurred.name] = function(_, arg1)
    return arg1.purchaseError
end

tbl1[CompleteRequest.name] = function(_, _)
    return {}
end

return createReducer({}, tbl1)
