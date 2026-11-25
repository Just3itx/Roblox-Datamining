-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local Cryo = require(SduiCoreSystemParent.Cryo)
local tutils = require(SduiCoreSystemParent.tutils)

local SduiBuilderProcessingPhase = require(SduiCoreSystem.SduiBuilderTypes).SduiBuilderProcessingPhase
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiErrorType = require(SduiCoreSystem.SduiErrors).SduiErrorType
local parseProps = require(SduiCoreSystem.parseProps)
local validateInterface = require(SduiCoreSystem.validateInterface)
local UiComponentInterface = SduiConfigTypes.UiComponentInterface

local SduiCompat = require(SduiCoreSystemParent.SduiCompat)
local mapServerBindingProps = SduiCompat.mapServerBindingProps
local ServerBindingPropMap = SduiCompat.ServerBindingPropMap
local SduiUsageRecorder = require(SduiCoreSystem.Analytics.SduiUsageRecorder)
local recordV1ComponentUsage = require(SduiCoreSystem.Analytics.recordV1ComponentUsage)

local tbl1 = {}

return {
    getComponentType = function(arg1, arg2)
        if not arg1.__isClientBinding and arg2.templateRegistry:shouldResolveTemplate(arg1) then
            arg2.templateRegistry:resolveTemplateForConfig(arg1, arg2)
        end
        return arg1.componentType
    end,
    buildAnalyticsContext = function(arg1, arg2, tbl2)
        arg2 = arg2 or tbl1

        local var1 = arg1.analyticsData or tbl1
        local ancestorAnalyticsData = Cryo.Dictionary.join(arg2.ancestorAnalyticsData or tbl1, arg2.analyticsData or tbl1)

        local getCollectionData = arg2.getCollectionData

        if tbl2 then
            var1 = Cryo.Dictionary.join(var1, tbl2)
        end

        return {
            analyticsData = var1,
            ancestorAnalyticsData = ancestorAnalyticsData,
            getCollectionData = getCollectionData
        }
    end,
    tryCreateEagerProcessedComponentConfig = function(arg1, arg2, name: string, arg3, bool1: boolean?)
        local instrumentation = arg2.dependencies.instrumentation
        instrumentation:startTimerFlow("EagerProcess")

        if not arg1 then
            arg2.dependencies.logger.reportError(SduiErrorType.NilComponentConfig, { name = name }, arg2.appPage)
            instrumentation:stopTimerFlow("EagerProcess", arg2, true)
            return false, arg1
        end
        assert(arg1, "componentConfig must exist")

        if arg1.__processed then
            arg2.dependencies.logger.reportError(SduiErrorType.EagerReprocessing, {
                message = "Eagerly evaluating a component that has already been processed",
                componentType = arg1.componentType,
                name = name
            }, arg2.appPage)
            instrumentation:stopTimerFlow("EagerProcess", arg2, true)
            return true, arg1
        end

        local value = if bool1 then tutils.deepCopy(arg1) else arg1

        if arg2.templateRegistry:shouldResolveTemplate(value) then
            local props = value.props
            if props and props.itemTemplateKey then
                if props.items then
                    for _, item in props.items do
                        if item.templateKey == nil then
                            item.templateKey = props.itemTemplateKey
                        end
                    end
                elseif props.item and props.item.templateKey == nil then
                    props.item.templateKey = props.itemTemplateKey
                end
            end

            if not arg2.templateRegistry:resolveTemplateForConfig(value, arg2) then
                instrumentation:stopTimerFlow("EagerProcess", arg2, true)
                return false, arg1
            end
        end

        local componentType = value.componentType

        if arg2.componentDefinitions:getComponent(componentType) == nil then
            arg2.dependencies.logger.reportError(
                SduiErrorType.NoComponentRegistered,
                { componentType = componentType, name = name },
                arg2.appPage
            )
            instrumentation:stopTimerFlow("EagerProcess", arg2, true)
            return false, arg1
        end

        local var2, var3 = validateInterface(value, UiComponentInterface, false)
        if not var2 then
            arg2.dependencies.logger.reportError(SduiErrorType.InvalidComponentConfig, {
                message = `(Eager) Invalid config for component. err: {var3}`,
                componentType = componentType,
                name = name,
                value = value
            }, arg2.appPage)
            instrumentation:stopTimerFlow("EagerProcess", arg2, true)
            return false, arg1
        end

        if value.props then
            local var4, var5 = mapServerBindingProps(value.props, ServerBindingPropMap)
            if var4 then
                for value3, value2 in var4 do
                    value.props[value3] = value2
                end
            end
            if var5 then
                arg2.dependencies.logger.reportError(SduiErrorType.UnmappedServerBindingProp, {
                    componentType = componentType,
                    name = name,
                    message = `Unmapped PascalCase props detected: {table.concat(var5, ", ")}. These props will not reach the camelCase component.`
                }, arg2.appPage)
            end
        end

        if not value.__usageRecorded then
            recordV1ComponentUsage(arg2.appPage, value)
            value.__usageRecorded = true
            SduiUsageRecorder.scheduleFlush()
        end

        if value.props then
            parseProps(componentType, value.props, name, arg2, arg3, nil, SduiBuilderProcessingPhase.Eager)
        end

        if value.conditionalProps then
            for _, conditionalProp in value.conditionalProps do
                local var4, var5 = mapServerBindingProps(conditionalProp.propOverrides, ServerBindingPropMap)
                if var4 then
                    for value, value2 in var4 do
                        conditionalProp.propOverrides[value] = value2
                    end
                end
                if var5 then
                    arg2.dependencies.logger.reportError(SduiErrorType.UnmappedServerBindingProp, {
                        componentType = componentType,
                        name = name,
                        message = `Unmapped PascalCase conditional props detected: {table.concat(var5, ", ")}. These props will not reach the camelCase component.`
                    }, arg2.appPage)
                end
                parseProps(componentType, conditionalProp.propOverrides, name, arg2, arg3, nil, SduiBuilderProcessingPhase.Eager)
            end
        end

        local propInterface = arg2.componentDefinitions:getPropInterface(componentType)
        if propInterface then
            local var4, message = validateInterface(value.props, propInterface)
            if not var4 then
                arg2.dependencies.logger.reportError(
                    SduiErrorType.InvalidProps,
                    { componentType = componentType, name = name, message = message },
                    arg2.appPage
                )
                instrumentation:stopTimerFlow("EagerProcess", arg2, true)
                return false, arg1
            end
        end

        value.__processed = true

        instrumentation:stopTimerFlow("EagerProcess", arg2)
        return true, value
    end
}
