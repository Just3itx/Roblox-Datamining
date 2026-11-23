-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local CancelSubscriptionAppParent = CancelSubscriptionApp.Parent
local React = require(CancelSubscriptionAppParent.React)
local useDispatch = require(CancelSubscriptionAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local MarketplaceService = game:GetService("MarketplaceService")
local useSelector = require(CancelSubscriptionAppParent.RoactUtils).Hooks.RoactRodux.useSelector
local selectSubscriptionId = require(CancelSubscriptionApp.Store.Selectors.selectSubscriptionId)

local CancelSubscriptionEnded = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionEnded)
local _Types = require(CancelSubscriptionApp.Store.Types)

local _CancelUserSubscriptionSuccessPrompt = require(script.Parent.CancelUserSubscriptionSuccessPrompt)

local function useCancelUserSubscriptionSuccessPromptProps()
    local var1 = useDispatch()
    local subscriptionId = useSelector(selectSubscriptionId) or ""

    return {
        onDismissed = React.useCallback(function()
            MarketplaceService:SignalUserSubscriptionStatusChanged(subscriptionId)
            var1(CancelSubscriptionEnded())
        end, { var1 })
    }
end

return useCancelUserSubscriptionSuccessPromptProps
