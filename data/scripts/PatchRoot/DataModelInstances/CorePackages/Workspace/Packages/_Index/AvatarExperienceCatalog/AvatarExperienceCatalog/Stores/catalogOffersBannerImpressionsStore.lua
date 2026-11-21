-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = ({})

return {
    hasSeenOfferId = function(str1: string): boolean
        return tbl1[str1] == true
    end,
    addOfferId = function(str1: string)
        tbl1[str1] = true
    end,
    clearOfferIds = function()
        tbl1 = {}
    end
}
