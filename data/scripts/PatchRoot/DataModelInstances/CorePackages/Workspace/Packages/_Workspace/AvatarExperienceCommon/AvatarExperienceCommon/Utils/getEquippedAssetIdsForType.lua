-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1, str1: string)
    local result = {}

    if not tbl1 then
        return result
    end

    local var1 = tbl1[str1]
    if var1 then
        for value, _ in var1 do
            table.insert(result, value)
        end
    end

    return result
end
