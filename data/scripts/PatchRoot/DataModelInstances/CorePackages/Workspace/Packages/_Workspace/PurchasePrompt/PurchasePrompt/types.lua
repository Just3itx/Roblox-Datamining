-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local _IAPExperience = require(PurchasePromptParent.IAPExperience)
local PurchasePromptLite = require(PurchasePromptParent.PurchasePromptLite)
local _LuauPolyfill = require(PurchasePromptParent.LuauPolyfill)

return {
    ProductTypeEnum = PurchasePromptLite.Enums.ProductKind
}
