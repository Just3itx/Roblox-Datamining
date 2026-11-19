-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function sort<T>(tbl1: {T}, func1: ((T, T) -> boolean)?): {T}
    local result = ({})

    for i = 1, #tbl1 do
        result[i] = tbl1[i]
    end

    table.sort(result, func1)

    return result
end

return sort
