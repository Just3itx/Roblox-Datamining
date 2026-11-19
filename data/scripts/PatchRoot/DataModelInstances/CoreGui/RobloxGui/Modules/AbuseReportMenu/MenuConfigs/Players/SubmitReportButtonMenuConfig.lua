-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RobloxGui = game:GetService("CoreGui").RobloxGui
local _Types = require(AbuseReportMenu.Components.Types)
local getToastMessageFromAbuseReason = require(AbuseReportMenu.MenuConfigs.getToastMessageFromAbuseReason)
local createVoiceAbuseReportRequest = require(RobloxGui.Modules.VoiceChat.createVoiceAbuseReportRequest)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local AbuseReportBuilder = require(AbuseReportMenu.ReportAnything.Utility.AbuseReportBuilder)
local ReportAbuseAnalytics = require(AbuseReportMenu.Analytics.ReportAbuseAnalytics)
local Constants = require(AbuseReportMenu.Components.Constants)
local TnSIXPWrapper = require(AbuseReportMenu.IXP.TnSIXPWrapper)
local Cryo = require(CorePackages.Packages.Cryo)

function isEligibleForVoiceSubmit(arg1, arg2): boolean
    return not (arg1.allegedAbuser == nil
        or arg1.allegedAbuserId == nil
        or arg1.abuseReason == nil
        or arg1.methodOfAbuse == nil
        or arg2.analyticsState.menuOpenedUnixTimestampMilliseconds == nil)
        and Players.LocalPlayer ~= nil
end

function isEligibleForRAOtherSubmit(arg1): boolean
    return not (arg1.allegedAbuser == nil or arg1.allegedAbuserId == nil or arg1.abuseReason == nil) and Players.LocalPlayer ~= nil
end

function isEligibleForTextSubmit(arg1): boolean
    return not (arg1.allegedAbuser == nil) and arg1.abuseReason ~= nil
end

return {
    componentType = "button",
    getIsVisible = function(_): boolean
        return true
    end,
    variant = "primary",
    getIconSrc = function(_): string
        return ""
    end,
    getButtonLabel = function(_): string
        return "SubmitButton"
    end,
    getIsDisabled = function(arg1, arg2): boolean
        local methodOfAbuse = arg1.methodOfAbuse

        if methodOfAbuse == Constants.AbuseMethods.VoiceChat then
            return not isEligibleForVoiceSubmit(arg1, arg2)
        end

        if methodOfAbuse == Constants.AbuseMethods.TextChat
            or methodOfAbuse == nil
            or methodOfAbuse == Constants.AbuseMethods.Other and not TnSIXPWrapper.getReportAnythingAvatarEnabled()
        then
            return not isEligibleForTextSubmit(arg1)
        end

        if methodOfAbuse == Constants.AbuseMethods.Other or methodOfAbuse == Constants.AbuseMethods.Avatar then
            return not isEligibleForRAOtherSubmit(arg1)
        end

        return false
    end,
    onClick = function(arg1, _, arg2)
        local allegedAbuser = arg1.allegedAbuser
        local allegedAbuserId = arg1.allegedAbuserId
        local abuseReason = arg1.abuseReason
        local methodOfAbuse = arg1.methodOfAbuse
        local menuOpenedUnixTimestampMilliseconds = arg2.analyticsState.menuOpenedUnixTimestampMilliseconds

        if methodOfAbuse == Constants.AbuseMethods.VoiceChat then
            if isEligibleForVoiceSubmit(arg1, arg2) then
                pcall(function()
                    task.spawn(function()
                        local voiceAbuseReportRequest = createVoiceAbuseReportRequest(Players, default, {
                            localUserId = Players.LocalPlayer.UserId,
                            abuserUserId = allegedAbuserId,
                            abuseComment = arg1.comment,
                            abuseReason = abuseReason,
                            inExpMenuOpenedUnixMilli = menuOpenedUnixTimestampMilliseconds,
                            sortedPlayerListUserIds = Cryo.List.map(arg1.playerObjects, function(arg3)
                                return arg3.UserId
                            end),
                            abuseVector = Constants.AbuseVector.Voice
                        })

                        Players:ReportAbuseV3(Players.LocalPlayer, voiceAbuseReportRequest)

                        arg2.analyticsDispatch({ type = Constants.AnalyticsActions.SetSubmissionCompleted })
                        arg2.showReportSentPage(allegedAbuser)
                    end)
                end)
            end

            return
        end

        if methodOfAbuse == Constants.AbuseMethods.TextChat
            or methodOfAbuse == Constants.AbuseMethods.Other and not TnSIXPWrapper.getReportAnythingAvatarEnabled()
            or methodOfAbuse == nil
        then
            if isEligibleForTextSubmit(arg1) then
                spawn(function()
                    Players:ReportAbuse(allegedAbuser, abuseReason, arg1.comment)
                end)
                arg2.analyticsDispatch({ type = Constants.AnalyticsActions.SetSubmissionCompleted })
                local toastMessageFromAbuseReason = getToastMessageFromAbuseReason(abuseReason)
                arg2.onReportComplete(toastMessageFromAbuseReason)
            end

            return
        end
        if methodOfAbuse ~= Constants.AbuseMethods.Other and methodOfAbuse ~= Constants.AbuseMethods.Avatar
            or not isEligibleForRAOtherSubmit(arg1)
        then
            return
        end

        pcall(function()
            task.spawn(function()
                local otherReportRequest = AbuseReportBuilder.buildOtherReportRequest(
                    {
                        localUserId = Players.LocalPlayer.UserId,
                        formSelectedAbuserUserId = allegedAbuserId,
                        abuseComment = arg1.comment,
                        abuseReason = abuseReason,
                        menuEntryPoint = ReportAbuseAnalytics:getAbuseReportSessionEntryPoint(),
                        variant = AbuseReportBuilder.Constants.Variant.NM
                    },
                    arg2.reportAnythingState,
                    arg2.reportAnythingAnalytics.getAccumulatedParameters()
                )

                if game:GetEngineFeature("WHAM2165") and methodOfAbuse == Constants.AbuseMethods.Avatar then
                    Players:ReportAvatarAbuse(allegedAbuserId, otherReportRequest)
                else
                    Players:ReportAbuseV3(Players.LocalPlayer, otherReportRequest)
                end

                arg2.analyticsDispatch({ type = Constants.AnalyticsActions.SetSubmissionCompleted })
                local toastMessageFromAbuseReason = getToastMessageFromAbuseReason(abuseReason, true)
                arg2.onReportComplete(toastMessageFromAbuseReason)
            end)
        end)
    end,
    fieldLabel = "",
    componentName = "SubmitButton"
}
