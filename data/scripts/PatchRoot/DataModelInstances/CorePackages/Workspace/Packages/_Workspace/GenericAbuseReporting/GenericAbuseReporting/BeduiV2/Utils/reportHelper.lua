-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local GetHumanoidDescription = require(GenericAbuseReportingParent.GetHumanoidDescription)
local Promise = require(GenericAbuseReportingParent.Promise)

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local appendReportAnythingTags = require(GenericAbuseReporting.BeduiV2.Utils.appendReportAnythingTags)

local FFlagEnableChatReportingTextChannelTag = require(GenericAbuseReportingParent.SharedFlags).FFlagEnableChatReportingTextChannelTag
local GetFFlagGetHumanoidDescriptionUpdatesV2E = require(GenericAbuseReportingParent.SharedFlags).GetFFlagGetHumanoidDescriptionUpdatesV2E
local FFlagAbuseReportForwardCustomTagFields = require(GenericAbuseReporting.Flags.FFlagAbuseReportForwardCustomTagFields)

local FFlagGenericAbuseReportingAvatarHumanoidDescription = require(GenericAbuseReporting.Flags.FFlagGenericAbuseReportingAvatarHumanoidDescription)

local appendReportAnythingTags2 = appendReportAnythingTags.appendReportAnythingTags
local getHumanoidDescription = GetHumanoidDescription.getHumanoidDescription

local function tag(str1: string?): {valueList: {{data: string}}}?
    return if str1 then {
        valueList = {{ data = str1 }}
    } else nil
end

local function isAllCapsKey(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return typeof(str1) == "string" and string.match(str1, "^[A-Z_][A-Z0-9_]*$") ~= nil
end

local function appendCustomTagFields(tags, arg1)
    local custom = arg1.data.custom
    if not custom then
        return
    end
    for k, value in pairs(custom) do
        if not isAllCapsKey(k) then
            continue
        end

        local str1 = typeof(value)
        if str1 == "string" or str1 == "number" or str1 == "boolean" then
            tags[k] = tag(tostring(value))
        end
    end
end

local function buildVoiceReport(arg1, tbl1): string
    local valueList = {}
    if tbl1 then
        for _, sortedPlayerListUserId in ipairs(tbl1.sortedPlayerListUserIds) do
            table.insert(valueList, { data = tostring(sortedPlayerListUserId) })
        end
    end

    local localPlayer = Players.LocalPlayer
    local tags = {
        ENTRY_POINT = tag("in-experience"),
        SUBMITTER_USER_ID = tag(tostring(localPlayer and localPlayer.UserId or 0)),
        REPORT_TARGET_USER_ID = tag(arg1.data.targetIdStr),
        REPORTED_ABUSE_CATEGORY = tag(arg1.data.category),
        REPORTER_COMMENT = tag(arg1.data.comment or ""),
        IS_PLACE_VOICE_ENABLED = tag("true"),
        VOICE_USER_IDS_FROM_CLIENT = { valueList = valueList },
        IN_EXP_MENU_OPENED_UNIX_MILLI = tag(tostring(tbl1 and tbl1.menuOpenedUnixMilli or 0)),
        VOICE_CHANNEL_ID = tag(tbl1 and tbl1.channelId or ""),
        VOICE_USER_COUNT = tag(tostring(tbl1 and tbl1.voiceUserCount or 0)),
        VOICE_IMPACTED_USER_COUNT = tag(tostring(tbl1 and tbl1.voiceImpactedUserCount or 0)),
        REPORTED_ABUSE_VECTOR = tag(arg1.data.abuseVector)
    }
    if FFlagAbuseReportForwardCustomTagFields then
        appendCustomTagFields(tags, arg1)
    end
    return HttpService:JSONEncode({ tags = tags })
end

local function buildChatReport(arg1, tbl1)
    local localPlayer = Players.LocalPlayer
    local messageId = tbl1.targetMessages and tbl1.targetMessages[1] and tbl1.targetMessages[1].messageId or ""
    local presetId = if tbl1.targetMessages and tbl1.targetMessages[1] then tbl1.targetMessages[1].presetId or nil else nil
    local presetChatVersion = if tbl1.targetMessages and tbl1.targetMessages[1] then tbl1.targetMessages[1].presetChatVersion or nil else nil
    local tbl2 = {
        tags = {
            ENTRY_POINT = tag("in-experience"),
            SUBMITTER_USER_ID = tag(tostring(localPlayer and localPlayer.UserId or 0)),
            REPORT_TARGET_USER_ID = tag(arg1.data.targetIdStr),
            REPORTED_ABUSE_CATEGORY = tag(arg1.data.category),
            REPORTER_COMMENT = tag(arg1.data.comment or ""),
            REPORTED_ABUSE_VECTOR = tag(arg1.data.abuseVector),
            REPORT_TARGET_MESSAGE_ID = tag(messageId),
            PRESET_ID = tag(presetId),
            PRESET_CHAT_VERSION = tag(presetChatVersion),
            VARIANT = tag("IGM_CLRv2")
        }
    }
    if FFlagEnableChatReportingTextChannelTag then
        local channel = tbl1.targetMessages and tbl1.targetMessages[1] and tbl1.targetMessages[1].channel

        local var1 = if channel then channel.Name else "RBXGlobal"
        tbl2.tags.IN_GAME_CHAT_TEXT_CHANNEL = tag(var1)
    end

    if FFlagAbuseReportForwardCustomTagFields then
        appendCustomTagFields(tbl2.tags, arg1)
    end
    return tbl2
end

local function getTargetHumanoidDescription(num1: number, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if GetFFlagGetHumanoidDescriptionUpdatesV2E() and arg1 then
        local identifiedAvatar = arg1.identificationResults.identifiedAvatars[num1]
        if identifiedAvatar and identifiedAvatar.humanoidDescription and identifiedAvatar.humanoidDescriptionStatus == "OK" then
            return identifiedAvatar.humanoidDescription, identifiedAvatar.humanoidDescriptionStatus
        end
    end
    return getHumanoidDescription(num1)
end

local function buildAvatarReport(arg1, arg2)
    local localPlayer = Players.LocalPlayer
    local tags = {
        ENTRY_POINT = tag("in-experience"),
        SUBMITTER_USER_ID = tag(tostring(localPlayer and localPlayer.UserId or 0)),
        REPORT_TARGET_USER_ID = tag(arg1.data.targetIdStr),
        REPORTED_ABUSE_CATEGORY = tag(arg1.data.category),
        REPORTER_COMMENT = tag(arg1.data.comment or ""),
        REPORTED_ABUSE_VECTOR = tag(arg1.data.abuseVector)
    }
    appendReportAnythingTags2(tags, arg2)
    local var1 = tonumber(arg1.data.targetIdStr)
    if FFlagGenericAbuseReportingAvatarHumanoidDescription and var1 then
        local input, var2 = getTargetHumanoidDescription(var1, arg2)
        tags.REPORT_TARGET_HUMANOID_DESCRIPTION = tag(HttpService:JSONEncode(input))
        tags.REPORT_TARGET_HUMANOID_DESCRIPTION_STATUS = tag(var2)
    end
    if FFlagAbuseReportForwardCustomTagFields then
        appendCustomTagFields(tags, arg1)
    end
    return { tags = tags }
end

local function buildPlaceReport(arg1, arg2): string
    local localPlayer = Players.LocalPlayer
    local tags = {
        ENTRY_POINT = tag("in-experience"),
        SUBMITTER_USER_ID = tag(tostring(localPlayer and localPlayer.UserId or 0)),
        PLACE_ID = tag(tostring(game.PlaceId)),
        REPORTED_ABUSE_CATEGORY = tag(arg1.data.category),
        REPORTER_COMMENT = tag(arg1.data.comment or ""),
        REPORTED_ABUSE_VECTOR = tag(arg1.data.abuseVector)
    }
    appendReportAnythingTags2(tags, arg2)
    if FFlagAbuseReportForwardCustomTagFields then
        appendCustomTagFields(tags, arg1)
    end
    return HttpService:JSONEncode({ tags = tags })
end

return {
    submitVoiceReport = function(arg1, tbl1)
        local voiceReport = buildVoiceReport(arg1, tbl1)
        return Promise.try(function()
            Players:ReportAbuseV3(Players.LocalPlayer, voiceReport)
            return {
                responseBody = {}
            }
        end)
    end,
    submitChatReport = function(arg1, tbl1)
        local chatReport = buildChatReport(arg1, tbl1)
        return Promise.try(function()
            Players:ReportChatAbuse(tbl1.eligibleMessages, tbl1.targetMessages, chatReport)
            return {
                responseBody = {}
            }
        end)
    end,
    submitChatReportWithoutMessage = function(arg1)
        return Promise.try(function()
            local var1 = tonumber(arg1.data.targetIdStr)
            local playerByUserId = var1 and Players:GetPlayerByUserId(var1)
            Players:ReportAbuse(playerByUserId, arg1.data.category, arg1.data.comment or "")
            return {
                responseBody = {}
            }
        end)
    end,
    submitAvatarReport = function(arg1, arg2)
        if FFlagGenericAbuseReportingAvatarHumanoidDescription then
            return Promise.try(function()
                local avatarReport = buildAvatarReport(arg1, arg2)
                Players:ReportAvatarAbuse(tonumber(arg1.data.targetIdStr), avatarReport)
                return {
                    responseBody = {}
                }
            end)
        end

        local avatarReport = buildAvatarReport(arg1, arg2)
        return Promise.try(function()
            Players:ReportAvatarAbuse(tonumber(arg1.data.targetIdStr), avatarReport)
            return {
                responseBody = {}
            }
        end)
    end,
    submitPlaceReport = function(arg1, arg2)
        local placeReport = buildPlaceReport(arg1, arg2)
        return Promise.try(function()
            Players:ReportAbuseV3(Players.LocalPlayer, placeReport)
            return {
                responseBody = {}
            }
        end)
    end,
    buildVoiceReport = buildVoiceReport,
    buildChatReport = buildChatReport,
    buildAvatarReport = buildAvatarReport,
    buildPlaceReport = buildPlaceReport
}
