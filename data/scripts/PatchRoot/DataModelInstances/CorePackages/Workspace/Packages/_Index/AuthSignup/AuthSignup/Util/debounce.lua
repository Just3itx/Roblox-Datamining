-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:30:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(callback, num1: number?)
    local num2 = 0
    return function(...)
        local tbl1 = { ... }
        local now = time()
        num2 = now
        task.delay(num1, function()
            if num2 == now then
                callback(unpack(tbl1))
            end
        end)
    end
end
