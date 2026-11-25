-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local _Signals = require(SquadsCoreParent.Signals)
local createSessionScopedSignal = require(SquadsCoreParent.SignalsUtils).createSessionScopedSignal

local function defaultSchedule(num1: number, func1: (...any) -> (...any))
    local var1 = task.delay(num1, func1)
    return function()
        task.cancel(var1)
    end
end

return function(tbl1)
    local var1 = tbl1 and tbl1.schedule or defaultSchedule

    local getBlockedSquadId, var3 = createSessionScopedSignal(nil)

    local var4 = nil

    local function func1() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var4 then
            var4()
            var4 = nil
        end
    end

    return {
        getBlockedSquadId = getBlockedSquadId,
        block = function(str1: string, num1: number)
            func1()

            if num1 <= 0 then
                var3(nil)
                return
            end

            var3(str1)
            var4 = var1(num1, function()
                var4 = nil
                var3(nil)
            end)
        end,
        unblock = function(str1: string?)
            if str1 ~= nil and getBlockedSquadId(false) ~= str1 then
                return
            end

            func1()
            var3(nil)
        end
    }
end
