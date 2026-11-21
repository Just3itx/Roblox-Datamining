-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarViewport = script:FindFirstAncestor("AvatarViewport")
local Constants = require(AvatarViewport.Constants)

local GetFIntAvatarViewportGamepadYawDegreesPerSecond = require(AvatarViewport.Flags.GetFIntAvatarViewportGamepadYawDegreesPerSecond)

local GetFIntAvatarViewportGamepadZoomGestureSpeedPerSecond = require(AvatarViewport.Flags.GetFIntAvatarViewportGamepadZoomGestureSpeedPerSecond)

local function getThumbstickAxis(vector2: Vector2, magnitude: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if vector2.Magnitude < magnitude then
        return 0
    end

    local num1 = math.abs(math.cos(math.atan2(vector2.Y, vector2.X)) * magnitude)
    return math.max(math.abs(vector2.X) - num1, 0) / (1 - num1) * math.sign(vector2.X)
end

local function getThumbstickAxisY(vector2: Vector2, magnitude: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if vector2.Magnitude < magnitude then
        return 0
    end

    local num1 = math.abs(math.sin(math.atan2(vector2.Y, vector2.X)) * magnitude)
    return math.max(math.abs(vector2.Y) - num1, 0) / (1 - num1) * math.sign(vector2.Y)
end

return {
    getThumbstickAxis = getThumbstickAxis,
    getThumbstickAxisY = getThumbstickAxisY,
    computeYawDeltaDegrees = function(vector2: Vector2, num1: number, num2: number, magnitude: number)
        local thumbstickAxis = getThumbstickAxis(vector2, magnitude)

        if thumbstickAxis == 0 then
            return 0
        end

        return -thumbstickAxis * num2 * num1
    end,
    computeZoomGestureDelta = function(vector2: Vector2, num1: number, num2: number, magnitude: number, num3: number): number
        local thumbstickAxisY = getThumbstickAxisY(vector2, magnitude)
        return if math.abs(thumbstickAxisY) < num3 then 0 else thumbstickAxisY * num2 * num1
    end,
    isRotating = function(vector2: Vector2, magnitude: number): boolean
        return getThumbstickAxis(vector2, magnitude) ~= 0
    end,
    defaultDeadzone = Constants.GamepadThumbstickDeadzone,
    getDefaultYawSpeedDegPerSecond = GetFIntAvatarViewportGamepadYawDegreesPerSecond,
    getDefaultZoomGestureSpeedPerSecond = GetFIntAvatarViewportGamepadZoomGestureSpeedPerSecond,
    defaultZoomAxisThreshold = Constants.GamepadZoomAxisThreshold
}
