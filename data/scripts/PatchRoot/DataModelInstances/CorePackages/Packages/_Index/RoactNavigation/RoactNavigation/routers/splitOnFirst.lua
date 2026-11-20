-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function TypeError<T>(str1: T): T -- Luacid: Inlined by compiler; 1 call site recovered
    return str1
end

local function splitOnFirst(arg1, arg2)
    if type(arg1) ~= "string" or type(arg2) ~= "string" then
        local str1 = TypeError("Expected the arguments to be of type `string`")
        error(str1)
    end

    if arg2 == "" then
        return { arg1 }
    end

    local var1 = arg1:find(arg2, 1, true)

    if var1 == nil then
        return { arg1 }
    end

    return { arg1:sub(1, var1 - 1), arg1:sub(var1 + arg2:len()) }
end

return splitOnFirst
