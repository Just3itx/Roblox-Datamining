-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function devAssert(arg1, str1: string)
    if _G.__DEV__ == true then
        assert(arg1, str1)
    end
end

return devAssert
