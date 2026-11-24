-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(callback: (...any) -> (...any), num1: number)
    local var1 = nil
    local num2 = num1 / 1000
    return {
        cancel = function()
            if var1 then
                task.cancel(var1)
                var1 = nil
            end
        end,
        call = function(...)
            local tbl1 = { ... }
            var1 = task.delay(num2, function()
                callback(unpack(tbl1))
            end)
        end
    }
end
