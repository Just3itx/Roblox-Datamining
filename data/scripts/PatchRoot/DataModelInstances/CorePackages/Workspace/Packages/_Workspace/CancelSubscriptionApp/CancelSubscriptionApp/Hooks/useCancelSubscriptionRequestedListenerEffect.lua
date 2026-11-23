-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local CancelSubscriptionAppParent = CancelSubscriptionApp.Parent
local React = require(CancelSubscriptionAppParent.React)
local useDispatch = require(CancelSubscriptionAppParent.RoactUtils).Hooks.RoactRodux.useDispatch

local InitiateCancelUserSubscriptionFlow = require(CancelSubscriptionApp.Store.Thunks.InitiateCancelUserSubscriptionFlow)
local useNetwork = require(CancelSubscriptionAppParent.EconomyCommonCoreScriptHooks).useNetwork
local CancelUserSubscriptionAsyncPromptStateEnum = require(CancelSubscriptionApp.Enums.CancelUserSubscriptionAsyncPromptStateEnum)

local function useCancelSubscriptionRequestedListenerEffect(none)
    local var1 = useDispatch()
    local var2 = useNetwork()
    React.useEffect(function()
        local connection = if var1 and var2 then MarketplaceService.PromptCancelSubscriptionRequested:Connect(function(subscriptionId: string)
            if none == CancelUserSubscriptionAsyncPromptStateEnum.None then
                var1(InitiateCancelUserSubscriptionFlow(var2, subscriptionId))
            end
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { var1, var2, none })
end
return useCancelSubscriptionRequestedListenerEffect
