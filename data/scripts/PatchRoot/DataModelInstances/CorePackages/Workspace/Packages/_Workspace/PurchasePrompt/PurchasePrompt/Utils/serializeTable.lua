-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function serializeTable(arg1, arg2, arg3, arg4)
    arg3 = arg3 or false
    arg4 = arg4 or 0

    local str1 = string.rep(" ", arg4)

    if arg2 then
        str1 ..= arg2 .. " = "
    end

    if type(arg1) == "table" then
        local var1 = str1 .. "{" .. (if arg3 then "" else "\n")

        for k, value in pairs(arg1) do
            var1 ..= serializeTable(value, k, arg3, arg4 + 1) .. "," .. (if arg3 then "" else "\n")
        end

        return var1 .. string.rep(" ", arg4) .. "}"
    end

    if type(arg1) == "number" then
        return str1 .. tostring(arg1)
    elseif type(arg1) == "string" then
        return str1 .. string.format("%q", arg1)
    elseif type(arg1) == "boolean" then
        return str1 .. (if arg1 then "true" else "false")
    end

    return str1 .. "\"[inserializeable datatype:" .. type(arg1) .. "]\""
end

return serializeTable
