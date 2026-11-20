-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)

local _VoiceChatServiceManager = require(script.Parent.VoiceChatServiceManager)
local getSortedPlayers = require(script.Parent.VoiceUsersByProximity).getSortedPlayers

return function(arg1, arg2, tbl1): string
    local playerByUserId = arg1:GetPlayerByUserId(tbl1.abuserUserId)
    local primaryPartPosition = if playerByUserId and playerByUserId.Character and playerByUserId.Character.PrimaryPart then playerByUserId.Character.PrimaryPart.Position else nil
    local num1 = #Cryo.Dictionary.values(arg2.participants)

    local num2 = primaryPartPosition and #getSortedPlayers(arg1, arg2, primaryPartPosition, 160, nil, playerByUserId) or 0

    local valueList = Cryo.List.map(tbl1.sortedPlayerListUserIds, function(arg3)
        return {
            data = tostring(arg3)
        }
    end)
    local input = { tags = 0 }
    local tags = {
        ENTRY_POINT = {
            valueList = {{ data = "in-experience" }}
        },
        SUBMITTER_USER_ID = 0,
        REPORT_TARGET_USER_ID = 0,
        REPORTED_ABUSE_CATEGORY = 0,
        REPORTER_COMMENT = 0,
        IS_PLACE_VOICE_ENABLED = 0,
        VOICE_USER_IDS_FROM_CLIENT = 0,
        IN_EXP_MENU_OPENED_UNIX_MILLI = 0,
        VOICE_CHANNEL_ID = 0,
        VOICE_USER_COUNT = 0,
        VOICE_IMPACTED_USER_COUNT = 0,
        REPORTED_ABUSE_VECTOR = 0
    }

    local submitterUserId = {
        valueList = {{
            data = tostring(tbl1.localUserId)
        }}
    }
    tags.SUBMITTER_USER_ID = submitterUserId

    local reportTargetUserId = {
        valueList = {{
            data = tostring(tbl1.abuserUserId)
        }}
    }
    tags.REPORT_TARGET_USER_ID = reportTargetUserId

    tags.REPORTED_ABUSE_CATEGORY = {
        valueList = {{
            data = tbl1.abuseReason
        }}
    }

    tags.REPORTER_COMMENT = {
        valueList = {{
            data = tbl1.abuseComment
        }}
    }

    tags.IS_PLACE_VOICE_ENABLED = {
        valueList = {{ data = "true" }}
    }

    tags.VOICE_USER_IDS_FROM_CLIENT = { valueList = valueList }

    local inExpMenuOpenedUnixMilli = {
        valueList = {{
            data = tostring(tbl1.inExpMenuOpenedUnixMilli)
        }}
    }
    tags.IN_EXP_MENU_OPENED_UNIX_MILLI = inExpMenuOpenedUnixMilli

    local voiceChannelId = {
        valueList = {{
            data = tostring(
                if game:GetEngineFeature("VoiceChatServiceExposesChannelId") then arg2.service:GetChannelId() else arg2.service:GetGroupId()
            )
        }}
    }
    tags.VOICE_CHANNEL_ID = voiceChannelId

    tags.VOICE_USER_COUNT = {
        valueList = {{
            data = tostring(num1)
        }}
    }

    tags.VOICE_IMPACTED_USER_COUNT = {
        valueList = {{
            data = tostring(num2)
        }}
    }

    tags.REPORTED_ABUSE_VECTOR = {
        valueList = {{
            data = tbl1.abuseVector
        }}
    }
    input.tags = tags

    return HttpService:JSONEncode(input)
end
