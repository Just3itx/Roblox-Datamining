-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1, tbl2)
    local result = ({})

    for _, value in pairs(tbl1) do
        local str1 = tostring(value)
        local var1 = tbl2[str1]
        if var1 then
            result[str1] = var1
        end
    end

    return result
end
