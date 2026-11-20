-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local CursorType = require(scriptParentParentParentParent.Foundation).Enums.CursorType

local function mapCursorType(arg1, bool1: boolean?)
    local str1 = tostring(arg1)
    local var1 = string.gsub(str1, if bool1 then "CursorKind%." else "CursorType%.", "")
    return CursorType[var1]
end

return mapCursorType
