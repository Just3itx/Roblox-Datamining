-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Types = require(script.Parent.Types)

return {
    isValidMessage = function(arg1): boolean
        return Types.isValidMessage(arg1) == true
    end,
    isValidMessageDraft = function(arg1): boolean
        return Types.isValidMessageDraft(arg1) == true
    end
}
