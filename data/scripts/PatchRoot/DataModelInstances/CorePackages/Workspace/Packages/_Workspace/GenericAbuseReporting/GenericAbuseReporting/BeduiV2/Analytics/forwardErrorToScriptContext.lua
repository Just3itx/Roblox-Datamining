-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function forwardErrorToScriptContext(arg1, str1: string?)
    task.spawn(function()
        local var1 = str1 or ""
        error(tostring(arg1) .. "\n" .. var1, 0)
    end)
end

return forwardErrorToScriptContext
