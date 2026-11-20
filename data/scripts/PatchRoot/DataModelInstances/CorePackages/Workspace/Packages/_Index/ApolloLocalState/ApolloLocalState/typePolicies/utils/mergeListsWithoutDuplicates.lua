-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloLocalStateParent = script:FindFirstAncestor("ApolloLocalState").Parent

local Cryo = require(ApolloLocalStateParent.Cryo)

local function mergeListsWithoutDuplicates(tbl1, tbl2, str1: string?)
    if not tbl2 or #tbl2 == 0 then
        return tbl1
    end
    if not tbl1 or #tbl1 == 0 then
        return tbl2
    end

    local var1 = Cryo.List.toSet(Cryo.List.map(tbl1, function(arg1)
        return if str1 then arg1[str1] else arg1
    end))

    local var2 = Cryo.List.filter(tbl2, function(arg1): boolean
        if str1 then
            arg1 = arg1[str1]
        end

        return not var1[arg1]
    end)

    return Cryo.List.join(table.clone(tbl1), var2)
end

return mergeListsWithoutDuplicates
