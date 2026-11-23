-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local useTokens = require(Foundation.Providers.Style.useTokens)

local Constants = require(Foundation.Constants)

local Sheet = script:FindFirstAncestor("Sheet")
local SheetContext = require(Sheet.SheetContext)
local SheetType = require(Sheet.SheetType)

local ScrollView = require(Foundation.Components.ScrollView)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local isScrollingFrameOverflowingY = require(Foundation.Utility.isScrollingFrameOverflowingY)

return React.memo(React.forwardRef(function(arg1, ref) -- name: SheetContent
    local var1 = useTokens()
    local var2 = React.useContext(SheetContext)

    local innerScrollingEnabled = var2.innerScrollingEnabled
    local setInnerScrollY = var2.setInnerScrollY
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

    local var3, var4 = React.useBinding(false)

    local var5 = React.useCallback(function(arg2)
        setInnerScrollY(arg2.CanvasPosition.Y)

        local var5 = isScrollingFrameOverflowingY(arg2, 1)

        setHasActionsDivider(var5)
        var4(var5)
    end, { setHasActionsDivider, setInnerScrollY })

    local var6, var7 = React.useBinding(0)
    local onAbsoluteSizeChanged = React.useCallback(function(arg2)
        var7(arg2.AbsoluteSize.Y)
    end, {})

    local bool1 = sheetType == SheetType.Bottom

    local var9 = arg1.Selectable == nil or arg1.Selectable

    local selectable = if var3 then var3:map(function(bool2: boolean)
        return var9 and bool2
    end) else nil

    local createElement = React.createElement
    local var11 = ScrollView
    local tbl1 = {
        scrollingFrameRef = arg1.scrollingFrameRef,
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
            CanvasSize = if sheetContentHeight then var6:map(function(yOffset: number): UDim2
                return UDim2.new(1, 0, 0, yOffset)
            end) else UDim2.fromScale(1, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y
        },
        Size = if sheetContentHeight then UDim2.fromScale(1, 1) else nil,
        padding = {
            top = hasHeader:map(function(bool2: boolean)
                if bool2 or hasFullBleed then
                    return UDim.new(0, 0)
                end

                return UDim.new(0, if bool1 then var1.Padding.Small else var1.Margin.Small)
            end),
            bottom = if bool1 then actionsHeight:map(function(num1: number): UDim
                return UDim.new(0, num1 + bottomPadding + var1.Margin.Small)
            end) else UDim.new(0, var1.Padding.Small),
            left = UDim.new(0, var1.Padding.Small),
            right = UDim.new(0, var1.Padding.Small)
        },
        ClipsDescendants = not bool1 or hasHeader,
        onCanvasPositionChanged = 0,
        onAbsoluteCanvasSizeChanged = 0,
        onAbsoluteWindowSizeChanged = 0,
        testId = 0,
        tag = "fill size-full-0 auto-y",
        ref = 0
    }

    function tbl1.onCanvasPositionChanged(arg2)
        setInnerScrollY(arg2.CanvasPosition.Y)
    end
    tbl1.onAbsoluteCanvasSizeChanged = var5
    tbl1.onAbsoluteWindowSizeChanged = var5
    tbl1.testId = `{testId}--content`

    tbl1.ref = ref

    return createElement(
        var11,
        tbl1,
        React.createElement(View, {
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            tag = "col align-x-center gap-medium size-full-0 auto-y padding-x-medium"
        }, {
            FullBleedSpacer = if hasFullBleed and fullBleedHeight then React.createElement(View, {
                Size = fullBleedHeight:map(function(num1: number): UDim2
                    return UDim2.new(1, 0, 0, math.max(0, num1))
                end),
                LayoutOrder = Constants.MIN_LAYOUT_ORDER,
                testId = `{testId}--content--full-bleed-spacer`
            }) else nil,
            Children = React.createElement(React.Fragment, nil, arg1.children)
        })
    )
end))
