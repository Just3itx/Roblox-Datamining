-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    Color3.fromRGB(245, 190, 240),
    Color3.fromRGB(192, 206, 251),
    Color3.fromRGB(145, 223, 188),
    Color3.fromRGB(63, 64, 70),
    Color3.fromRGB(250, 212, 106)
}

return function(num1: number)
    return tbl1[num1 % #tbl1 + 1]
end
