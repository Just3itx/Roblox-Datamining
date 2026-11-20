-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local FillBehavior = require(Foundation.Enums.FillBehavior)
local Flags = require(Foundation.Utility.Flags)
local InputSize = require(Foundation.Enums.InputSize)
local OverflowScrollContainer = require(Foundation.Components.OverflowScrollContainer)
local TabItem = require(script.Parent.TabItem)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useAnimatedHighlight = require(Foundation.Utility.useAnimatedHighlight)

local OverflowScrollContainer2 = require(script.Parent.OverflowScrollContainer)

local tbl1 = {
    fillBehavior = FillBehavior.Fill,
    size = InputSize.Medium,
    testId = "--foundation-tabs",
    ZIndex = 1
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Tabs
    local var1 = useTokens()
    local var2 = withDefaults(arg1, tbl1)

    local var3, var4 = React.useState(var2.defaultActiveTabId or Dash.get(var2, { 1, "id" }))

    local onActivated = React.useCallback(function(arg2)
        if var2.onActivated then
            var2.onActivated(arg2)
        end
        var4(arg2)
    end, Flags.FoundationTabsStableOnActivated and { var2.onActivated } or nil)

    local bool1 = var2.fillBehavior == FillBehavior.Fill
    local var6 = var2.activeTabId or var3
    local var7 = Dash.find(var2.tabs, function(arg2): boolean
        return arg2.id == var6
    end)

    local var8 = React.useRef(nil)

    local var9 = nil
    local var10 = nil
    local var11

    if Flags.FoundationUnifiedScrimScrolling then
        local var12
        var9, var12 = React.useBinding(0)
        var10 = var12
        var11 = React.useCallback(function(arg2)
            var10(arg2.AbsoluteSize.X)
        end, {})
    else
        var11 = nil
    end

    local var12 = React.useRef({})
    local var13 = React.useMemo(function()
        local current = var12.current
        for _, tab in var2.tabs do
            if tab.ref then
                current[tab.id] = tab.ref
            elseif not current[tab.id] then
                current[tab.id] = React.createRef()
            end
        end
        return current
    end, { var2.tabs })

    local var14 = useAnimatedHighlight(var6, ref or var8, var13, var2.size, var2.fillBehavior)

    local highlightPosition = var14.highlightPosition
    local highlightWidth = var14.highlightWidth
    local activeItemHeight = var14.activeItemHeight

    local size = var2.size
    local createElement = React.createElement
    local var15 = View
    local var16 = withCommonProps

    local tbl2 = {
        tag = if Flags.FoundationUnifiedScrimScrolling then "auto-y no-clip" else "auto-y clip",
        Size = UDim2.fromScale(1, 0),
        sizeConstraint = if Flags.FoundationUnifiedScrimScrolling then not bool1 and {
            MaxSize = var9:map(function(x: number): Vector2
                return Vector2.new(x, math.huge)
            end)
        } or nil else nil
    }

    local var17 = var16(var2, tbl2)

    local tbl3 = { Tabs = 0, AnimatedBorder = 0 }
    local createElement2 = React.createElement
    local var18 = View
    local tbl4 = {
        ref = ref or var8,
        tag = "col auto-y",
        Size = UDim2.fromScale(1, 0)
    }
    local tbl5 = { Wrapper = 0, Content = 0 }
    local createElement3 = React.createElement
    local var19 = View
    local tbl6 = {
        LayoutOrder = 1,
        tag = "auto-y",
        Size = UDim2.fromScale(1, 0),
        testId = `{var2.testId}--wrapper`
    }
    local tbl7 = { ScrollContainer = 0, Border = 0 }
    local createElement4 = React.createElement
    local var20 = if Flags.FoundationUnifiedScrimScrolling then OverflowScrollContainer else OverflowScrollContainer2
    local var21 = Flags.FoundationUnifiedScrimScrolling
        and {
            LayoutOrder = 1,
            size = var2.size,
            scrimBottomInset = var1.Stroke.Thick,
            testId = `{var2.testId}--scroll-container`
        }
        or {
            LayoutOrder = 1,
            size = var2.size,
            testId = `{var2.testId}--scroll-container`
        }
    local tbl8 = { TabList = 0 }
    local createElement5 = React.createElement
    local var22 = View
    local tbl9 = { onAbsoluteSizeChanged = 0, tag = 0, Size = 0, testId = 0 }
    if not Flags.FoundationUnifiedScrimScrolling then
        var11 = nil
    end

    tbl9.onAbsoluteSizeChanged = var11

    tbl9.tag = if Flags.FoundationFixTabsFitGap then "row flex-y-fill auto-xy" else {
        ["row flex-y-fill auto-xy"] = true,
        ["gap-large"] = not bool1 and (size == InputSize.Small or size == InputSize.XSmall)
    }
    tbl9.Size = if bool1 then UDim2.fromScale(1, 0) else nil
    tbl9.testId = `{var2.testId}--list`

    tbl8.TabList = createElement5(var22, tbl9, Dash.map(var2.tabs, function(arg2, layoutOrder)
        return React.createElement(TabItem, {
            id = arg2.id,
            text = arg2.text,
            indicator = arg2.indicator,
            key = tostring(arg2.id),
            icon = arg2.icon,
            leading = arg2.leading,
            trailing = arg2.trailing,
            isActive = arg2.id == var6,
            onActivated = onActivated,
            LayoutOrder = layoutOrder,
            fillBehavior = var2.fillBehavior,
            size = var2.size,
            isDisabled = arg2.isDisabled,
            testId = `{var2.testId}--item-{arg2.id}`,
            ref = var13[arg2.id]
        })
    end))

    tbl7.ScrollContainer = createElement4(var20, var21, tbl8)

    tbl7.Border = React.createElement(View, {
        LayoutOrder = 2,
        AnchorPoint = Vector2.new(0, 1),
        Size = UDim2.new(1, 0, 0, var1.Stroke.Thick),
        Position = UDim2.fromScale(0, 1),
        backgroundStyle = var1.Color.Stroke.Default,
        testId = `{var2.testId}--border`
    })
    tbl5.Wrapper = createElement3(var19, tbl6, tbl7)

    tbl5.Content = if var7 and var7.content then React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "auto-y",
            Size = UDim2.fromScale(1, 0),
            testId = `{var2.testId}--content`
        },
        var7.content
    ) else nil
    tbl3.Tabs = createElement2(var18, tbl4, tbl5)

    tbl3.AnimatedBorder = React.createElement(View, {
        LayoutOrder = 0,
        ZIndex = var2.ZIndex + 1,
        Size = highlightWidth:map(function(xOffset: number): UDim2
            return UDim2.fromOffset(xOffset, var1.Stroke.Thick)
        end),
        AnchorPoint = Vector2.new(0, 1),
        Position = React.joinBindings({ highlightPosition, activeItemHeight }):map(function(tbl10: {number}): UDim2
            local xOffset = tbl10[1]
            local yOffset = tbl10[2]
            return UDim2.fromOffset(xOffset, yOffset)
        end),
        backgroundStyle = var1.Color.System.Contrast,
        testId = `{var2.testId}--animated-border`
    })

    return createElement(var15, var17, tbl3)
end))
