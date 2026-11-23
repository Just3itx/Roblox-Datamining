-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBlox = script:FindFirstAncestor("AppBlox")
local AppBloxParent = AppBlox.Parent

local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)
local ReactUtils = require(AppBloxParent.ReactUtils)
local SharedFlags = require(AppBloxParent.SharedFlags)
local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local FFlagLuaAppEdpDirectionalGradientMidTransparency = SharedFlags.FFlagLuaAppEdpDirectionalGradientMidTransparency

local ScrollView = Foundation.ScrollView
local View = Foundation.View

local DetailsPageLayoutContext = require(script.Parent.DetailsPageLayoutContext)
local DetailsPageLayoutUtils = require(script.Parent.DetailsPageLayoutUtils)

local FFlagDetailsPageLayoutUseMeasuredSizeForInitialScroll = require(AppBlox.Flags.FFlagDetailsPageLayoutUseMeasuredSizeForInitialScroll)

local selection = { Selectable = false }
local binding = React.createBinding(0)

return React.memo(React.forwardRef(function(tbl2, ref) -- name: DetailsPageLayoutContent
    local var1 = React.useContext(DetailsPageLayoutContext)

    local contentTopOffset = var1.contentTopOffset
    local hasFullBleed = var1.hasFullBleed
    local isFullscreen = var1.isFullscreen
    local isFullscreenOverlay = var1.isFullscreenOverlay
    local headerBarHeight = var1.headerBarHeight
    local hasHeader = var1.hasHeader
    local onCanvasPositionChanged = var1.onCanvasPositionChanged
    local fullBleedOverlapOffset = var1.fullBleedOverlapOffset
    local initialScrollY = var1.initialScrollY
    local hasValidContainerSize = var1.hasValidContainerSize
    local containerHeight = var1.containerHeight
    local onCanvasSizeChanged = var1.onCanvasSizeChanged
    local hasActions = var1.hasActions
    local actionBarHeight = var1.actionBarHeight
    local testId = var1.testId
    local gradientTopBleedOffset = var1.gradientTopBleedOffset
    local gradientMidTransparency = var1.gradientMidTransparency
    assert(testId, "DetailsPageLayout.Content must be used within DetailsPageLayout.Root")

    local useCallback = React.useCallback
    local function func1(arg1)
        if arg1 and (FFlagDetailsPageLayoutUseMeasuredSizeForInitialScroll and hasFullBleed or initialScrollY > 0) then
            arg1.CanvasPosition = Vector2.new(0, initialScrollY)
        end
    end

    local var2 = if FFlagDetailsPageLayoutUseMeasuredSizeForInitialScroll then hasFullBleed else nil
    local var3 = useCallback(func1, { initialScrollY, var2 })

    local scrollingFrameRef = ReactUtils.useComposedRef(tbl2.scrollingFrameRef, var3)

    local var5, var6 = React.useBinding(initialScrollY)
    local var7, var8 = React.useBinding(0)

    local var4 = React.useCallback(function(arg1)
        var6(arg1.CanvasPosition.Y)
        if onCanvasPositionChanged then
            onCanvasPositionChanged(arg1)
        end
    end, { onCanvasPositionChanged })

    local var10 = React.useMemo(function()
        if not (hasHeader and hasActions and actionBarHeight) then
            return nil
        end
        return React.joinBindings({ hasHeader, hasActions, actionBarHeight }):map(function(tbl3): UDim2
            local var10 = tbl3[1]
            local var11 = tbl3[2]
            local var12 = tbl3[3]
            return UDim2.new(1, 0, 1, -((if var10 then headerBarHeight else 0) + (if var11 then var12 else 0)))
        end)
    end, {
        hasHeader,
        hasActions,
        actionBarHeight,
        headerBarHeight
    })
    local var11 = React.useMemo(function()
        if not hasHeader then
            return nil
        end
        return hasHeader:map(function(bool1: boolean): UDim2
            return UDim2.new(0, 0, 0, if bool1 then headerBarHeight else 0)
        end)
    end, { hasHeader, headerBarHeight })

    local paddingTop = React.useMemo(function()
        if not contentTopOffset then
            return nil
        end
        return React.joinBindings({ contentTopOffset, containerHeight or binding }):map(function(tbl3): UDim
            local var12 = tbl3[1]
            local var13 = tbl3[2]
            local offset = DetailsPageLayoutUtils.computeCanvasPaddingTop(var12, hasFullBleed, fullBleedOverlapOffset, headerBarHeight)

            if var13 > 0 then
                offset = math.min(offset, var13 * 0.75)
            end
            return UDim.new(0, offset)
        end)
    end, {
        contentTopOffset,
        containerHeight,
        hasFullBleed,
        fullBleedOverlapOffset,
        headerBarHeight
    })

    local paddingBottom = React.useMemo(function()
        if not (hasActions and actionBarHeight) then
            return nil
        end
        return React.joinBindings({ hasActions, actionBarHeight }):map(function(tbl3): UDim
            local var13 = tbl3[1]
            local offset = tbl3[2]
            if var13 then
                return UDim.new(0, offset)
            end

            return UDim.new(0, 0)
        end)
    end, { hasActions, actionBarHeight })

    local var14 = React.useMemo(function()
        if not paddingTop then
            return nil
        end
        return React.joinBindings({ paddingTop, var5 }):map(function(tbl3): UDim2
            local var14 = tbl3[1]
            local var15 = tbl3[2]
            return UDim2.new(0, 0, 0, var14.Offset - var15 - gradientTopBleedOffset)
        end)
    end, { paddingTop, var5, gradientTopBleedOffset })

    local var15 = React.useMemo(function()
        if not containerHeight then
            return nil
        end
        return React.joinBindings({ var7, containerHeight }):map(function(tbl3): UDim2
            local var15 = tbl3[1]
            local var16 = tbl3[2]

            if not (var15 > 0) then
                var15 = math.max(var16, 1)
            end

            return UDim2.new(1, 0, 0, var15 + gradientTopBleedOffset)
        end)
    end, { var7, containerHeight, gradientTopBleedOffset })

    if isFullscreen then
        assert(var10 and var11, "bindings required in fullscreen mode")

        return React.createElement(View, {
            Size = var10,
            Position = var11,
            ZIndex = 1,
            tag = "col bg-surface-0",
            testId = `{testId}--content`,
            ref = ref
        }, {
            Children = React.createElement(React.Fragment, nil, tbl2.children)
        })
    end

    assert(
        paddingTop and onCanvasPositionChanged and containerHeight and hasActions and actionBarHeight,
        "DetailsPageLayout.Content requires bindings in scroll mode"
    )

    if hasFullBleed and not hasValidContainerSize then
        return React.createElement(
            View,
            {
                tag = "size-full clip bg-surface-0",
                ZIndex = 1,
                testId = `{testId}--content`,
                ref = ref
            }
        )
    end

    local createElement = React.createElement
    local var16 = View
    local tbl3 = { Position = var14, Size = var15, tag = "col", ZIndex = 0 }

    local tbl4 = { GradientBar = 0, SolidFill = 0 }
    local element

    if hasFullBleed and contentTopOffset then
        element = React.createElement(View, {
            Size = contentTopOffset:map(function(num1: number): UDim2
                return UDim2.new(1, 0, 0, math.min(num1, fullBleedOverlapOffset) + gradientTopBleedOffset)
            end),
            tag = "bg-surface-0",
            LayoutOrder = 0
        }, {
            Gradient = React.createElement("UIGradient", {
                Rotation = 270,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, FFlagLuaAppEdpDirectionalGradientMidTransparency and gradientMidTransparency or 0.25), NumberSequenceKeypoint.new(1, 1) })
            })
        })
    else
        element = nil
    end

    tbl4.GradientBar = element

    tbl4.SolidFill = React.createElement(View, { tag = "fill size-full-0 bg-surface-0", LayoutOrder = 1 })
    local backgroundLayers = createElement(var16, tbl3, tbl4)

    local createElement2 = React.createElement
    local var17 = View
    local tbl5 = {
        tag = "size-full clip",
        ZIndex = 1,
        ref = ref,
        testId = `{testId}--content`
    }
    local tbl6 = { BackgroundLayers = backgroundLayers, ScrollContent = 0 }

    local createElement3 = React.createElement
    local var18 = ScrollView
    local tbl7 = {
        scrollingFrameRef = scrollingFrameRef,
        selection = selection,
        scroll = 0,
        onAbsoluteCanvasSizeChanged = 0,
        onCanvasPositionChanged = 0,
        tag = "size-full clip",
        ZIndex = 1
    }
    local scroll = {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(1, 0, 0, 0),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollingEnabled = 0
    }
    local bool1

    if FFlagLuaAppMediaGalleryGamepadSupport then
        bool1 = not isFullscreenOverlay
        bool1 = bool1 and not (var1.disableFocusNavEngineScroll == true)
    else
        bool1 = not isFullscreenOverlay
    end

    scroll.ScrollingEnabled = bool1
    tbl7.scroll = scroll

    function tbl7.onAbsoluteCanvasSizeChanged(arg1)
        var8(arg1.AbsoluteCanvasSize.Y)
        if onCanvasSizeChanged then
            local var19 = arg1.AbsoluteCanvasSize.Y - arg1.AbsoluteSize.Y
            onCanvasSizeChanged(var19)
        end
    end
    tbl7.onCanvasPositionChanged = var4

    tbl6.ScrollContent = createElement3(
        var18,
        tbl7,
        React.createElement(View, { tag = "col size-full-0 auto-y" }, {
            CanvasPadding = React.createElement("UIPadding", { PaddingTop = paddingTop, PaddingBottom = paddingBottom }),
            ContentSection = React.createElement(View, {
                Size = containerHeight:map(function(yOffset: number): UDim2
                    return UDim2.new(1, 0, 0, yOffset)
                end),
                tag = "auto-y",
                LayoutOrder = 1
            }, {
                ContentBackground = React.createElement(
                    View,
                    { tag = "col align-x-center size-full-0 auto-y" },
                    {
                        Children = React.createElement(React.Fragment, nil, tbl2.children)
                    }
                )
            })
        })
    )

    return createElement2(var17, tbl5, tbl6)
end))
