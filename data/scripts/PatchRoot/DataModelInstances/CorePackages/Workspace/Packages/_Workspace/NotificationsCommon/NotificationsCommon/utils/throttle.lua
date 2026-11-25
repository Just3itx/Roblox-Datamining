-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:30:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(callback, num1: number?)
    local bool1 = false
    local num2 = num1 or 1
    return function(...)
        if bool1 then
            return
        end
        bool1 = true
        callback(...)
        task.delay(num2, function()
            bool1 = false
        end)
    end
end
