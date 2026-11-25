-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local getSduiTelemetryHandlerNameRegistry = require(SduiCoreSystem.getSduiTelemetryHandlerNameRegistry)
local reportUnifiedLoggingAction = require(SduiCoreSystem.Analytics.reportUnifiedLoggingAction)

local function logActionTelemetry(str1: string?, arg1, arg2, arg3, arg4)
    if str1 and str1 ~= "" then
        local var1 = getSduiTelemetryHandlerNameRegistry().getTelemetryHandler(str1)
        if var1 then
            var1(arg2, arg3, arg4)
        else
            (if FFlagSduiErrorPaths then arg4.dependencies and arg4.dependencies.logger or SduiLogger else SduiLogger).reportError(
                SduiErrors.SduiErrorType.InvalidActionParams,
                {
                    message = `Unknown telemetry handler name: {str1}`,
                    name = arg2.actionType
                },
                arg4.appPage
            )
        end
    elseif arg1.telemetryHandler then
        arg1.telemetryHandler(arg2, arg3, arg4)
    end

    if arg1.skipUnifiedLogging or arg2.skipUnifiedLogging then
        return
    end

    if arg3 ~= nil then
        reportUnifiedLoggingAction(arg4, arg2, arg3)
        return
    end

    (if FFlagSduiErrorPaths then arg4.dependencies and arg4.dependencies.logger or SduiLogger else SduiLogger).reportError(
        SduiErrors.SduiErrorType.NilAnalyticsContext,
        {
            message = `Could not reportUnifiedLoggingAction. Missing analyticsContext {arg2.actionType}`,
            name = arg2.actionType
        },
        arg4.appPage
    )
end

return logActionTelemetry
