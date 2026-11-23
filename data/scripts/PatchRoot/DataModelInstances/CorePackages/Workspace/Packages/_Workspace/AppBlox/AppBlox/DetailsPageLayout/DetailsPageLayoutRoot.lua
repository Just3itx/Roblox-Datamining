-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBlox = script:FindFirstAncestor("AppBlox")
local AppBloxParent = AppBlox.Parent

local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)
local Responsive = require(AppBloxParent.Responsive)
local SharedFlags = require(AppBloxParent.SharedFlags)
local Display = require(AppBloxParent.Display)
local AppNavBar = require(AppBloxParent.AppNavBar)
local View = Foundation.View
local withDefaults = Foundation.Utility.withDefaults
local useTokens = Foundation.Hooks.useTokens
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useDeviceInsets = Responsive.useDeviceInsets
local useNavBarSize = AppNavBar.useNavBarSize
local useNavBarPlacement = AppNavBar.useNavBarPlacement

local CompositionTags = require(AppBloxParent.AppComposition).CompositionTags

local DetailsPageLayoutContext = require(script.Parent.DetailsPageLayoutContext)
local DetailsPageLayoutUtils = require(script.Parent.DetailsPageLayoutUtils)

local FFlagDetailsPageLayoutUseMeasuredSizeForInitialScroll = require(AppBlox.Flags.FFlagDetailsPageLayoutUseMeasuredSizeForInitialScroll)

local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local FFlagLuaAppEdpDirectionalGradientMidTransparency = SharedFlags.FFlagLuaAppEdpDirectionalGradientMidTransparency

local tbl1 = {
    testId = "app-blox-details-page",
    fullBleedAspectRatio = 16 / 9,
    fullBleedOverlapOffset = 180,
    reserveHeaderBarSpace = true
}

return React.memo(React.forwardRef(function(tbl2, ref) -- name: DetailsPageLayoutRoot
    local var1 = useDeviceInsets()
    local var2 = useTokens()

    local var3 = withDefaults(tbl2, tbl1)
    local var4 = var3.compositionLayoutTag or CompositionTags.Layout.Detail

    local fullBleedAspectRatio = var3.fullBleedAspectRatio
    local var5 = (fullBleedAspectRatio == nil or not (fullBleedAspectRatio > 0)) and 16 / 9 or fullBleedAspectRatio
    local hasFullBleed = not (var3.fullBleedContent == nil) and not var3.isFullscreen
    local hasHeader, setHasHeader = React.useBinding(false)
    local hasActions, setHasActions = React.useBinding(false)
    local actionBarHeight, setActionBarHeight = React.useBinding(0)

    local scale = var2.Config.UI.Scale
    local fullBleedOverlapOffset = var3.fullBleedOverlapOffset * scale
    local gradientTopBleedOffset = if var3.gradientTopBleedOffset then var3.gradientTopBleedOffset * scale else var2.Size.Size_2000
    local var14 = var2.Size.Size_1000 + var2.Padding.Large + var2.Padding.Medium
    local var15 = Responsive.useBreakpointXOrSmaller(Responsive.Keys.Small)
    local yOffset

    if FFlagLuaAppMediaGalleryGamepadSupport then
        if var3.reserveHeaderBarSpace then
            if not var15 then
                var14 = var2.Size.Size_2000
            end
        else
            var14 = 0
        end

        yOffset = var14 + var1.top
    else
        if not var15 then
            var14 = var2.Size.Size_2000
        end

        yOffset = var14 + var1.top
    end
    local var16, setFullscreenContent = React.useState(nil)
    local isFullscreenOverlay = var16 ~= nil

    local onExitFullscreenOverlay, setOnExitFullscreenOverlay = React.useState(nil)

    local var20, var21 = React.useState(false)
    local stickyHeaderActive = not hasFullBleed or var20 or isFullscreenOverlay

    local var23 = useNavBarSize()
    local var24 = useNavBarPlacement()

    local var25 = React.useMemo(function()
        local var25 = Display.GetDisplayStore(false).getViewportSize(false)
        local x = if var24 == AppNavBar.Placement.Left then math.max(0, var25.X - var23) else var25.X
        local vector2 = Vector2.new(x, var25.Y)
        return {
            containerSize = vector2,
            initialScrollY = if hasFullBleed then DetailsPageLayoutUtils.computeInitialScrollYForSize(vector2, {
                fullBleedAspectRatio = var5,
                headerBarHeight = yOffset,
                fullBleedOverlapOffset = fullBleedOverlapOffset,
                hasFullBleed = hasFullBleed,
                bannerBottomVisiblePercent = tbl2.bannerBottomVisiblePercent
            }) else 0
        }
    end, {})
    local containerSize = var25.containerSize
    local initialScrollY = var25.initialScrollY

    local var26, var27 = React.useBinding(containerSize)
    local var28, var29 = React.useBinding(initialScrollY)
    local var30, var31 = React.useBinding(0)
    local var6, var33 = React.useState(initialScrollY)
    local hasValidContainerSize, var35 = React.useState(true)

    local var36 = React.useRef(hasFullBleed and not FFlagDetailsPageLayoutUseMeasuredSizeForInitialScroll)

    local containerHeight = var26:map(function(vector2: Vector2)
        return vector2.Y
    end)

    local var38 = var26:map(function(vector2: Vector2): UDim2
        return UDim2.new(0, vector2.X, 0, vector2.X / var5)
    end)

    local contentTopOffset = var26:map(function(vector2: Vector2)
        if not hasFullBleed then
            return 0
        end
        return DetailsPageLayoutUtils.computeContentTopOffset(vector2.X, var5, yOffset)
    end)

    local var40 = React.joinBindings({ contentTopOffset, var28 }):map(function(arg1): UDim2
        local var40 = arg1[1]
        local var41 = arg1[2]
        local yOffset2 = math.max(0, var40 + yOffset - var41) / 2
        return UDim2.new(0.5, 0, 0, yOffset2)
    end)

    local headerOpacity = React.joinBindings({ var28, contentTopOffset, var30 }):map(function(arg1): number
        local var41 = arg1[1]
        local var42 = arg1[2]
        local var43 = arg1[3]

        if var42 == 0 then
            return math.clamp(var41 / DetailsPageLayoutUtils.getNoBannerFadeParams(yOffset), 0, 1)
        end

        local var44, var45 = DetailsPageLayoutUtils.getHeaderFadeParams(var42, var43, fullBleedOverlapOffset)
        return math.clamp((var41 - var44) / var45, 0, 1)
    end)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local absoluteSize = arg1.AbsoluteSize
        var27(absoluteSize)
        if not (absoluteSize.X > 0) or not (absoluteSize.Y > 0) then
            return
        end

        var35(true)
        if not hasFullBleed or var36.current then
            return
        end

        var36.current = true
        local var42 = DetailsPageLayoutUtils.computeInitialScrollYForSize(absoluteSize, {
            fullBleedAspectRatio = var5,
            headerBarHeight = yOffset,
            fullBleedOverlapOffset = fullBleedOverlapOffset,
            hasFullBleed = hasFullBleed,
            bannerBottomVisiblePercent = tbl2.bannerBottomVisiblePercent
        })
        var33(var42)
        var29(var42)
    end, {
        hasFullBleed,
        var5,
        yOffset,
        fullBleedOverlapOffset,
        tbl2.bannerBottomVisiblePercent,
        containerSize
    })

    local var43 = React.useRef(0)
    local onCanvasSizeChanged = React.useCallback(function(current: number)
        if math.abs(current - var43.current) > 0.5 then
            var43.current = current
            var31(current)
        end
    end, {})

    local onCanvasPositionChanged = React.useCallback(function(arg1)
        local canvasPositionY = arg1.CanvasPosition.Y
        var29(canvasPositionY)

        if hasFullBleed then
            local value = contentTopOffset:getValue()
            local value2 = var30:getValue()

            local var45, var46 = DetailsPageLayoutUtils.getHeaderFadeParams(value, value2, fullBleedOverlapOffset)
            var21(DetailsPageLayoutUtils.shouldShowStickyBar(canvasPositionY, value, var45, var46))
        end
    end, { hasFullBleed, fullBleedOverlapOffset })

    local useMemo = React.useMemo
    local function func1()
        return {
            hasFullBleed = hasFullBleed,
            hasHeader = hasHeader,
            setHasHeader = setHasHeader,
            hasActions = hasActions,
            setHasActions = setHasActions,
            isFullscreen = var3.isFullscreen,
            headerBarHeight = yOffset,
            actionBarHeight = actionBarHeight,
            setActionBarHeight = setActionBarHeight,
            onCanvasPositionChanged = onCanvasPositionChanged,
            contentTopOffset = contentTopOffset,
            fullBleedOverlapOffset = fullBleedOverlapOffset,
            gradientTopBleedOffset = gradientTopBleedOffset,
            gradientMidTransparency = if FFlagLuaAppEdpDirectionalGradientMidTransparency then var3.gradientMidTransparency else nil,
            initialScrollY = var6,
            hasValidContainerSize = hasValidContainerSize,
            disableFocusNavEngineScroll = if FFlagLuaAppMediaGalleryGamepadSupport then var3.disableFocusNavEngineScroll else nil,
            containerHeight = containerHeight,
            headerOpacity = headerOpacity,
            stickyHeaderActive = stickyHeaderActive,
            onClose = var3.onClose,
            testId = var3.testId,
            onCanvasSizeChanged = onCanvasSizeChanged,
            isFullscreenOverlay = isFullscreenOverlay,
            setFullscreenContent = setFullscreenContent,
            onExitFullscreenOverlay = onExitFullscreenOverlay,
            setOnExitFullscreenOverlay = setOnExitFullscreenOverlay
        }
    end

    local isFullscreen = var3.isFullscreen
    local gradientMidTransparency = if FFlagLuaAppEdpDirectionalGradientMidTransparency then var3.gradientMidTransparency else nil
    local tableValue1 = hasFullBleed
    local tableValue2 = isFullscreen
    local tableValue3 = yOffset
    local tableValue4 = fullBleedOverlapOffset
    local tableValue5 = gradientTopBleedOffset
    local tableValue6 = gradientMidTransparency
    local tableValue7 = var6
    local tableValue8 = hasValidContainerSize
    local tableValue9 = stickyHeaderActive
    local tableValue10 = var3.onClose
    local tableValue11 = var3.testId
    local tableValue12 = containerHeight
    local tableValue13 = headerOpacity
    local tableValue14 = onCanvasPositionChanged
    local tableValue15 = onCanvasSizeChanged
    local tableValue16 = isFullscreenOverlay
    local disableFocusNavEngineScroll = if FFlagLuaAppMediaGalleryGamepadSupport then var3.disableFocusNavEngineScroll else nil
    local value = useMemo(func1, {
        tableValue1,
        tableValue2,
        tableValue3,
        tableValue4,
        tableValue5,
        tableValue6,
        tableValue7,
        tableValue8,
        tableValue9,
        tableValue10,
        tableValue11,
        tableValue12,
        tableValue13,
        tableValue14,
        tableValue15,
        tableValue16,
        onExitFullscreenOverlay,
        disableFocusNavEngineScroll
    })

    local createElement = React.createElement
    local provider = DetailsPageLayoutContext.Provider
    local tbl3 = { value = value }

    return createElement(
        provider,
        tbl3,
        React.createElement(View, {
            tag = `size-full clip bg-surface-0 {var4}`,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            ref = ref,
            selectionGroup = var3.selectionGroup,
            testId = `{var3.testId}--root`
        }, {
            FullBleed = if hasFullBleed then React.createElement(View, {
                tag = "position-top-center anchor-top-center size-full clip",
                ZIndex = 0,
                testId = `{var3.testId}--fullbleed`
            }, {
                ParallaxFrame = React.createElement(View, { Position = var40, Size = var38, tag = "anchor-center-center clip" }, var3.fullBleedContent)
            }) else nil,
            Children = React.createElement(React.Fragment, nil, var3.children),
            FullscreenOverlay = if isFullscreenOverlay then React.createElement(View, {
                Size = hasHeader:map(function(bool3: boolean): UDim2
                    if bool3 then
                        return UDim2.new(1, 0, 1, -yOffset)
                    end

                    return UDim2.fromScale(1, 1)
                end),
                Position = hasHeader:map(function(bool3: boolean): UDim2
                    if bool3 then
                        return UDim2.fromOffset(0, yOffset)
                    end

                    return UDim2.fromOffset(0, 0)
                end),
                ZIndex = 10,
                tag = "clip",
                testId = `{var3.testId}--fullscreen-overlay`
            }, var16) else nil
        })
    )
end))
