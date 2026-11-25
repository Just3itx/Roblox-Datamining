-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local PromptNativeUpsellSuggestions = require(PurchasePrompt.Actions.PromptNativeUpsellSuggestions)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[PromptNativeUpsellSuggestions.name] = function(_, arg1)
    return {
        products = arg1.products,
        selection = arg1.selection,
        virtualItemBadgeType = arg1.virtualItemBadgeType,
        experimentVariant = arg1.experimentVariant
    }
end

return createReducer({}, tbl1)
