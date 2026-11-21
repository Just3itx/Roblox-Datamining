-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _FormValidationErrorEnum = require(script.Parent.FormValidationErrorEnum)

local function buildFormValidator(tbl1)
    return function(arg1)
        for _, value in tbl1 do
            local var1, var2 = value(arg1)
            if not var1 then
                return false, var2
            end
        end
        return true, nil
    end
end

return buildFormValidator
