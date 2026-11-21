-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.mouseMovement(position: vector?)
    return {
        UserInputType = Enum.UserInputType.MouseMovement,
        Position = position or Vector3.new(0, 0, 0)
    }
end

function module.mouseButton1(position: vector?)
    return {
        UserInputType = Enum.UserInputType.MouseButton1,
        Position = position or Vector3.new(0, 0, 0)
    }
end

function module.mouseButton2(position: vector?)
    return {
        UserInputType = Enum.UserInputType.MouseButton2,
        Position = position or Vector3.new(0, 0, 0)
    }
end

function module.mouseWheel(z: number)
    return {
        UserInputType = Enum.UserInputType.MouseWheel,
        Position = Vector3.new(0, 0, z)
    }
end

function module.touch(position: vector?)
    return {
        UserInputType = Enum.UserInputType.Touch,
        Position = position or Vector3.new(0, 0, 0)
    }
end

function module.keyboard()
    return {
        UserInputType = Enum.UserInputType.Keyboard
    }
end

return module
