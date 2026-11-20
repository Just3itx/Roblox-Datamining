-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _Types = require(ViewRecycler.Core.Types)

local ItemKeyRegistry = require(script.Parent.ItemKeyRegistry)
local MutationController = require(script.Parent.MutationController)

local function createSequenceDataSource(tbl1, func1: ((...any) -> (...any))?)
    local var1 = table.clone(tbl1 or {})
    local var2 = ItemKeyRegistry.create(func1, "DataSource.sequence")
    local var3 = var2.rebuild(var1)

    local tbl2 = ({})
    local num1 = 0

    local function record(arg1) -- Luacid: Inlined by compiler; 7 call sites recovered
        if num1 > 0 then
            table.insert(tbl2, arg1)
        end
    end

    local function undo(arg1)
        local kind = arg1.kind
        if kind == "insert" then
            table.remove(var1, arg1.index)
            table.remove(var3, arg1.index)
            var2.release(arg1.key)
            return
        elseif kind == "remove" then
            for k, key in arg1.keys do
                table.insert(var1, arg1.index + k - 1, arg1.values[k])
                table.insert(var3, arg1.index + k - 1, key)
                var2.adopt(key)
            end

            return
        elseif kind == "set" then
            var1[arg1.index] = arg1.value
            return
        end

        if kind == "move" then
            local var4 = table.remove(var1, arg1.toIndex)
            local var5 = table.remove(var3, arg1.toIndex)
            table.insert(var1, arg1.fromIndex, var4)
            table.insert(var3, arg1.fromIndex, var5)
        else
            var1 = arg1.values
            var3 = arg1.keys
            if arg1.keyRegistry ~= nil then
                var2.restore(arg1.keyRegistry)
            end
        end
    end

    local function closeTransaction() -- Luacid: Inlined by compiler; 1 call site recovered
        num1 -= 1
        if num1 == 0 then
            table.clear(tbl2)
        end
    end

    local var4 = MutationController(function(): number
        return #var1
    end, function(): number
        num1 += 1
        return #tbl2
    end, function(arg1)
        for i = #tbl2, arg1 + 1, -1 do
            undo(tbl2[i])
            tbl2[i] = nil
        end

        closeTransaction()
    end, closeTransaction)

    local module = {
        getItemCount = function(): number
            return #var1
        end,
        getItem = function(arg1)
            return var1[arg1]
        end,
        getItemKey = function(arg1)
            return var3[arg1]
        end,
        getItems = function(num2: number, num3: number)
            return table.move(var1, num2, num3, 1, {})
        end,
        subscribe = var4.subscribe,
        transaction = var4.transaction
    }

    function module.append(arg1)
        module.insert(#var1 + 1, arg1)
    end

    function module.prepend(arg1)
        module.insert(1, arg1)
    end

    function module.insert(index: number, arg1)
        local num2 = #var1
        assert(index >= 1 and index <= num2 + 1, "DataSource.sequence: insert index out of range")
        local key = var2.claim(arg1, index)
        table.insert(var1, index, arg1)
        table.insert(var3, index, key)
        record({ kind = "insert", index = index, key = key })
        var4.emit({ type = DataSourceChangeType.Insert, index = index, keys = { key } }, num2)
    end

    function module.remove(index: number, num2: number?)
        local num3 = #var1
        local num4 = num2 or 1
        assert(num4 > 0 and index >= 1 and index + num4 - 1 <= num3, "DataSource.sequence: remove range out of range")

        local keys = table.create(num4)
        local values = table.create(num4)
        for i = 1, num4 do
            values[i] = table.remove(var1, index)
            local var7 = table.remove(var3, index)
            keys[i] = var7
            var2.release(var7)
        end
        record({ kind = "remove", index = index, keys = keys, values = values })
        var4.emit({ type = DataSourceChangeType.Remove, index = index, keys = keys }, num3)
    end

    function module.setItem(index: number, arg1)
        local num2 = #var1
        assert(index >= 1 and index <= num2, "DataSource.sequence: setItem index out of range")
        local var5 = var3[index]
        var2.assertPreserved(var5, arg1, index)
        record({ kind = "set", index = index, value = var1[index] })
        var1[index] = arg1
        var4.emit({ type = DataSourceChangeType.Update, keys = { var5 } }, num2)
    end

    function module.moveItem(fromIndex: number, toIndex: number)
        local num2 = #var1
        assert(fromIndex >= 1 and fromIndex <= num2, "DataSource.sequence: moveItem source index out of range")

        assert(toIndex >= 1 and toIndex <= num2, "DataSource.sequence: moveItem destination index out of range")

        if fromIndex == toIndex then
            return
        end
        local var5 = table.remove(var1, fromIndex)
        local key = table.remove(var3, fromIndex)
        table.insert(var1, toIndex, var5)
        table.insert(var3, toIndex, key)
        record({ kind = "move", fromIndex = fromIndex, toIndex = toIndex })
        var4.emit({ type = DataSourceChangeType.Move, fromIndex = fromIndex, toIndex = toIndex, key = key }, num2)
    end

    function module.reorder(tbl3)
        local num2 = #var1
        assert(#tbl3 == num2, "DataSource.sequence: reorder must contain every key")
        local tbl4 = ({})
        for value, value2 in var3 do
            tbl4[value2] = var1[value]
        end
        local var5 = table.create(num2)
        local var6 = table.create(num2)
        local tbl5 = ({})
        for value, value2 in tbl3 do
            assert(not (tbl4[value2] == nil) and tbl5[value2] == nil, "DataSource.sequence: reorder must contain every key once")

            tbl5[value2] = true
            var5[value] = tbl4[value2]
            var6[value] = value2
        end
        record({ kind = "replace", values = var1, keys = var3 })
        var1 = var5
        var3 = var6
        var4.emit({ type = DataSourceChangeType.Reorder, keys = table.clone(var6) }, num2)
    end

    function module.replaceItems(index: number, num2: number, tbl3)
        assert(index >= 1 and index <= num2 and num2 <= #var1, "DataSource.sequence: replaceItems range out of range")

        var4.transaction(function()
            module.remove(index, num2 - index + 1)
            if #tbl3 == 0 then
                return
            end

            local num3 = #var1
            record({ kind = "replace", values = var1, keys = var3, keyRegistry = var2.snapshot() })
            local keys = table.create(#tbl3)
            for value, value2 in tbl3 do
                keys[value] = var2.claim(value2, index + value - 1)
            end

            local var6 = table.create(num3 + #tbl3)
            local var7 = table.create(num3 + #tbl3)
            if index > 1 then
                table.move(var1, 1, index - 1, 1, var6)
                table.move(var3, 1, index - 1, 1, var7)
            end
            for value, value2 in tbl3 do
                local var8 = index + value - 1
                var6[var8] = value2
                var7[var8] = keys[value]
            end
            if index <= num3 then
                table.move(var1, index, num3, index + #tbl3, var6)
                table.move(var3, index, num3, index + #tbl3, var7)
            end
            var1 = var6
            var3 = var7
            var4.emit({ type = DataSourceChangeType.Insert, index = index, keys = keys }, num3)
        end)
    end

    function module.reset(tbl3)
        local num2 = #var1
        local var5 = table.clone(tbl3)
        local keyRegistry = if num1 > 0 then var2.snapshot() else nil
        local var7 = var2.rebuild(var5)
        record({ kind = "replace", values = var1, keys = var3, keyRegistry = keyRegistry })
        var1 = var5
        var3 = var7
        var4.emit({ type = DataSourceChangeType.Reset, keys = table.clone(var7) }, num2)
    end

    return module
end

return createSequenceDataSource
