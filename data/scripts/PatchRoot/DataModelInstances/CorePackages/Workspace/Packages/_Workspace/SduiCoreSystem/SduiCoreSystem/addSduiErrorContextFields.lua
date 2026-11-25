-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _SduiErrors = require(script.Parent.SduiErrors)

local function addSduiErrorContextFields(arg1, arg2)
    if arg2 then
        arg1.fullName = arg2.fullName
        arg1.rctPath = arg2.rctPath
        arg1.templateId = arg2.templateId
    end
end

return addSduiErrorContextFields
