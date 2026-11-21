-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Constants)

local module = {}

function module.clampYRotDeg(num1: number): number
    return math.clamp(num1, -Constants.YRotMaxDeg, Constants.YRotMaxDeg)
end

function module.clampDistanceScale(num1: number): number
    return math.clamp(num1, Constants.ZoomMinScale, Constants.ZoomMaxScale)
end

function module.getSliderValueFromYRotDeg(num1: number): number
    return math.clamp(num1 * Constants.SliderMax / Constants.YRotMaxDeg, -Constants.SliderMax, Constants.SliderMax)
end

function module.getYRotDegFromSliderValue(num1: number): number
    return math.clamp(num1 * Constants.YRotMaxDeg / Constants.SliderMax, -Constants.YRotMaxDeg, Constants.YRotMaxDeg)
end

function module.getCameraDistanceScaleFromSliderValue(num1: number)
    local var1 = -num1 / Constants.SliderMax + 1
    return (1 - Constants.ZoomMinScale) * var1 * var1 + Constants.ZoomMinScale
end

function module.getSliderValueFromCameraDistanceScale(num1: number): number
    return math.clamp(
        (math.sqrt(math.max(0, (num1 - Constants.ZoomMinScale) / (1 - Constants.ZoomMinScale))) - 1) * -Constants.SliderMax,
        -Constants.SliderMax,
        Constants.SliderMax
    )
end

function module.adjustDistanceScaleByZoomGesture(num1: number, num2: number)
    local num3 = math.clamp(module.getSliderValueFromCameraDistanceScale(num1) + num2 * 2, -Constants.SliderMax, Constants.SliderMax)
    return module.clampDistanceScale(module.getCameraDistanceScaleFromSliderValue(num3))
end

function module.adjustDistanceScaleBySliderStep(num1: number, num2: number)
    local num3 = math.clamp(module.getSliderValueFromCameraDistanceScale(num1) + num2, -Constants.SliderMax, Constants.SliderMax)
    return module.clampDistanceScale(module.getCameraDistanceScaleFromSliderValue(num3))
end

module.PINCH_DELTA_TO_ZOOM_DELTA = 0.05

return module
