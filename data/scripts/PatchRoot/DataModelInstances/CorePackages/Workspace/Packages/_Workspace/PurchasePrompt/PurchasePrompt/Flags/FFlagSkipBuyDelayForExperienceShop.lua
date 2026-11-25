-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local SharedFlags = require(PurchasePromptParent.SharedFlags)

local FFlagPromptPurchaseClearStateOnCompletion = require(script.Parent.FFlagPromptPurchaseClearStateOnCompletion)

return SharedFlags.FFlagSkipBuyDelayForExperienceShop and FFlagPromptPurchaseClearStateOnCompletion
