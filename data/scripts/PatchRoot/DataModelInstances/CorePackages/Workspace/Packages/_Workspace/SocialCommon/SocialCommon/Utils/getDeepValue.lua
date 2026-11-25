-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, str1: string)
    if not arg1 then
        return nil
    end
    for _, value in ipairs(str1:split(".")) do
        if arg1[value] == nil then
            return nil
        end

        arg1 = arg1[value]
    end

    return arg1
end
