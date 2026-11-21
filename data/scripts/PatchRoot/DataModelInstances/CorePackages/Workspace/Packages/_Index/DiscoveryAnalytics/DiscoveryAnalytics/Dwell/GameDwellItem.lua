-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    identity = function(tbl1): string
        local str1 = if tbl1.rank > 0 then `rank:{tbl1.rank}` else `cell:{tbl1.cell}`
        return `{str1}/{tbl1.universeId}/{tbl1.adFlag}/{tbl1.adId}`
    end
}
