-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local CancelSubscriptionAppParent = CancelSubscriptionApp.Parent
local React = require(CancelSubscriptionAppParent.React)
local useDispatch = require(CancelSubscriptionAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(CancelSubscriptionAppParent.RoactUtils).Hooks.RoactRodux.useSelector

local CancelSubscriptionEnded = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionEnded)
local CancelSubscriptionSucceeded = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionSucceeded)
local CancelSubscriptionFailed = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionFailed)
local CancelSubscriptionRequested = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionRequested)
local ErrorStateEnum = require(CancelSubscriptionApp.Enums.ErrorStateEnum)
local _Types = require(CancelSubscriptionApp.Store.Types)
local selectExpirationDate = require(CancelSubscriptionApp.Store.Selectors.selectExpirationDate)
local selectSubscriptionId = require(CancelSubscriptionApp.Store.Selectors.selectSubscriptionId)

local _CancelUserSubscriptionRequestPrompt = require(script.Parent.CancelUserSubscriptionRequestPrompt)

local function useCancelUserSubscriptionRequestPromptProps()
    local expirationDate = useSelector(selectExpirationDate) or ""
    local subscriptionId = useSelector(selectSubscriptionId) or ""
    local var2 = useDispatch()

    return {
        onCancel = React.useCallback(function()
            var2(CancelSubscriptionEnded())
        end, { var2 }),
        onConfirm = React.useCallback(function()
            var2(CancelSubscriptionRequested())
            local success, _result = pcall(function()
                return MarketplaceService:PerformCancelSubscription(subscriptionId)
            end)
            if success then
                var2(CancelSubscriptionSucceeded(subscriptionId))
                return
            end
            var2(CancelSubscriptionFailed(ErrorStateEnum.ErrorCancelling, subscriptionId))
        end, { var2 }),
        expirationDate = expirationDate,
        subscriptionId = subscriptionId
    }
end

return useCancelUserSubscriptionRequestPromptProps
