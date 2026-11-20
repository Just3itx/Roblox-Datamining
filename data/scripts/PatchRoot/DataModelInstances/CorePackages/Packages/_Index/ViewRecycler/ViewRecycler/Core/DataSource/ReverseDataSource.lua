-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _Types = require(ViewRecycler.Core.Types)

local TranslatedDataSource = require(script.Parent.TranslatedDataSource)

local function reversedKeys(keys) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1 = table.create(#keys)
    for k, key in keys do
        var1[#keys - k + 1] = key
    end
    return var1
end

local function createReverseDataSource(tbl1)
    return TranslatedDataSource(tbl1.getItemCount, function(arg1)
        return tbl1.getItem(tbl1.getItemCount() - arg1 + 1)
    end, function(arg1)
        return tbl1.getItemKey(tbl1.getItemCount() - arg1 + 1)
    end, function(callback)
        return tbl1.subscribe(function(arg1)
            local previousItemCount = arg1.previousItemCount
            local changes = {}
            for _, value in arg1.changes do
                if value.type == DataSourceChangeType.Insert then
                    table.insert(
                        changes,
                        {
                            type = DataSourceChangeType.Insert,
                            index = previousItemCount - value.index + 2,
                            keys = reversedKeys(value.keys)
                        }
                    )
                    previousItemCount += #value.keys
                elseif value.type == DataSourceChangeType.Remove then
                    table.insert(changes, {
                        type = DataSourceChangeType.Remove,
                        index = previousItemCount - value.index - #value.keys + 2,
                        keys = reversedKeys(value.keys)
                    })
                    previousItemCount -= #value.keys
                elseif value.type == DataSourceChangeType.Update then
                    table.insert(changes, { type = DataSourceChangeType.Update, keys = table.clone(value.keys) })
                elseif value.type == DataSourceChangeType.Move then
                    table.insert(changes, {
                        type = DataSourceChangeType.Move,
                        fromIndex = previousItemCount - value.fromIndex + 1,
                        toIndex = previousItemCount - value.toIndex + 1,
                        key = value.key
                    })
                elseif value.type == DataSourceChangeType.Reorder then
                    local keys = reversedKeys(value.keys)
                    table.insert(changes, { type = DataSourceChangeType.Reorder, keys = keys })
                elseif value.type == DataSourceChangeType.Reset then
                    local keys = reversedKeys(value.keys)
                    table.insert(changes, { type = DataSourceChangeType.Reset, keys = keys })
                    previousItemCount = #keys
                end
            end
            callback({ changes = changes, previousItemCount = arg1.previousItemCount, itemCount = arg1.itemCount })
        end)
    end)
end

return createReverseDataSource
