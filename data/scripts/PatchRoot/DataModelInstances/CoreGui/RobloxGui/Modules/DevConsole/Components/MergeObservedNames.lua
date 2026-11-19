-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function mergeObservedNames(tbl1, tbl2, str1: string): boolean
    local bool1 = false
    for _, value in tbl1 do
        local var1 = value[str1]
        if var1 and not tbl2[var1] then
            tbl2[var1] = true
            bool1 = true
        end
    end

    return bool1
end

return mergeObservedNames
