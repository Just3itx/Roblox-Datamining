-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(func1: (...any) -> (...any))
    local thread = coroutine.create(func1)

    return (function(thread1: thread, bool1: boolean, ...)
        if not bool1 or coroutine.status(thread1) ~= "dead" then
            return nil
        end

        return ...
    end)(thread, coroutine.resume(thread))
end
