-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getAdjacentTabName(tbl1, name: string, num1: number)
    if #tbl1 < 2 then
        return nil
    end

    local var1 = table.clone(tbl1)
    table.sort(var1, function(arg1, arg2): boolean
        return arg1.tabIndex < arg2.tabIndex
    end)

    local var2 = nil
    for value, value2 in var1 do
        if value2.name == name then
            var2 = value
            break
        end
    end

    if var2 == nil then
        return nil
    end

    local num2 = #var1

    return var1[(var2 - 1 + num1) % num2 + 1].name
end

return getAdjacentTabName
