-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("AXSetAngularVelocityIsOptional", false)

local module = {}

function module.normalizeStickByDeadzone(vector2: Vector2, num1: number?)
    local magnitude = vector2.Magnitude
    local num2 = num1 or 0.2
    if magnitude < num2 then
        return Vector2.new(0, 0)
    end
    return (magnitude - num2) / (1 - num2) * vector2.Unit
end

function module.rotateAndZoom(arg1, num1: number, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?, callback3: ((...any) -> (...any))?)
    local var1 = module.normalizeStickByDeadzone(Vector2.new(arg1.Position.X, arg1.Position.Y))
    if var1 == Vector2.new(0, 0) then
        return
    end
    if not bool1 or callback then
        callback(0)
    end
    if callback2 and math.abs(var1.X) > 0.5 then
        callback2(num1 * var1.X * math.rad(120))
    end

    if callback3 and math.abs(var1.Y) > 0.5 then
        callback3(num1 * -var1.Y * 10)
    end
end

function module.mapPositionToDirection(vector2: Vector2)
    local var1 = module.normalizeStickByDeadzone(vector2)
    local x = var1.X
    local y = var1.Y

    if x * x + y * y > 0.25 then
        local num1 = math.atan2(y, x)

        if num1 > -math.rad(135) and num1 <= -(math.pi / 4) then
            return Enum.KeyCode.Down
        end

        if num1 > -(math.pi / 4) and num1 <= math.pi / 4 then
            return Enum.KeyCode.Right
        end

        if num1 > math.pi / 4 and num1 <= math.rad(135) then
            return Enum.KeyCode.Up
        end

        if num1 > math.rad(135) or num1 <= -math.rad(135) then
            return Enum.KeyCode.Left
        end
    end

    return nil
end

return module
