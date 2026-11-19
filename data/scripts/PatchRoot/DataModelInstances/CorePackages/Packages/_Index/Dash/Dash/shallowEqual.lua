-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:00:58Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function shallowEqual(arg1, arg2)
    if arg1 == arg2 then
        return true
    end
    if typeof(arg1) ~= "table" or typeof(arg2) ~= "table" or #arg1 ~= #arg2 then
        return false
    end
    if arg1 == nil or arg2 == nil then
        return false
    end
    for value, value2 in arg1 do
        if arg2[value] ~= value2 then
            return false
        end
    end
    for value, value2 in arg2 do
        if arg1[value] ~= value2 then
            return false
        end
    end
    return true
end

return shallowEqual
