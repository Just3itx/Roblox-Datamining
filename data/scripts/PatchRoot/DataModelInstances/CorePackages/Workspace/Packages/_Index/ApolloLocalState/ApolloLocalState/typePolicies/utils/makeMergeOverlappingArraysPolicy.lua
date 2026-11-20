-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function makeMergeOverlappingArraysPolicy(str1: string)
    local function mergeOverlappingArraysPolicy(_, arg1, arg2, arg3)
        arg1 = arg1 or {}
        arg2 = arg2 or {}
        if #arg2 == 0 then
            return arg1
        end
        if #arg1 == 0 then
            return arg2
        end

        local tbl1 = ({})
        local var1 = table.clone(arg1)

        for value, value2 in var1 do
            local var2 = arg3:readField(str1, value2)
            if var2 then
                tbl1[var2] = value
            end
        end

        for _, value in arg2 do
            local var2 = arg3:readField(str1, value)
            if var2 and tbl1[var2] then
                local var3 = tbl1[var2]
                var1[var3] = arg3:mergeObjects(var1[var3], value)
            else
                table.insert(var1, value)
            end
        end

        return var1
    end

    return mergeOverlappingArraysPolicy
end

return makeMergeOverlappingArraysPolicy
