-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthAnalyticsParent = script:FindFirstAncestor("AuthAnalytics").Parent
local default = require(AuthAnalyticsParent.LoggingProtocol).default
local TelemetryConfigs = require(script.Parent.TelemetryConfigs)

local bool1 = game:DefineFastFlag("LuaAppCredentialSheetEventStream", false)

local tbl1 = {
    [TelemetryConfigs.IosAuthServiceLoginCredentialSheetShownConfig.eventName] = TelemetryConfigs.IosAuthServiceLoginCredentialSheetShownEventConfig,
    [TelemetryConfigs.IosAuthServiceLoginCredentialSheetPasswordSelectedConfig.eventName] = TelemetryConfigs.IosAuthServiceLoginCredentialSheetPasswordSelectedEventConfig,
    [TelemetryConfigs.IosAuthServiceLoginCredentialSheetPasskeySelectedConfig.eventName] = TelemetryConfigs.IosAuthServiceLoginCredentialSheetPasskeySelectedEventConfig,
    [TelemetryConfigs.IosAuthServiceLoginCredentialSheetErrorConfig.eventName] = TelemetryConfigs.IosAuthServiceLoginCredentialSheetErrorEventConfig,
    [TelemetryConfigs.IosAuthServiceLoginCredentialSheetDismissedConfig.eventName] = TelemetryConfigs.IosAuthServiceLoginCredentialSheetDismissedEventConfig,
    [TelemetryConfigs.IosAuthServiceLoginCredentialSheetLoginSuccessConfig.eventName] = TelemetryConfigs.IosAuthServiceLoginCredentialSheetLoginSuccessEventConfig,
    [TelemetryConfigs.IosAuthServiceLoginCredentialSheetLoginFailureConfig.eventName] = TelemetryConfigs.IosAuthServiceLoginCredentialSheetLoginFailureEventConfig,
    [TelemetryConfigs.IosAuthServiceLoginCredentialSheetUnavailableConfig.eventName] = TelemetryConfigs.IosAuthServiceLoginCredentialSheetUnavailableEventConfig
}

local module = {}

function module.report(arg1, tbl2)
    default:logRobloxTelemetryCounter(arg1, 1, tbl2)

    if not bool1 then
        return
    end

    local var1 = tbl1[arg1.eventName]
    if var1 == nil then
        return
    end

    default:logRobloxTelemetryEvent(var1, nil, tbl2)
end

return module
