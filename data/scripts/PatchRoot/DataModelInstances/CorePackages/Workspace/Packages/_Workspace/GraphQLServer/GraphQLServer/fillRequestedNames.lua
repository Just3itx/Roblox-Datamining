-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function fillRequestedNames(tbl1, tbl2)
    local tbl3 = {}
    for _, value in tbl2 do
        if string.sub(value, 1, 6) == "names." then
            table.insert(tbl3, string.sub(value, 7))
        end
    end
    if tbl1 == nil or #tbl3 == 0 then
        return tbl1
    end

    local result = {}
    for _, value in tbl1 do
        local names = type(value.names) ~= "table" and {} or table.clone(value.names)
        for _, value2 in tbl3 do
            if type(names[value2]) ~= "string" then
                names[value2] = ""
            end
        end
        local var2 = table.clone(value)
        var2.names = names
        table.insert(result, var2)
    end
    return result
end

return fillRequestedNames
