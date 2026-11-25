-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local makeActionCreator = require(PurchasePromptParent.Rodux).makeActionCreator
local _RobuxUpsell = require(PurchasePrompt.Models.RobuxUpsell)

local actionCreator = makeActionCreator(script.Name, function(products, selection: number, virtualItemBadgeType: string, experimentVariant: string?)
    return {
        products = products,
        selection = selection,
        virtualItemBadgeType = virtualItemBadgeType,
        experimentVariant = experimentVariant
    }
end)

local tbl1 = {
    name = actionCreator.name,
    __call = function(_, tbl1, num1: number, str1: string, str2: string?)
        return actionCreator(tbl1, num1, str1, str2)
    end
}

setmetatable(tbl1, tbl1)

return tbl1
