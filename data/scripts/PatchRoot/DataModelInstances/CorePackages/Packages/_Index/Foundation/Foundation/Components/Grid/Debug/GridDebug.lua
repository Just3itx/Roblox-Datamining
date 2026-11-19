-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:00:39Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Breakpoint = require(Foundation.Enums.Breakpoint)
local GridDebugStyleSheet = require(script.Parent.GridDebugStyleSheet)
local React = require(FoundationParent.React)
local StyleSheetContext = require(Foundation.Providers.Style.StyleSheetContext)
local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)
local getGridMetrics = require(Foundation.Utility.getGridMetrics)
local useBreakpoint = require(Foundation.Providers.Responsive.Hooks.useBreakpoint)
local useResponsive = require(Foundation.Providers.Responsive.useResponsive)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local function DebugCol(tbl1)
    return React.createElement(View, {
        Size = tbl1.size or UDim2.new(0, tbl1.width or 0, 1, 0),
        backgroundStyle = tbl1.backgroundStyle,
        LayoutOrder = tbl1.LayoutOrder,
        tag = tbl1.tag
    })
end

local tbl1 = { debugTransparency = 0.7 }

local function GridDebug(tbl2)
    local var1 = withDefaults(tbl2, tbl1)
    local var2 = useTokens()
    local value, ref = React.useState(nil)
    local var5 = useResponsive()
    local var6, var3 = React.useState(nil)
    local breakpoint, var9 = useBreakpoint(var6)
    local gridMetrics = getGridMetrics(var5.config, breakpoint, var9.X)
    local width = var5.config.breakpoint.widths[Breakpoint.XLarge]
    local tbl3 = {}

    local var10 = ({
        [Enum.ItemLineAlignment.Start] = "position-top-left anchor-top-left",
        [Enum.ItemLineAlignment.Center] = "position-top-center anchor-top-center",
        [Enum.ItemLineAlignment.End] = "position-top-right anchor-top-right"
    })[var1.align]

    for layoutOrder = 1, gridMetrics.full.colCount - 1 do
        if not (layoutOrder < gridMetrics.full.colCount) then
            continue
        end

        table.insert(
            tbl3,
            React.createElement(DebugCol, {
                key = `DebugCol{layoutOrder}`,
                width = gridMetrics.gutterWidth,
                backgroundStyle = {
                    Color3 = var2.Color.System.Alert.Color3,
                    Transparency = 0.5
                },
                LayoutOrder = layoutOrder
            })
        )
    end

    local createElement = React.createElement
    local var11 = View
    local tbl4 = {
        tag = `size-full-full {var10}`
    }
    local tbl5 = {
        GridDebugStyleSheet = React.createElement(GridDebugStyleSheet, { breakpoint = breakpoint, ref = ref }),
        GridDebugMeasureWrapper = React.createElement(
            View,
            { ref = var3, tag = "size-full-0" },
            {
                GridMeasureSizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(width, math.huge) })
            }
        ),
        GridDebugMeasure = React.createElement(View, {
            Size = UDim2.new(1, 0, 0, 4),
            backgroundStyle = {
                Color3 = Color3.fromRGB(255, 0, 0),
                Transparency = var1.debugTransparency
            }
        }),
        GridDebugSizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(width, math.huge) }),
        GridDebugSizeLabel = React.createElement(Text, {
            tag = "position-top-center anchor-top-center auto-xy padding-xxsmall text-label-small text-truncate-end bg-over-media-300",
            Text = `breakpoint: {var5.config.breakpoint.shortNames[breakpoint]}, width: {var9.X}, columns: {gridMetrics.full.colCount}, maxWidth: {width}, margin: {gridMetrics.margin}, gapWidth: {gridMetrics.gutterWidth}`
        }),
        GridDebug = React.createElement(View, {
            tag = "row size-full-full",
            backgroundStyle = {
                Color3 = var2.Color.System.Emphasis.Color3,
                Transparency = var1.debugTransparency
            }
        }, {
            LeftMargin = React.createElement(DebugCol, {
                width = gridMetrics.margin,
                backgroundStyle = {
                    Color3 = var2.Color.System.Warning.Color3,
                    Transparency = var1.debugTransparency
                },
                LayoutOrder = 0
            }),
            Columns = React.createElement(View, {
                tag = "row flex-x-evenly fill size-0-full",
                backgroundStyle = {
                    Color3 = var2.Color.System.Emphasis.Color3,
                    Transparency = var1.debugTransparency
                },
                LayoutOrder = 1
            }, tbl3),
            RightMargin = React.createElement(DebugCol, {
                width = gridMetrics.margin,
                backgroundStyle = {
                    Color3 = var2.Color.System.Warning.Color3,
                    Transparency = var1.debugTransparency
                },
                LayoutOrder = 2
            })
        }),
        GridDebugContent = 0
    }
    local element

    if value then
        element = React.createElement(
            StyleSheetContext.Provider,
            { value = value },
            React.createElement(View, { tag = "size-full-full" }, {
                GridDebugPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, gridMetrics.gapHeight * 2) }),
                GridDebugChildren = React.createElement(React.Fragment, nil, tbl2.children)
            })
        )
    else
        element = nil
    end

    tbl5.GridDebugContent = element
    return createElement(var11, tbl4, tbl5)
end

return GridDebug
