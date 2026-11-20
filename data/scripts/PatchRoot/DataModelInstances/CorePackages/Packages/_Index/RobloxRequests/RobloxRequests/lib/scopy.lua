-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function deepcopy(arg1)
    if type(arg1) ~= "table" then
        return arg1
    end

    local result = {}
    for k, value in next, arg1 do
        result[deepcopy(k)] = deepcopy(value)
    end
    setmetatable(result, deepcopy((getmetatable(arg1))))
    return result
end

return deepcopy
