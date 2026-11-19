-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:31:14Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function map(tbl1, func1: (...any) -> (...any))
    local result = ({})

    for value, value2 in tbl1 do
        local var1, var2 = func1(value2, value)
        if var2 == nil then
            var2 = value
        end
        if var1 ~= nil then
            result[var2] = var1
        end
    end

    return result
end

return map
