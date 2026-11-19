-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:31:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local equalObjects = require(script.Parent.Parent.equalObjects)

local function compare(arg1, arg2)
    if type(arg1) ~= "table" or type(arg2) ~= "table" then
        return arg1 == arg2
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

local function equals(...)
    if equalObjects(...) then
        return true
    end

    local select2 = select
    local var1 = select2("#", ...)
    local select3 = select
    local var2 = select3(1, ...)

    for i = 2, var1 do
        local select = select
        local var3 = select(i, ...)

        if not compare(var2, var3) then
            return false
        end
    end

    return true
end

return equals
