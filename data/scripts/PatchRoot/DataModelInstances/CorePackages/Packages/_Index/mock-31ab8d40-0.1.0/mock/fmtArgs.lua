-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): string
    local tbl1 = {}
    for i = 1, arg1.n do
        if type(arg1[i]) == "string" then
            table.insert(tbl1, "\"" .. arg1[i] .. "\"")
        else
            table.insert(tbl1, tostring(arg1[i]))
        end
    end
    return "{" .. table.concat(tbl1, ", ") .. "}"
end
