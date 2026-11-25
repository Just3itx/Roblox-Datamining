-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local React = require(SduiSharedUtilitiesParent.React)
local _Foundation = require(SduiSharedUtilitiesParent.Foundation)
local getSduiComponentWrapper = require(SduiSharedUtilitiesParent.SduiCoreSystem).getSduiComponentWrapper

local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local useCreateClientBindingSduiContext = require(SduiSharedUtilities.useCreateClientBindingSduiContext)
local useComponentConfig = require(SduiSharedUtilities.hooks.useComponentConfig)
local useComponentLifecycleTiming = require(SduiSharedUtilities.hooks.useComponentLifecycleTiming)
local useDataUpdatedTimestamp = require(SduiSharedUtilities.hooks.useDataUpdatedTimestamp)
local useLocalAnalyticsData = require(SduiSharedUtilities.hooks.useLocalAnalyticsData)
local useUiStatus = require(SduiSharedUtilities.hooks.useUiStatus)
local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)
local useStatefulRef = require(SduiSharedUtilities.hooks.useStatefulRef)
local SduiFeatureEntryPointUi = require(SduiSharedUtilities.ui.SduiFeatureEntryPointUi)

local FFlagSduiFeatureEntryPointTakesAbsoluteSizeHandler = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiFeatureEntryPointTakesAbsoluteSizeHandler

return React.memo(React.forwardRef(function(tbl1, arg1) -- name: SduiFeatureEntryPoint
    local configKey = tbl1.configKey
    local appPage = tbl1.appPage
    local shouldDisplayLoading = tbl1.shouldDisplayLoading == nil or tbl1.shouldDisplayLoading
    local shouldDisplayError = tbl1.shouldDisplayError == nil or tbl1.shouldDisplayError

    local componentConfig = useComponentConfig(configKey, tbl1.identifier)

    useComponentLifecycleTiming(tbl1.loadTimer, typeof(componentConfig) == "table")

    local var4 = useDataUpdatedTimestamp(configKey, tbl1.identifier)

    local uiStatus = useUiStatus(configKey)

    local var6, ref = useStatefulRef(arg1)

    local sduiContext = useCreateClientBindingSduiContext(
        appPage,
        var6,
        nil,
        var4,
        configKey,
        tbl1.appCompositionEnabledOverride,
        tbl1.routeName
    )

    local localAnalyticsData = useLocalAnalyticsData(configKey, appPage, tbl1.additionalAnalyticsData)

    return React.createElement(SduiFeatureEntryPointUi, {
        onRetry = tbl1.onRetry,
        contentSlot = if componentConfig then React.createElement(getSduiComponentWrapper(componentConfig), {
            debugName = `SduiFeatureEntryPoint-{configKey}`,
            componentConfig = componentConfig,
            sduiContext = sduiContext,
            localAnalyticsData = localAnalyticsData,
            extraLocalProps = tbl1.extraLocalProps
        }) else nil,
        uiStatus = uiStatus,
        errorSlot = tbl1.errorSlot,
        loadingSlot = tbl1.loadingSlot,
        shouldDisplayLoading = shouldDisplayLoading,
        shouldDisplayError = shouldDisplayError,
        onAbsoluteSizeChange = if FFlagSduiFeatureEntryPointTakesAbsoluteSizeHandler then tbl1.onAbsoluteSizeChange else nil,
        Size = if tbl1.Size then tbl1.Size else UDim2.new(1, 0, 0, 0),
        AutomaticSize = if tbl1.AutomaticSize then tbl1.AutomaticSize else Enum.AutomaticSize.Y,
        Position = tbl1.Position,
        LayoutOrder = tbl1.LayoutOrder,
        ref = ref
    })
end))
