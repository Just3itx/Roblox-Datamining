-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function describeProblematicProperties(tbl1, tbl2): string
    local tbl3 = {}
    for _, value in tbl1 do
        local var1 = if tbl2 then tbl2[value] else nil

        if var1 == 0 then
            table.insert(tbl3, `{value} (must be empty)`)
        elseif var1 ~= nil then
            table.insert(tbl3, `{value} (limit {var1} bytes)`)
        else
            table.insert(tbl3, value)
        end
    end
    return table.concat(tbl3, ", ")
end

return describeProblematicProperties
