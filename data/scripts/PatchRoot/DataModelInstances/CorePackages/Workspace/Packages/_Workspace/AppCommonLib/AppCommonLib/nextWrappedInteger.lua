-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(num1: number): number
    local num2 = num1 + 1
    return if num2 >= 2 ^ 53 then 0 else num2
end
