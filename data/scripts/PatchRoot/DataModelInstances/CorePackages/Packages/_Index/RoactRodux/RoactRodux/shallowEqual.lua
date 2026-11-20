-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function shallowEqual(arg1, arg2)
    if arg1 == nil then
        return arg2 == nil
    end

    if arg2 == nil then
        return arg1 == nil
    end

    for k, value in pairs(arg1) do
        if value ~= arg2[k] then
            return false
        end
    end

    for k, value in pairs(arg2) do
        if value ~= arg1[k] then
            return false
        end
    end

    return true
end

return shallowEqual
