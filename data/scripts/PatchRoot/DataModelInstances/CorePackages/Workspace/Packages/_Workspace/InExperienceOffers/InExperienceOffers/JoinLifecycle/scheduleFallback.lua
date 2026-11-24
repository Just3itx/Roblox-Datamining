-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function scheduleFallback(num1: number, callback: (...any) -> (...any))
    local function guardedCallback()
        if not game:IsLoaded() then
            return
        end
        callback()
    end

    if game:IsLoaded() then
        task.delay(num1, guardedCallback)
        return
    end
    game.Loaded:Once(function()
        task.delay(num1, guardedCallback)
    end)
end

return scheduleFallback
