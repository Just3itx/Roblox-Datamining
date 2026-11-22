-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local AppSplitView = require(SplitPaneParent.AppSplitView)
local Constants = require(SplitPaneParent.NavigationRodux).Constants
local RobloxAppEnums = require(SplitPaneParent.RobloxAppEnums)
local SharedFlags = require(SplitPaneParent.SharedFlags)

local SplitView = AppSplitView.SplitView
local Enums = AppSplitView.Enums

local useSplitPaneRender = require(script.Parent.Parent.Hooks.useSplitPaneRender)

local useSplitPaneFocusNavBridge = require(script.Parent.Parent.Hooks.useSplitPaneFocusNavBridge)
local FFlagSplitPaneEducationalTour = SharedFlags.FFlagSplitPaneEducationalTour
local FFlagNavigationCommandHandle = SharedFlags.FFlagNavigationCommandHandle
local SplitPaneEducationalTour = if FFlagSplitPaneEducationalTour then require(script.Parent.SplitPaneEducationalTour) else nil
local SupportPaneTopRoutePublisher = if FFlagNavigationCommandHandle then require(script.Parent.SupportPaneTopRoutePublisher) else nil
local tbl1 = {
    [Constants.TempRnSwitchNavigatorName] = true
}
if Constants.HomeContainerName ~= nil then
    tbl1[Constants.HomeContainerName] = true
end

local function getActiveRouteName(arg1)
    while arg1 ~= nil and tbl1[arg1.routeName] and arg1.routes ~= nil and arg1.index ~= nil do
        arg1 = arg1.routes[arg1.index]
    end
    return if arg1 == nil then nil else arg1.routeName
end

local function isHomeActive(screens)
    local screen = screens[1]
    local state = if screen == nil or screen.descriptor == nil then nil else screen.descriptor.state

    if getActiveRouteName(state) ~= RobloxAppEnums.AppPage.Home then
        return false
    end

    for i = 2, #screens do
        local options = if screens[i].descriptor == nil then nil else screens[i].descriptor.options

        if options == nil or options.splitPaneEligibility ~= Enums.SplitPaneSlot.Support then
            return false
        end
    end
    return true
end

local function useSupportPaneAnchorRef()
    local var1 = React.useRef(nil)

    return var1, (React.useCallback(function(current)
        var1.current = current
    end, {}))
end

local function SplitPaneNavigationLayout(tbl2)
    local var1 = useSplitPaneRender(tbl2.screens, tbl2.cards, tbl2.paneIndices, tbl2.isRouteActiveOnPane)
    local ref = React.useRef(nil)

    useSplitPaneFocusNavBridge(ref)
    local isRootAppStack = FFlagSplitPaneEducationalTour and var1.isRootAppStack
    local var3, var4

    if FFlagSplitPaneEducationalTour then
        var3, var4 = useSupportPaneAnchorRef()
    else
        var4 = nil
        var3 = nil
    end

    if not var1.isBreakpointEnabled then
        local var5 = table.clone(var1.primarySlotChildren)
        for k, overlaySlotChild in var1.overlaySlotChildren do
            var5[k] = overlaySlotChild
        end
        return React.createElement(React.Fragment, nil, var5)
    end

    local state

    if FFlagNavigationCommandHandle and tbl2.isRouteActiveOnPane and #tbl2.paneIndices > 0 then
        local screen = tbl2.screens[tbl2.paneIndices[#tbl2.paneIndices]]
        if screen == nil then
            state = nil
        else
            state = screen.descriptor.state
        end
    else
        state = nil
    end

    local supportPaneMode = var1.supportPaneMode
    local isSupportSurfaceEligible = isRootAppStack
        and var1.supportContentProps.paneCount == 0
        and not var1.supportContentProps.hasDetailOnTop
        and isHomeActive(tbl2.screens)
    local var6 = if var1.renderSupportContent ~= nil then var1.renderSupportContent(var1.supportContentProps, var1.supportSlotChildren) else React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1)
        },
        var1.supportSlotChildren
    )

    if isRootAppStack and var4 ~= nil then
        var6 = React.createElement(
            "Frame",
            {
                ref = var4,
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            },
            { SupportContent = var6 }
        )
    end

    local supportPane = {
        width = var1.supportWidth,
        minWidth = var1.supportMinWidth,
        maxWidth = var1.supportMaxWidth,
        resizable = if supportPaneMode == Enums.SupportPaneMode.Normal and var1.supportPaneResizable then Enums.PaneResizable.Horizontal else Enums.PaneResizable.None,
        element = var6
    }

    local bool1 = next(var1.overlaySlotChildren) ~= nil

    local tbl4 = {
        ContentPaneSurface = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                ref = ref
            },
            var1.primarySlotChildren
        )
    }
    return React.createElement(React.Fragment, nil, {
        SplitView = React.createElement(SplitView, {
            supportPane = supportPane,
            supportPaneMode = supportPaneMode,
            supportResizerAbovePane = var1.supportResizerAbovePane,
            onSupportPaneWidthChanged = var1.onSupportPaneWidthChanged,
            onContentRegionRectChanged = var1.onContentRegionRectChanged
        }, tbl4),
        TopRoutePublisher = if state == nil then nil else React.createElement(SupportPaneTopRoutePublisher, { routeState = state }),
        EducationalTour = if isRootAppStack then React.createElement(
            SplitPaneEducationalTour,
            {
                supportPaneRef = var3,
                supportPaneMode = supportPaneMode,
                isSupportSurfaceEligible = isSupportSurfaceEligible
            }
        ) else nil,
        Overlay = if bool1 then React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 10
            },
            var1.overlaySlotChildren
        ) else nil
    })
end

return SplitPaneNavigationLayout
