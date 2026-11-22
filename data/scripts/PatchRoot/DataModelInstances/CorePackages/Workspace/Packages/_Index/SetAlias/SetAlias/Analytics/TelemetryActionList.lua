-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SetAlias = script:FindFirstAncestor("SetAlias")
local EventNames = require(script.Parent.Enums.EventNames)

local SetAliasParent = SetAlias.Parent
local SupportedTelemetryBackends = require(SetAliasParent.SocialLuaAnalytics).Analytics.Enums.SupportedTelemetryBackends

return {
    defaults = {
        throttlingThousandths = game:DefineFastInt("SetAliasAnalyticsThrottlingThousandths", 1000),
        links = ""
    },
    [EventNames.CustomizeNameLoadingStage] = {
        description = "Set Alias View Opened",
        lastUpdated = { 24, 6, 10 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryStat,
            dynamicCustomFields = {
                status = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    }
}
