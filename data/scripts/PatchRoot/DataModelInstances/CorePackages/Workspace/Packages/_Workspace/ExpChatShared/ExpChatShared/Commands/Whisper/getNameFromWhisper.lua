-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getArgs(str1: string, tbl1)
    for _, value in pairs(tbl1) do
        local var1 = value .. " "
        local num1 = string.len(var1)

        if string.sub(str1, 1, num1):lower() == var1 then
            return string.sub(str1, num1 + 1)
        end
    end

    return nil
end

return function(str1: string, tbl1)
    local args = getArgs(str1, tbl1)

    if args then
        return string.split(args, " ")[1]
    end

    return nil
end
