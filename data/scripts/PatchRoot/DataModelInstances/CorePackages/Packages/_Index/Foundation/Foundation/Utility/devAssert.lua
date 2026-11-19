-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function devAssert(arg1, str1: string)
    if _G.__DEV__ == true then
        assert(arg1, str1)
    end
end

return devAssert
