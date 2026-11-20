-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function handleNoYieldValidation(thread1: thread, bool1: boolean, ...)
    if not bool1 then
        local var1 = ...
        if typeof(var1) == "string" then
            error(debug.traceback(thread1, var1), 2)
        else
            error(tostring(var1), 2)
        end
    end

    if coroutine.status(thread1) ~= "dead" then
        error(debug.traceback(thread1, "Attempted to yield!"), 2)
    end

    return ...
end

return if _G.__SIGNALS_VALIDATION_ENABLED__ or _G.__DEV__ then function(func1: (...any) -> (...any), ...) -- name: callWithValidation
    local thread = coroutine.create(func1)
    return handleNoYieldValidation(thread, coroutine.resume(thread, ...))
end else function(func1: (...any) -> (...any), ...) -- name: callWithoutValidation
    return func1(...)
end
