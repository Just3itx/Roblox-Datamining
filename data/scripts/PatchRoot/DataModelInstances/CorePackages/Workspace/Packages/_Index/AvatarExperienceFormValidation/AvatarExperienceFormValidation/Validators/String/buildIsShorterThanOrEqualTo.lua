-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FormValidationErrorEnum = require(script.Parent.Parent.Parent.FormValidationErrorEnum)

local function buildIsShorterThanOrEqualTo(num1: number)
    return function(str1: string)
        local var1 = utf8.len(str1)
        if var1 ~= nil and var1 <= num1 then
            return true
        end
        return false, FormValidationErrorEnum.FailedIsShorterThanOrEqualTo
    end
end

return buildIsShorterThanOrEqualTo
