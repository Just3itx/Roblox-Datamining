-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.replaceNewlines(arg1, arg2)
    arg2 = arg2 or " "

    return arg1:gsub("\r\n", arg2):gsub("\r", arg2):gsub("\n", arg2)
end

function module.truncateLength(arg1, arg2)
    arg2 = arg2 or 140

    if arg1:len() <= arg2 then
        return arg1
    end

    local str1 = ""
    local num1 = ("..."):len()

    for value, value2 in utf8.graphemes(arg1) do
        local var1 = arg1:sub(value, value2)

        if arg2 < str1:len() + var1:len() + num1 then
            break
        end

        str1 ..= var1
    end

    local var1, var2 = str1:gsub("%s+%S-$", "...", 1)

    return if var2 > 0 then var1 else str1 .. "..."
end

function module.sanitizeDescription(arg1)
    arg1 = module.replaceNewlines(arg1)
    return (module.truncateLength(arg1))
end

return module
