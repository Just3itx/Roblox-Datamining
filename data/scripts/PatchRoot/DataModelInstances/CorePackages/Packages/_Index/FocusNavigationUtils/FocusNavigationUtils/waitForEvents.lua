-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function waitForEvents()
    task.defer(coroutine.running())
    coroutine.yield()
end

return waitForEvents
