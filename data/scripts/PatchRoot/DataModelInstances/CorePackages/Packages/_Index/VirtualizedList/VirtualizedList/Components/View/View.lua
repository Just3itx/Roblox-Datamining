-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local React = require(scriptParentParentParentParent.React)
local Change = React.Change

local var1 = React.Component:extend("View")
function var1.init(tbl1, props)
    tbl1.props = props
    tbl1._nativeRef = tbl1.props.nativeRef or React.createRef()
end

function var1.render(arg1)
    local var2 = if Array.isArray(arg1.props.style) then Array.reduce(arg1.props.style, function(arg2, arg3)
        return Object.assign(arg2, arg3)
    end, {}) else arg1.props.style

    local var3 = Object.assign(table.clone(arg1.props), var2)

    arg1.nativeProps = {
        ref = arg1._nativeRef,
        BackgroundColor3 = var3.BackgroundColor3,
        Name = var3.Name or "View",
        Size = var3.Size or UDim2.new(1, 0, 0, 0),
        AutomaticSize = var3.AutomaticSize or Enum.AutomaticSize.Y,
        ZIndex = var3.ZIndex or nil,
        LayoutOrder = var3.LayoutOrder or nil,
        BorderSizePixel = var3.BorderSizePixel or 0,
        BackgroundTransparency = var3.BackgroundTransparency or 1,
        SelectionGroup = var3.SelectionGroup,
        SelectionBehaviorLeft = var3.SelectionBehaviorLeft,
        SelectionBehaviorRight = var3.SelectionBehaviorRight,
        SelectionBehaviorUp = var3.SelectionBehaviorUp,
        SelectionBehaviorDown = var3.SelectionBehaviorDown,
        [Change.AbsoluteSize] = var3.onLayout
    }
    return React.createElement("Frame", arg1.nativeProps, arg1.props.children)
end

return var1
