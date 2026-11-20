-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local React = require(scriptParentParentParentParent.React)
local Change = React.Change

local var1 = React.Component:extend("ScrollContentViewNativeComponent")

function var1.init(arg1, props)
    arg1.props = props
end

function var1.render(arg1)
    local var2 = if Array.isArray(arg1.props.style) then Array.reduce(arg1.props.style, function(arg2, arg3)
        return Object.assign(arg2, arg3)
    end, {}) else arg1.props.style

    local var3 = Object.assign({
        Name = "RCTScrollContentView",
        [Change.AbsoluteSize] = arg1.props.onLayout,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0)
    }, arg1.props.AutomaticSize and {
        AutomaticSize = arg1.props.AutomaticSize
    } or nil, var2)

    return React.createElement("Frame", var3, arg1.props.children)
end

return var1
