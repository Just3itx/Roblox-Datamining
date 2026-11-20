-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _Types = require(ViewRecycler.Core.Types)
local createEvent = require(ViewRecycler.Internal.createEvent)
local readDenseRange = require(script.Parent.readDenseRange)

local function createMapDataSource(tbl1, func1: (...any) -> (...any))
    local tbl2 = ({})
    local event = createEvent()
    local num1 = 0
    local var1 = nil

    local function getItem(index: number)
        local input = tbl1.getItem(index)
        if num1 == 0 then
            return func1(input, index)
        end
        local itemKey = tbl1.getItemKey(index)
        local var2 = tbl2[itemKey]
        if var2 ~= nil and var2.input == input and var2.index == index then
            return var2.output
        end
        local output = func1(input, index)
        tbl2[itemKey] = { input = input, index = index, output = output }

        return output
    end

    local function connectChild() -- Luacid: Inlined by compiler; 1 call site recovered
        var1 = tbl1.subscribe(function(arg1)
            for _, value in arg1.changes do
                if value.type == DataSourceChangeType.Reset then
                    tbl2 = {}
                    break
                end
                if value.type ~= DataSourceChangeType.Update and value.type ~= DataSourceChangeType.Remove then
                    continue
                end

                for _, value2 in if value.type == DataSourceChangeType.Update then value.keys else value.keys do
                    tbl2[value2] = nil
                end
            end

            event.fire({ changes = arg1.changes, previousItemCount = arg1.previousItemCount, itemCount = arg1.itemCount })
        end)
    end

    return {
        getItemCount = tbl1.getItemCount,
        getItem = getItem,
        getItemKey = tbl1.getItemKey,
        getItems = function(arg1, arg2)
            return readDenseRange(tbl1.getItemCount(), getItem, arg1, arg2)
        end,
        subscribe = function(func2: (...any) -> (...any))
            if num1 == 0 then
                tbl2 = {}
                connectChild()
            end

            num1 += 1
            local var2 = event.connect(func2)
            local bool1 = true
            return function()
                if not bool1 then
                    return
                end
                bool1 = false
                var2()
                num1 -= 1
                if num1 == 0 and var1 ~= nil then
                    var1()
                    var1 = nil
                    tbl2 = {}
                end
            end
        end
    }
end

return createMapDataSource
