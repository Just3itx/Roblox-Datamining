-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local ReactUtils = require(scriptParentParentParent.ReactUtils)

local mockStyleComponent = require(scriptParentParent.Utility.mockStyleComponent)
local render = require(scriptParentParentParent.Dev.ReactTestingLibrary).render

local benchmark = require(scriptParentParentParent.Dev.JestBenchmark).benchmark

function measureFPS(arg1, num1: number?)
    task.wait()
    task.wait()
    arg1.start("fps")
    task.wait(num1 or 0.5)
    arg1.stop()
end

function mountComponentTimes(arg1, num1: number, str1: string)
    local tbl1 = ({})
    for i = 1, num1 do
        tbl1[i] = arg1
    end
    local var1 = mockStyleComponent(tbl1)

    benchmark(`Mount {str1} {num1} times`, function()
        render(var1):unmount()
    end)
end

function AutoScrollingFrame(arg1)
    local var1 = ReactUtils.useClock()

    return React.createElement("ScrollingFrame", {
        Size = UDim2.fromOffset(100, 100),
        CanvasSize = UDim2.fromOffset(100, 0),
        CanvasPosition = var1:map(function(num1: number): Vector2
            return Vector2.new(0, num1 * 10000)
        end),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, arg1.children)
end

function scrollComponentTimes(arg1, num1: number, str1: string)
    local tbl1 = ({})
    for i = 1, num1 do
        tbl1[i] = arg1
    end

    tbl1[num1 + 1] = React.createElement("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        FillDirection = Enum.FillDirection.Vertical
    })

    local var1 = mockStyleComponent(React.createElement(AutoScrollingFrame, {}, tbl1))

    benchmark(`Scroll {str1} {num1} times`, function(arg2)
        local var2 = render(var1)
        measureFPS(arg2)
        var2:unmount()
    end)
end

return {
    mountComponentTimes = mountComponentTimes,
    scrollComponentTimes = scrollComponentTimes,
    measureFPS = measureFPS
}
