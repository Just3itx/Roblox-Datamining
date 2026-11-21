-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FormValidationErrorEnum = require(script.Parent.Parent.FormValidationErrorEnum)

local function isNotNull(arg1)
    if arg1 ~= nil then
        return true
    end
    return false, FormValidationErrorEnum.FailedIsNotNull
end

return isNotNull
