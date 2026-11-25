-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local SetProduct = require(PurchasePrompt.Actions.SetProduct)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetProduct.name] = function(_, arg1)
    return {
        id = arg1.id,
        infoType = arg1.infoType,
        equipIfPurchased = arg1.equipIfPurchased
    }
end

tbl1[CompleteRequest.name] = function(_, _)
    return {}
end

return (createReducer({}, tbl1))
