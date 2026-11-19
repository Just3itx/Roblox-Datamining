-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:10:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function deepEqual(arg1, arg2, arg3)
    if arg1 == arg2 then
        return true
    end
    local str1 = type(arg1)
    if str1 ~= type(arg2) then
        return false
    end
    if str1 ~= "table" then
        return false
    end

    if not arg3 then
        local var1 = getmetatable(arg1)
        if var1 and var1.__eq then
            return arg1 == arg2
        end
    end

    local tbl1 = ({})

    for k, value in pairs(arg1) do
        local var1 = arg2[k]
        if var1 == nil or not deepEqual(value, var1, arg3) then
            return false
        end
        tbl1[k] = true
    end

    for k, _ in pairs(arg2) do
        if not tbl1[k] then
            return false
        end
    end
    return true
end

return deepEqual
