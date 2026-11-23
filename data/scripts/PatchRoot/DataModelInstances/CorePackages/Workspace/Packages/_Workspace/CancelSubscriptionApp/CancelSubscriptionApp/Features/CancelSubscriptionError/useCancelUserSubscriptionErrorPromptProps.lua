-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local CancelSubscriptionAppParent = CancelSubscriptionApp.Parent
local React = require(CancelSubscriptionAppParent.React)
local useDispatch = require(CancelSubscriptionAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(CancelSubscriptionAppParent.RoactUtils).Hooks.RoactRodux.useSelector

local CancelSubscriptionEnded = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionEnded)
local selectErrorState = require(CancelSubscriptionApp.Store.Selectors.selectErrorState)
local ErrorStateEnum = require(CancelSubscriptionApp.Enums.ErrorStateEnum)
local selectSubscriptionId = require(CancelSubscriptionApp.Store.Selectors.selectSubscriptionId)

local _CancelUserSubscriptionErrorPrompt = require(script.Parent.CancelUserSubscriptionErrorPrompt)

local function useCancelUserSubscriptionErrorPromptProps()
    local errorState = useSelector(selectErrorState)
    local var2 = useDispatch()
    local subscriptionId = useSelector(selectSubscriptionId) or ""

    return {
        onDismiss = React.useCallback(function()
            if errorState == ErrorStateEnum.Expiring then
                MarketplaceService:SignalUserSubscriptionStatusChanged(subscriptionId)
            end
            var2(CancelSubscriptionEnded())
        end, { errorState, var2 }),
        errorState = errorState
    }
end

return useCancelUserSubscriptionErrorPromptProps
