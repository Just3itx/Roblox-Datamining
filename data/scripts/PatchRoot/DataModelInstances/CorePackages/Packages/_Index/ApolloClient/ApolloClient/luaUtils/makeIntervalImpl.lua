-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local var1 = newproxy(false)

return function(callback)
    return {
        setInterval = function(callback2, num1: number, ...)
            local tbl1 = { ... }
            local tbl2 = {
                [var1] = 1
            }

            local num2 = (if num1 == nil then 0 else num1) / 1000

            local function func1()
                callback(num2, function()
                    if tbl2[var1] == 1 then
                        callback2(unpack(tbl1))
                        func1()
                    end
                end)
            end

            func1()

            return tbl2
        end,
        clearInterval = function(tbl1)
            if tbl1[var1] == 1 then
                tbl1[var1] = 3
            end
        end
    }
end
