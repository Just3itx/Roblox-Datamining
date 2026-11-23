-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(num1: number?, num2: number?, num3: number?)
    if not num1 or not num2 or not num3 or num3 == 0 then
        return nil
    end
    return num2 + math.ceil(num1 / num3) - 1
end
