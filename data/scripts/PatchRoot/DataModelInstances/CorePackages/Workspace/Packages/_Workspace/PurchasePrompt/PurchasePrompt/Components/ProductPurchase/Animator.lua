-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local Roact = PurchasePromptDeps.Roact
local Otter = PurchasePromptDeps.Otter
local t = PurchasePromptDeps.t

local var1 = Roact.Component:extend(script.Name)

local tbl1 = { dampingRatio = 1, frequency = 1.6 }

var1.validateProps = t.interface({
    shouldShow = t.boolean,
    skipAnimation = t.optional(t.boolean),
    onShown = t.optional(t.callback),
    onHidden = t.optional(t.callback)
})

function var1.init(arg1)
    local animationProgress, setProgress = Roact.createBinding(1)

    arg1.motor = Otter.createSingleMotor(1)
    arg1.motor:start()

    arg1.motor:onStep(setProgress)
    arg1.animationProgress = animationProgress
    arg1.setProgress = setProgress

    function arg1.onComplete()
        if arg1.props.shouldShow then
            if arg1.props.onShown then
                arg1.props.onShown()
            end
        elseif arg1.props.onHidden then
            arg1.props.onHidden()
        end
    end

    arg1.motor:onComplete(arg1.onComplete)

    local num1 = if arg1.props.shouldShow then 0 else 1
    if not arg1.props.skipAnimation then
        arg1.motor:setGoal(Otter.spring(num1, tbl1))

        return
    end

    arg1.motor:stop()
    setProgress(num1)
    task.defer(function()
        arg1.onComplete()
    end)
end

function var1.didUpdate(arg1, arg2, _)
    if arg2.shouldShow == arg1.props.shouldShow and arg2.skipAnimation == arg1.props.skipAnimation then
        return
    end

    local num1 = if arg1.props.shouldShow then 0 else 1
    if not arg1.props.skipAnimation then
        arg1.motor:setGoal(Otter.spring(num1, tbl1))
        return
    end

    arg1.motor:stop()
    arg1.setProgress(num1)
    task.defer(function()
        arg1.onComplete()
    end)
end

function var1.render(arg1)
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = arg1.animationProgress:map(function(arg2): UDim2
            return UDim2.new(0, 0, -1 * arg2, 0)
        end)
    }, arg1.props[Roact.Children])
end

return var1
