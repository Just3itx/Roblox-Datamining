-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local React = require(SduiSharedUtilitiesParent.React)
local ReactRoblox = require(SduiSharedUtilitiesParent.ReactRoblox)
local Foundation = require(SduiSharedUtilitiesParent.Foundation)
local Loading = Foundation.Loading
local Snackbar = Foundation.Snackbar
local useTokens = Foundation.Hooks.useTokens
local ReactFocusNavigation = require(SduiSharedUtilitiesParent.ReactFocusNavigation)
local useDispatch = require(SduiSharedUtilitiesParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigateBack = require(SduiSharedUtilitiesParent.NavigationRodux).Thunks.NavigateBack
local VisibilityControl = require(SduiSharedUtilitiesParent.AppNavBar).VisibilityControl
local FFlagSignalsNavP3Dispatch = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SduiSharedUtilitiesParent.RobloxAppNavigation).NavigationCommands else nil
local useCloseWithBackButton = require(SduiSharedUtilitiesParent.AppBlox).useCloseWithBackButton
local getSduiComponentWrapper = require(SduiSharedUtilitiesParent.SduiCoreSystem).getSduiComponentWrapper
local Page = require(SduiSharedUtilitiesParent.AppPageShell).Page
local Signal = require(SduiSharedUtilitiesParent.AppCommonLib).Signal

local useCreateClientBindingSduiContext = require(SduiSharedUtilities.useCreateClientBindingSduiContext)
local UiStatus = require(SduiSharedUtilities.SduiIntegrationTypes).UiStatus
local SduiPageErrorState = require(SduiSharedUtilities.SduiPageErrorState)
local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local useLocalAnalyticsData = require(SduiSharedUtilities.hooks.useLocalAnalyticsData)
local useStatefulRef = require(SduiSharedUtilities.hooks.useStatefulRef)
local useComponentConfig = require(SduiSharedUtilities.hooks.useComponentConfig)
local useUiStatus = require(SduiSharedUtilities.hooks.useUiStatus)
local useDataUpdatedTimestamp = require(SduiSharedUtilities.hooks.useDataUpdatedTimestamp)
local useSduiPageContent = require(SduiSharedUtilities.hooks.useSduiPageContent)
local usePageEntrySnackbar = require(SduiSharedUtilities.usePageEntrySnackbar)

local FFlagAppPageShellScrollToTopFocus = require(SduiSharedUtilitiesParent.SharedFlags).FFlagAppPageShellScrollToTopFocus
local FFlagAppPageShellScrollTelemetry = require(SduiSharedUtilitiesParent.SharedFlags).FFlagAppPageShellScrollTelemetry
local FFlagAppThemeHalloween2026HomeBackground = require(SduiSharedUtilitiesParent.SharedFlags).FFlagAppThemeHalloween2026HomeBackground

return React.memo(React.forwardRef(function(tbl1, arg1) -- name: SduiPageWrapperEntryPoint
    local appPage = tbl1.appPage
    local configKey = tbl1.configKey or appPage
    local debugName = `SduiPageWrapperEntryPoint-{configKey}`
    local var2 = useTokens()
    local var3 = useDispatch()

    local componentConfig = useComponentConfig(configKey, tbl1.stickyIdentifier)

    local var5 = useUiStatus(configKey)
    local bool1 = var5 == UiStatus.Loading
    local bool2 = var5 == UiStatus.Error

    local localAnalyticsData = useLocalAnalyticsData(configKey, appPage, tbl1.additionalAnalyticsData)
    local refreshSignal = React.useMemo(function()
        return Signal.new()
    end, {})
    local refresh = tbl1.refresh
    local var8 = React.useCallback(function()
        refreshSignal:fire()
        if refresh then
            return refresh()
        end
        return nil
    end, { refreshSignal, refresh })

    local _, var9 = useStatefulRef(arg1)

    local var10 = React.useCallback(function()
        if tbl1.onCloseActivated then
            tbl1.onCloseActivated()
        elseif FFlagSignalsNavP3Dispatch then
            NavigationCommands.back()
        else
            var3(NavigateBack())
        end
    end, { var3, tbl1.onCloseActivated })

    local _, var11 = ReactFocusNavigation.useMostRecentOrDefaultFocusBehavior(var9)
    local var12 = useCloseWithBackButton

    if FFlagAppPageShellScrollToTopFocus and tbl1.handleBackButton == false then
        var10 = nil
    end

    local ref = var12(var11, var10)

    local var14 = usePageEntrySnackbar(configKey)

    local var15, var1 = React.useState(nil)
    local var17 = useDataUpdatedTimestamp(configKey, tbl1.contentIdentifier)
    local sduiContext = useCreateClientBindingSduiContext(
        appPage,
        var15,
        nil,
        var17,
        configKey,
        nil,
        tbl1.routeName,
        tbl1.scrollAway,
        tbl1.videoPlaybackContext
    )

    local contentConfig = useSduiPageContent({
        configKey = configKey,
        contentIdentifier = tbl1.contentIdentifier,
        contentMode = tbl1.contentMode,
        sduiContext = sduiContext,
        localAnalyticsData = localAnalyticsData,
        debugName = debugName,
        pageTimer = tbl1.pageTimer,
        refreshSignal = refreshSignal,
        defaultFocusRef = if FFlagAppPageShellScrollToTopFocus then tbl1.defaultFocusRef else nil
    })

    local localStickyHeaderSlot = tbl1.localStickyHeaderSlot
    local stickyHeaderSlot = React.useMemo(function()
        local element

        if tbl1.stickyIdentifier == nil or componentConfig == nil then
            element = nil
        else
            local sduiComponentWrapper = getSduiComponentWrapper(componentConfig)
            element = React.createElement(sduiComponentWrapper, {
                debugName = `{debugName}-sticky`,
                componentConfig = componentConfig,
                sduiContext = sduiContext,
                localAnalyticsData = localAnalyticsData
            })
        end

        if localStickyHeaderSlot == nil and element == nil then
            return nil
        end

        local result = {}
        if localStickyHeaderSlot ~= nil then
            for _, value in localStickyHeaderSlot do
                table.insert(result, value)
            end
        end
        if element ~= nil then
            table.insert(result, element)
        end
        return result
    end, {
        tbl1.stickyIdentifier,
        componentConfig,
        sduiContext,
        localAnalyticsData,
        debugName,
        localStickyHeaderSlot
    })

    local var21 = nil
    if bool1 then
        var21 = tbl1.loadingSlot
            or React.createElement(
                Foundation.View,
                { tag = "size-full", ZIndex = 2 },
                React.createElement(Loading, { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5) })
            )
    elseif bool2 then
        var21 = tbl1.errorSlot or React.createElement(SduiPageErrorState, { refresh = tbl1.refresh })
    end

    local bool3 = not (stickyHeaderSlot == nil) and next(stickyHeaderSlot) ~= nil
    local feedTopMargin = tbl1.feedTopMargin
    local stickyTopPadding = if bool3 then tbl1.stickyTopPadding or feedTopMargin else nil

    if bool3 then
        feedTopMargin = tbl1.stickyBottomPadding
    end
    local scrollAway = tbl1.scrollAway
    local pageTopPadding = tbl1.pageTopPadding
    local chrome = React.useMemo(function(): {height: any, liveHeightBinding: number, scrollAwayHeight: number}?
        local height = pageTopPadding or 0
        if height <= 0 then
            return nil
        end

        local headerHeightBinding = if scrollAway then scrollAway.headerHeightBinding else nil

        if headerHeightBinding == nil and scrollAway and scrollAway.scrollAwayHeight then
            local scrollAwayHeight = scrollAway.scrollAwayHeight
            headerHeightBinding = VisibilityControl.getHeaderBinding():map(function(num1: number)
                return num1 * scrollAwayHeight
            end)
        end
        return {
            height = height,
            scrollAwayHeight = if scrollAway then scrollAway.scrollAwayHeight else nil,
            liveHeightBinding = headerHeightBinding
        }
    end, { pageTopPadding, scrollAway })

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ref = var1
    }
    local tbl3 = {
        UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
        Content = 0,
        StateOverlay = 0
    }
    local createElement2 = React.createElement
    local var24 = Page
    local tbl4 = {
        contentConfig = contentConfig,
        stickyHeaderSlot = stickyHeaderSlot,
        composition = tbl1.composition,
        chrome = chrome,
        stickyBackgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.stickyBackgroundStyle or tbl1.backgroundStyle else tbl1.backgroundStyle,
        onScrollToEnd = tbl1.onScrollToEnd,
        onScrollToEndThreshold = tbl1.onScrollToEndThreshold,
        onRefresh = 0,
        appEventName = 0,
        contentTopPadding = 0,
        stickyTopPadding = 0,
        scrollPerformanceIntervalName = 0
    }

    if not refresh then
        var8 = nil
    end

    tbl4.onRefresh = var8
    tbl4.appEventName = appPage
    tbl4.contentTopPadding = feedTopMargin
    tbl4.stickyTopPadding = stickyTopPadding
    tbl4.scrollPerformanceIntervalName = if FFlagAppPageShellScrollTelemetry then tbl1.scrollPerformanceIntervalName else nil
    tbl3.Content = createElement2(var24, tbl4)

    tbl3.StateOverlay = var21
    local pageBody = createElement(str2, tbl2, tbl3)

    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl5 = {
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = if tbl1.backgroundStyle then tbl1.backgroundStyle.Transparency else 0,
        BackgroundColor3 = if tbl1.backgroundStyle then tbl1.backgroundStyle.Color3 else var2.Color.Surface.Surface_0.Color3,
        ref = ref,
        ClipsDescendants = true
    }
    local tbl6 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }),
        PageBody = pageBody,
        SnackbarPortal = 0
    }
    local portal

    if var14 and var14.snackbarConfig then
        portal = ReactRoblox.createPortal({
            SduiSnackbarScreenGui = React.createElement(
                "ScreenGui",
                {
                    DisplayOrder = tbl1.snackbarPortalLayoutOrder,
                    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                    IgnoreGuiInset = true
                },
                {
                    Snackbar = React.createElement(Snackbar, {
                        title = var14.snackbarConfig.title,
                        icon = var14.snackbarConfig.icon,
                        Position = UDim2.new(0.5, 0, 1, -var2.Padding.XLarge),
                        AnchorPoint = Vector2.new(0.5, 1),
                        AutomaticSize = Enum.AutomaticSize.XY,
                        onClose = var14.onDismiss
                    })
                }
            )
        }, CoreGui)
    else
        portal = nil
    end

    tbl6.SnackbarPortal = portal
    return createElement3(str3, tbl5, tbl6)
end))
