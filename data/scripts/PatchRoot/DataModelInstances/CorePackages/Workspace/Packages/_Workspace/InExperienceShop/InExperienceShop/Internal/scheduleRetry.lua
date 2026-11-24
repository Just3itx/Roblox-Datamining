-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function scheduleRetry(num1: number, callback: (...any) -> (...any))
    task.delay(num1, function() -- name: guardedCallback
        if not game:IsLoaded() then
            return
        end
        callback()
    end)
end
return scheduleRetry
