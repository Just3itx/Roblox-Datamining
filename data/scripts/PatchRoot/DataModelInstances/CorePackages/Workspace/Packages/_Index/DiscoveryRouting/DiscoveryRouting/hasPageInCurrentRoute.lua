-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, name, bool1: boolean?)
    if not arg1 then
        return false
    end

    local num1 = #arg1
    if bool1 then
        num1 -= 1
    end

    for i = 1, num1 do
        if arg1[i].name == name then
            return true
        end
    end

    return false
end
