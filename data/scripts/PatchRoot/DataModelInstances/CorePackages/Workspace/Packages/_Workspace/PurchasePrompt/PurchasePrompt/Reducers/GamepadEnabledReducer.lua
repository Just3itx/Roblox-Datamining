-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetGamepadEnabled = require(PurchasePrompt.Actions.SetGamepadEnabled)

local bool1 = UserInputService:GetPlatform() == Enum.Platform.XBoxOne
    or UserInputService:GetPlatform() == Enum.Platform.PS4
    or UserInputService:GetPlatform() == Enum.Platform.PS5

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetGamepadEnabled.name] = function(_, arg1)
    return arg1.enabled
end

return (createReducer(bool1, tbl1))
