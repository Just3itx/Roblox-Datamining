-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1): boolean
    return tbl1.userId % 100 + 1 <= tbl1.throttle
end
