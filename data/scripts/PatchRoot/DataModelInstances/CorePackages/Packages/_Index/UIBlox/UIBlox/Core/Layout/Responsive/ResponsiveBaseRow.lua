-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParentParent = scriptParent.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Object = require(scriptParentParentParentParentParent.LuauPolyfill).Object

local ResponsiveLayoutContext = require(scriptParent.ResponsiveLayoutContext)
local ResponsiveLayoutConfigReader = require(scriptParent.ResponsiveLayoutConfigReader)

local var1 = Roact.PureComponent:extend("ResponsiveBaseRow")

local function multilineScrollingValidator(props)
    if props.multiLine and props.scrollable then
        return false, "multiLine can't be scrollable"
    end
    return true
end

local strictInterface = t.strictInterface
local tbl1 = {
    kind = t.optional(t.string),
    layoutOrder = t.optional(t.integer),
    zIndex = t.optional(t.number),
    scrollable = t.optional(t.boolean),
    clipsDescendants = t.optional(t.boolean),
    selectable = t.optional(t.boolean),
    pages = t.optional(t.numberPositive),
    multiLine = t.optional(t.boolean),
    lines = t.optional(t.intersection(t.integer, t.numberMin(0))),
    paddingTopLines = t.optional(t.intersection(t.integer, t.numberMin(0))),
    relativeHeight = t.optional(t.UDim),
    scrollingFrameRef = t.optional(t.table),
    [Roact.Children] = t.optional(t.table),
    gridBasicRowRef = t.optional(t.union(t.table, t.callback))
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = {
    kind = "default",
    scrollable = false,
    selectable = false,
    clipsDescendants = true,
    multiLine = false
}

function var1.renderChildrenWithPadding(arg1, offset: number?, arg2)
    local lines = arg1.props.lines or 1
    local paddingTopLines = arg1.props.paddingTopLines or 0
    local assign = Object.assign
    local tbl2 = {
        _uiblox_grid_padding_ = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, offset),
            PaddingRight = UDim.new(0, offset),
            PaddingTop = if arg1.props.multiLine and paddingTopLines > 0 and lines > 0 then UDim.new(paddingTopLines / lines, paddingTopLines / lines * arg2) else nil
        })
    }
    return assign(tbl2, arg1.props[Roact.Children])
end

function var1.renderChildrenMultiline(arg1, fillDirectionMaxCells, arg2, xOffset, yOffset)
    local lines = arg1.props.lines or 1
    if arg1.props.paddingTopLines then
        lines -= arg1.props.paddingTopLines
    end
    local num1 = math.max(lines, 1)
    local assign = Object.assign
    local tbl2 = {
        _uiblox_grid_layout_ = Roact.createElement("UIGridLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirectionMaxCells = fillDirectionMaxCells,
            CellSize = UDim2.new(
                1 / fillDirectionMaxCells,
                math.floor((1 - fillDirectionMaxCells) / fillDirectionMaxCells * xOffset),
                1 / num1,
                math.floor((1 - num1) / num1 * yOffset)
            ),
            CellPadding = UDim2.fromOffset(xOffset, yOffset)
        })
    }
    return assign(tbl2, arg1:renderChildrenWithPadding(arg2, yOffset))
end

function var1.renderChildren(arg1, arg2, arg3, offset: number?, arg4)
    local var2 = Object.assign({
        _uiblox_grid_layout_ = Roact.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, offset)
            }
        )
    }, arg1:renderChildrenWithPadding(arg3, arg4))

    if not arg2 then
        return var2
    end

    local pages = arg1.props.pages or 1
    local tbl2 = {
        ResponsiveRowScroller = Roact.createElement("ScrollingFrame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ScrollingDirection = Enum.ScrollingDirection.X,
            ScrollBarThickness = 0,
            CanvasSize = UDim2.new(pages, (pages - 1) * (offset - 2 * arg3), 1, 0),
            AutomaticCanvasSize = arg1.props.pages and Enum.AutomaticSize.None or Enum.AutomaticSize.X,
            Selectable = arg1.props.selectable,
            ClipsDescendants = arg1.props.clipsDescendants,
            [Roact.Ref] = arg1.props.scrollingFrameRef
        }, var2)
    }
    return tbl2
end

local function applyUDim(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.Scale * arg2 + arg1.Offset
end

function var1.getSize(arg1, arg2, arg3, arg4, arg5, arg6)
    if arg2 == nil then
        return UDim2.fromScale(1, 0)
    end
    local yScale = arg2.Scale / arg6

    local yOffset = applyUDim(arg2, (arg3 - 2 * arg5) / arg6 - arg3)

    if arg1.props.multiLine and arg1.props.lines then
        if arg1.props.lines == 0 then
            return UDim2.fromScale(1, 0)
        end
        yScale *= arg1.props.lines
        yOffset = yOffset * arg1.props.lines + (arg1.props.lines - 1) * arg4
    end
    return UDim2.new(1, 0, yScale, yOffset)
end

function var1.render(arg1)
    assert(multilineScrollingValidator(arg1.props))
    local relativeHeight = arg1.props.relativeHeight
    local scrollable = arg1.props.scrollable
    local multiLine = arg1.props.multiLine
    local str1 = if arg1.props.layoutOrder then string.format("ResponsiveRow%02d", arg1.props.layoutOrder) else "ResponsiveRow"

    return Roact.createElement(ResponsiveLayoutContext.Consumer, {
        render = function(arg2)
            local var2 = Object.assign({}, arg2, {
                kind = arg1.props.kind or Object.None,
                scrollable = scrollable,
                pages = arg1.props.pages or 1,
                multiLine = multiLine,
                relativeHeight = relativeHeight,
                subPixelOffset = 0
            })

            if not relativeHeight then
                relativeHeight = ResponsiveLayoutConfigReader.getValue(var2, "relativeHeight")
                var2.relativeHeight = relativeHeight
            end
            local value = ResponsiveLayoutConfigReader.getValue(var2, "width")
            local value2 = ResponsiveLayoutConfigReader.getValue(var2, "gutter") or 0
            local var3 = ResponsiveLayoutConfigReader.getValue(var2, "verticalGutter") or value2
            local value3 = ResponsiveLayoutConfigReader.getValue(var2, "margin") or 0
            local value4 = ResponsiveLayoutConfigReader.getValue(var2, "columns") or 1
            local var4 = relativeHeight and (not multiLine or arg1.props.lines)
            local size = arg1:getSize(relativeHeight, value2, var3, value3, value4)
            local createElement = Roact.createElement
            local provider = ResponsiveLayoutContext.Provider
            local tbl2 = { value = var2 }
            local tbl3 = {}
            local str2 = str1
            tbl3[str2] = Roact.createElement(
                "Frame",
                {
                    Size = size,
                    SizeConstraint = Enum.SizeConstraint.RelativeXX,
                    AutomaticSize = if var4 then Enum.AutomaticSize.None else Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    LayoutOrder = arg1.props.layoutOrder,
                    ZIndex = arg1.props.zIndex,
                    [Roact.Ref] = arg1.props.gridBasicRowRef
                },
                Object.assign(
                    {
                        _uiblox_grid_maxwidth_ = if value then Roact.createElement(
                            "UISizeConstraint",
                            {
                                MaxSize = Vector2.new(value, not relativeHeight and math.huge or applyUDim(size.Y, value))
                            }
                        ) else nil
                    },
                    if multiLine then arg1:renderChildrenMultiline(value4, value3, value2, var3) else arg1:renderChildren(scrollable, value3, value2, var3)
                )
            )
            return createElement(provider, tbl2, tbl3)
        end
    })
end

return Roact.forwardRef(function(arg1, gridBasicRowRef)
    return Roact.createElement(var1, Object.assign({}, arg1, { gridBasicRowRef = gridBasicRowRef }))
end)
