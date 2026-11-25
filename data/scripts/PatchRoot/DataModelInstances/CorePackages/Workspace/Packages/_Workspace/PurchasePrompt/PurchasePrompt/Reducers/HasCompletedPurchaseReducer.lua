-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local PurchaseCompleteRecieved = require(PurchasePrompt.Actions.PurchaseCompleteRecieved)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[PurchaseCompleteRecieved.name] = function(_, _): boolean
    return true
end

tbl1[CompleteRequest.name] = function(_, _): boolean
    return false
end

return createReducer(false, tbl1)
