-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local _IAPExperience = require(PurchasePromptParent.IAPExperience)

return require(script.Parent.makeActionCreator)(script.Name, "response")
