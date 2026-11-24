-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(callback, arg1)
    local bool1 = false

    return function(...)
        if bool1 then
            return
        end
        bool1 = true
        callback(...)
        task.delay(arg1, function()
            bool1 = false
        end)
    end
end
