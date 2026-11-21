-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackground = script:FindFirstAncestor("EditProfileBackground")
local EventNames = require(script.Parent.Enums.EventNames)

local EditProfileBackgroundParent = EditProfileBackground.Parent
local SupportedTelemetryBackends = require(EditProfileBackgroundParent.SocialLuaAnalytics).Analytics.Enums.SupportedTelemetryBackends

return {
    defaults = {
        throttlingThousandths = game:DefineFastInt("EditProfileBackgroundAnalyticsThrottlingThousandths", 1000),
        links = ""
    },
    [EventNames.EditProfileBackgroundOpened] = {
        description = "Edit Profile Background Page Opened",
        lastUpdated = { 25, 7, 30 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.EditProfileBackgroundLoadingStage] = {
        description = "Edit Profile Background Loading Stage",
        lastUpdated = { 25, 7, 30 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryStat,
            dynamicCustomFields = {
                status = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.BackgroundSelected] = {
        description = "Background Selected",
        lastUpdated = { 25, 7, 30 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                backgroundId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.EditProfileBackgroundFailure] = {
        description = "Edit Profile Background Failure",
        lastUpdated = { 25, 8, 4 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                errorType = function<T>(arg1: T): T
                    return arg1
                end,
                errorCode = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    }
}
