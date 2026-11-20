-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local copy = require(script.Parent.copy)

local function noUpdate<T, U>(arg1: T, arg2: U): (T, U)
    return arg1, arg2
end

local function call(arg1, ...)
    if type(arg1) == "function" then
        return arg1(...)
    end
end

local function update(arg1, arg2, arg3, arg4)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    assert(arg2 ~= nil, "expected second argument to be anything but nil, got nil")

    local var1 = copy(arg1)

    arg3 = arg3 or noUpdate
    local var2, var3

    if var1[arg2] ~= nil then
        var2, var3 = arg3(var1[arg2], arg2)
        call(arg4, true, var2, var3 or arg2)
    else
        var2, var3 = call(arg4, false, arg2)
    end

    var1[var3 or arg2] = var2

    return var1
end

return update
