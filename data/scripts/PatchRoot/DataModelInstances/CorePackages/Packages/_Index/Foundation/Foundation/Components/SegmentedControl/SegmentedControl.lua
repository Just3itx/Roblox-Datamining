-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local _ControlState = require(Foundation.Enums.ControlState)

local FillBehavior = require(Foundation.Enums.FillBehavior)

local InputSize = require(Foundation.Enums.InputSize)

local SegmentedControlVariant = require(Foundation.Enums.SegmentedControlVariant)

local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local useAnimatedHighlight = require(Foundation.Utility.useAnimatedHighlight)
local withDefaults = require(Foundation.Utility.withDefaults)

local Segment = require(script.Parent.Segment)
local useSegmentedControlVariants = require(script.Parent.useSegmentedControlVariants)

local Flags = require(Foundation.Utility.Flags)

local tbl1 = {
    size = InputSize.Medium,
    variant = SegmentedControlVariant.Filled,
    fillBehavior = FillBehavior.Fit,
    testId = "--foundation-segmented-control",
    ZIndex = 1
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: SegmentedControl
    local var1 = withDefaults(arg1, tbl1)
    local variant = if Flags.FoundationSegmentedControlBeta then var1.variant else nil
    local fillBehavior = if Flags.FoundationSegmentedControlBeta then var1.fillBehavior else nil
    local var2 = useTokens()
    local var3 = useSegmentedControlVariants(
        var2,
        var1.size,
        if Flags.FoundationSegmentedControlBeta then variant else nil,
        if Flags.FoundationSegmentedControlBeta then fillBehavior else nil,
        var1.isCircular
    )
    local bool1 = if Flags.FoundationSegmentedControlBeta then fillBehavior == FillBehavior.Fill else nil
    local var4 = React.useRef(nil)

    local var5 = React.useRef({})
    local var6 = React.useMemo(function()
        local current = var5.current
        for _, segment in var1.segments do
            if segment.ref then
                current[segment.id] = segment.ref
            elseif not current[segment.id] then
                current[segment.id] = React.createRef()
            end
        end
        return current
    end, { var1.segments })

    local var7 = useAnimatedHighlight(
        var1.value,
        ref or var4,
        var6,
        if Flags.FoundationSegmentedControlBeta then var1.size else nil,
        if Flags.FoundationSegmentedControlBeta then fillBehavior else nil
    )

    local activeItemHeight = var7.activeItemHeight
    local highlightPosition = var7.highlightPosition
    local highlightWidth = var7.highlightWidth
    local var8, var9 = React.useBinding(Vector2.new(0, 0))
    local var10 = var9

    local var11 = React.useCallback(function(arg2)
        var10(arg2.AbsoluteSize)
    end, { var3.container.tag })

    local onAbsoluteSizeChanged = React.useCallback(function(arg2)
        if var1.onAbsoluteSizeChanged then
            var1.onAbsoluteSizeChanged(arg2)
        end
        var11(arg2)
    end, { var1.onAbsoluteSizeChanged, var11 })

    local var13 = React.useCallback(function(tbl2)
        local num1 = 0
        if tbl2.current then
            local current = var6[var1.value].current
            if current then
                num1 = current.AbsolutePosition.Y - tbl2.current.AbsolutePosition.Y
            end
        end
        return num1
    end, { var1.value })

    local createElement = React.createElement
    local var14 = View
    local var15 = withCommonProps

    local tbl2 = {
        tag = if Flags.FoundationSegmentedControlBeta then if bool1 then "size-full-0 auto-y" else nil else nil,
        Size = if Flags.FoundationSegmentedControlBeta then if bool1 then nil else var8:map(function(vector2: Vector2): UDim2
            return UDim2.fromOffset(vector2.X, vector2.Y)
        end) else var8:map(function(vector2: Vector2): UDim2
            return UDim2.fromOffset(vector2.X, vector2.Y)
        end)
    }

    local var16 = var15(var1, tbl2)

    local tbl3 = { SegmentsContainer = 0, Overlay = 0 }
    local createElement2 = React.createElement
    local var17 = View
    local var18 = withDefaults
    local tbl4 = {
        tag = var3.container.tag,
        stroke = if Flags.FoundationSegmentedControlBeta then var3.container.stroke else nil,
        ref = ref or var4,
        testId = `{var1.testId}--segments-container`
    }

    tbl3.SegmentsContainer = createElement2(
        var17,
        var18(tbl4, { onAbsoluteSizeChanged = onAbsoluteSizeChanged }),
        Dash.map(var1.segments, function(arg2, num1: number)
            local layoutOrder = (num1 - 1) * 2 + 1
            local createElement3 = React.createElement
            local fragment = React.Fragment
            local tbl5 = {
                key = tostring(arg2.id)
            }
            local tbl6 = {
                Segment = React.createElement(Segment, {
                    id = arg2.id,
                    size = var1.size,
                    variant = if Flags.FoundationSegmentedControlBeta then variant else nil,
                    fillBehavior = if Flags.FoundationSegmentedControlBeta then fillBehavior else nil,
                    isCircular = var1.isCircular,
                    text = arg2.text,
                    icon = arg2.icon,
                    isActive = arg2.id == var1.value,
                    onActivated = var1.onActivated,
                    LayoutOrder = layoutOrder,
                    testId = `{var1.testId}--segment-{arg2.id}`,
                    ref = var6[arg2.id]
                })
            }
            return createElement3(fragment, tbl5, tbl6)
        end)
    )

    tbl3.Overlay = React.createElement(View, {
        tag = var3.segment.tag,
        backgroundStyle = if Flags.FoundationSegmentedControlBeta then var2.Color.Shift.Shift_300 else var2.Color.Shift.Shift_400,
        Size = React.joinBindings({ highlightWidth, activeItemHeight }):map(function(tbl5: {number}): UDim2
            return UDim2.fromOffset(tbl5[1], tbl5[2])
        end),
        Position = highlightPosition:map(function(xOffset: number): UDim2
            local yOffset = var13(ref or var4)
            return UDim2.fromOffset(xOffset, yOffset)
        end),
        ZIndex = var1.ZIndex + 1,
        testId = `{var1.testId}--animated-overlay`
    })

    return createElement(var14, var16, tbl3)
end))
