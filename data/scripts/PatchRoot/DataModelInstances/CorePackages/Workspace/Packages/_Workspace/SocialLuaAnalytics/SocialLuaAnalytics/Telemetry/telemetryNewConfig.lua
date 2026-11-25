-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalytics = script:FindFirstAncestor("SocialLuaAnalytics")
local SocialLuaAnalyticsParent = SocialLuaAnalytics.Parent
local Cryo = require(SocialLuaAnalyticsParent.Cryo)
local _SupportedTelemetryBackends = require(SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends)
local formatEventStreamFields = require(SocialLuaAnalytics.Telemetry.formatEventStreamFields)
local _Contexts = require(SocialLuaAnalytics.Analytics.Enums.Contexts)

local function telemetryConfig(tbl1)
    return {
        name = tbl1.name,
        description = tbl1.description,
        eventStreamCtx = tbl1.eventStreamCtx,
        lastUpdated = tbl1.lastUpdated,
        backendsList = Cryo.List.map(tbl1.backendsList, function(arg1)
            if arg1.type ~= "EventIngest" then
                return arg1
            end

            return Cryo.Dictionary.join(arg1, {
                format = function(...)
                    local var1 = arg1.format(...)
                    return formatEventStreamFields(var1)
                end
            })
        end),
        throttlingThousandths = tbl1.throttlingThousandths
    }
end

return telemetryConfig
