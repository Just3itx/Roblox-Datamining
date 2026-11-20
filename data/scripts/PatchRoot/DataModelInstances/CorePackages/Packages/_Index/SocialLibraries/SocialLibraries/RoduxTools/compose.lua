-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(...)
    local tbl1 = { ... }
    local num1 = #tbl1

    if num1 == 0 then
        return function<T>(arg1: T): T
            return arg1
        end
    end

    local var1 = tbl1[1]
    for i = 2, num1 do
        local var2 = tbl1[i]
        local var3 = var1

        var1 = function(...)
            return var3(var2(...))
        end
    end
    return var1
end
