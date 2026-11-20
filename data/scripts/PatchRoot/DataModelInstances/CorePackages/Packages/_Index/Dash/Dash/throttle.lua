-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local assign = require(scriptParent.assign)

local function throttle(callback, num1: number, tbl1)
    local var1 = assign({ leading = true, trailing = true }, tbl1)

    local num2 = math.max(0, num1)
    local leading = var1.leading
    local trailing = var1.trailing

    local huge = -math.huge
    local var2 = nil
    local tbl2 = {}

    local function clearScheduled() -- Luacid: Inlined by compiler; 1 call site recovered
        if var2 then
            task.cancel(var2)
            var2 = nil
        end
    end

    local function invoke() -- Luacid: Inlined by compiler; 1 call site recovered
        huge = os.clock()
        var2 = nil
        callback(table.unpack(tbl2))
    end

    return function(...)
        local now = os.clock()
        tbl2 = { ... }

        local num3 = now - huge

        if leading and num2 <= num3 then
            clearScheduled()
            invoke()
            return
        end

        if trailing and not var2 then
            local num4 = num2 - (now - (huge == -math.huge and now or huge))
            local num5 = if num4 < 0 then 0 else num4

            var2 = task.delay(num5, invoke)
        end
    end
end

return throttle
