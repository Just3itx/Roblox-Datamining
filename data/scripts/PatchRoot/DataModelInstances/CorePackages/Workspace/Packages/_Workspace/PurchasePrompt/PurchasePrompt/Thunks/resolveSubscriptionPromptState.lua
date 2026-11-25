-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local SetPromptState = require(scriptParentParent.Actions.SetPromptState)
local ErrorOccurred = require(scriptParentParent.Actions.ErrorOccurred)
local SubscriptionPurchaseInfoReceived = require(scriptParentParent.Actions.SubscriptionPurchaseInfoReceived)

local PromptState = require(scriptParentParent.Enums.PromptState)
local PurchaseError = require(scriptParentParent.Enums.PurchaseError)

local Thunk = require(scriptParentParent.Thunk)

local function resolveSubscriptionPromptState(arg1)
    return Thunk.new(script.Name, nil, function(arg2, _)
        arg2:dispatch(SubscriptionPurchaseInfoReceived(arg1))

        if arg1.CanPurchase == false then
            return arg2:dispatch(ErrorOccurred(PurchaseError.AlreadySubscribed))
        end

        return arg2:dispatch(SetPromptState(PromptState.PromptSubscriptionPurchase))
    end)
end

return resolveSubscriptionPromptState
