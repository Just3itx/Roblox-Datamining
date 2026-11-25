-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiCoreSystemParent = SduiCoreSystem.Parent
local _Signals = require(SduiCoreSystemParent.Signals)

local SduiErrors = require(SduiCoreSystem.SduiErrors)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local createSduiErrorLogger = require(SduiCoreSystem.createSduiErrorLogger)
local getSduiActionHandlerRegistry = require(SduiCoreSystem.getSduiActionHandlerRegistry)

local getSduiServiceDependenciesStore = require(SduiCoreSystem.ClientBinding.getSduiServiceDependenciesStore)
local logActionTelemetry = require(SduiCoreSystem.Analytics.logActionTelemetry)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local PropResultCategory = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes).PropResultCategory
local ProtoVariableMapper = require(SduiCoreSystem.ClientBinding.ProtoVariableMapper)
local SduiClientBindingBuilder = require(SduiCoreSystem.ClientBinding.SduiClientBindingBuilder)
local buildPropTable = SduiClientBindingBuilder.buildPropTable
local SduiActionType = require(SduiCoreSystem.SduiActionType)
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local FFlagSduiExperimentalComponent = require(SduiCoreSystemParent.SharedFlags).FFlagSduiExperimentalComponent

local function mergeTemplateParamsWithOverrides(tbl1, arg1)
    if typeof(arg1) ~= "table" then
        return tbl1
    end
    local var1 = not tbl1 and {} or table.clone(tbl1)
    for value, value2 in arg1 do
        var1[value] = value2
    end
    return var1
end

local function buildActionProp(str1: string, arg1, arg2, arg3, arg4, arg5)
    local currentComponentType = arg4.currentComponentType
    local currentParserName = arg4.currentParserName

    if str1 ~= "value" then
        if str1 == "conditional" then
            return SduiPropUtils.generateConditionalPropValue(arg1, arg2, arg4, arg5, arg3, buildActionProp), PropResultCategory.PropSignal
        end
        error(`Could not build prop. Unknown propDefinitionType: {str1}`)

        return
    end

    local var1 = nil
    local success, result = pcall(function()
        local appPage = arg4.appPage
        local value = if typeof(arg1) == "table" and arg1.kind then arg1.kind.value or nil else nil
        local experimentalType = if FFlagSduiExperimentalComponent and value then value.experimental_type else nil
        var1 = if experimentalType then SduiActionType[experimentalType] elseif value and value.action_type then ProtoVariableMapper.mapActionTypeToLua(value.action_type) else nil

        if not var1 then
            error(`Could not map actionType: {experimentalType or value and value.action_type}`)
        end

        local var2 = getSduiActionHandlerRegistry().getActionHandlerConfig(var1)

        if not var2 then
            error(`Could not find action for actionType: {var1}`)
        end

        return function(_, arg6, arg7)
            local var3 = getSduiServiceDependenciesStore().getDependencies(appPage)
            local var4

            if FFlagSduiErrorPaths and var3 and var3.logger then
                var4 = table.clone(var3)
                var4.logger = createSduiErrorLogger(var3.logger, arg4.errorContext, var1)
            else
                var4 = var3
            end

            local tbl1 = {
                dependencies = var4,
                appPage = appPage,
                configKey = arg4.configKey
            }

            local data = nil
            if arg1 and arg1.telemetry_handler then
                local telemetryHandler = arg1.telemetry_handler
                if telemetryHandler.kind and telemetryHandler.kind.type then
                    local var5
                    data, var5 = SduiClientBindingBuilder.buildProp(telemetryHandler, arg2, arg3, arg4, arg5)

                    if var5 == PropResultCategory.PropSignal then
                        data = data(false).data
                    end
                end
            end

            local data2 = nil
            if arg1 and arg1.skip_unified_logging then
                local skipUnifiedLogging = arg1.skip_unified_logging
                if skipUnifiedLogging.kind and skipUnifiedLogging.kind.type then
                    local var5
                    data2, var5 = SduiClientBindingBuilder.buildProp(skipUnifiedLogging, arg2, arg3, arg4, arg5)

                    if var5 == PropResultCategory.PropSignal then
                        data2 = data2(false).data
                    end
                end
            end

            local actionParams = value and value.action_params
            local tbl2 = { actionType = var1, telemetryHandler = data, skipUnifiedLogging = data2 }
            local var5

            if actionParams and next(actionParams) then
                local var6
                var5, var6 = buildPropTable(actionParams, arg2, arg3, arg4, arg5)
                if var6 then
                    for value2, value3 in var6 do
                        var5[value2] = value3(false).data
                    end
                end
            else
                var5 = nil
            end

            tbl2.actionParams = mergeTemplateParamsWithOverrides(var5, arg7)

            logActionTelemetry(data, var2, tbl2, arg5, tbl1)

            if var2.handler then
                return var2.handler(tbl2, arg5, tbl1, arg6)
            end
        end
    end)

    if success then
        return result, PropResultCategory.Literal
    end
    return function(_, _, _)
        SduiLogger.reportCounter(
            SduiErrors.SduiCounterName.ExecutedInvalidAction,
            { name = var1, componentType = currentComponentType, parserName = currentParserName }
        )
    end, PropResultCategory.Failed, result
end
return buildActionProp
