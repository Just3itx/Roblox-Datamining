-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local getUserSubscriptionDetails = require(CancelSubscriptionApp.NetworkRequests.getUserSubscriptionDetails)
local CancelSubscriptionRequested = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionRequested)
local CancelSubscriptionStarted = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionStarted)
local CancelSubscriptionFailed = require(CancelSubscriptionApp.Store.Actions.CancelSubscriptionFailed)
local ErrorStateEnum = require(CancelSubscriptionApp.Enums.ErrorStateEnum)
local LocalizationService = game:GetService("LocalizationService")

local function InitiateCancelUserSubscriptionFlow(arg1, str1: string)
    return function(arg2)
        arg2:dispatch(CancelSubscriptionRequested(str1))

        local robloxLocaleId = LocalizationService.RobloxLocaleId
        local errorCancelling = ErrorStateEnum.ErrorCancelling
        return getUserSubscriptionDetails(arg1, str1):andThen(function(arg3)
            if arg3.SubscriptionState == Enum.SubscriptionState.SubscribedWillRenew
                or arg3.SubscriptionState == Enum.SubscriptionState.SubscribedRenewalPaymentPending
            then
                local var1 = arg3.NextRenewTime:FormatLocalTime("LL", robloxLocaleId)
                arg2:dispatch(CancelSubscriptionStarted(str1, var1))
                return
            end

            if arg3.SubscriptionState == Enum.SubscriptionState.NeverSubscribed
                or arg3.SubscriptionState == Enum.SubscriptionState.Expired
            then
                errorCancelling = ErrorStateEnum.Unsubscribed
            elseif arg3.SubscriptionState == Enum.SubscriptionState.SubscribedWillNotRenew then
                errorCancelling = ErrorStateEnum.Expiring
            end
            arg2:dispatch(CancelSubscriptionFailed(errorCancelling, str1))
        end):catch(function(_)
            arg2:dispatch(CancelSubscriptionFailed(ErrorStateEnum.ErrorCancelling, str1))
        end)
    end
end

return InitiateCancelUserSubscriptionFlow
