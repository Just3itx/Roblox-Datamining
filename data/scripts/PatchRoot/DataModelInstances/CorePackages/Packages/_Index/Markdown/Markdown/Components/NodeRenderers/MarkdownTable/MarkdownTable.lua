-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")

local MarkdownParent = Markdown.Parent
local Dash = require(MarkdownParent.Dash)
local Foundation = require(MarkdownParent.Foundation)
local React = require(MarkdownParent.React)

local columnWidths = require(script.Parent.columnWidths)
local mergeContexts = require(Markdown.Utils.mergeContexts)
local _Types = require(Markdown.Types)

local ScrollView = Foundation.ScrollView
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function getTableContext(context)
    return mergeContexts(context, { textStyles = { textTags = "text-body-medium content-default" } })
end

local function getColumnCount(node): number -- Luacid: Inlined by compiler; 1 call site recovered
    local child = node.children[1]
    return if child then #child.children else 0
end

local function getCellPadding(arg1, arg2)
    local var1 = (arg1.textStyles.textSize or arg2.Typography.BodyMedium.FontSize) / arg2.Typography.BodyMedium.FontSize
    return {
        x = math.round(arg2.Padding.XLarge * var1),
        y = math.round(arg2.Padding.Medium * var1),
        text = math.round(arg2.Padding.XXSmall * var1)
    }
end

local function MarkdownTable(tbl1)
    local var1 = useTokens()

    local var2, var3 = React.useState(0)
    local var4, var5 = React.useState(nil)
    local var6 = React.useRef(nil)

    local var7 = React.useMemo(function()
        return getTableContext(tbl1.context)
    end, { tbl1.context })

    React.useEffect(function()
        local current = var6.current or columnWidths.createWidthCache()
        var6.current = current
        local var9 = columnWidths.measureColumnContentWidths(tbl1.node, var7, current)
        var5(function(tbl2)
            return if tbl2 and Dash.shallowEqual(tbl2, var9) then tbl2 else var9
        end)
    end, { tbl1.node, var7 })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize.X)
    end, {})

    local tableCellPadding = getCellPadding(var7, var1)
    local columnCount = getColumnCount(tbl1.node)
    local offset = math.ceil(var1.Stroke.Standard)
    local var9 = math.max(columnCount - 1, 0) * var1.Stroke.Standard
    local tableColumnWidths = if var4 and var2 > 0 then columnWidths.computeColumnWidths(
        columnWidths.fillUnmeasuredColumns(var4, columnCount),
        var2 - offset * 2 - var9,
        tableCellPadding.x * 2
    ) else nil
    local xOffset = if tableColumnWidths then Dash.sum(tableColumnWidths) + var9 + offset * 2 else 0
    local var11 = if var2 < xOffset then var1.Size.Size_150 + var1.Gap.XSmall else 0

    local scroll = React.useMemo(function()
        return {
            AutomaticSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromOffset(xOffset, 0),
            ScrollingDirection = Enum.ScrollingDirection.X,
            scrollBarVisibility = Foundation.Enums.Visibility.Always
        }
    end, { xOffset })

    return React.createElement(View, {
        tag = "size-full-0 auto-y",
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }, {
        ScrollView = React.createElement(ScrollView, { tag = "size-full-0 auto-y", scroll = scroll }, {
            BorderInset = React.createElement(View, { tag = "auto-xy" }, {
                UIPadding = React.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, offset),
                    PaddingBottom = UDim.new(0, offset + var11),
                    PaddingLeft = UDim.new(0, offset),
                    PaddingRight = UDim.new(0, offset)
                }),
                Table = tableColumnWidths
                    and React.createElement(
                        View,
                        {
                            tag = "auto-xy col gap-none radius-medium stroke-standard stroke-default"
                        },
                        var7.processChildren(
                            tbl1.node,
                            mergeContexts(
                                var7,
                                {
                                    tableColumnWidths = tableColumnWidths,
                                    tableCellPadding = tableCellPadding,
                                    tableRowCount = #tbl1.node.children
                                }
                            )
                        )
                    )
            })
        })
    })
end
return MarkdownTable
