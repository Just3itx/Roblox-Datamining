-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _Types = require(ViewRecycler.Core.Types)

local ItemKeyRegistry = require(script.Parent.ItemKeyRegistry)
local MutationController = require(script.Parent.MutationController)
local readDenseRange = require(script.Parent.readDenseRange)

local function createDequeDataSource(tbl1, func1: ((...any) -> (...any))?)
    local tbl2 = tbl1 or {}
    local tbl3 = ({})
    local tbl4 = ({})
    local var1 = ItemKeyRegistry.create(func1, "DataSource.deque")
    local var2 = var1.rebuild(tbl2)
    local num1 = math.max(8, #tbl2)
    local num2 = 1
    local num3 = #tbl2
    for value, value2 in tbl2 do
        tbl3[value] = value2
        local var3 = var2[value]
        tbl4[value] = var3
    end

    local var3 = MutationController(function()
        return num3
    end, function()
        return {
            values = table.clone(tbl3),
            keys = table.clone(tbl4),
            capacity = num1,
            head = num2,
            count = num3,
            keyRegistry = var1.snapshot()
        }
    end, function(arg1)
        tbl3 = arg1.values
        tbl4 = arg1.keys
        num1 = arg1.capacity
        num2 = arg1.head
        num3 = arg1.count
        var1.restore(arg1.keyRegistry)
    end)

    local function physical(num4: number): number -- Luacid: Inlined by compiler; 7 call sites recovered
        return (num2 + num4 - 2) % num1 + 1
    end

    local function ensureCapacity(num4: number)
        if num4 <= num1 then
            return
        end
        local num5 = num1 * 2
        while num5 < num4 do
            num5 *= 2
        end
        local tbl5 = ({})
        local tbl6 = ({})
        for i = 1, num3 do
            tbl5[i] = tbl3[physical(i)]
            tbl6[i] = tbl4[physical(i)]
        end
        tbl3 = tbl5
        tbl4 = tbl6
        num1 = num5
        num2 = 1
    end

    local function claimMany(tbl5, num4: number)
        local var4 = table.create(#tbl5)
        local tbl6 = table.pack(pcall(function()
            for value, value2 in tbl5 do
                var4[value] = var1.claim(value2, num4 + value - 1)
            end
        end))
        if not tbl6[1] then
            for _, value in var4 do
                var1.release(value)
            end
            error(tbl6[2], 0)
        end
        return var4
    end

    local var4 = nil
    var4 = {
        getItemCount = function()
            return num3
        end,
        getItem = function(arg1)
            return tbl3[physical(arg1)]
        end,
        getItemKey = function(arg1)
            return tbl4[physical(arg1)]
        end,
        getItems = function(arg1, arg2)
            return readDenseRange(num3, var4.getItem, arg1, arg2)
        end,
        subscribe = var3.subscribe,
        transaction = var3.transaction
    }

    function var4.pushFront(arg1)
        var4.pushFrontMany({ arg1 })
    end

    function var4.pushBack(arg1)
        var4.pushBackMany({ arg1 })
    end

    function var4.pushFrontMany(tbl5)
        local num4 = #tbl5
        if num4 == 0 then
            return
        end
        local num5 = num3
        local keys = claimMany(tbl5, 1)
        ensureCapacity(num3 + num4)
        num2 = (num2 - num4 - 1) % num1 + 1
        for value, value2 in tbl5 do
            local var6 = (num2 + value - 2) % num1 + 1
            tbl3[var6] = value2
            tbl4[var6] = keys[value]
        end
        num3 += num4
        var3.emit({ type = DataSourceChangeType.Insert, index = 1, keys = keys }, num5)
    end

    function var4.pushBackMany(tbl5)
        local num4 = #tbl5
        if num4 == 0 then
            return
        end
        local num5 = num3
        local keys = claimMany(tbl5, num3 + 1)
        ensureCapacity(num3 + num4)
        for value, value2 in tbl5 do
            local num6 = physical(num3 + value)
            tbl3[num6] = value2
            tbl4[num6] = keys[value]
        end
        num3 += num4
        var3.emit({ type = DataSourceChangeType.Insert, index = num5 + 1, keys = keys }, num5)
    end

    function var4.popFront()
        if num3 == 0 then
            return nil
        end
        local num4 = num3
        local var5 = tbl3[num2]
        tbl3[num2] = nil
        local var6 = tbl4[num2]
        tbl4[num2] = nil
        var1.release(var6)
        num2 = num2 % num1 + 1
        num3 -= 1
        var3.emit({ type = DataSourceChangeType.Remove, index = 1, keys = { var6 } }, num4)
        return var5
    end

    function var4.popBack()
        if num3 == 0 then
            return nil
        end
        local index = num3
        local num5 = physical(num3)
        local var5 = tbl3[num5]
        tbl3[num5] = nil
        local var6 = tbl4[num5]
        tbl4[num5] = nil
        var1.release(var6)
        num3 -= 1
        var3.emit({ type = DataSourceChangeType.Remove, index = index, keys = { var6 } }, index)

        return var5
    end

    function var4.setItem(num4: number, arg1)
        local num5 = num3
        assert(num4 >= 1 and num4 <= num5, "DataSource.deque: setItem index out of range")
        local num6 = physical(num4)
        local var5 = tbl4[num6]
        var1.assertPreserved(var5, arg1, num4)
        tbl3[num6] = arg1
        var3.emit({ type = DataSourceChangeType.Update, keys = { var5 } }, num5)
    end

    return var4
end

return createDequeDataSource
