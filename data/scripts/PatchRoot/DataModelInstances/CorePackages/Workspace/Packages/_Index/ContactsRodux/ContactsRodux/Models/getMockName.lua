-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local num1 = 0

return function(): string
    num1 += 1
    return tostring(num1)
end
