-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetButtonState = require(PurchasePrompt.Actions.SetButtonState)
local ButtonState = require(PurchasePrompt.Enums.ButtonState)

local createReducer = Rodux.createReducer
local ButtonStateEnabled = ButtonState.Enabled
local tbl1 = {}
tbl1[SetButtonState.name] = function(_, arg1)
    return arg1.state
end

return createReducer(ButtonStateEnabled, tbl1)
