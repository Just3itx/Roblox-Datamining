-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    if type(arg1) ~= "string" then
        return ""
    end

    if type(arg2) ~= "table" then
        return arg1
    end

    for k, value in pairs(arg2) do
        if type(k) == "string" and type(value) == "string" then
            arg1 = string.gsub(arg1, k, value)
        end
    end

    return arg1
end
