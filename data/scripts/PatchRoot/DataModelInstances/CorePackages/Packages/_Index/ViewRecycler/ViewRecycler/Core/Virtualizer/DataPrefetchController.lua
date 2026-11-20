-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataPrefetch = require(ViewRecycler.Core.DataPrefetch)
local _ItemSequence = require(ViewRecycler.Core.Virtualizer.ItemSequence)
local Types = require(ViewRecycler.Core.Types)

local var1 = table.freeze({})
local var2 = table.freeze({ startItems = 0, endItems = 0 })

local function sameRange(range, arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return range.firstIndex == arg1.firstIndex and range.lastIndex == arg1.lastIndex
end

local function sameOptions(arg1, arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.startItems == arg2.startItems and arg1.endItems == arg2.endItems
end

local function createDataPrefetchController(arg1)
    local bool1 = false
    local itemSequence = nil
    local var3 = DataPrefetch.resolve(arg1)
    local tbl1 = ({})

    local function createRequest(edge, arg2)
        local tbl2 = {
            range = table.freeze(arg2)
        }
        tbl1[edge] = tbl2
        return table.freeze({
            edge = edge,
            range = tbl2.range,
            isCurrent = function(): boolean
                return not bool1 and tbl1[edge] == tbl2
            end
        })
    end

    local function desiredRange(start, num1: number, mountedRange, arg2)
        local var4 = if start == DataPrefetch.Edge.Start then arg2.startItems else arg2.endItems

        if var4 == 0 then
            return nil
        end

        local tbl2

        if start == DataPrefetch.Edge.Start then
            tbl2 = { firstIndex = 0, lastIndex = 0 }
            local var5 = mountedRange.firstIndex - var4
            tbl2.firstIndex = math.max(1, var5)
            tbl2.lastIndex = mountedRange.firstIndex - 1
        else
            tbl2 = {
                firstIndex = mountedRange.lastIndex + 1,
                lastIndex = 0
            }
            local var5 = mountedRange.lastIndex + var4
            tbl2.lastIndex = math.min(num1, var5)
        end
        return if Types.isIndexRangeEmpty(tbl2) then nil else tbl2
    end

    local function reconcileEdge(edge, arg2, tbl2)
        local var4 = tbl1[edge]
        if arg2 == nil then
            tbl1[edge] = nil
            return tbl2
        end

        if var4 == nil or not sameRange(var4.range, arg2) then
            tbl2 = tbl2 or {}
            table.insert(tbl2, createRequest(edge, arg2))
        end
        return tbl2
    end

    return {
        reconcile = function(tbl2)
            assert(not bool1, "DataPrefetchController: cannot reconcile after destroy")
            local options = tbl2.options
            local var4 = if options == nil then 0 else options.startItems or 0
            local var5 = if options == nil then 0 else options.endItems or 0
            if var4 == 0 and var5 == 0 then
                if itemSequence ~= tbl2.itemSequence or not sameOptions(var3, var2) then
                    table.clear(tbl1)
                end
                itemSequence = tbl2.itemSequence
                var3 = var2
                return var1
            end

            local var6 = DataPrefetch.resolve(tbl2.options)
            local mountedRange = tbl2.mountedRange
            local var7 = if Types.isIndexRangeEmpty(mountedRange) then 0 else tbl2.itemSequence.getItemCount()
            local var8, var9

            if Types.isIndexRangeEmpty(mountedRange) then
                var8 = nil
                var9 = nil
            else
                var8 = desiredRange(DataPrefetch.Edge.Start, var7, mountedRange, var6)
                var9 = desiredRange(DataPrefetch.Edge.End, var7, mountedRange, var6)
            end

            if itemSequence ~= tbl2.itemSequence or not sameOptions(var3, var6) then
                table.clear(tbl1)
            end
            itemSequence = tbl2.itemSequence
            var3 = var6

            local var10 = reconcileEdge(DataPrefetch.Edge.Start, var8, nil)
            return reconcileEdge(DataPrefetch.Edge.End, var9, var10) or var1
        end,
        destroy = function()
            if bool1 then
                return
            end
            bool1 = true
            table.clear(tbl1)
        end
    }
end

return createDataPrefetchController
