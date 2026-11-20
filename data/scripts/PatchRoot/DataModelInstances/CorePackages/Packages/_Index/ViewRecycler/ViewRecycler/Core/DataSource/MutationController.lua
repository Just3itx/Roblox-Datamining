-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _Types = require(ViewRecycler.Core.Types)
local createEvent = require(ViewRecycler.Internal.createEvent)

local function createMutationController(func1: (...any) -> (...any), func2: (...any) -> (...any), callback: (...any) -> (...any), callback2: ((...any) -> (...any))?)
    local event = createEvent()
    local num1 = 0
    local tbl1 = {}
    local var1 = nil

    local function flush()
        local previousItemCount = var1
        local changes = tbl1
        tbl1 = {}
        var1 = nil
        event.fire({ changes = changes, previousItemCount = previousItemCount, itemCount = func1() })
    end

    local function queueChanges(tbl2, num2: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        if #tbl1 == 0 then
            var1 = num2
        end
        for _, value in tbl2 do
            table.insert(tbl1, value)
        end
    end

    return {
        subscribe = event.connect,
        emit = function(arg1, num2: number)
            queueChanges({ arg1 }, num2)
            if num1 == 0 then
                flush()
            end
        end,
        emitMany = function(tbl2, num2: number)
            queueChanges(tbl2, num2)

            if num1 == 0 then
                flush()
            end
        end,
        transaction = function(callback3: (...any) -> (...any))
            local var2 = func2()
            local var3 = table.clone(tbl1)
            local var4 = var1
            num1 += 1
            local tbl2 = table.pack(pcall(function(): boolean
                callback3()
                return true
            end))
            num1 -= 1
            if not tbl2[1] then
                callback(var2)
                tbl1 = var3
                var1 = var4
                error(tbl2[2], 0)
            end
            if callback2 ~= nil then
                callback2(var2)
            end
            if num1 == 0 and #tbl1 > 0 then
                flush()
            end
        end
    }
end

return createMutationController
