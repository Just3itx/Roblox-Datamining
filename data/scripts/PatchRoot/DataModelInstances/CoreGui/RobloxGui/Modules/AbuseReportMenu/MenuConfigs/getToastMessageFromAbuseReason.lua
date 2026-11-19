-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local Constants = require(AbuseReportMenu.Components.Constants)
local ReportSuccessToast = Constants.ReportSuccessToast
local PlayerAbuseTypes = Constants.PlayerAbuseTypes

local function getToastMessageFromAbuseReason(str1: string, bool1: boolean?)
    local chatGeneric = ReportSuccessToast.ChatGeneric

    if str1 == PlayerAbuseTypes.Cheating then
        chatGeneric = ReportSuccessToast.Cheating
    elseif str1 == PlayerAbuseTypes.Username then
        chatGeneric = ReportSuccessToast.BadUserName
    elseif str1 == PlayerAbuseTypes.Links or str1 == Constants.InappropriateContentAbuseReason then
        chatGeneric = ReportSuccessToast.Place
    end

    if bool1 then
        chatGeneric = ReportSuccessToast.ReportAnythingGeneric
    end

    return chatGeneric
end

return getToastMessageFromAbuseReason
