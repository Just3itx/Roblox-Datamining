-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _Types = require(ViewRecycler.Core.Types)

local KeyUtils = require(script.Parent.KeyUtils)
local TranslatedDataSource = require(script.Parent.TranslatedDataSource)

local function createConcatDataSource(...)
    local tbl1 = { ... }

    local function resolve(num1: number)
        for _, value in tbl1 do
            if num1 <= value.getItemCount() then
                return value, num1
            end
            num1 -= value.getItemCount()
        end
        error("DataSource.concat: index out of range")
    end

    local var1 = TranslatedDataSource(function() -- name: getItemCount
        local num1 = 0
        for _, value in tbl1 do
            num1 += value.getItemCount()
        end
        return num1
    end, function(arg1)
        local var1, num1 = resolve(arg1)
        return var1.getItem(num1)
    end, function(arg1)
        local var1, num1 = resolve(arg1)
        return var1.getItemKey(num1)
    end, function(callback)
        local tbl2 = ({})
        for value, value2 in tbl1 do
            local var1 = table.create(value2.getItemCount())
            for i = 1, value2.getItemCount() do
                var1[i] = value2.getItemKey(i)
            end
            tbl2[value] = var1
        end
        local function collectAllKeys()
            local result = {}
            for _, value in tbl2 do
                for _, value2 in value do
                    table.insert(result, value2)
                end
            end
            return result
        end
        local function validateCurrentKeys() -- Luacid: Inlined by compiler; 1 call site recovered
            KeyUtils.validateUnique(collectAllKeys(), "DataSource.concat")
        end
        local tbl3 = {}
        for value, value2 in tbl1 do
            table.insert(tbl3, value2.subscribe(function(arg1)
                local num1 = 0
                for i = 1, value - 1 do
                    num1 += #tbl2[i]
                end
                local num2 = 0
                for _, value3 in tbl2 do
                    num2 += #value3
                end
                local var1 = tbl2[value]
                local changes = {}
                for _, value3 in arg1.changes do
                    if value3.type == DataSourceChangeType.Insert then
                        for k, key in value3.keys do
                            table.insert(var1, value3.index + k - 1, key)
                        end
                        table.insert(
                            changes,
                            {
                                type = DataSourceChangeType.Insert,
                                index = num1 + value3.index,
                                keys = table.clone(value3.keys)
                            }
                        )
                    elseif value3.type == DataSourceChangeType.Remove then
                        for _ = 1, #value3.keys do
                            table.remove(var1, value3.index)
                        end
                        table.insert(
                            changes,
                            {
                                type = DataSourceChangeType.Remove,
                                index = num1 + value3.index,
                                keys = table.clone(value3.keys)
                            }
                        )
                    elseif value3.type == DataSourceChangeType.Update then
                        table.insert(changes, { type = DataSourceChangeType.Update, keys = table.clone(value3.keys) })
                    elseif value3.type == DataSourceChangeType.Move then
                        table.insert(var1, value3.toIndex, table.remove(var1, value3.fromIndex))
                        table.insert(changes, {
                            type = DataSourceChangeType.Move,
                            fromIndex = num1 + value3.fromIndex,
                            toIndex = num1 + value3.toIndex,
                            key = value3.key
                        })
                    elseif value3.type == DataSourceChangeType.Reorder then
                        tbl2[value] = table.clone(value3.keys)
                        var1 = tbl2[value]
                        table.insert(changes, { type = DataSourceChangeType.Reorder, keys = collectAllKeys() })
                    elseif value3.type == DataSourceChangeType.Reset then
                        tbl2[value] = table.clone(value3.keys)
                        var1 = tbl2[value]
                        table.insert(changes, { type = DataSourceChangeType.Reset, keys = collectAllKeys() })
                    end
                end

                validateCurrentKeys()
                callback({ changes = changes, previousItemCount = num2, itemCount = #collectAllKeys() })
            end))
        end

        return function()
            for _, value in tbl3 do
                value()
            end
        end
    end)

    local tbl2 = ({})
    for i = 1, var1.getItemCount() do
        tbl2[i] = var1.getItemKey(i)
    end
    KeyUtils.validateUnique(tbl2, "DataSource.concat")
    return var1
end

return createConcatDataSource
