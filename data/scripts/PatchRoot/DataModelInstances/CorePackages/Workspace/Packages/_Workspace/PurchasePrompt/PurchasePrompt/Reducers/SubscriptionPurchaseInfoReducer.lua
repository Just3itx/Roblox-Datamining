-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)
local SubscriptionPurchaseInfoReceived = require(PurchasePrompt.Actions.SubscriptionPurchaseInfoReceived)
local getPreviewImageUrl = require(PurchasePrompt.getPreviewImageUrl)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SubscriptionPurchaseInfoReceived.name] = function(_, arg1)
    arg1.subscriptionPurchaseInfo.ImageUrl = getPreviewImageUrl(arg1.subscriptionPurchaseInfo)
    return arg1.subscriptionPurchaseInfo
end

tbl1[CompleteRequest.name] = function(_, _)
    return {}
end

return (createReducer({}, tbl1))
