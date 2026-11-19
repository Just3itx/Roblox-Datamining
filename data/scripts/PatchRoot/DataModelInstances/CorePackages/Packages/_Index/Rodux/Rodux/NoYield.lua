-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function resultHandler(arg1, arg2, ...)
    if not arg2 then
        error(debug.traceback(arg1, (...)), 2)
    end

    if coroutine.status(arg1) ~= "dead" then
        error(debug.traceback(arg1, "Attempted to yield inside changed event!"), 2)
    end

    return ...
end

local function NoYield(arg1, ...)
    local thread = coroutine.create(arg1)

    return resultHandler(thread, coroutine.resume(thread, ...))
end

return NoYield
