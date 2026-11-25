-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local Cryo = require(SduiCoreSystemParent.Cryo)
local React = require(SduiCoreSystemParent.React)

local SduiBuilder = require(SduiCoreSystem.SduiBuilder)
local SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiErrorType = require(SduiCoreSystem.SduiErrors).SduiErrorType
local SduiBuilderProcessingPhase = SduiBuilderTypes.SduiBuilderProcessingPhase
local compareSduiProps = require(SduiCoreSystem.compareSduiProps)
local compareSduiAnalyticsContext = require(SduiCoreSystem.compareSduiAnalyticsContext)

local parseProps = require(SduiCoreSystem.parseProps)

local function SduiErrorComponent(_)
    return React.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.new(0, 100, 0, 100) })
end

local tbl1 = {}

return React.memo(function(arg1) -- name: SduiFastPathComponent
    local componentConfig = arg1.componentConfig
    local componentType = componentConfig.componentType
    local sduiContext = arg1.sduiContext
    local debugName = arg1.debugName
    local parentAnalyticsContext = arg1.parentAnalyticsContext
    local localAnalyticsData = arg1.localAnalyticsData
    local extraLocalProps = arg1.extraLocalProps

    local var1 = React.useRef(nil)
    if var1.current == nil then
        var1.current = SduiBuilder.buildAnalyticsContext(componentConfig, parentAnalyticsContext, localAnalyticsData)
    else
        local current = SduiBuilder.buildAnalyticsContext(componentConfig, parentAnalyticsContext, localAnalyticsData)
        if not compareSduiAnalyticsContext(var1.current, current) then
            var1.current = current
        end
    end
    local current = var1.current

    local var2 = table.clone(componentConfig.props or tbl1)
    parseProps(componentType, var2, debugName, sduiContext, current, nil, SduiBuilderProcessingPhase.Render)

    if extraLocalProps then
        var2 = Cryo.Dictionary.join(var2, extraLocalProps)
    end

    var2.componentConfig = componentConfig
    var2.sduiContext = sduiContext
    var2.debugName = debugName
    var2.analyticsContext = current

    local component = sduiContext.componentDefinitions:getComponent(componentType)
    if component ~= nil then
        return React.createElement(component, var2)
    end

    sduiContext.dependencies.logger.reportError(
        SduiErrorType.NoComponentRegistered,
        { componentType = componentType, name = debugName },
        sduiContext.appPage
    )
    return React.createElement(SduiErrorComponent)
end, compareSduiProps)
