-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(callback, num1: number?)
    local var1 = nil
    local num2 = num1 or 0.5

    return function(...)
        local tbl1 = { ... }

        if var1 then
            task.cancel(var1)
        end

        var1 = task.delay(num2, function()
            callback(unpack(tbl1))
            var1 = nil
        end)
    end
end
