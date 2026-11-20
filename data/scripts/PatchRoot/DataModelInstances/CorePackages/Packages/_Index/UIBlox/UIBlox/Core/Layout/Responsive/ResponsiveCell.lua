-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParentParent = scriptParent.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Object = require(scriptParentParentParentParentParent.LuauPolyfill).Object

local ResponsiveLayoutContext = require(scriptParent.ResponsiveLayoutContext)
local ResponsiveLayoutConfigReader = require(scriptParent.ResponsiveLayoutConfigReader)

local var1 = Roact.PureComponent:extend("ResponsiveCell")

local interface = t.interface
local tbl1 = {
    layoutOrder = t.optional(t.integer),
    zIndex = t.optional(t.integer),
    colspan = t.optional(t.union(t.integer, t.table)),
    rowspan = t.optional(t.union(t.integer, t.table)),
    order = t.optional(t.union(t.integer, t.table)),
    [Roact.Children] = t.optional(t.table),
    gridCellRef = t.optional(t.union(t.table, t.callback))
}
var1.validateProps = interface(tbl1)

local function findProp(props, str1: string, arg1)
    arg1 = if arg1 == nil then "default" else arg1

    if props[str1 .. "_" .. arg1] ~= nil then
        return props[str1 .. "_" .. arg1]
    end
    if props[str1] == nil then
        return nil
    end

    if type(props[str1]) == "table" then
        if props[str1][arg1] == nil then
            return props[str1].default
        end

        return props[str1][arg1]
    end

    return props[str1]
end

function var1.getColspan(arg1, arg2)
    local prop = findProp(arg1.props, "colspan", arg2)
    return if prop == nil then 1 else prop
end

function var1.getRowspan(arg1, arg2)
    local prop = findProp(arg1.props, "rowspan", arg2)
    return if prop == nil then 1 else prop
end

function var1.getOrder(arg1, arg2)
    if arg1.props.layoutOrder then
        return arg1.props.layoutOrder
    end
    return (findProp(arg1.props, "order", arg2))
end

local function round(arg1, arg2): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = math.floor(arg1)
    arg2.subPixelOffset += arg1 - num1
    local num2 = math.floor(arg2.subPixelOffset + 0.5)
    arg2.subPixelOffset -= num2
    return num1 + num2
end

function var1.getSize(_, xScale: number?, yScale: number?, arg1): UDim2
    local value = ResponsiveLayoutConfigReader.getValue(arg1, "gutter") or 0
    if arg1.multiLine then
        local var2 = ResponsiveLayoutConfigReader.getValue(arg1, "verticalGutter") or value

        return UDim2.new(xScale, (xScale - 1) * value, yScale, (yScale - 1) * var2)
    end
    local value2 = ResponsiveLayoutConfigReader.getValue(arg1, "columns") or 1
    if arg1.scrollable then
        value2 *= math.max(arg1.pages, 1)
    end

    return UDim2.new(xScale / value2, round((xScale / value2 - 1) * value, arg1), 1, 0)
end

function var1.render(arg1)
    return Roact.createElement(ResponsiveLayoutContext.Consumer, {
        render = function(arg2)
            local colspan = arg1:getColspan(arg2.breakpoint)
            local var2 = if arg2.multiLine then arg1:getRowspan(arg2.breakpoint) else 1
            if not (colspan > 0 and var2 > 0) then
                return nil
            end

            local layoutOrder = arg1:getOrder(arg2.breakpoint)
            local str1 = if layoutOrder then string.format("ResponsiveCell%02d", layoutOrder) else "ResponsiveCell"
            local var3 = arg2.multiLine and (colspan > 1 or var2 > 1)
            local responsiveCellInner = Roact.createElement("Frame", {
                Name = if var3 then nil else str1,
                Size = arg1:getSize(colspan, var2, arg2),
                AutomaticSize = if arg2.relativeHeight then Enum.AutomaticSize.None else Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = layoutOrder,
                ZIndex = arg1.props.zIndex,
                [Roact.Ref] = arg1.props.gridCellRef
            }, arg1.props[Roact.Children])

            if not var3 then
                return responsiveCellInner
            end

            return Roact.createElement(
                "Frame",
                { Name = str1, BackgroundTransparency = 1, LayoutOrder = layoutOrder },
                { ResponsiveCellInner = responsiveCellInner }
            )
        end
    })
end

return Roact.forwardRef(function(arg1, gridCellRef)
    return Roact.createElement(var1, Object.assign({}, arg1, { gridCellRef = gridCellRef }))
end)
