-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local equalObjects = require(script.Parent.Parent.equalObjects)

local function equals(...)
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

            for k, value in pairs(var2) do
                if value ~= var3[k] then
                    return false
                end
            end
        end
    end

    return true
end

return equals
