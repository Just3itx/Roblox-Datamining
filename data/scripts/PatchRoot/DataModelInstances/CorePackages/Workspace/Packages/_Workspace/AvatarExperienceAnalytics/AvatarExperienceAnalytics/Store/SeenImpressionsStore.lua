-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = ({})

local function getOrCreateCategory(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if not tbl1[str1] then
        tbl1[str1] = {}
    end
    return tbl1[str1]
end

return {
    Category = { WidgetItems = "WidgetItems", UnifiedImpressions = "UnifiedImpressions" },
    hasSeen = function(str1: string, str2: string): boolean
        local var1 = tbl1[str1]
        return not (var1 == nil) and var1[str2] == true
    end,
    markSeen = function(str1: string, str2: string)
        getOrCreateCategory(str1)[str2] = true
    end,
    clearCategory = function(str1: string)
        tbl1[str1] = nil
    end,
    clear = function()
        table.clear(tbl1)
    end
}
