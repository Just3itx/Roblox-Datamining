-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:10:50Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(arg1, arg2, arg3)
    if not (arg1 and arg2) then
        return false
    end

    if arg1 == arg2 then
        return true
    end
    arg3 = arg3 or {}

    for k, value in pairs(arg1) do
        if arg2[k] ~= value and not arg3[k] then
            return false
        end
    end
    for k, value in pairs(arg2) do
        if arg1[k] ~= value and not arg3[k] then
            return false
        end
    end

    return true
end
