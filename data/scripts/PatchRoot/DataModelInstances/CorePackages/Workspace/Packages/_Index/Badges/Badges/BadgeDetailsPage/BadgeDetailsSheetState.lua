-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local getIsBadgeDetailsSheetOpen = false

return {
    getIsBadgeDetailsSheetOpen = function()
        return getIsBadgeDetailsSheetOpen
    end,
    setIsBadgeDetailsSheetOpen = function(bool2: boolean)
        getIsBadgeDetailsSheetOpen = bool2
    end
}
