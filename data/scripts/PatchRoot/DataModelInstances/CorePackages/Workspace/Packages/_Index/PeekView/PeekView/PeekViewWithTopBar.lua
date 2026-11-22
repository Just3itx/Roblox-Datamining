-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeekViewParent = script:FindFirstAncestor("PeekView").Parent
local Cryo = require(PeekViewParent.Cryo)
local React = require(PeekViewParent.React)
local useRoactService = require(PeekViewParent.RobloxAppHooks).useRoactService
local useRouteName = require(PeekViewParent.Navigation).useRouteName
local AppEventIngestService = require(PeekViewParent.RoactServiceTags).AppEventIngestService
local useStyle = require(PeekViewParent.UIBlox).Core.Style.useStyle
local PeekView = require(script.Parent.PeekView)
local PeekViewState = require(script.Parent.PeekViewState)
local peekViewDismissedEvent = require(script.Parent.analytics.peekViewDismissedEvent)

local FFlagProfilePlatformNewProfileHeader = require(PeekViewParent.SharedFlags).FFlagProfilePlatformNewProfileHeader

local FFlagFixOverlayTopInsetForDeviceSafeInsets = require(PeekViewParent.SharedFlags).FFlagFixOverlayTopInsetForDeviceSafeInsets
local shouldUseDeviceSafeInsets = require(PeekViewParent.Display).shouldUseDeviceSafeInsets
local useDeviceInsets = require(PeekViewParent.Responsive).useDeviceInsets

local function PeekViewWithTopBar(tbl1)
    local var1 = useRoactService(AppEventIngestService)
    local page = useRouteName()

    local var3 = useStyle()
    local onClosed = tbl1.onClosed
    local onViewStateChanged = tbl1.onViewStateChanged
    local viewStateChanged = React.useCallback(function(closed, arg1, arg2)
        if closed == PeekViewState.Closed then
            if onClosed then
                onClosed()
            end

            if arg2.dismissMethod and var1 then
                local viewChangedEventMeta = tbl1.viewChangedEventMeta or {}

                peekViewDismissedEvent.logEvent(var1, "PeekView", Cryo.Dictionary.join(viewChangedEventMeta, arg2, { page = page }))
            end
        end

        if onViewStateChanged then
            onViewStateChanged(closed, arg1)
        end
    end, {
        onClosed,
        onViewStateChanged,
        tbl1.viewChangedEventMeta,
        var1,
        page
    })

    local yOffset = if FFlagFixOverlayTopInsetForDeviceSafeInsets and shouldUseDeviceSafeInsets then useDeviceInsets().top else 0

    local var5, var6 = React.useBinding(0)
    local function briefToFullTransitionPercent(arg1)
        var6(arg1)
        if tbl1.transitionPercentCallback then
            tbl1.transitionPercentCallback(arg1)
        end
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(tbl1.viewWidth or UDim.new(1, 0), UDim.new(1, 0)),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl3 = {
        PeekViewTopBar = React.createElement("CanvasGroup", {
            Position = UDim2.new(0, 0, 0, -yOffset),
            Size = UDim2.new(1, 0, 0, tbl1.topBarHeight + yOffset),
            BackgroundColor3 = var3.Theme.BackgroundDefault.Color,
            Active = false,
            BackgroundTransparency = 0,
            BorderColor3 = var3.Tokens.Color.Common.Shimmer.Color3,
            BorderSizePixel = 0,
            GroupTransparency = var5:map(function(arg1): number
                return 1 - arg1
            end),
            ZIndex = 2
        }, {
            PeekViewTopBarInner = if yOffset > 0 then React.createElement(
                "Frame",
                {
                    Position = UDim2.new(0, 0, 0, yOffset),
                    Size = UDim2.new(1, 0, 0, tbl1.topBarHeight),
                    BackgroundTransparency = 1
                },
                {
                    TopBarSlot = tbl1.topBarSlot
                }
            ) else tbl1.topBarSlot
        }),
        PeekViewContainer = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }

    local tbl5 = {
        PeekView = React.createElement(PeekView, {
            hasScrim = true,
            fullViewContentHeight = tbl1.fullViewContentHeight,
            briefViewContentHeight = tbl1.briefViewContentHeight,
            bottomDockedContainerHeight = tbl1.bottomDockedContainerHeight,
            bottomDockedContainerContent = {
                PeekViewBottomBar = tbl1.bottomBarSlot
            },
            mountAsFullView = tbl1.mountAsFullView,
            mountAnimation = tbl1.mountAnimation,
            viewStateChanged = viewStateChanged,
            briefToFullTransitionPercent = briefToFullTransitionPercent,
            hasSolidDragger = if FFlagProfilePlatformNewProfileHeader then tbl1.hasSolidDragger else nil,
            scrollingFrameRef = tbl1.scrollingFrameRef
        }, {
            UIListLayout = React.createElement("UIListLayout", {
                Padding = UDim.new(0, 0),
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top
            }),
            Content = tbl1.contentSlot
        })
    }
    tbl3.PeekViewContainer = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return PeekViewWithTopBar
