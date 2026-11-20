-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _Types = require(ViewRecycler.Core.Types)

local ItemKeyRegistry = require(script.Parent.ItemKeyRegistry)
local MutationController = require(script.Parent.MutationController)
local readDenseRange = require(script.Parent.readDenseRange)

local function createRingBufferDataSource(index: number, tbl1, func1: ((...any) -> (...any))?)
    assert(index > 0 and index % 1 == 0, "DataSource.ringBuffer: capacity must be a positive integer")
    local tbl2 = tbl1 or {}
    assert(#tbl2 <= index, "DataSource.ringBuffer: initial values exceed capacity")
    local tbl3 = ({})
    local tbl4 = ({})
    local var1 = ItemKeyRegistry.create(func1, "DataSource.ringBuffer")
    local var2 = var1.rebuild(tbl2)
    local num1 = 1
    local num2 = #tbl2
    for value, value2 in tbl2 do
        tbl3[value] = value2
        local var3 = var2[value]
        tbl4[value] = var3
    end

    local var3 = MutationController(function()
        return num2
    end, function()
        return {
            values = table.clone(tbl3),
            keys = table.clone(tbl4),
            head = num1,
            count = num2,
            keyRegistry = var1.snapshot()
        }
    end, function(arg1)
        tbl3 = arg1.values
        tbl4 = arg1.keys
        num1 = arg1.head
        num2 = arg1.count
        var1.restore(arg1.keyRegistry)
    end)

    local function physical(num3: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
        return (num1 + num3 - 2) % index + 1
    end

    local var4 = nil
    var4 = {
        getItemCount = function()
            return num2
        end,
        getItem = function(arg1)
            return tbl3[physical(arg1)]
        end,
        getItemKey = function(arg1)
            return tbl4[physical(arg1)]
        end,
        getItems = function(arg1, arg2)
            return readDenseRange(num2, var4.getItem, arg1, arg2)
        end,
        subscribe = var3.subscribe,
        transaction = var3.transaction
    }

    function var4.push(arg1)
        local num3 = num2
        if num2 ~= index then
            local var5 = var1.claim(arg1, num2 + 1)
            local num4 = physical(num2 + 1)
            tbl3[num4] = arg1
            tbl4[num4] = var5
            num2 += 1
            var3.emit({ type = DataSourceChangeType.Insert, index = num2, keys = { var5 } }, num3)
            return
        end

        local num4 = num1
        local var5 = tbl4[num4]
        local var6 = var1.replace(var5, arg1, index)
        tbl3[num4] = arg1
        tbl4[num4] = var6
        num1 = num1 % index + 1
        var3.emitMany({
            {
                type = DataSourceChangeType.Remove,
                index = 1,
                keys = { var5 }
            },
            {
                type = DataSourceChangeType.Insert,
                index = index,
                keys = { var6 }
            }
        }, num3)
    end
    function var4.clear()
        local num3 = num2
        if num3 == 0 then
            return
        end
        tbl3 = {}
        tbl4 = {}
        var1.clear()
        num1 = 1
        num2 = 0
        var3.emit({ type = DataSourceChangeType.Reset, keys = {} }, num3)
    end

    return var4
end

return createRingBufferDataSource
