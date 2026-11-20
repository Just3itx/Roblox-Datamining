-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Otter = require(scriptParentParentParentParentParent.Otter)

local tbl1 = { dampingRatio = 1, frequency = 3.5 }

local var1 = Roact.PureComponent:extend("IntroScroll")

var1.validateProps = t.strictInterface({ childWidgetIndex = t.number, scrollingFrameRef = t.table, updateCanvasPosition = t.callback })

function var1.init(arg1)
    arg1.motor = Otter.createSingleMotor(0)
    arg1.motor:onStep(function(x: number?)
        arg1.props.updateCanvasPosition(Vector2.new(x, 0))
    end)
end

function var1.didUpdate(arg1, arg2, _)
    if not arg1.props.childWidgetIndex or arg1.props.childWidgetIndex == arg2.childWidgetIndex then
        return
    end

    local current = arg1.props.scrollingFrameRef.current
    local num1 = math.clamp(current.AbsoluteCanvasSize.X - current.AbsoluteSize.X, 0, current.AbsoluteSize.X * 0.25)

    arg1.motor:setGoal(Otter.instant(num1))
    arg1.motor:step(0)

    arg1.motor:setGoal(arg1:getGoal())
end

function var1.getGoal(_, _)
    return Otter.spring(0, tbl1)
end

function var1.render(_)
    return nil
end

function var1.willUnmount(arg1)
    if arg1.motor then
        arg1.motor:destroy()
        arg1.motor = nil
    end
end

return var1
