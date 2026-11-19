-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function blendTransparencies(num1: number?, num2: number?)
    if num1 == nil then
        return num2 or 0
    end

    if num2 == nil then
        return num1 or 0
    end

    return 1 - (1 - num1) * (1 - num2)
end

return blendTransparencies
