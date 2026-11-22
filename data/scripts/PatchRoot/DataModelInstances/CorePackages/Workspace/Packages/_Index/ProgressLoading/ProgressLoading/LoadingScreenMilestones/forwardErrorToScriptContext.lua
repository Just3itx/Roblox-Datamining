-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function forwardErrorToScriptContext(str1: string)
    task.spawn(function()
        error(str1, 0)
    end)
end

return forwardErrorToScriptContext
