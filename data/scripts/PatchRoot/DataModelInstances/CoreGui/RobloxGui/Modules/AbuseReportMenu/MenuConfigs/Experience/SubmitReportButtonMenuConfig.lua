-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)
local TnSIXPWrapper = require(AbuseReportMenu.IXP.TnSIXPWrapper)
local AbuseReportBuilder = require(AbuseReportMenu.ReportAnything.Utility.AbuseReportBuilder)
local ReportAbuseAnalytics = require(AbuseReportMenu.Analytics.ReportAbuseAnalytics)
local getToastMessageFromAbuseReason = require(AbuseReportMenu.MenuConfigs.getToastMessageFromAbuseReason)

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
    onClick = function(arg1, _, arg2)
        local abuseReason = arg1.abuseReason

        if abuseReason == nil or Players.LocalPlayer == nil then
            return
        end

        if TnSIXPWrapper.getReportAnythingExperienceEnabled() then
            local experienceReportRequest = AbuseReportBuilder.buildExperienceReportRequest(
                {
                    localUserId = Players.LocalPlayer.UserId,
                    placeId = game.PlaceId,
                    abuseComment = arg1.comment,
                    abuseReason = abuseReason,
                    menuEntryPoint = ReportAbuseAnalytics:getAbuseReportSessionEntryPoint(),
                    variant = AbuseReportBuilder.Constants.Variant.NM
                },
                arg2.reportAnythingState,
                arg2.reportAnythingAnalytics.getAccumulatedParameters()
            )
            Players:ReportAbuseV3(Players.LocalPlayer, experienceReportRequest)

            arg2.analyticsDispatch({ type = Constants.AnalyticsActions.SetSubmissionCompleted })
            local toastMessageFromAbuseReason = getToastMessageFromAbuseReason(abuseReason, true)
            arg2.onReportComplete(toastMessageFromAbuseReason)
            return
        end

        spawn(function()
            local str1 = tostring(game.PlaceId)
            local str2 = "N/A"
            local str3 = "N/A"
            pcall(function()
                local productInfoAsync = MarketplaceService:GetProductInfoAsync(game.PlaceId, Enum.InfoType.Asset)
                str2 = productInfoAsync.Name
                str3 = productInfoAsync.Description
            end)
            local str4 = string.format(
                "User Report: \n    %s \nPlace Title: \n    %s \nPlaceId: \n    %s \nPlace Description: \n    %s \n",
                arg1.comment,
                str2,
                str1,
                str3
            )

            Players:ReportAbuse(nil, abuseReason, str4)
        end)
        arg2.analyticsDispatch({ type = Constants.AnalyticsActions.SetSubmissionCompleted })
        local toastMessageFromAbuseReason = getToastMessageFromAbuseReason(abuseReason)
        arg2.onReportComplete(toastMessageFromAbuseReason)
    end,
    fieldLabel = "",
    componentName = "SubmitButton"
}
