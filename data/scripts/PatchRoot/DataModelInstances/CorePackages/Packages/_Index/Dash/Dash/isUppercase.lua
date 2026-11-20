-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local assertEqual = require(scriptParent.assertEqual)

local function isUppercase(str1: string): boolean
    assertEqual(#str1 > 0, true, "Attempted to call Dash.isUppercase with an empty string")
    local str2 = str1:sub(1, 1)
    return str2 == str2:upper()
end
return isUppercase
