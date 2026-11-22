-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoinParent = script:FindFirstAncestor("SocialExperienceJoin").Parent

local SupportedTelemetryBackends = require(SocialExperienceJoinParent.SocialLuaAnalytics).Analytics.Enums.SupportedTelemetryBackends
local FFlagJoinabilityCTARefactor = require(SocialExperienceJoinParent.SharedFlags).FFlagJoinabilityCTARefactor
local EventNames = require(script.Parent.EventNames)

return {
    defaults = {
        throttlingThousandths = game:DefineFastInt("SocialExperienceJoinAnalyticsThrottlingThousandths", 1000),
        links = ""
    },
    [EventNames.JoinExperience] = {
        description = "Experience launch attempt from another user's presence; followUser differentiates Join from Play.",
        lastUpdated = { 26, 10, 5 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                status = function<T>(arg1: T): T
                    return arg1
                end,
                followUser = FFlagJoinabilityCTARefactor and function<T>(arg1: T): T
                    return arg1
                end or nil
            }
        }}
    },
    [EventNames.PurchaseExperienceAttempt] = {
        description = "Purchase Experience Attempt Status after requesting",
        lastUpdated = { 24, 7, 17 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                status = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.PurchaseExperience] = {
        description = "Purchase Experience Button click",
        lastUpdated = { 24, 7, 17 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CancelPurchaseExperience] = {
        description = "Cancel Purchase Experience Attempt from other user",
        lastUpdated = { 24, 7, 17 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.UnableToJoinViewDetails] = {
        description = "Unable to Join Experience View Details",
        lastUpdated = { 24, 7, 17 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.UnableToJoinCancel] = {
        description = "Unable to Join Experience Cancel",
        lastUpdated = { 24, 7, 17 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    }
}
