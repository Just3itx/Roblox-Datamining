-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:50:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local assign = require(scriptParent.assign)

local function debounce(callback, num1: number, tbl1)
    local var1 = assign({ leading = false, trailing = true }, tbl1)

    local num2 = 0
    local var2 = nil
    local bool1 = false
    local function func1() end

    func1 = var1.trailing and function(num3: number, bool2: boolean, ...)
        if num2 ~= num3 then
            return
        end
        bool1 = false

        if not bool2 then
            callback(...)
        end
    end or var1.leading and function(num3: number)
        if num2 == num3 then
            bool1 = false
        end
    end or func1

    return function(...)
        num2 += 1
        local num3 = num2
        local var3 = var1.leading and not bool1

        if var2 then
            task.cancel(var2)
            var2 = nil
        end

        if var3 then
            bool1 = true
            callback(...)
        end

        var2 = task.delay(num1, func1, num3, var3, ...)
    end
end

return debounce
