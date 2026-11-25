-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local Rodux = PurchasePromptDeps.Rodux
local Cryo = PurchasePromptDeps.Cryo

local SetABVariation = require(PurchasePrompt.Actions.SetABVariation)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetABVariation.name] = function(arg1, arg2)
    assert(type(arg2.key) == "string", "Expected 'key' to be a string")
    assert(type(arg2.variation) == "string", "Expected 'variation' to be a string")
    return Cryo.Dictionary.join(arg1, { [arg2.key] = arg2.variation })
end

return (createReducer({}, tbl1))
