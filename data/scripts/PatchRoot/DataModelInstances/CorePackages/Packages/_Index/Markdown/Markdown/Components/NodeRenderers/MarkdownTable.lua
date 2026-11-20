-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")

local MarkdownParent = Markdown.Parent
local Foundation = require(MarkdownParent.Foundation)
local React = require(MarkdownParent.React)

local getRowContext = require(script.getRowContext)
local MarkdownTable = require(script.MarkdownTable)
local renderInline = require(Markdown.Components.NodeRenderers.renderInline)
local shouldUseTopPadding = require(Markdown.Utils.shouldUseTopPadding)
local TableAlignment = require(Markdown.Enums.TableAlignment)
local _Types = require(Markdown.Types)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    [TableAlignment.Left] = Enum.HorizontalAlignment.Left,
    [TableAlignment.Center] = Enum.HorizontalAlignment.Center,
    [TableAlignment.Right] = Enum.HorizontalAlignment.Right
}

local function TableDivider(tbl2)
    local var1 = useTokens()
    local standard = var1.Stroke.Standard

    return React.createElement(View, {
        tag = "self-stretch",
        Size = if tbl2.isVertical then UDim2.fromOffset(standard, 0) else UDim2.fromOffset(0, standard),
        backgroundStyle = var1.Color.Stroke.Default,
        LayoutOrder = tbl2.LayoutOrder
    })
end

local function renderTableRowCells(arg1, arg2, ref, onAbsoluteSizeChanged: ((...any) -> (...any))?)
    local var1 = arg2.processChildren(arg1, getRowContext(arg1, arg2))

    for i = 2, #arg1.children do
        table.insert(
            var1,
            React.createElement(TableDivider, { key = `Divider{i}`, isVertical = true, LayoutOrder = i * 2 - 1 })
        )
    end

    return React.createElement(
        View,
        {
            tag = "auto-xy row items-start",
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            LayoutOrder = 2,
            ref = ref
        },
        var1
    )
end

local function TableRow(tbl2)
    local node = tbl2.node

    local bool1 = node.name == "TABLE_HEADER"
    local bool2 = node.index == tbl2.context.tableRowCount

    local var1 = React.useRef(nil)
    local var2, var3 = React.useState(Vector2.zero)
    local var4 = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize)
    end, {})

    React.useLayoutEffect(function()
        if bool1 and var1.current then
            var3(var1.current.AbsoluteSize)
        end
    end, { bool1 })

    local createElement = React.createElement
    local var5 = View
    local tbl3 = {
        tag = "auto-xy col items-stretch",
        LayoutOrder = node.index
    }
    local tbl4 = {
        Divider = if node.index > 1 then React.createElement(TableDivider, { LayoutOrder = 1, isVertical = false }) else nil,
        Content = 0
    }

    local createElement2 = React.createElement
    local var6 = View
    local tbl5 = { tag = "auto-xy", LayoutOrder = 2 }

    local tbl6 = {
        Background = if bool1 then React.createElement(View, {
            tag = {
                ["bg-shift-100"] = true,
                ["radius-medium"] = bool2,
                ["radius-top-medium"] = not bool2
            },
            Size = UDim2.fromOffset(var2.X, var2.Y),
            ZIndex = 0
        }) else nil,
        Cells = 0
    }

    local func1 = renderTableRowCells
    local context = tbl2.context

    if not bool1 then
        var4 = nil
    end

    tbl6.Cells = func1(node, context, var1, var4)
    tbl4.Content = createElement2(var6, tbl5, tbl6)
    return createElement(var5, tbl3, tbl4)
end

return {
    renderTable = function(node, context)
        return React.createElement(
            View,
            {
                key = tostring(node.index),
                tag = "size-full-0 auto-y col",
                LayoutOrder = node.index
            },
            {
                UIPadding = shouldUseTopPadding(node) and React.createElement("UIPadding", { PaddingTop = UDim.new(0, 10) }),
                Table = React.createElement(MarkdownTable, { node = node, context = context })
            }
        )
    end,
    renderTableRow = function(node, context)
        return React.createElement(TableRow, { key = tostring(node.index), node = node, context = context })
    end,
    renderTableCell = function(arg1, arg2)
        local index = arg1.index or 1
        local tableColumnWidth = if arg2.tableColumnWidths then arg2.tableColumnWidths[index] else nil
        local alignment = arg1.attributes and arg1.attributes.alignment
        local var1 = arg2.tableCellPadding or { x = 0, y = 0, text = 0 }

        local createElement = React.createElement
        local var2 = View
        local tbl2 = {
            key = tostring(index),
            tag = "auto-y",
            Size = UDim2.fromOffset(tableColumnWidth or 0, 0),
            LayoutOrder = index * 2
        }
        local tbl3 = {
            UIPadding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, var1.y),
                PaddingBottom = UDim.new(0, var1.y),
                PaddingLeft = UDim.new(0, var1.x),
                PaddingRight = UDim.new(0, var1.x)
            }),
            Text = React.createElement(View, { tag = "size-full-0 auto-y" }, {
                UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, var1.text), PaddingBottom = UDim.new(0, var1.text) }),
                InlineLayout = renderInline(arg1, arg2, if alignment then tbl1[alignment] else nil)
            })
        }
        return createElement(var2, tbl2, tbl3)
    end
}
