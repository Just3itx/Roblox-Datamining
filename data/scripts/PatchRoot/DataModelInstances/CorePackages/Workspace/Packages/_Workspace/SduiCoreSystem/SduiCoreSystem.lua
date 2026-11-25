-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiActionType = require(script.SduiActionType)
local SduiImpressionEventType = require(script.SduiImpressionEventType)
local SduiBuilderTypes = require(script.SduiBuilderTypes)
local SduiComponentType = require(script.SduiComponentType)
local SduiConfigTypes = require(script.SduiConfigTypes)
local SduiContentTypes = require(script.SduiContentTypes)
local _SduiDataStoreTypes = require(script.SduiDataStoreTypes)
local _SduiFocusNavigationTypes = require(script.SduiFocusNavigationTypes)
local _SduiPoolStoreTypes = require(script.ClientBinding.SduiPoolStoreTypes)
local SduiErrors = require(script.SduiErrors)

return {
    ["jest.config"] = script["jest.config"],
    executeAction = require(script.executeAction),
    createSduiErrorLogger = require(script.createSduiErrorLogger),
    addSduiErrorContextFields = require(script.addSduiErrorContextFields),
    findAnalyticsField = require(script.findAnalyticsField),
    findAnalyticsFieldInAncestors = require(script.findAnalyticsFieldInAncestors),
    getActionTelemetryFieldValue = require(script.getActionTelemetryFieldValue),
    getSduiComponentWrapper = require(script.getSduiComponentWrapper),
    reportUnifiedLoggingAction = require(script.Analytics.reportUnifiedLoggingAction),
    reportUnifiedLoggingImpressions = require(script.Analytics.reportUnifiedLoggingImpressions),
    parseProps = require(script.parseProps),
    SduiActionParams = require(script.SduiActionParams),
    SduiActionType = SduiActionType,
    SduiImpressionEventType = SduiImpressionEventType,
    SduiBuilder = require(script.SduiBuilder),
    SduiBuilderTypes = SduiBuilderTypes,
    SduiCollectionAnalyticsBuilder = require(script.Analytics.SduiCollectionAnalyticsBuilder),
    SduiComponent = require(script.SduiComponent),
    SduiComponentType = SduiComponentType,
    SduiConfigTypes = SduiConfigTypes,
    SduiContentTypes = SduiContentTypes,
    SduiErrors = SduiErrors,
    SduiInstrumentation = require(script.SduiInstrumentation),
    SduiLogger = require(script.SduiLogger),
    SduiMockUtils = require(script.ClientBinding.SduiMockUtils),
    SduiParseHelpers = require(script.SduiParseHelpers),
    SduiPoolStore = require(script.ClientBinding.SduiPoolStore),
    SduiParsers = require(script.SduiParsers),
    SduiResponsiveHelpers = require(script.SduiResponsiveHelpers),
    SduiTemplateRegistry = require(script.SduiTemplateRegistry),
    SduiUsageRecorder = require(script.Analytics.SduiUsageRecorder),
    recordTemplateUsage = require(script.Analytics.recordTemplateUsage),
    recordV1ComponentUsage = require(script.Analytics.recordV1ComponentUsage),
    recordV1RegisteredTemplates = require(script.Analytics.recordV1RegisteredTemplates),
    useUidRefString = require(script.useUidRefString),
    validateInterface = require(script.validateInterface),
    validateSduiComponentConfig = require(script.validateSduiComponentConfig),
    getSduiClientBindingBuilder = function()
        return require(script.ClientBinding.SduiClientBindingBuilder)
    end,
    getSduiDataBinder = function()
        return require(script.ClientBinding.SduiDataBinder)
    end,
    getProtoVariableMapper = function()
        return require(script.ClientBinding.ProtoVariableMapper)
    end,
    getDefaultHydrationIdPaths = function()
        return require(script.ClientBinding.defaultHydrationIdPaths)
    end,
    createBuilderConfig = function(arg1)
        return require(script.ClientBinding.createBuilderConfig)(arg1)
    end,
    getSduiActionHandlerRegistry = function()
        return require(script.getSduiActionHandlerRegistry)()
    end,
    getSduiImpressionHandlerRegistry = function()
        return require(script.getSduiImpressionHandlerRegistry)()
    end,
    getSduiTelemetryHandlerNameRegistry = function()
        return require(script.getSduiTelemetryHandlerNameRegistry)()
    end,
    getSduiServiceDependenciesStore = function()
        return require(script.ClientBinding.getSduiServiceDependenciesStore)()
    end,
    getOneByTwoTileFlowIdsFromPools = function(arg1)
        return require(script.ClientBinding.PropBuilder.SduiPoolEntryHelpers).getOneByTwoTileFlowIdsFromPools(arg1)
    end,
    getSduiTokensStore = function()
        return require(script.ClientBinding.getSduiTokensStore)()
    end,
    getSduiPolicyStore = function()
        return require(script.ClientBinding.getSduiPolicyStore)()
    end,
    getSduiComponentRegistry = require(script.getSduiComponentRegistry),
    getSduiClientPageScope = require(script.ClientBinding.getSduiClientPageScope),
    usePageScopeRef = require(script.ClientBinding.usePageScopeRef),
    SduiCapabilities = require(script.ClientBinding.SduiCapabilities)
}
