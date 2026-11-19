-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:01:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local var1 = newproxy(false)

return function(callback)
    return {
        setTimeout = function(callback2, num1: number?, ...)
            local tbl1 = { ... }
            local tbl2 = {
                [var1] = 1
            }

            local var2 = (if num1 == nil then 0 else num1) / 1000
            callback(var2, function()
                if tbl2[var1] == 1 then
                    callback2(unpack(tbl1))
                    tbl2[var1] = 2
                end
            end)

            return tbl2
        end,
        clearTimeout = function(tbl1)
            if tbl1 == nil then
                return
            end
            if tbl1[var1] == 1 then
                tbl1[var1] = 3
            end
        end
    }
end
