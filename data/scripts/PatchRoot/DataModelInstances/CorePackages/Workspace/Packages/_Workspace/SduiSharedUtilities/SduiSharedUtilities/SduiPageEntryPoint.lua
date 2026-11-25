-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local ReactRoblox = require(SduiSharedUtilitiesParent.ReactRoblox)
local React = require(SduiSharedUtilitiesParent.React)
local Foundation = require(SduiSharedUtilitiesParent.Foundation)
local Loading = Foundation.Loading
local useTokens = Foundation.Hooks.useTokens
local ReactFocusNavigation = require(SduiSharedUtilitiesParent.ReactFocusNavigation)
local useDispatch = require(SduiSharedUtilitiesParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigateBack = require(SduiSharedUtilitiesParent.NavigationRodux).Thunks.NavigateBack
local FFlagSignalsNavP3Dispatch = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SduiSharedUtilitiesParent.RobloxAppNavigation).NavigationCommands else nil
local useCloseWithBackButton = require(SduiSharedUtilitiesParent.AppBlox).useCloseWithBackButton
local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)
local getSduiComponentWrapper = require(SduiSharedUtilitiesParent.SduiCoreSystem).getSduiComponentWrapper
local CompositionTags = require(SduiSharedUtilitiesParent.AppComposition).CompositionTags

local getSduiApiStore = require(SduiSharedUtilities.getSduiApiStore)
local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local SduiPageNavigationHeader = require(SduiSharedUtilities.SduiPageNavigationHeader)
local useCreateClientBindingSduiContext = require(SduiSharedUtilities.useCreateClientBindingSduiContext)
local NavButtonType = require(SduiSharedUtilities.SduiIntegrationTypes).NavButtonType
local SduiPageErrorState = require(SduiSharedUtilities.SduiPageErrorState)
local usePageEntrySnackbar = require(SduiSharedUtilities.usePageEntrySnackbar)
local useComponentLifecycleTiming = require(SduiSharedUtilities.hooks.useComponentLifecycleTiming)
local useLocalAnalyticsData = require(SduiSharedUtilities.hooks.useLocalAnalyticsData)
local useStatefulRef = require(SduiSharedUtilities.hooks.useStatefulRef)
local useComponentConfig = require(SduiSharedUtilities.hooks.useComponentConfig)
local useUiStatus = require(SduiSharedUtilities.hooks.useUiStatus)
local useDataUpdatedTimestamp = require(SduiSharedUtilities.hooks.useDataUpdatedTimestamp)
local UiStatus = require(SduiSharedUtilities.SduiIntegrationTypes).UiStatus
local Snackbar = Foundation.Snackbar
local FFlagLuaAppSduiPageEntryPointSnackbar = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppSduiPageEntryPointSnackbar
local FFlagSduiPageEntryUseSharedHooks = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiPageEntryUseSharedHooks
local FFlagLuaAppMediaGalleryGamepadSupport = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppMediaGalleryGamepadSupport
local FFlagSduiPageEntryPointResolvedSlot = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiPageEntryPointResolvedSlot
local FFlagAppThemeHalloween2026HomeBackground = require(SduiSharedUtilitiesParent.SharedFlags).FFlagAppThemeHalloween2026HomeBackground
local FFlagSduiVerticalFeedScrollTelemetry = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiVerticalFeedScrollTelemetry
local FFlagLuaAppSduiVideoThumbnail = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppSduiVideoThumbnail
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay

local function SduiPageEntryPoint(tbl1, arg1)
    local appPage = tbl1.appPage
    local configKey = tbl1.configKey or appPage
    local debugName = `SduiPageEntryPoint-{configKey}`
    local pageTimer = tbl1.pageTimer

    local var2 = useTokens()
    local var3 = useDispatch()
    local var4

    if FFlagSduiPageEntryUseSharedHooks then
        var4 = useComponentConfig(configKey, tbl1.identifier)
    else
        local var5 = React.useCallback(function(arg2)
            return getSduiApiStore().getRootConfig(configKey, arg2, tbl1.identifier)
        end, { configKey, tbl1.identifier })
        var4 = SignalsReact.useSignalState(var5)
    end

    local var5 = React.useCallback(function(arg2)
        return getSduiApiStore().getTitle(configKey, arg2)
    end, { configKey })
    local title = SignalsReact.useSignalState(var5) or tbl1.pageTitle

    local var7 = useUiStatus(configKey)
    local bool1 = var7 == UiStatus.Loading
    local bool2 = var7 == UiStatus.Error

    local var8 = FFlagSduiPageEntryPointResolvedSlot

    if var8 then
        if tbl1.resolvedSlot == nil then
            var8 = false
        else
            var8 = not (bool1 or bool2)
        end
    end
    if FFlagSduiPageEntryUseSharedHooks then
        useComponentLifecycleTiming(pageTimer, typeof(var4) == "table" or FFlagSduiPageEntryPointResolvedSlot and var8)
    else
        React.useEffect(function()
            if pageTimer then
                pageTimer.logComponentMounted()
            end
        end, { pageTimer })

        local useEffect = React.useEffect
        local function func1()
            if pageTimer and (var4 or FFlagSduiPageEntryPointResolvedSlot and var8) then
                pageTimer.logComponentReady()
            end
        end

        local var9 = var4
        local var10 = if FFlagSduiPageEntryPointResolvedSlot then var8 else nil
        useEffect(func1, { pageTimer, var9, var10 })
    end

    local localAnalyticsData = if FFlagSduiPageEntryUseSharedHooks then useLocalAnalyticsData(configKey, appPage, tbl1.additionalAnalyticsData) else React.useMemo(function()
        return { configKey = configKey, appPage = appPage }
    end, { configKey, appPage })

    local var10, var11

    if FFlagSduiPageEntryUseSharedHooks then
        var10, var11 = useStatefulRef(arg1)
    else
        var10, var11 = React.useState(nil)
        React.useRef(var10).current = var10
    end

    local closeCallback = React.useCallback(function()
        if tbl1.onCloseActivated then
            tbl1.onCloseActivated()
        elseif FFlagSignalsNavP3Dispatch then
            NavigationCommands.back()
        else
            var3(NavigateBack())
        end
    end, { var3, tbl1.onCloseActivated })

    local _, var13 = ReactFocusNavigation.useMostRecentOrDefaultFocusBehavior(var11)
    local ref = useCloseWithBackButton(var13, closeCallback)
    local var15 = if FFlagLuaAppSduiPageEntryPointSnackbar then usePageEntrySnackbar(configKey) else nil
    local var16 = useDataUpdatedTimestamp(configKey, tbl1.identifier)

    local var17, var1 = React.useState(nil)

    local var19 = useCreateClientBindingSduiContext

    local var20 = nil

    local var21 = nil
    local routeName = tbl1.routeName
    local scrollAway = tbl1.scrollAway
    local videoPlaybackContext = if FFlagLuaAppSduiVideoThumbnail or FFlagLuaAppOneByTwoHoverIdleAutoplay then tbl1.videoPlaybackContext else nil
    local sduiContext = var19(appPage, var17, var20, var16, configKey, var21, routeName, scrollAway, videoPlaybackContext)

    local bool3 = var10 == nil

    local useMemo = React.useMemo
    local function func1()
        if var4 == nil then
            return nil
        end

        local sduiComponentWrapper = getSduiComponentWrapper(var4)
        return React.createElement(sduiComponentWrapper, {
            debugName = debugName,
            componentConfig = var4,
            sduiContext = sduiContext,
            localAnalyticsData = localAnalyticsData,
            extraLocalProps = {
                pageBottomPadding = tbl1.pageBottomPadding,
                feedTopMargin = tbl1.feedTopMargin,
                scrollingFrameRef = tbl1.scrollingFrameRef,
                scrollToSelectionRevealOnly = if FFlagLuaAppMediaGalleryGamepadSupport then tbl1.scrollToSelectionRevealOnly else nil,
                onScrollDirectionChanged = tbl1.onScrollDirectionChanged,
                defaultContentTag = tbl1.contentTag,
                defaultStickyContentTag = tbl1.stickyContentTag,
                scrollPerformanceIntervalName = if FFlagSduiVerticalFeedScrollTelemetry then tbl1.scrollPerformanceIntervalName else nil,
                backgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.feedBackgroundStyle else nil
            }
        })
    end

    local var23 = var4

    local contentTag = tbl1.contentTag
    local stickyContentTag = tbl1.stickyContentTag
    local pageBottomPadding = tbl1.pageBottomPadding
    local feedTopMargin = tbl1.feedTopMargin
    local scrollingFrameRef = tbl1.scrollingFrameRef
    local scrollToSelectionRevealOnly = if FFlagLuaAppMediaGalleryGamepadSupport then tbl1.scrollToSelectionRevealOnly else nil
    local onScrollDirectionChanged = tbl1.onScrollDirectionChanged
    local scrollPerformanceIntervalName = if FFlagSduiVerticalFeedScrollTelemetry then tbl1.scrollPerformanceIntervalName else nil
    local feedBackgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.feedBackgroundStyle else nil
    local var24 = useMemo(func1, {
        var23,
        debugName,
        sduiContext,
        localAnalyticsData,
        contentTag,
        stickyContentTag,
        pageBottomPadding,
        feedTopMargin,
        scrollingFrameRef,
        scrollToSelectionRevealOnly,
        onScrollDirectionChanged,
        scrollPerformanceIntervalName,
        feedBackgroundStyle
    })

    local bool4 = tbl1.scrollingFrameRef ~= nil

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        [React.Tag] = tbl1.layoutTag,
        Size = UDim2.new(1, 0, if bool4 then 0 else 1, 0),
        AutomaticSize = if bool4 then Enum.AutomaticSize.Y else nil,
        BorderSizePixel = 0,
        BackgroundTransparency = if tbl1.backgroundStyle then tbl1.backgroundStyle.Transparency else 0,
        BackgroundColor3 = if tbl1.backgroundStyle then tbl1.backgroundStyle.Color3 else var2.Color.Surface.Surface_0.Color3,
        ref = ref,
        ClipsDescendants = tbl1.clipsDescendantsOverride == nil or tbl1.clipsDescendantsOverride
    }
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }),
        PageTopPadding = if tbl1.pageTopPadding and tbl1.pageTopPadding > 0 then React.createElement("UIPadding", { PaddingTop = UDim.new(0, tbl1.pageTopPadding) }) else nil,
        PageHeader = 0,
        PageBody = 0,
        SnackbarPortal = 0
    }
    local element

    if bool3 or not tbl1.includeNavigationHeaderBar then
        element = nil
    else
        element = React.createElement(SduiPageNavigationHeader, {
            title = title,
            contentTag = tbl1.headerContentTag or CompositionTags.ContentRegion.Header,
            layoutOrder = 1,
            renderUtilities = tbl1.renderUtilities,
            navButtonType = tbl1.navButtonType or NavButtonType.back,
            closeCallback = closeCallback,
            scrollAwayHeader = tbl1.scrollAway ~= nil
        })
    end

    tbl3.PageHeader = element
    local var25

    if bool1 then
        if tbl1.loadingSlot then
            var25 = tbl1.loadingSlot
        else
            var25 = React.createElement(
                Foundation.View,
                {
                    Size = UDim2.new(1, 0, 1, 0)
                },
                React.createElement(Loading, { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5) })
            )
        end
    elseif bool2 then
        if tbl1.errorSlot then
            var25 = tbl1.errorSlot
        else
            var25 = React.createElement(SduiPageErrorState, { refresh = tbl1.refresh })
        end
    else
        local createElement2 = React.createElement
        local str3 = "Frame"
        local tbl4 = {
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, if bool4 then 0 else 1, 0),
            AutomaticSize = if bool4 then Enum.AutomaticSize.Y else nil,
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            ref = var1
        }
        local tbl5 = {
            UIFlexItem = if bool4 then nil else React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
            Content = 0
        }

        if bool3 then
            var24 = nil
        elseif FFlagSduiPageEntryPointResolvedSlot and tbl1.resolvedSlot then
            var24 = tbl1.resolvedSlot
        end

        tbl5.Content = var24
        var25 = createElement2(str3, tbl4, tbl5)
    end

    tbl3.PageBody = var25
    local portal

    if var15 and var15.snackbarConfig then
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
                        title = var15.snackbarConfig.title,
                        icon = var15.snackbarConfig.icon,
                        Position = UDim2.new(0.5, 0, 1, -var2.Padding.XLarge),
                        AnchorPoint = Vector2.new(0.5, 1),
                        AutomaticSize = Enum.AutomaticSize.XY,
                        onClose = var15.onDismiss
                    })
                }
            )
        }, CoreGui)
    else
        portal = nil
    end

    tbl3.SnackbarPortal = portal
    return createElement(str2, tbl2, tbl3)
end

if FFlagSduiPageEntryUseSharedHooks then
    return React.memo(React.forwardRef(SduiPageEntryPoint))
end
return React.memo(SduiPageEntryPoint)
