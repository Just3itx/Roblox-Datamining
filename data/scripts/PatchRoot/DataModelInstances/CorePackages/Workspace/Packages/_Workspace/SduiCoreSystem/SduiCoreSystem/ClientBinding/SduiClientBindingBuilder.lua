-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local Signals = require(SduiCoreSystemParent.Signals)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local buildDataBindingSourcesForTemplate = require(SduiCoreSystem.ClientBinding.buildDataBindingSourcesForTemplate)

local buildAnalyticsContextForClientBinding = require(SduiCoreSystem.ClientBinding.buildAnalyticsContextForClientBinding)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local PropResultCategory = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes).PropResultCategory
local ProtoVariableMapper = require(SduiCoreSystem.ClientBinding.ProtoVariableMapper)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)

local SharedFlags = require(SduiCoreSystemParent.SharedFlags)
local FFlagSduiExperimentalComponent = SharedFlags.FFlagSduiExperimentalComponent
local FFlagSduiErrorPaths = SharedFlags.FFlagSduiErrorPaths

local function buildProp(arg1, arg2, arg3, arg4, arg5, str1: string?)
    if arg1.oneof_prop and arg1.oneof_prop.value then
        if FFlagSduiExperimentalComponent then
            local propBuilder = arg1.prop_builder
            if propBuilder ~= nil then
                str1 = propBuilder
            end
        end

        return buildProp(arg1.oneof_prop.value, arg2, arg3, arg4, arg5, str1)
    end

    if typeof(arg1) == "table" and arg1.descriptor == nil then
        return arg4.getPropBuilder("ContainerProp")(nil, arg1, arg2, arg3, arg4, arg5)
    end

    local type = arg1 and arg1.kind and arg1.kind.type
    if type == nil then
        error("No propDefinitionType provided")
    end

    if arg1.descriptor == nil then
        error(`No propDefinitionType descriptor provided for {type}`)
    end
    local name = arg1.descriptor.name

    local var1 = FFlagSduiExperimentalComponent and str1 ~= nil
    if not var1 then
        str1 = name
    end

    arg4.currentParserName = str1

    local propBuilder = arg4.getPropBuilder(str1, var1)

    local value = arg1.kind and arg1.kind.value
    if value == nil then
        error(`No propDefinitionValue provided for {type}`)
    end

    local var2, var3, var4 = propBuilder(type, value, arg2, arg3, arg4, arg5)

    return var2, var3, var4
end

local function buildPropTable(arg1, arg2, arg3, arg4, arg5)
    local tbl1 = ({})
    if arg1 == nil then
        error("Attempt to buildPropTable with nil")
    end

    local currentComponentType = arg4.currentComponentType

    local var1 = nil
    local var2 = nil
    local var3 = nil
    for value, value2 in arg1 do
        local var4 = ProtoVariableMapper.mapPropName(value)
        local success, result = pcall(function()
            local var5, var6, var7 = buildProp(value2, arg2, arg3, arg4, arg5)
            if var6 == PropResultCategory.PropSignal then
                if var1 == nil then
                    var1 = {}
                end
                var1[var4] = var5
                return
            end

            if var6 == PropResultCategory.NestedComponentConfig then
                if var2 == nil then
                    var2 = {}
                end
                var2[var4] = var5
                return
            end

            if var6 == PropResultCategory.NestedComponentConfigListPropSignal then
                if var1 == nil then
                    var1 = {}
                end
                var1[var4] = var5
                if var3 == nil then
                    var3 = {}
                end
                var3[var4] = true
                return
            end

            if var6 == PropResultCategory.Failed then
                tbl1[var4] = var5

                local tbl2 = {
                    message = `ClientBinding - failed to build prop {var4}: {var5}, {var7}`,
                    propName = `{var4}`,
                    name = arg4.debugName,
                    componentType = currentComponentType,
                    parserName = value2.descriptor.name,
                    value = value2
                }
                if FFlagSduiErrorPaths then
                    addSduiErrorContextFields(tbl2, arg4.errorContext)
                end
                SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, arg4.appPage)
                return
            end
            if var6 == PropResultCategory.Literal then
                tbl1[var4] = var5
                return
            end
            local tbl2 = {
                message = `ClientBinding - unexpected propResultCategory: {var6}. {var4}: {var5}, {var7}`,
                propName = `{var4}`,
                name = arg4.debugName,
                componentType = currentComponentType,
                parserName = value2.descriptor.name,
                value = value2
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl2, arg4.errorContext)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, arg4.appPage)

            tbl1[var4] = var5
        end)

        if success then
            continue
        end
        local tbl2 = {
            message = `ClientBinding - failed to build prop {var4}: {result}. {result}`,
            propName = `{var4}`,
            name = arg4.debugName,
            componentType = currentComponentType,
            parserName = value2.descriptor.name,
            value = value2
        }
        if FFlagSduiErrorPaths then
            addSduiErrorContextFields(tbl2, arg4.errorContext)
        end
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, arg4.appPage)
    end

    return tbl1, var1, var2, var3
end

local tbl1 = {
    __index = function(arg1, arg2)
        if arg2 == "analyticsData" then
            return arg1.analyticsContext and arg1.analyticsContext.analyticsData
        end

        return nil
    end
}

local function resolveComponentType(arg1)
    if not FFlagSduiExperimentalComponent then
        local componentType = arg1.shared and arg1.shared.component_type
        if not componentType then
            error("Could not determine ui component type")
        end
        return (ProtoVariableMapper.mapUiComponentTypeToLua(componentType))
    end

    local var1 = nil
    if arg1.experimental_type then
        var1 = SduiComponentType[arg1.experimental_type]
    else
        local componentType = arg1.shared and arg1.shared.component_type
        if componentType then
            var1 = ProtoVariableMapper.mapUiComponentTypeToLua(componentType)
        end
    end
    if not var1 then
        error("Could not determine ui component type")
    end
    return var1
end

return {
    buildPropTable = buildPropTable,
    buildProp = buildProp,
    buildConfigForComponent = function(arg1, arg2, arg3, arg4, _, arg5, tbl2, str1: string?, str2: string?)
        if not (arg1 and next(arg1)) then
            error("Attempt to buildConfigForComponent with nil template")
        end
        local value = arg1.kind.value

        local var1 = resolveComponentType(value)
        local var2 = nil
        if FFlagSduiErrorPaths then
            var2 = tbl2 or {}
            local errorContext = arg3.errorContext
            local var3 = if errorContext then errorContext.fullName else arg3.appPage
            local rctPath = if errorContext then errorContext.rctPath else nil
            local var4 = str1 or var1 or arg1.kind.type
            local tbl3 = {
                fullName = if str2 and str2 ~= "" then `{var3}.{var4}[{str2}]` else `{var3}.{var4}`,
                rctPath = 0,
                templateId = 0
            }

            if str1 then
                if rctPath then
                    rctPath = `{rctPath}.{str1}`
                else
                    rctPath = str1
                end
            end

            tbl3.rctPath = rctPath

            tbl3.templateId = if str1 then arg3.getTemplateIdForRCT and arg3.getTemplateIdForRCT(str1) else errorContext and errorContext.templateId
            var2.errorContext = tbl3

            arg3 = table.clone(arg3)
            local errorContext2 = var2.errorContext
            arg3.errorContext = errorContext2
        end
        arg3.currentComponentType = var1
        local var3

        if arg5 ~= nil then
            var3 = arg5
        else
            local var4 = not value.shared and {} or value.shared.data or {}
            var3 = Signals.createComputed(function(arg6)
                local success, result = pcall(function()
                    return buildDataBindingSourcesForTemplate(arg2(arg6), var4)
                end)
                if success then
                    return result
                end

                local tbl3 = {
                    name = arg3.debugName,
                    componentType = var1,
                    message = SduiParseHelpers.stringifyValue(result)
                }
                if FFlagSduiErrorPaths then
                    addSduiErrorContextFields(tbl3, arg3.errorContext)
                end
                SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToBuildBindingSources, tbl3, arg3.appPage)

                return {}
            end)
        end

        var2 = not FFlagSduiErrorPaths and (tbl2 or {}) or var2

        var2.__processed = true
        var2.__isClientBinding = true
        var2.componentType = var1
        setmetatable(var2, tbl1)
        local var4, var5

        if value.shared and value.shared.analytics_data then
            var4, var5 = buildPropTable(value.shared.analytics_data, var3, arg2, arg3, nil)
        else
            var4 = nil
            var5 = nil
        end

        local analyticsContext = buildAnalyticsContextForClientBinding(var4, var5, arg4, arg3)
        var2.analyticsContext = analyticsContext

        if value.props then
            local props, propSignals, nestedComponentConfigs, nestedComponentConfigListPropSignalNames = buildPropTable(value.props, var3, arg2, arg3, var2.analyticsContext)
            var2.props = props

            if propSignals ~= nil and next(propSignals) then
                var2.propSignals = propSignals
            end
            if nestedComponentConfigs ~= nil and next(nestedComponentConfigs) then
                var2.nestedComponentConfigs = nestedComponentConfigs
            end
            if nestedComponentConfigListPropSignalNames ~= nil and next(nestedComponentConfigListPropSignalNames) then
                var2.nestedComponentConfigListPropSignalNames = nestedComponentConfigListPropSignalNames
            end
        end

        if value.shared and value.shared.is_component_filtered then
            local isComponentFiltered = value.shared.is_component_filtered
            local success, result, result2, result3 = pcall(function()
                return buildProp(isComponentFiltered, var3, arg2, arg3, var2.analyticsContext)
            end)

            if not success or result3 or result2 == PropResultCategory.Failed then
                local var6 = if result3 then SduiParseHelpers.stringifyValue(result3) else SduiParseHelpers.stringifyValue(result)
                local var7 = SduiParseHelpers.stringifyValue(isComponentFiltered)
                local tbl3 = {
                    message = `Failed to build is_component_filtered prop: {var6}`,
                    name = arg3.debugName,
                    componentType = var1,
                    value = var7
                }
                if FFlagSduiErrorPaths then
                    addSduiErrorContextFields(tbl3, arg3.errorContext)
                end
                SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl3, arg3.appPage)
            elseif result2 == PropResultCategory.PropSignal then
                var2.isComponentFilteredSignal = result
            elseif result2 == PropResultCategory.Literal then
                function var2.isComponentFilteredSignal()
                    return { data = result }
                end
            end
        end

        return var2
    end
}
