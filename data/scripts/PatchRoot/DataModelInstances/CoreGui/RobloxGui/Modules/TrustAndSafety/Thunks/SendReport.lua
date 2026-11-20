-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Players = game:GetService("Players")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local _ReportAbuseLogic = require(RobloxGui.Modules.VoiceChat.ReportAbuseLogic)

local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Resources.Constants)
local ShowToast = require(scriptParentParent.Actions.ShowToast)
local OpenReportSentDialog = require(scriptParentParent.Actions.OpenReportSentDialog)
local EndReportFlow = require(scriptParentParent.Actions.EndReportFlow)
local ReportManager = require(scriptParentParent.Utility.ReportManager)

return function(arg1, abusingPlayer, reason, comment, reportCategory, arg2, arg3)
    return function(arg4)
        local state = arg4:getState()
        if arg1 == Constants.ReportType.Player then
            ReportManager.submitUserAbuseReport({
                reportCategory = reportCategory,
                abusingPlayer = abusingPlayer,
                reason = reason,
                comment = comment,
                beginningTimestamp = state.report.beginningTimestamp,
                sortedUserIds = state.report.sortedUserIds
            }, function()
                arg4:dispatch(OpenReportSentDialog(arg1, abusingPlayer))
            end)

            return
        end
        if arg1 ~= Constants.ReportType.Place then
            return
        end

        ReportManager.submitPlaceAbuseReport({
            placeId = game.PlaceId,
            placeName = state.placeInfo.name,
            placeDescription = state.placeInfo.description,
            reason = reason,
            comment = comment
        }, function()
            arg4:dispatch(ShowToast(arg2, arg3))
        end)
        arg4:dispatch(EndReportFlow())
    end
end
