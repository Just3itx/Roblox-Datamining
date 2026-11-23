-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthAnalytics = script:FindFirstAncestor("AuthAnalytics")
local AuthAnalyticsParent = AuthAnalytics.Parent

local TelemetryConfigs = require(AuthAnalytics.RobloxTelemetry.TelemetryConfigs)
local LoginStatus = require(AuthAnalyticsParent.RobloxAppEnums).LoginStatus

local FFlagUseSignalsForAuthenticationStatus = require(AuthAnalyticsParent.SharedFlags).FFlagUseSignalsForAuthenticationStatus
local GetAuthenticationStatusStore = if FFlagUseSignalsForAuthenticationStatus then require(AuthAnalyticsParent.AuthenticationStatus).GetAuthenticationStatusStore else nil
local tbl1 = {
    [LoginStatus.UNKNOWN] = true,
    [LoginStatus.LOGGED_OUT] = true,
    [LoginStatus.LOGGED_IN] = true
}

local function normalizeAuthenticationStatusForTelemetry(str1: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == nil then "NIL" elseif tbl1[str1] then str1 else "UNRECOGNIZED"
end

return function(arg1, arg2, arg3)
    return function(arg4)
        local var1 = if FFlagUseSignalsForAuthenticationStatus then GetAuthenticationStatusStore(false).getStatus(false) else arg4:getState().AuthenticationStatus.status

        if var1 == LoginStatus.LOGGED_IN then
            return
        end

        arg3(arg1):andThen(function(_)
            arg2:logRobloxTelemetryCounter(
                TelemetryConfigs.ValidCookieForNoCachedUserTelemetryConfig,
                1,
                {
                    authenticationStatus = normalizeAuthenticationStatusForTelemetry(var1)
                }
            )
        end):catch(function(_) end)
    end
end
