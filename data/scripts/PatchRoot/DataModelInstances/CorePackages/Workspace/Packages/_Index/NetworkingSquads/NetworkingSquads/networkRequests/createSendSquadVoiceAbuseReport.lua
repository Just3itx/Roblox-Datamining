-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NetworkingSquadsParent = script:FindFirstAncestor("NetworkingSquads").Parent

local Cryo = require(NetworkingSquadsParent.Cryo)
local Url = require(NetworkingSquadsParent.Http).Url
local _networkingSquadTypes = require(script.Parent.Parent.networkingSquadTypes)

return function(arg1)
    return (arg1.roduxNetworking.POST("SendSquadVoiceAbuseReport", function(arg2, arg3)
        assert(arg3.voiceChannelId, "Missing voiceChannelId")

        local valueList = Cryo.List.map(arg3.voiceUserIds, function(arg4)
            return {
                data = tostring(arg4)
            }
        end)
        local tags = {
            ENTRY_POINT = {
                valueList = {{ data = "party" }}
            },
            SUBMITTER_USER_ID = {
                valueList = {{
                    data = arg3.submitterUserId
                }}
            },
            REPORT_TARGET_USER_ID = {
                valueList = {{
                    data = arg3.abuserUserId
                }}
            },
            REPORTED_ABUSE_CATEGORY = {
                valueList = {{
                    data = arg3.abuseReason
                }}
            },
            REPORTER_COMMENT = {
                valueList = {{
                    data = arg3.abuseComment
                }}
            },
            IS_PLACE_VOICE_ENABLED = {
                valueList = {{ data = "true" }}
            },
            VOICE_USER_IDS_FROM_CLIENT = { valueList = valueList },
            IN_EXP_MENU_OPENED_UNIX_MILLI = 0,
            VOICE_CHANNEL_ID = 0,
            VOICE_USER_COUNT = 0,
            VOICE_IMPACTED_USER_COUNT = 0,
            REPORTED_ABUSE_VECTOR = 0
        }
        local inExpMenuOpenedUnixMilli = {
            valueList = {{
                data = tostring(math.floor(arg3.reportBeginTimestampMs))
            }}
        }
        tags.IN_EXP_MENU_OPENED_UNIX_MILLI = inExpMenuOpenedUnixMilli

        tags.VOICE_CHANNEL_ID = {
            valueList = {{
                data = arg3.voiceChannelId
            }}
        }
        local voiceUserCount = {
            valueList = {{
                data = tostring(arg3.voiceUserCount)
            }}
        }
        tags.VOICE_USER_COUNT = voiceUserCount
        tags.VOICE_IMPACTED_USER_COUNT = {
            valueList = {{ data = "0" }}
        }
        tags.REPORTED_ABUSE_VECTOR = {
            valueList = {{ data = "voice" }}
        }
        return arg2(Url.APIS_URL):path("abuse-reporting"):path("v2"):path("abuse-report"):body({ tags = tags })
    end))
end
