-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(callback, arg1)
    local num1 = 0
    return function(...)
        local tbl1 = { ... }
        local now = time()
        num1 = now
        delay(arg1, function()
            if num1 == now then
                callback(unpack(tbl1))
            end
        end)
    end
end
