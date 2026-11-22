-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, str1: string)
    for _, value in ipairs(str1:split(".")) do
        if arg1[value] == nil then
            return nil
        end

        arg1 = arg1[value]
    end

    return arg1
end
