-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)
local useTokens = require(Foundation.Providers.Style.useTokens)

local Constants = require(Foundation.Constants)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local Sheet = script:FindFirstAncestor("Sheet")
local SheetContext = require(Sheet.SheetContext)
local SheetType = require(Sheet.SheetType)

local Flags = require(Foundation.Utility.Flags)
local ScrollView = require(Foundation.Components.ScrollView)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local devAssert = require(Foundation.Utility.devAssert)
local isScrollingFrameOverflowingY = require(Foundation.Utility.isScrollingFrameOverflowingY)

local useComposedRef = ReactUtils.useComposedRef

local function getMaxCanvasPositionY(arg1): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return math.max(0, arg1.AbsoluteCanvasSize.Y - arg1.AbsoluteWindowSize.Y)
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: SheetContent
    local var1 = useTokens()
    local var2 = React.useContext(SheetContext)

    local innerScrollingEnabled = var2.innerScrollingEnabled
    local setInnerScrollY = var2.setInnerScrollY
    local innerScrollingRef = var2.innerScrollingRef
    local actionsHeight = var2.actionsHeight
    local sheetContentHeight = var2.sheetContentHeight
    local setHasActionsDivider = var2.setHasActionsDivider
    local bottomPadding = var2.bottomPadding
    local hasHeader = var2.hasHeader
    local hasFullBleed = var2.hasFullBleed
    local fullBleedHeight = var2.fullBleedHeight
    local sheetType = var2.sheetType
    local testId = var2.testId
    assert(
        innerScrollingEnabled
            and setInnerScrollY
            and actionsHeight
            and setHasActionsDivider
            and bottomPadding
            and hasHeader
            and testId,
        "SheetContent must be used within a Sheet"
    )
    local bool1 = if Flags.FoundationSheetReversedContent then arg1.isReversed == true else false
    local contentRevealOffset = if bool1 then var2.contentRevealOffset else nil

    if Flags.FoundationSheetReversedContent then
        devAssert(
            not (bool1 and hasFullBleed),
            "Sheet.Content with isReversed=true is unsupported when used with Sheet.FullBleed"
        )
    end

    if Flags.FoundationSheetReversedContent then
        local setIsContentReversed = var2.setIsContentReversed
        React.useLayoutEffect(function()
            if not (bool1 and setIsContentReversed) then
                return nil
            end
            setIsContentReversed(true)
            return function()
                setIsContentReversed(false)
            end
        end, { bool1, setIsContentReversed })
    end

    local var3, var4 = React.useBinding(false)
    local var5 = if Flags.FoundationSheetReversedContent then React.useRef(true) else nil
    local var6 = nil
    local var7 = nil
    if Flags.FoundationSheetReversedContent then
        local var8
        var6, var8 = React.useBinding(0)
        var7 = var8
    end

    local var8 = React.useCallback(function(arg2)
        if bool1 and var5.current then
            arg2.CanvasPosition = Vector2.new(0, (getMaxCanvasPositionY(arg2)))
        end
        setInnerScrollY(arg2.CanvasPosition.Y)

        local var8 = isScrollingFrameOverflowingY(arg2, 1)

        if bool1 then
            var7(arg2.AbsoluteWindowSize.Y)
            setHasActionsDivider(getMaxCanvasPositionY(arg2) - arg2.CanvasPosition.Y > 1)
        else
            setHasActionsDivider(var8)
        end
        var4(var8)
    end, { bool1, setHasActionsDivider, setInnerScrollY })

    local var9, var10 = React.useBinding(0)
    local onAbsoluteSizeChanged = React.useCallback(function(arg2)
        var10(arg2.AbsoluteSize.Y)
    end, {})

    local var12 = if contentRevealOffset then contentRevealOffset:map(function(yOffset: number): UDim2
        return UDim2.fromOffset(0, yOffset)
    end) else nil

    local var13 = if contentRevealOffset then React.joinBindings({ windowSizeY = var6, revealOffset = contentRevealOffset }):map(function(tbl1)
        return UDim2.new(1, 0, 0, math.max(0, tbl1.windowSizeY - tbl1.revealOffset))
    end) elseif bool1 then var6:map(function(yOffset: number): UDim2
        return UDim2.new(1, 0, 0, yOffset)
    end) else nil

    local bool2 = sheetType == SheetType.Bottom
    local var14 = if arg1.isContentFullBleed then nil else UDim.new(0, var1.Padding.Small)
    local bool3 = sheetType == SheetType.Side and not arg1.isContentFullBleed
    local var15 = arg1.Selectable == nil or arg1.Selectable

    local selectable = if var3 then var3:map(function(bool4: boolean)
        return var15 and bool4
    end) else nil

    local isVerticalSheetGesture = var2.isVerticalSheetGesture

    local contentInteractionSinkContainer = React.createElement("Folder", nil, {
        ContentInteractionSink = if isVerticalSheetGesture then React.createElement(View, {
            Size = UDim2.fromScale(1, 1),
            Selectable = false,
            ZIndex = 2,
            testId = `{testId}--content--interaction-sink`,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = Dash.noop
        }) else nil
    })

    local scrollingFrameRef = useComposedRef(innerScrollingRef, arg1.scrollingFrameRef)

    local element2 = React.createElement(View, {
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        Position = var12,
        Size = var13,
        padding = if Flags.FoundationSideSheetInternalDrawer then bool3 and {
            left = UDim.new(0, var1.Padding.Medium),
            right = UDim.new(0, var1.Padding.Medium + var1.Padding.Small)
        }
            or nil else nil,
        tag = {
            ["col align-x-center gap-medium size-full-0 auto-y"] = true,
            ["padding-x-medium"] = if Flags.FoundationSideSheetInternalDrawer then not (arg1.isContentFullBleed or bool3) else not arg1.isContentFullBleed,
            ["align-y-bottom"] = bool1
        }
    }, {
        FullBleedSpacer = if hasFullBleed and fullBleedHeight then React.createElement(View, {
            Size = fullBleedHeight:map(function(num1: number): UDim2
                return UDim2.new(1, 0, 0, math.max(0, num1))
            end),
            LayoutOrder = Constants.MIN_LAYOUT_ORDER,
            testId = `{testId}--content--full-bleed-spacer`
        }) else nil,
        Children = React.createElement(React.Fragment, nil, arg1.children),
        ContentInteractionSinkContainer = contentInteractionSinkContainer
    })

    local createElement = React.createElement
    local var18 = ScrollView

    local tbl1 = {
        scrollingFrameRef = scrollingFrameRef,
        ZIndex = 1,
        selection = {
            Selectable = selectable,
            NextSelectionUp = arg1.NextSelectionUp,
            NextSelectionDown = arg1.NextSelectionDown,
            NextSelectionLeft = arg1.NextSelectionLeft,
            NextSelectionRight = arg1.NextSelectionRight
        },
        scroll = {
            ScrollingEnabled = innerScrollingEnabled,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = if sheetContentHeight then var9:map(function(yOffset: number): UDim2
                return UDim2.new(1, 0, 0, yOffset)
            end) else UDim2.fromScale(1, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y
        },
        Size = if sheetContentHeight then UDim2.fromScale(1, 1) else nil,
        Position = if contentRevealOffset then contentRevealOffset:map(function(num1: number): UDim2
            return UDim2.fromOffset(0, -num1)
        end) else nil,
        padding = 0,
        ClipsDescendants = 0,
        onCanvasPositionChanged = 0,
        onAbsoluteCanvasSizeChanged = 0,
        onAbsoluteWindowSizeChanged = 0,
        testId = 0,
        tag = 0,
        ref = 0
    }

    local padding = {
        top = hasHeader:map(function(bool4: boolean)
            if bool4 or hasFullBleed then
                return UDim.new(0, 0)
            end

            return UDim.new(0, if bool2 then var1.Padding.Small else var1.Margin.Small)
        end),
        bottom = if bool2 then actionsHeight:map(function(num1: number): UDim
            return UDim.new(0, num1 + bottomPadding + var1.Margin.Small)
        end) else UDim.new(0, var1.Padding.Small),
        left = var14,
        right = 0
    }

    if Flags.FoundationSideSheetInternalDrawer and bool3 then
        var14 = nil
    end

    padding.right = var14
    tbl1.padding = padding

    tbl1.ClipsDescendants = not bool2 or hasHeader
    function tbl1.onCanvasPositionChanged(arg2)
        if bool1 then
            var5.current = getMaxCanvasPositionY(arg2) - arg2.CanvasPosition.Y <= 1
            setHasActionsDivider(not var5.current)
        end
        setInnerScrollY(arg2.CanvasPosition.Y)
    end
    tbl1.onAbsoluteCanvasSizeChanged = var8
    tbl1.onAbsoluteWindowSizeChanged = var8
    tbl1.testId = `{testId}--content`
    tbl1.tag = if contentRevealOffset then "size-full" else "fill size-full-0 auto-y"
    tbl1.ref = ref
    local scrollView = createElement(var18, tbl1, element2)

    if not contentRevealOffset then
        return scrollView
    end

    return React.createElement(
        View,
        {
            ClipsDescendants = true,
            ZIndex = 1,
            tag = "fill size-full-0",
            testId = `{testId}--content--viewport`
        },
        { ScrollView = scrollView }
    )
end))
