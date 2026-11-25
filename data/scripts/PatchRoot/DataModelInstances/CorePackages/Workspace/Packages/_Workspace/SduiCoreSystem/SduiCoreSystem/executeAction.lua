-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local logActionTelemetry = require(SduiCoreSystem.Analytics.logActionTelemetry)

local _SduiActionType = require(SduiCoreSystem.SduiActionType)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local getSduiActionHandlerRegistry = require(SduiCoreSystem.getSduiActionHandlerRegistry)
local createSduiErrorLogger = require(SduiCoreSystem.createSduiErrorLogger)
local FFlagSduiErrorPaths = require(SduiCoreSystem.Parent.SharedFlags).FFlagSduiErrorPaths

local function executeAction(arg1, arg2, arg3, arg4)
    if not arg1 then
        return
    end
    assert(arg1, "actionConfig must exist")

    local var1 = getSduiActionHandlerRegistry().getActionHandlerConfig(arg1.actionType)

    if not var1 then
        return
    end
    assert(var1, "actionHandlerConfig must exist")
    if FFlagSduiErrorPaths then
        arg3 = table.clone(arg3)
        arg3.dependencies = table.clone(arg3.dependencies)
        arg3.dependencies.logger = createSduiErrorLogger(arg3.dependencies.logger, nil, arg1.actionType)
    end

    logActionTelemetry(arg1.telemetryHandler, var1, arg1, arg2, arg3)

    if var1.handler then
        return var1.handler(arg1, arg2, arg3, arg4)
    end
end

return executeAction
