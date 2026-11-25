-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local _types = require(PurchasePrompt.types)

local SetPostPurchaseActions = require(PurchasePrompt.Actions.SetPostPurchaseActions)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetPostPurchaseActions.name] = function(_, arg1)
    return arg1.postPurchaseActions
end

return (createReducer({}, tbl1))
