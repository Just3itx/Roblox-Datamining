-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local React = require(SduiCoreSystemParent.React)
local Signals = require(SduiCoreSystemParent.Signals)
local SignalsReact = require(SduiCoreSystemParent.SignalsReact)
local tutils = require(SduiCoreSystemParent.tutils)

local compareSduiProps = require(SduiCoreSystem.compareSduiProps)
local SduiErrorType = require(SduiCoreSystem.SduiErrors).SduiErrorType
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local getSduiComponentRegistry = require(SduiCoreSystem.getSduiComponentRegistry)
local validateInterface = require(SduiCoreSystem.validateInterface)
local createSduiErrorLogger = require(SduiCoreSystem.createSduiErrorLogger)

local function SduiErrorComponent(_)
    return React.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.new(0, 100, 0, 100) })
end

local tbl1 = {}

local function useComponentSduiContext(arg1)
    local sduiContext = arg1.sduiContext
    local errorContext = arg1.componentConfig.errorContext
    return React.useMemo(function()
        local var1 = table.clone(sduiContext)
        var1.dependencies = table.clone(sduiContext.dependencies)
        var1.dependencies.logger = createSduiErrorLogger(sduiContext.dependencies.logger, errorContext or tbl1)
        return var1
    end, { sduiContext, errorContext })
end

local function buildWrappedComponent(func1: (...any) -> (...any), arg1, sduiContext, tbl2)
    local componentType = arg1.componentConfig.componentType

    if arg1.localAnalyticsData then
        arg1.componentConfig.analyticsContext.setLocalAnalyticsData(arg1.localAnalyticsData)
    end

    local var1 = not arg1.componentConfig.props and {} or table.clone(arg1.componentConfig.props)
    local var2 = if arg1.componentConfig.nestedComponentConfigListPropSignalNames then arg1.componentConfig.nestedComponentConfigListPropSignalNames else tbl1

    if tbl2 then
        for value, value2 in tbl2 do
            if not (value2.isNestedComponentConfig or var2[value]) then
                var1[value] = value2.data
            end
        end
    end

    if arg1.extraLocalProps then
        for k, extraLocalProp in arg1.extraLocalProps do
            var1[k] = extraLocalProp
        end
    end
    var1.componentConfig = arg1.componentConfig
    var1.sduiContext = sduiContext
    var1.debugName = arg1.debugName
    var1.analyticsContext = arg1.componentConfig.analyticsContext

    local var3 = nil
    if tbl2 then
        for value, value2 in tbl2 do
            if not value2.isNestedComponentConfig then
                continue
            end

            if var3 == nil then
                var3 = not arg1.componentConfig.nestedComponentConfigs and {} or table.clone(arg1.componentConfig.nestedComponentConfigs)
            end

            var3[value] = value2.data
        end
    end

    local var4 = var3 or arg1.componentConfig.nestedComponentConfigs

    if var4 then
        for value, componentConfig in var4 do
            local var5 = func1(componentConfig)
            local createElement = React.createElement
            local tbl3 = {
                sduiContext = sduiContext,
                componentConfig = componentConfig,
                debugName = `{arg1.debugName}.{value}`
            }
            var1[value] = createElement(var5, tbl3)
        end
    end

    if tbl2 and next(var2) then
        for value in var2 do
            local var5 = tbl2[value]
            if not var5 then
                continue
            end

            local data = var5.data
            if not data then
                continue
            end

            local tbl3 = ({})
            for layoutOrder, componentConfig in data do
                local var6 = func1(componentConfig)

                local str1 = `{value}_{layoutOrder}_{componentConfig.componentType}`
                tbl3[str1] = React.createElement(var6, {
                    sduiContext = sduiContext,
                    componentConfig = componentConfig,
                    extraLocalProps = { layoutOrder = layoutOrder },
                    debugName = `{arg1.debugName}.{value}[{layoutOrder}]`
                })
            end
            var1[value] = tbl3
        end
    end

    local var5 = getSduiComponentRegistry().getComponentDefinition(componentType)
    local component = if var5 then var5.component or nil else nil

    if component == nil then
        sduiContext.dependencies.logger.reportError(
            SduiErrorType.NoComponentRegistered,
            {
                componentType = componentType,
                name = arg1.debugName
            },
            sduiContext.appPage
        )
        return React.createElement(SduiErrorComponent)
    end

    local propInterface = var5 and var5.propInterface
    if propInterface and not validateInterface(var1, propInterface) then
        return nil
    end

    return React.createElement(component, var1)
end

local function createSduiClientBindingWrappers(func1: (...any) -> (...any))
    return {
        SduiClientBindingThinWrapper = React.memo(function(arg1)
            local sduiContext = arg1.sduiContext
            if FFlagSduiErrorPaths then
                sduiContext = useComponentSduiContext(arg1)
            end
            return buildWrappedComponent(func1, arg1, sduiContext)
        end, compareSduiProps),
        SduiDataBindingWrapper = React.memo(function(arg1)
            local sduiContext = arg1.sduiContext
            if FFlagSduiErrorPaths then
                sduiContext = useComponentSduiContext(arg1)
            end
            local propSignals = arg1.componentConfig.propSignals
            local isComponentFilteredSignal = arg1.componentConfig.isComponentFilteredSignal
            local extraLocalPropSignals = arg1.extraLocalPropSignals

            local var1 = React.useMemo(function()
                assert(
                    propSignals or isComponentFilteredSignal or extraLocalPropSignals,
                    "propSignals, isComponentFilteredSignal, or extraLocalPropSignals must exist"
                )

                return Signals.createComputed(function(arg2)
                    local result = ({})
                    if propSignals then
                        for k, propSignal in propSignals do
                            result[k] = propSignal(arg2)
                        end
                    end

                    if extraLocalPropSignals then
                        for k, extraLocalPropSignal in extraLocalPropSignals do
                            local tbl2 = {
                                data = extraLocalPropSignal(arg2)
                            }
                            result[k] = tbl2
                        end
                    end
                    if isComponentFilteredSignal and isComponentFilteredSignal(arg2).data == true then
                        result.__isComponentFiltered = true
                    end
                    return result
                end, tutils.shallowEqual)
            end, {
                propSignals,
                isComponentFilteredSignal,
                extraLocalPropSignals,
                arg1.componentConfig.componentType
            })

            local var2 = SignalsReact.useSignalState(var1)

            if var2.__isComponentFiltered == true then
                return nil
            end
            return buildWrappedComponent(func1, arg1, sduiContext, var2)
        end, compareSduiProps)
    }
end

return createSduiClientBindingWrappers
