-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local _Types = require(Foundation.Components.Types)

return {
    calculateSVFromPosition = function(vector2: Vector2, vector2_2: Vector2, vector2_3: Vector2)
        local num1 = math.clamp(vector2.X - vector2_2.X, 0, vector2_3.X)
        local num2 = math.clamp(vector2.Y - vector2_2.Y, 0, vector2_3.Y)

        return num1 / vector2_3.X, 1 - num2 / vector2_3.Y
    end,
    createHSVUpdateHandler = function(callback, callback2, callback3, callback4, arg1): (number, number, number) -> ()
        return function(hue: number, saturation: number, num1: number)
            arg1.current = true
            callback(hue)
            callback2(saturation)
            callback3(num1)

            local color3 = Color3.fromHSV(hue, saturation, num1)
            callback4(color3)

            arg1.current = false
        end
    end,
    createColorInputChangeHandler = function(callback, arg1, callback2, callback3, callback4): (Color3) -> ()
        return function(color3: Color3)
            callback(color3)

            if not arg1.current then
                local hue, saturation, value = color3:ToHSV()
                callback2(hue)
                callback3(saturation)
                callback4(value)
            end
        end
    end,
    isPartialHSV = function(arg1): boolean
        return not (typeof(arg1) == "Color3") and (arg1.S == nil or arg1.V == nil)
    end,
    toColor3 = function(arg1): Color3
        if typeof(arg1) == "Color3" then
            return arg1
        end

        return Color3.fromHSV(arg1.H / 360, (arg1.S or 100) / 100, (arg1.V or 100) / 100)
    end
}
