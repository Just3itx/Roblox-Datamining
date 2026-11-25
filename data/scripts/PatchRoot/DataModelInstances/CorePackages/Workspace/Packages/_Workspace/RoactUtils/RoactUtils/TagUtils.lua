-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    combineReactTags = function(...)
        local tbl1 = table.pack(...)

        local tbl2 = {}
        for i = 1, tbl1.n do
            local var1 = tbl1[i]
            if var1 and var1 ~= "" then
                table.insert(tbl2, var1)
            end
        end

        if #tbl2 > 0 then
            return table.concat(tbl2, " ")
        end

        return nil
    end
}
