-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local Cryo = require(SduiCoreSystemParent.Cryo)
local React = require(SduiCoreSystemParent.React)

local SduiBuilder = require(SduiCoreSystem.SduiBuilder)
local SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local SduiConditionalPropWrapper = require(SduiCoreSystem.ConditionalProps.SduiConditionalPropWrapper)
local SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local SduiErrorType = SduiErrors.SduiErrorType
local SduiBuilderProcessingPhase = SduiBuilderTypes.SduiBuilderProcessingPhase
local compareSduiProps = require(SduiCoreSystem.compareSduiProps)
local compareSduiAnalyticsContext = require(SduiCoreSystem.compareSduiAnalyticsContext)

local SduiCompat = require(SduiCoreSystemParent.SduiCompat)
local mapServerBindingProps = SduiCompat.mapServerBindingProps
local ServerBindingPropMap = SduiCompat.ServerBindingPropMap
local parseProps = require(SduiCoreSystem.parseProps)
local validateInterface = require(SduiCoreSystem.validateInterface)
local UiComponentInterface = SduiConfigTypes.UiComponentInterface
local SduiUsageRecorder = require(SduiCoreSystem.Analytics.SduiUsageRecorder)
local recordV1ComponentUsage = require(SduiCoreSystem.Analytics.recordV1ComponentUsage)

local tbl1 = {}

local var1 = nil

local function SduiErrorComponent(_)
    return React.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.new(0, 100, 0, 100) })
end

local wrappedComponent = React.memo(function(arg1)
    local __processed = arg1.componentConfig.__processed
    local var2 = if __processed then SduiBuilderProcessingPhase.Render else SduiBuilderProcessingPhase.Lazy
    local componentConfig = arg1.componentConfig
    local sduiContext = arg1.sduiContext
    local debugName = arg1.debugName
    local parentAnalyticsContext = arg1.parentAnalyticsContext
    local localAnalyticsData = arg1.localAnalyticsData
    local extraLocalProps = arg1.extraLocalProps
    local conditionalProps = arg1.conditionalProps

    local instrumentation = sduiContext.dependencies.instrumentation
    instrumentation:startTimerFlow("BuildPropsAndChildren")

    local var3 = React.useRef(nil)
    if var3.current == nil then
        var3.current = SduiBuilder.buildAnalyticsContext(componentConfig, parentAnalyticsContext, localAnalyticsData)
    else
        local current = SduiBuilder.buildAnalyticsContext(componentConfig, parentAnalyticsContext, localAnalyticsData)
        if not compareSduiAnalyticsContext(var3.current, current) then
            var3.current = current
        end
    end
    local current = var3.current

    local componentType = SduiBuilder.getComponentType(componentConfig, sduiContext)
    if componentType == nil then
        sduiContext.dependencies.logger.reportError(SduiErrorType.NilComponentType, {
            message = `Unable to resolve componentType for component with template {componentConfig and componentConfig.templateKey or nil}`,
            name = debugName
        }, sduiContext.appPage)
        instrumentation:stopTimerFlow("BuildPropsAndChildren", sduiContext, true)
        return React.createElement(SduiErrorComponent)
    end

    local component = sduiContext.componentDefinitions:getComponent(componentType)
    if component == nil then
        sduiContext.dependencies.logger.reportError(
            SduiErrorType.NoComponentRegistered,
            { componentType = componentType, name = debugName },
            sduiContext.appPage
        )
        instrumentation:stopTimerFlow("BuildPropsAndChildren", sduiContext, true)
        return React.createElement(SduiErrorComponent)
    end

    instrumentation:startTimerFlow("ParseProps")
    local var4 = Cryo.Dictionary.join(componentConfig.props or tbl1, conditionalProps or tbl1)
    if not __processed then
        local var5, var6 = mapServerBindingProps(var4, ServerBindingPropMap)
        if var5 then
            for value, value2 in var5 do
                var4[value] = value2
            end
        end
        if var6 then
            sduiContext.dependencies.logger.reportError(SduiErrorType.UnmappedServerBindingProp, {
                componentType = componentType,
                name = debugName,
                message = `Unmapped PascalCase props detected: {table.concat(var6, ", ")}. These props will not reach the camelCase component.`
            }, sduiContext.appPage)
        end
    end
    parseProps(componentType, var4, debugName, sduiContext, current, nil, var2)
    if extraLocalProps then
        var4 = Cryo.Dictionary.join(var4, extraLocalProps)
    end

    var4.componentConfig = componentConfig
    var4.sduiContext = sduiContext
    var4.debugName = debugName
    var4.analyticsContext = current

    if not __processed then
        local propInterface = sduiContext.componentDefinitions:getPropInterface(componentType)
        if propInterface then
            local var5, message = validateInterface(var4, propInterface)
            if not var5 then
                instrumentation:stopTimerFlow("ParseProps", sduiContext, true)
                sduiContext.dependencies.logger.reportError(
                    SduiErrorType.InvalidProps,
                    { componentType = componentType, name = debugName, message = message },
                    sduiContext.appPage
                )
                return React.createElement(SduiErrorComponent)
            end
        end
    end

    instrumentation:stopTimerFlow("ParseProps", sduiContext)

    local var5 = componentConfig.children and {} or nil
    if componentConfig.children then
        assert(var5, "reactChildren must exist")
        for k, child in componentConfig.children do
            local str1 = `{child.componentType}_{k}`

            var5[str1] = React.createElement(var1, {
                componentConfig = child,
                sduiContext = sduiContext,
                parentAnalyticsContext = current,
                extraLocalProps = { index = k, layoutOrder = k },
                debugName = str1
            })
        end
    end

    instrumentation:stopTimerFlow("BuildPropsAndChildren", sduiContext)
    return React.createElement(component, var4, var5)
end, compareSduiProps)

var1 = function(arg1)
    if not arg1.componentConfig then
        arg1.sduiContext.dependencies.logger.reportError(
            SduiErrorType.NilComponentConfig,
            {
                name = arg1.debugName
            },
            arg1.sduiContext.appPage
        )
        return React.createElement(SduiErrorComponent)
    end

    if not arg1.componentConfig.__processed then
        if arg1.sduiContext.templateRegistry:shouldResolveTemplate(arg1.componentConfig) then
            arg1.sduiContext.templateRegistry:resolveTemplateForConfig(arg1.componentConfig, arg1.sduiContext)
        end

        local var3, var4 = validateInterface(arg1.componentConfig, UiComponentInterface, false)
        if not var3 then
            arg1.sduiContext.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.InvalidComponentConfig,
                {
                    message = `Invalid config for component. err: {var4}`,
                    componentType = arg1.componentConfig.componentType,
                    name = arg1.debugName
                },
                arg1.sduiContext.appPage
            )
        end
    end

    if not arg1.componentConfig.__usageRecorded then
        recordV1ComponentUsage(arg1.sduiContext.appPage, arg1.componentConfig)
        arg1.componentConfig.__usageRecorded = true
        SduiUsageRecorder.scheduleFlush()
    end

    if not arg1.componentConfig.conditionalProps then
        return React.createElement(wrappedComponent, arg1)
    end

    return React.createElement(SduiConditionalPropWrapper, {
        wrappedComponent = wrappedComponent,
        sduiContext = arg1.sduiContext,
        parentAnalyticsContext = arg1.parentAnalyticsContext,
        extraLocalProps = arg1.extraLocalProps,
        componentConfig = arg1.componentConfig,
        debugName = arg1.debugName,
        localAnalyticsData = arg1.localAnalyticsData
    })
end

return React.memo(var1, compareSduiProps)
