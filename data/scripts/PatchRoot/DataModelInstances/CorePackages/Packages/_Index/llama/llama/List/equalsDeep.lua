-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local equalObjects = require(script.Parent.Parent.equalObjects)

local function equalsDeepOneWay(arg1, arg2)
    if type(arg1) == "table" and type(arg2) == "table" then
        for i = 1, #arg1 do
            if not equalsDeepOneWay(arg1[i], arg2[i]) then
                return false
            end
        end
    elseif arg1 ~= arg2 then
        return false
    end

    return true
end

local function equalsDeep(...)
    if equalObjects(...) then
        return true
    end

    local select2 = select
    local var1 = select2("#", ...)

    for i = 1, var1 do
        local select3 = select
        local var2 = select3(i, ...)

        for j = 1, var1 do
            if j == i then
                continue
            end

            local select = select
            local var3 = select(j, ...)

            if not equalsDeepOneWay(var2, var3) then
                return false
            end
        end
    end

    return true
end

return equalsDeep
