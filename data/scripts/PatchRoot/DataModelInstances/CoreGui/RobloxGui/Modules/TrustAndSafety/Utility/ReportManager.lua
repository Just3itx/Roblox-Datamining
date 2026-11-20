-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")

local _Dash = require(CorePackages.Packages.Dash)

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local createVoiceAbuseReportRequest = require(RobloxGui.Modules.VoiceChat.createVoiceAbuseReportRequest)
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url

local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Resources.Constants)
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local SessionUtility = require(scriptParentParent.Utility.SessionUtility)

function sendAnalytics(reportType: string, num1: number, reason: string, abuseVector: string?)
    SendAnalytics(reportType, Constants.Analytics.ReportSubmittedName, {
        reportType = reportType,
        reportedEntityId = tostring(num1),
        reportSource = Constants.Analytics.ReportSourceInGame,
        reason = reason,
        abuseVector = abuseVector
    })
end

function getAbuseVectorFromReportCategory(reportCategory: string): string
    if reportCategory == Constants.Category.Voice then
        return "voice"
    end

    if reportCategory == Constants.Category.Text then
        return "chat"
    end

    return "other"
end

function submitUserAbuseReport(tbl1, callback)
    local bool1 = tbl1.reportCategory == Constants.Category.Voice
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end

    pcall(function()
        coroutine.wrap(function()
            local abuseVector = getAbuseVectorFromReportCategory(tbl1.reportCategory)

            if bool1 then
                local voiceAbuseReportRequest = createVoiceAbuseReportRequest(Players, default, {
                    localUserId = localPlayer.UserId,
                    abuserUserId = tbl1.abusingPlayer.UserId,
                    abuseComment = tbl1.comment,
                    abuseReason = tbl1.reason,
                    inExpMenuOpenedUnixMilli = math.floor(tbl1.beginningTimestamp * 1000),
                    sortedPlayerListUserIds = tbl1.sortedUserIds,
                    abuseVector = abuseVector
                })

                if game:GetEngineFeature("AbuseReportV3") then
                    Players:ReportAbuseV3(localPlayer, voiceAbuseReportRequest)
                else
                    local apiUrl = Url.APIS_URL .. "/abuse-reporting/v2/abuse-report"
                    HttpRbxApiService:PostAsyncFullUrl(apiUrl, voiceAbuseReportRequest)
                end
            else
                Players:ReportAbuse(tbl1.abusingPlayer, tbl1.reason, tbl1.comment)
            end

            sendAnalytics(Constants.Analytics.ReportTypeUser, tbl1.abusingPlayer.UserId, tbl1.reason, abuseVector)
            SessionUtility.endAbuseReportSession()

            if callback then
                callback()
            end
        end)()
    end)
end

function submitPlaceAbuseReport(tbl1, callback)
    if tbl1.placeName == "" then
        return
    end

    coroutine.wrap(function()
        if not RunService:IsStudio() then
            local var1 = string.format(
                "User Report: \n    %s \nPlace Title: \n    %s \nPlaceId: \n    %s \nPlace Description: \n    %s \n",
                tbl1.comment,
                tbl1.placeName,
                tostring(tbl1.placeId),
                tbl1.placeDescription
            )

            Players:ReportAbuse(nil, tbl1.reason, var1)
        end

        sendAnalytics(Constants.Analytics.ReportTypeGame, tbl1.placeId, tbl1.reason)
        SessionUtility.endAbuseReportSession()

        if callback then
            callback()
        end
    end)()
end

return {
    submitUserAbuseReport = submitUserAbuseReport,
    submitPlaceAbuseReport = submitPlaceAbuseReport
}
