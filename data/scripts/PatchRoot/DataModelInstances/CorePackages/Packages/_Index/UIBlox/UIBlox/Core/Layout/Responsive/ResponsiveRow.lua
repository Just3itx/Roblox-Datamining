-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local LuauPolyfill = require(scriptParentParentParentParentParent.LuauPolyfill)
local Object = LuauPolyfill.Object
local Array = LuauPolyfill.Array
local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local ResponsiveLayoutContext = require(scriptParent.ResponsiveLayoutContext)
local ResponsiveLayoutConfigReader = require(scriptParent.ResponsiveLayoutConfigReader)
local ResponsiveBaseRow = require(scriptParent.ResponsiveBaseRow)
local ResponsiveCell = require(scriptParent.ResponsiveCell)

local var1 = Roact.PureComponent:extend("ResponsiveRow")

var1.validateProps = t.strictInterface({
    kind = t.optional(t.string),
    layoutOrder = t.optional(t.integer),
    zIndex = t.optional(t.number),
    scrollable = t.optional(t.boolean),
    clipsDescendants = t.optional(t.boolean),
    selectable = t.optional(t.boolean),
    multiLine = t.optional(t.boolean),
    displayLines = t.optional(t.NumberRange),
    relativeHeight = t.optional(t.UDim),
    data = t.optional(t.any),
    getItem = t.optional(t.callback),
    getItemCount = t.optional(t.callback),
    renderItem = t.optional(t.callback),
    keyExtractor = t.optional(t.callback),
    getCellColspan = t.optional(t.callback),
    getCellRowspan = t.optional(t.callback),
    getCellOrder = t.optional(t.callback),
    scrollingFrameRef = t.optional(t.table),
    forwardedRef = t.optional(t.union(t.table, t.callback))
})

var1.defaultProps = {
    kind = "default",
    multiLine = false,
    data = {},
    getItem = function(arg1, arg2, _)
        return if type(arg1) == "table" then arg1[arg2] else nil
    end,
    renderItem = function<T>(arg1: T, _): T
        return arg1
    end,
    getCellColspan = function(_, _)
        return nil
    end,
    getCellRowspan = function(_, _)
        return nil
    end,
    getCellOrder = function(_, _)
        return nil
    end
}

local function countItems(props, arg1)
    if props.getItemCount then
        return props.getItemCount(props.data, arg1)
    end

    if props.getItem == var1.defaultProps.getItem then
        return #props.data
    end
    for i = 1, arg1.columns do
        if props.getItem(props.data, i, arg1) == nil then
            return i - 1
        end
    end
    return arg1.columns
end

local function resolveCellProp(arg1, item, arg2, num1: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1 then
        local var2 = arg1(item, arg2)
        if var2 ~= nil then
            if type(var2) ~= table then
                return var2
            end

            local breakpoint = arg2.breakpoint or "default"
            if var2[breakpoint] ~= nil then
                return var2[breakpoint]
            end

            if var2.default ~= nil then
                return var2.default
            end
        end
    end
    return num1
end

local function addPaddingCells(tbl1, arg1)
    local tbl2 = {}
    local function shouldSkip(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        local num1 = math.floor(arg2 / arg1.columns)
        local var2 = arg2 - num1 * arg1.columns
        return tbl2[string.format("%d,%d", var2, num1)]
    end
    local function setSkip(num1: number, colspan, rowspan)
        local num2 = math.floor(num1 / arg1.columns)
        local var2 = num1 - num2 * arg1.columns
        for i = var2, var2 + colspan - 1 do
            for j = num2, num2 + rowspan - 1 do
                tbl2[string.format("%d,%d", i, j)] = true
            end
        end
    end
    return Array.reduce(tbl1, function<T>(tbl3: {T}, arg2): {T}
        while shouldSkip(#tbl3) do
            table.insert(tbl3, { order = #tbl3 + 1 })
        end

        if arg2.colspan > 1 or arg2.rowspan > 1 then
            setSkip(#tbl3, arg2.colspan, arg2.rowspan)
        end
        table.insert(tbl3, Object.assign({}, arg2, { order = #tbl3 + 1 }))

        return tbl3
    end, {})
end

local function formatCellKey(arg1, arg2): string -- Luacid: Inlined by compiler; 2 call sites recovered
    local num1 = math.floor(math.log10(arg2) + 1)
    return string.format("ResponsiveRowCell%0" .. num1 .. "d", arg1)
end

function filterDisplayedCells(arg1, arg2, displayLines)
    local var2 = (displayLines.Min - 1) * arg2.columns + 1
    local var3 = displayLines.Max * arg2.columns

    local var4 = Array.filter(arg1, function(_, arg3): boolean
        return var2 <= arg3 and arg3 <= var3
    end)
    local var5 = (displayLines.Max - displayLines.Min + 1) * arg2.columns

    return Array.map(var4, function(arg3, _)
        return Object.assign({}, arg3, { key = formatCellKey((arg3.order - 1) % var5 + 1, var5) })
    end)
end

function var1.init(arg1)
    arg1.itemCache = {}
end

function var1.renderChildren(arg1, arg2)
    local tbl1 = {}
    local itemCache = ({})
    local num1 = 1
    local num2 = 1
    for i = 1, countItems(arg1.props, arg2) do
        local item = arg1.props.getItem(arg1.props.data, i, arg2)

        local var2 = nil
        local var3 = if arg1.props.keyExtractor then arg1.props.keyExtractor(item, i, arg2) else nil

        if var3 and arg1.itemCache[var3] then
            var2 = arg1.itemCache[var3]
        end
        local cell = var2 or arg1.props.renderItem(item, arg2)

        if var3 then
            itemCache[var3] = cell
        end
        local tbl3 = {
            colspan = resolveCellProp(arg1.props.getCellColspan, item, arg2, 1),
            rowspan = resolveCellProp(arg1.props.getCellRowspan, item, arg2, 1),
            order = resolveCellProp(arg1.props.getCellOrder, item, arg2, i),
            cell = cell
        }
        table.insert(tbl1, tbl3)
    end

    arg1.itemCache = itemCache
    if arg1.props.multiLine then
        Array.sort(tbl1, function(arg3, arg4)
            return arg3.order - arg4.order
        end)
        tbl1 = addPaddingCells(tbl1, arg2)
        num1 = math.ceil(#tbl1 / arg2.columns)
        if arg1.props.displayLines then
            tbl1 = filterDisplayedCells(tbl1, arg2, arg1.props.displayLines)
        end
    elseif arg1.props.scrollable then
        num2 = Array.reduce(tbl1, function(arg3, arg4)
            return arg3 + arg4.colspan
        end, 0) / arg2.columns
    end

    if UIBloxConfig.setZIndexOnGridCells then
        for i = 1, #tbl1 do
            tbl1[i].zIndex = #tbl1 + 2 - i
        end
    end

    return Array.map(tbl1, function(arg3, arg4)
        return Roact.createElement(ResponsiveCell, {
            key = arg3.key or formatCellKey(arg4, #tbl1),
            colspan = arg3.colspan,
            rowspan = arg3.rowspan,
            order = arg3.order,
            zIndex = arg3.zIndex
        }, {
            ResponsiveItem = arg3.cell
        })
    end), num2, num1
end

function var1.render(arg1)
    return Roact.createElement(ResponsiveLayoutContext.Consumer, {
        render = function(arg2)
            local var2 = Object.assign({}, arg2, { kind = arg1.props.kind or Object.None })

            local var3, pages, lines = arg1:renderChildren({
                breakpoint = var2.breakpoint,
                kind = var2.kind,
                width = ResponsiveLayoutConfigReader.getValue(var2, "width") or 1,
                columns = ResponsiveLayoutConfigReader.getValue(var2, "columns") or 1,
                margin = ResponsiveLayoutConfigReader.getValue(var2, "margin") or 1,
                gutter = ResponsiveLayoutConfigReader.getValue(var2, "gutter") or 1,
                verticalGutter = ResponsiveLayoutConfigReader.getValue(var2, "verticalGutter")
            })
            local createElement = Roact.createElement
            local var6 = ResponsiveBaseRow
            local tbl1 = {
                kind = arg1.props.kind,
                layoutOrder = arg1.props.layoutOrder,
                zIndex = arg1.props.zIndex,
                scrollable = arg1.props.scrollable,
                clipsDescendants = arg1.props.clipsDescendants,
                selectable = arg1.props.selectable,
                pages = pages,
                multiLine = arg1.props.multiLine,
                lines = lines,
                paddingTopLines = if arg1.props.multiLine and arg1.props.displayLines then math.max(arg1.props.displayLines.Min - 1, 0) else nil,
                relativeHeight = arg1.props.relativeHeight,
                scrollingFrameRef = arg1.props.scrollingFrameRef,
                [Roact.Ref] = arg1.props.forwardedRef
            }
            return createElement(var6, tbl1, var3)
        end
    })
end

return Roact.forwardRef(function(arg1, forwardedRef)
    return Roact.createElement(var1, Object.assign({}, arg1, { forwardedRef = forwardedRef }))
end)
