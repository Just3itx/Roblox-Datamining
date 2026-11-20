-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function resultHandler(thread1: thread, bool1: boolean, ...)
    if not bool1 then
        local var1 = ...
        if typeof(var1) == "string" then
            error(debug.traceback(thread1, var1), 3)
        else
            error(var1, 3)
        end
    end

    if coroutine.status(thread1) ~= "dead" then
        error(
            debug.traceback(
                thread1,
                "\nYielding is not allowed inside components or hooks.\n\nYielding in a component stalls React's scheduler, freezing the entire application until the yield completes.\nCheck the stack trace below to find the exact location of the yield.\n\nFor more details and how to fix this, see: go/react-yield-error\n"
            ),
            3
        )
    end
    return ...
end

local function NoYield(func1: (...any) -> (...any), ...)
    local thread = coroutine.create(func1)
    return resultHandler(thread, coroutine.resume(thread, ...))
end

return NoYield
