-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoiceParent = script:FindFirstAncestor("CrossExperienceVoice").Parent

local SupportedTelemetryBackends = require(CrossExperienceVoiceParent.SocialLuaAnalytics).Analytics.Enums.SupportedTelemetryBackends

local EventNames = require(script.Parent.EventNames)

return {
    defaults = {
        throttlingThousandths = game:DefineFastInt("PartyVoiceTelemetryThrottlingThousandths", 1000),
        links = ""
    },
    [EventNames.PartyVoiceStateChanged] = {
        lastUpdated = { 24, 12, 8 },
        description = "Event when a user transitions state during a party voice session",
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                status = function<T>(arg1: T): T
                    return arg1
                end,
                previousStatus = function<T>(arg1: T): T
                    return arg1
                end,
                detail = function<T>(arg1: T): T
                    return arg1
                end,
                activeDm = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.PartyVoiceConnectedParticipantsOnJoin] = {
        lastUpdated = { 24, 11, 30 },
        description = "Event when a user successfully connects to a party voice channel",
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                numberActive = function<T>(arg1: T): T
                    return arg1
                end,
                activeDm = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.PartyVoiceJoinFailure] = {
        lastUpdated = { 25, 3, 12 },
        description = "Event when a user attempts to connect to party voice and results in failure",
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                errorMessage = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.PartyVoiceJoinAttempt] = {
        lastUpdated = { 24, 12, 8 },
        description = "Event when a user attempts to connect to party voice",
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                activeDm = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.PartyVoiceUnmuteParticipant] = {
        lastUpdated = { 25, 3, 30 },
        description = "Event when a user unmutes a participant in party voice",
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.PartyVoiceMuteParticipant] = {
        lastUpdated = { 25, 3, 30 },
        description = "Event when a user mutes a participant in party voice",
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.PartyVoiceBlockParticipant] = {
        lastUpdated = { 25, 3, 30 },
        description = "Event when a user blocks a participant in party voice",
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.PartyVoiceUnblockParticipant] = {
        lastUpdated = { 25, 3, 30 },
        description = "Event when a user unblocks a participant in party voice",
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    }
}
