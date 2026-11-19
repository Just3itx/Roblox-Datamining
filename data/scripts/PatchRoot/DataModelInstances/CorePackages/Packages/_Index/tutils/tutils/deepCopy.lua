-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function deepCopy(arg1, arg2)
    if type(arg1) ~= "table" then
        return arg1
    end

    if arg2 and arg2[arg1] then
        return arg2[arg1]
    end

    local var1 = arg2 or {}
    local var2 = setmetatable({}, (getmetatable(arg1)))
    var1[arg1] = var2
    for k, value in pairs(arg1) do
        var2[deepCopy(k, var1)] = deepCopy(value, var1)
    end
    return var2
end

return deepCopy
