-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.DPadUp] = true
}

local function shouldFocusBackButtonOnKey(arg1, bool1: boolean, str1: string?): boolean
    return if tbl1[arg1] then if bool1 then str1 == nil or str1 == "" else false else false
end

return shouldFocusBackButtonOnKey
