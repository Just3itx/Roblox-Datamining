-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FormValidationErrorEnum = require(script.Parent.Parent.Parent.FormValidationErrorEnum)

local function isNotWhitespace(str1: string)
    if string.match(str1, "%S") ~= nil then
        return true
    end
    return false, FormValidationErrorEnum.FailedIsNotWhitespace
end

return isNotWhitespace
