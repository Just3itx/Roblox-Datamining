-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParent.Parent.t)
local SlidingDirection = require(scriptParent.Enum.SlidingDirection)
local SpringAnimatedItem = require(scriptParentParentParent.Utility.SpringAnimatedItem)

local var1 = Roact.PureComponent:extend("SlidingContainer")

local tbl1 = {
    [SlidingDirection.Up] = UDim2.new(0, 0, 1, 0),
    [SlidingDirection.Down] = UDim2.new(0, 0, -1, 0),
    [SlidingDirection.Left] = UDim2.new(1, 0, 0, 0),
    [SlidingDirection.Right] = UDim2.new(-1, 0, 0, 0)
}

var1.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.integer),
    onComplete = t.optional(t.callback),
    show = t.optional(t.boolean),
    slidingDirection = SlidingDirection.isEnumValue,
    springOptions = t.optional(t.table),
    [Roact.Children] = t.optional(t.table)
})
var1.defaultProps = {
    springOptions = { dampingRatio = 1, frequency = 4 }
}

function var1.render(arg1)
    local show = arg1.props.show
    local slidingDirection = arg1.props.slidingDirection

    return Roact.createElement(SpringAnimatedItem.AnimatedFrame, {
        springOptions = arg1.props.springOptions,
        animatedValues = {
            step = if show then 0 else 1
        },
        mapValuesToProps = function(arg2)
            local var2 = tbl1[slidingDirection]
            return {
                Position = UDim2.new(var2.X.Scale * arg2.step, 0, var2.Y.Scale * arg2.step, 0)
            }
        end,
        regularProps = {
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.layoutOrder,
            Position = show and tbl1[slidingDirection] or UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0)
        },
        onComplete = arg1.props.onComplete,
        [Roact.Children] = arg1.props[Roact.Children]
    })
end

return var1
