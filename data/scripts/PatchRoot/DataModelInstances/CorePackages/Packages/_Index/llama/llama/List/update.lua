-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local copy = require(script.Parent.copy)

local function noUpdate<T>(arg1: T): T
    return arg1
end

local function call(arg1, ...)
    if type(arg1) == "function" then
        return arg1(...)
    end
end

local function update(arg1, arg2, arg3, arg4)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local str2 = type(arg2)
    assert(str2 == "number" and arg2 % 1 == 0, "expected an integer for second argument, got " .. str2)

    local var1 = copy(arg1)

    local var2 = arg3 or noUpdate
    local var3

    if var1[arg2] ~= nil then
        var3 = var2(var1[arg2], arg2)
        call(arg4, true, var3, arg2)
    else
        var3 = call(arg4, false, arg2)
    end

    var1[arg2] = var3

    return var1
end

return update
