-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    formatDescription = function(tbl1): string
        local tbl2 = {}
        for _, value in tbl1 do
            if value.username ~= nil and value.username ~= "" then
                table.insert(tbl2, `@{value.username}`)
            end
        end
        return table.concat(tbl2, ", ")
    end,
    formatTitle = function(tbl1): string
        local var1 = table.create(#tbl1)
        for value, value2 in tbl1 do
            var1[value] = value2.displayName
        end
        return table.concat(var1, ", ")
    end
}
