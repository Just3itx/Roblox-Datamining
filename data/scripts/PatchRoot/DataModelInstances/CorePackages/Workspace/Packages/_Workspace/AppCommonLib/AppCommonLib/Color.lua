-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.RgbFromHex(arg1): (number, number, number)
    assert(arg1 >= 0 and arg1 <= 16777215, "RgbFromHex: Out of range")

    local var1 = arg1 % 256
    arg1 = (arg1 - var1) / 256
    local var2 = arg1 % 256
    return (arg1 - var2) / 256, var2, var1
end

function module.Color3FromHex(arg1): Color3
    return Color3.fromRGB(module.RgbFromHex(arg1))
end

return module
