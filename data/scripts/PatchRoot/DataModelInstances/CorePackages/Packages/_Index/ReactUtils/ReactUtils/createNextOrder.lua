-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createNextOrder(): () -> number
    local num1 = 0

    return function(): number
        num1 += 1
        return num1
    end
end

return createNextOrder
