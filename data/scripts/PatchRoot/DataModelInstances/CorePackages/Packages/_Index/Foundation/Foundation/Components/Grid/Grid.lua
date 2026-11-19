-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:00:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Breakpoint = require(Foundation.Enums.Breakpoint)
local GridStyleSheet = require(script.Parent.GridStyleSheet)
local React = require(FoundationParent.React)
local _ResponsiveContext = require(Foundation.Providers.Responsive.ResponsiveContext)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local getGridMetrics = require(Foundation.Utility.getGridMetrics)
local useBreakpoint = require(Foundation.Providers.Responsive.Hooks.useBreakpoint)
local useResponsive = require(Foundation.Providers.Responsive.useResponsive)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    [Enum.ItemLineAlignment.Start] = "items-start",
    [Enum.ItemLineAlignment.Center] = "items-center",
    [Enum.ItemLineAlignment.End] = "items-end"
}

local tbl2 = {
    tag = "size-full-0 auto-y",
    align = Enum.ItemLineAlignment.Start,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Wraps = true,
    testId = "--foundation-grid"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Grid
    local var1 = withDefaults(arg1, tbl2)
    local var2 = useResponsive()
    local var3, var4 = React.useState(nil)
    local breakpoint, var6 = useBreakpoint(var3)
    local gridMetrics = getGridMetrics(var2.config, breakpoint, var6.X)
    local width = var2.config.breakpoint.widths[Breakpoint.XLarge]
    local var7 = tbl1[var1.align]

    local createElement = React.createElement
    local var8 = View
    local var9 = withCommonProps(var1, { tag = var1.tag, ref = ref })

    local tbl3 = {
        GridMeasure = React.createElement(
            View,
            { ref = var4, tag = "size-full-0" },
            {
                GridMeasureSizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(width, math.huge) })
            }
        ),
        GridAlignment = 0
    }

    local createElement2 = React.createElement
    local var10 = View
    local tbl4 = {
        tag = `col flex-x-fill size-full-0 auto-y {var7}`
    }
    local tbl5 = {
        GridStyleSheet = React.createElement(GridStyleSheet, { breakpoint = breakpoint, containerWidth = var6.X }),
        Grid = React.createElement(View, {
            tag = "auto-y",
            Size = UDim2.fromOffset(var6.X, 0),
            layout = {
                Padding = if var1.Wraps then nil else UDim.new(0, gridMetrics.gutterWidth),
                SortOrder = var1.SortOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = if var1.Wraps then Enum.UIFlexAlignment.SpaceBetween else nil,
                Wraps = var1.Wraps
            }
        }, {
            GridSizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(width, math.huge) }),
            GridMargin = React.createElement(
                "UIPadding",
                {
                    PaddingLeft = UDim.new(0, gridMetrics.margin),
                    PaddingRight = UDim.new(0, gridMetrics.margin)
                }
            )
        }, var1.children)
    }
    tbl3.GridAlignment = createElement2(var10, tbl4, tbl5)
    return createElement(var8, var9, tbl3)
end))
