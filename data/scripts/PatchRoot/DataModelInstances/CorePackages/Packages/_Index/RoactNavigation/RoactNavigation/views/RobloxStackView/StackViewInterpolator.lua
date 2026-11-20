-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local getSceneIndicesForInterpolationInputRange = require(scriptParentParentParent.utils.getSceneIndicesForInterpolationInputRange)
local lerp = require(scriptParentParentParent.utils.lerp)

local function forInitial(arg1)
    local forceHidden = arg1.initialPositionValue ~= arg1.scene.index
    local num1 = if forceHidden then 1000000 else 0

    return {
        forceHidden = forceHidden,
        initialPosition = UDim2.new(0, num1, 0, num1),
        positionStep = nil
    }
end

return {
    forHorizontal = function(arg1)
        local initialPositionValue = arg1.initialPositionValue
        local layout = arg1.layout
        local scene = arg1.scene

        if not layout.isMeasured then
            return (forInitial(arg1))
        end

        local sceneIndicesForInterpolationInputRange = getSceneIndicesForInterpolationInputRange(arg1)

        if not sceneIndicesForInterpolationInputRange then
            return {
                forceHidden = true,
                initialPosition = UDim2.new(0, 100000, 0, 100000),
                positionStep = nil
            }
        end

        local first = sceneIndicesForInterpolationInputRange.first
        local last = sceneIndicesForInterpolationInputRange.last
        local index = scene.index

        local initWidth = layout.initWidth

        local function calculate(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
            if arg2 < first then
                return initWidth
            elseif arg2 < index then
                return lerp(initWidth, 0, (arg2 - first) / (index - first))
            elseif arg2 == index then
                return 0
            elseif arg2 < last then
                return lerp(0, -initWidth, (arg2 - index) / (last - index))
            end
            return -initWidth
        end

        local function stepper(arg2, arg3)
            local current = arg2.current
            if not current then
                return
            end

            local currentPosition = current.Position
            current.Position = UDim2.new(currentPosition.X.Scale, calculate(arg3), currentPosition.Y.Scale, currentPosition.Y.Offset)
        end

        return {
            initialPosition = UDim2.new(0, calculate(initialPositionValue), 0, 0),
            positionStep = stepper
        }
    end,
    forVertical = function(arg1)
        local initialPositionValue = arg1.initialPositionValue
        local layout = arg1.layout
        local scene = arg1.scene

        if not layout.isMeasured then
            return (forInitial(arg1))
        end

        local sceneIndicesForInterpolationInputRange = getSceneIndicesForInterpolationInputRange(arg1)

        if not sceneIndicesForInterpolationInputRange then
            return {
                forceHidden = true,
                initialPosition = UDim2.new(0, 100000, 0, 100000),
                positionStep = nil
            }
        end

        local first = sceneIndicesForInterpolationInputRange.first
        local index = scene.index
        local initHeight = layout.initHeight

        local function calculate(arg2)
            if arg2 < first then
                return initHeight
            elseif arg2 < index then
                return lerp(initHeight, 0, (arg2 - first) / (index - first))
            end
            return 0
        end

        return {
            initialPosition = UDim2.new(0, 0, 0, calculate(initialPositionValue)),
            positionStep = function(arg2, arg3) -- name: stepper
                local current = arg2.current
                if not current then
                    return
                end

                local currentPosition = current.Position
                current.Position = UDim2.new(currentPosition.X.Scale, currentPosition.X.Offset, currentPosition.Y.Scale, calculate(arg3))
            end
        }
    end,
    forFade = function(arg1)
        local initialPositionValue = arg1.initialPositionValue
        local layout = arg1.layout
        local scene = arg1.scene

        if not layout.isMeasured then
            return (forInitial(arg1))
        end

        if not getSceneIndicesForInterpolationInputRange(arg1) then
            return {
                forceHidden = true,
                initialPosition = UDim2.new(0, 100000, 0, 100000),
                positionStep = nil
            }
        end

        local index = scene.index

        local function calculate(arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
            return index - 0.5 <= arg2
        end

        return {
            forceHidden = not calculate(initialPositionValue),
            initialPosition = UDim2.new(0, 0, 0, 0),
            positionStep = function(arg2, arg3) -- name: stepper
                local current = arg2.current
                if not current then
                    return
                end

                current.Visible = not not calculate(arg3)
            end
        }
    end
}
