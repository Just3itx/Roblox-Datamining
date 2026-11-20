-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Services = require(Foundation.Utility.Wrappers.Services)

local SliderStepDirection = require(Foundation.Components.Slider.SliderStepDirection)

local calculateAdjacentStepValue = require(Foundation.Components.Slider.calculateAdjacentStepValue)
local constants = require(Foundation.Components.Slider.constants)

local function getStepSignForKeyCode(keyCode: Enum.KeyCode, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = if bool1 then "vertical" else "horizontal"

    if table.find(constants.stepIncrement[str1], keyCode) then
        return 1
    end

    if table.find(constants.stepDecrement[str1], keyCode) then
        return -1
    end

    return nil
end

local function isExitKey(keyCode): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return table.find(constants.exit, keyCode) ~= nil
end

local function getRepeatInterval(num1: number, step: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if step == nil or not (step > 0) then if num1 >= 15 then 0.03 elseif num1 >= 5 then 0.06 else 0.1 else 0.1
end

local function useSliderDirectionalInput(bool1: boolean, step: number?, numberRange: NumberRange, bool2: boolean, handlers)
    local var1 = React.useRef({ step = step, range = numberRange, handlers = handlers })

    var1.current = { step = step, range = numberRange, handlers = handlers }

    React.useEffect(function()
        if not bool1 then
            return
        end

        local currentInput = nil
        local num1 = 0
        local var2 = nil
        local num2 = 0
        local num3 = 0

        local function performStep(num4: number) -- Luacid: Inlined by compiler; 2 call sites recovered
            local current = var1.current
            local var3 = if num4 > 0 then SliderStepDirection.Increment else SliderStepDirection.Decrement
            current.handlers.onStep(calculateAdjacentStepValue(current.handlers.getValue(), var3, current.range, current.step))
        end

        local function stopStepping(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
            if arg1 ~= nil and arg1 ~= currentInput then
                return
            end
            currentInput = nil
            num1 = 0
            if var2 then
                task.cancel(var2)
                var2 = nil
            end
        end

        local function startStepping(inputObject: InputObject, num4: number)
            if inputObject == currentInput and num4 == num1 then
                return
            end

            stopStepping(nil)
            currentInput = inputObject
            num1 = num4
            performStep(num4)

            var2 = task.spawn(function()
                task.wait(0.4)
                local num5 = 0

                while currentInput == inputObject and num1 == num4 do
                    performStep(num4)
                    num5 += 1
                    task.wait((getRepeatInterval(num5, var1.current.step)))
                end
            end)
        end

        local function evaluateInput(input: InputObject)
            if isExitKey(input.KeyCode) then
                var1.current.handlers.onExit()
                return
            end

            local stepSignForKeyCode = getStepSignForKeyCode(input.KeyCode, bool2)
            if stepSignForKeyCode then
                startStepping(input, stepSignForKeyCode)
                return
            end

            if not table.find(constants.analogStep, input.KeyCode) then
                return
            end

            local num4 = if bool2 then input.Position.Y else input.Position.X

            if not (math.abs(num4) >= constants.thumbstickDeadzone) then
                num2 = 0
                num3 = 0
                stopStepping(input)
                return
            end

            local num5 = if num4 > 0 then 1 else -1
            local bool3 = not (num2 == 0) and num5 ~= num2
            num3 = if bool3 then num3 + 1 else 0

            if bool3 and num3 < 3 then
                stopStepping(input)
                return
            end

            num2 = num5
            startStepping(input, num5)
        end

        local function handleInputEnded(input: InputObject)
            if table.find(constants.analogStep, input.KeyCode) then
                num2 = 0
                num3 = 0
            end

            stopStepping(input)
        end

        local tbl1 = { Services.UserInputService.InputBegan:Connect(evaluateInput), Services.UserInputService.InputChanged:Connect(evaluateInput), Services.UserInputService.InputEnded:Connect(handleInputEnded) }

        return function()
            stopStepping(nil)

            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, { bool1, bool2 })
end

return useSliderDirectionalInput
