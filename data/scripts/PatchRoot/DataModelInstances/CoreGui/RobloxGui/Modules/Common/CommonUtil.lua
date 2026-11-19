-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.TableConcat<T>(tbl1: {T}, tbl2: {T}): {T}
    for i = 1, #tbl2 do
        tbl1[#tbl1 + 1] = tbl2[i]
    end
    return tbl1
end

function module.SortByName(tbl1: {any})
    table.sort(tbl1, function(arg1, arg2): boolean -- name: compareInstanceNames
        return arg1.Name < arg2.Name
    end)

    return tbl1
end

return module
