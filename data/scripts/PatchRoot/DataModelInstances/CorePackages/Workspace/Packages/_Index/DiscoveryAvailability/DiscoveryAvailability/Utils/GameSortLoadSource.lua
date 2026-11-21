-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = ({})

return {
    GameSortLoadSourceType = { API = "API", ClientFallbackCache = "ClientFallbackCache" },
    setSortLoadSource = function(str1: string, str2: string?)
        if str2 then
            tbl1[str1] = str2
            return
        end
        tbl1[str1] = nil
    end,
    getSortLoadSource = function(str1: string)
        return tbl1[str1]
    end
}
