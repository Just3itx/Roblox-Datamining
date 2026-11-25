-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiResponseType = require(script.SduiIntegrationTypes).SduiResponseType
local SduiRequestConcurrencyPolicy = require(script.SduiIntegrationTypes).SduiRequestConcurrencyPolicy
local SduiLoadTimer = require(script.SduiLoadTimer)
local SduiSurfaceLoadTimeTracker = require(script.SduiSurfaceLoadTimeTracker)
local _SduiIntegrationTypes = require(script.SduiIntegrationTypes)
local scriptParent = script.Parent
local _SduiCoreSystem = require(scriptParent.SduiCoreSystem)

local FFlagHomePageRefetchOnDataHydrationAccountReset = require(scriptParent.SharedFlags).FFlagHomePageRefetchOnDataHydrationAccountReset
local FFlagSduiApiStoreUpdateInputData = require(scriptParent.SharedFlags).FFlagSduiApiStoreUpdateInputData

local module = {
    ["jest.config"] = script["jest.config"],
    ["jest.mockDataModel.config"] = script["jest.mockDataModel.config"],
    SduiFocusTags = require(script.FocusNavigation.SduiFocusTags),
    OnNavigateBackWrapper = require(script.FocusNavigation.NavigateBackBindings).OnNavigateBackWrapper,
    useOnNavigateBack = function(func1: (...any) -> (...any), arg1)
        return require(script.FocusNavigation.NavigateBackBindings).useOnNavigateBack(func1, arg1)
    end,
    useInitialFocusOnTag = function(str1: string, tbl1)
        require(script.FocusNavigation.useInitialFocusOnTag)(str1, tbl1)
    end,
    useSelectionOrderTracking = function(tbl1)
        require(script.FocusNavigation.useSelectionOrderTracking)(tbl1)
    end,
    usePageButtonBindings = function(tbl1, arg1, arg2)
        return require(script.FocusNavigation.usePageButtonBindings)(tbl1, arg1, arg2)
    end,
    useBackButtonBinding = function(func1: (...any) -> (...any))
        return require(script.FocusNavigation.useBackButtonBinding)(func1)
    end,
    createSduiFocusActivationStore = function()
        return require(script.FocusNavigation.createSduiFocusActivationStore)()
    end,
    getSduiFocusActivationStore = function()
        return require(script.FocusNavigation.getSduiFocusActivationStore)()
    end,
    useSduiFocusActivation = function(str1: string?, func1: ((...any) -> (...any))?)
        require(script.FocusNavigation.useSduiFocusActivation)(str1, func1)
    end,
    createSduiApiStore = require(script.createSduiApiStore),
    getSduiApiStore = require(script.getSduiApiStore),
    SduiInputDataUpdates = if FFlagSduiApiStoreUpdateInputData then require(script.SduiInputDataUpdates) else nil,
    useDataHydrationAccountGeneration = if FFlagHomePageRefetchOnDataHydrationAccountReset then require(script.hooks.useDataHydrationAccountGeneration) else nil
}

function module.fetchSduiTemplates(tbl1, bool1: boolean?)
    return require(script.fetchSduiTemplates)(tbl1, bool1)
end

function module.createTemplateApiRequestConfig(tbl1)
    return require(script.createTemplateApiRequestConfig)(tbl1)
end
module.handleSduiApiResponse = require(script.handleSduiApiResponse)
function module.prewarmAppTemplatesOnLaunch()
    return require(script.prewarmAppTemplatesOnLaunch)()
end
module.SduiLoadTimer = SduiLoadTimer
module.SduiSurfaceLoadTimeTracker = SduiSurfaceLoadTimeTracker
module.SduiPageEntryPoint = require(script.SduiPageEntryPoint)
module.SduiPageWrapperEntryPoint = require(script.SduiPageWrapperEntryPoint)
module.SduiPageNavigationHeader = require(script.SduiPageNavigationHeader)
module.useScrollAwayHeaderPosition = require(script.useScrollAwayHeaderPosition)
module.SduiFeatureEntryPoint = require(script.SduiFeatureEntryPoint)
module.getSduiTemplateStore = require(script.getSduiTemplateStore)
module.getSduiPageEntrySnackbarStore = require(script.getSduiPageEntrySnackbarStore)
module.usePageEntrySnackbar = require(script.usePageEntrySnackbar)
module.useComponentConfig = require(script.hooks.useComponentConfig)
module.usePreferredTextSizeLineBudget = require(script.hooks.usePreferredTextSizeLineBudget)
module.usePublishContainerWidth = require(script.hooks.usePublishContainerWidth)
module.useEntrySurfacing = require(script.hooks.useEntrySurfacing)
module.useInputData = require(script.hooks.useInputData)
module.useSduiPageScopeField = require(script.hooks.useSduiPageScopeField)
module.useUiStatus = require(script.hooks.useUiStatus)
module.UiStatus = require(script.SduiIntegrationTypes).UiStatus
module.SduiProtobufResponseHelpers = require(script.SduiProtobufResponseHelpers)
module.SduiPageAnalytics = require(script.SduiPageAnalytics)
module.SduiRequestConcurrencyPolicy = SduiRequestConcurrencyPolicy
module.SduiResponseType = SduiResponseType
module.SduiApiStorePostConfigContentType = require(script.SduiApiStorePostConfig).SduiApiStorePostConfigContentType
module.SduiOverlayEntryPoint = require(script.SduiOverlayEntryPoint)
module.getSduiClientPageScope = require(scriptParent.SduiCoreSystem).getSduiClientPageScope
module.usePageScopeRef = require(scriptParent.SduiCoreSystem).usePageScopeRef
module.SduiCapabilities = require(scriptParent.SduiCoreSystem).SduiCapabilities
module.getSduiDataBinder = require(scriptParent.SduiCoreSystem).getSduiDataBinder
module.streamingFeedMergeStrategy = require(script.streamingFeedMergeStrategy)
module.buildSduiCollectionInfo = require(script.buildSduiCollectionInfo)
module.getPreferredTextSizeLineBudget = require(script.getPreferredTextSizeLineBudget)
return module
