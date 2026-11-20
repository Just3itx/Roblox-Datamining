-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _DataSource = require(ViewRecycler.Core.DataSource)
local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local Diagnostics = require(ViewRecycler.Core.Diagnostics)
local _Layout = require(ViewRecycler.Core.Layout)
local PlacementTypes = require(ViewRecycler.Core.Placement.PlacementTypes)
local ShallowTable = require(ViewRecycler.Internal.ShallowTable)
local Types = require(ViewRecycler.Core.Types)
local _SlotBinder = require(ViewRecycler.Core.Recycling.SlotBinder)

local cloneFrozen = ShallowTable.cloneFrozen
local containsEqual = ShallowTable.containsEqual
local optionalContainsEqual = ShallowTable.optionalContainsEqual

local ITEM_LAYOUT_KEYS = Types.ITEM_LAYOUT_KEYS
local ITEM_PLACEMENT_KEYS = PlacementTypes.ITEM_PLACEMENT_KEYS
local var1 = table.freeze({ firstIndex = 1, lastIndex = 0 })
local placements = table.freeze({})
local var3 = table.freeze({})
local var4 = table.freeze(
    {
        retainedItems = var3,
        additionalItems = var3,
        placements = placements,
        hasViewportRelativePlacements = false
    }
)

local function sameRange(mountedRange, arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return mountedRange.firstIndex == arg1.firstIndex and mountedRange.lastIndex == arg1.lastIndex
end

local function measuresSameContent(state, state2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if state == state2 then
        return true
    end
    local itemLayout = state.itemLayout
    local itemLayout2 = state2.itemLayout

    return state.assignment == state2.assignment
        and state.pinnedPosition == state2.pinnedPosition
        and itemLayout.crossAxisIndex == itemLayout2.crossAxisIndex
        and itemLayout.crossAxisCount == itemLayout2.crossAxisCount
        and itemLayout.crossAxisSpacing == itemLayout2.crossAxisSpacing
end

local function resolveLayout(arg1, arg2, bool1: boolean?)
    if arg2 ~= nil and containsEqual(arg2, arg1, ITEM_LAYOUT_KEYS) then
        return arg2
    elseif table.isfrozen(arg1) then
        return arg1
    elseif bool1 then
        return (table.freeze(arg1))
    end

    return (cloneFrozen(arg1))
end

local function resolvePlacement(arg1, num1: number, state)
    local tbl1 = placements
    local var5 = nil
    if arg1 ~= nil and arg1.viewportRelative then
        local mainAxisEndLimit = arg1.mainAxisEndLimit
        tbl1 = {
            mainAxisOffset = num1 + (arg1.mainAxisOffset or 0),
            mainAxisLength = arg1.mainAxisLength,
            mainAxisEndLimit = if mainAxisEndLimit == nil then nil else num1 + mainAxisEndLimit,
            zIndex = arg1.zIndex
        }
        var5 = {
            mainAxisOffset = arg1.mainAxisOffset,
            mainAxisLength = arg1.mainAxisLength,
            mainAxisEndLimit = mainAxisEndLimit,
            viewportRelative = true,
            zIndex = arg1.zIndex
        }
    elseif arg1 ~= nil then
        tbl1 = {
            mainAxisOffset = arg1.mainAxisOffset,
            mainAxisLength = arg1.mainAxisLength,
            mainAxisEndLimit = arg1.mainAxisEndLimit,
            zIndex = arg1.zIndex
        }
    end
    if state ~= nil and containsEqual(state.canvasPlacement, tbl1, ITEM_PLACEMENT_KEYS) then
        tbl1 = state.canvasPlacement
    elseif tbl1 ~= placements then
        table.freeze(tbl1)
    end
    if state ~= nil and optionalContainsEqual(state.viewportPlacement, var5, ITEM_PLACEMENT_KEYS) then
        return tbl1, state.viewportPlacement
    end

    if var5 ~= nil then
        table.freeze(var5)
    end
    return tbl1, var5
end

local distanceFrom = nil
local sortByIndex = nil
local prioritizeSlots = nil
if FFlagViewRecyclerReact084 then
    distanceFrom = function(arg1, arg2)
        local index = arg2.index
        if index == nil or arg2.side then
            return 0
        end

        if index < arg1.firstIndex then
            return arg1.firstIndex - index
        end
        return math.max(0, index - arg1.lastIndex)
    end

    sortByIndex = function(tbl1)
        for i = 2, #tbl1 do
            local var5 = tbl1[i]

            while i > 1 and tbl1[i - 1].index > var5.index do
                tbl1[i] = tbl1[i - 1]
                i -= 1
            end
            tbl1[i] = var5
        end
    end

    prioritizeSlots = function(tbl1, arg1, tbl2, tbl3)
        local firstIndex = arg1.firstIndex
        local lastIndex = arg1.lastIndex
        local num1 = 0
        for _, value in tbl1 do
            local index = value.index
            if index == nil or value.side or firstIndex <= index and index <= lastIndex then
                num1 += 1
                tbl1[num1] = value
            elseif index < firstIndex then
                table.insert(tbl2, value)
            else
                table.insert(tbl3, value)
            end
        end
        sortByIndex(tbl2)
        sortByIndex(tbl3)
        local num2 = #tbl2
        local num3 = 1
        for i = num1 + 1, #tbl1 do
            local var5

            if num2 >= 1 and (tbl3[num3] == nil or firstIndex - tbl2[num2].index <= tbl3[num3].index - lastIndex) then
                var5 = tbl2[num2]
                num2 -= 1
            else
                var5 = tbl3[num3]
                num3 += 1
            end
            tbl1[i] = var5
        end
        table.clear(tbl2)
        table.clear(tbl3)
    end
end

local function createListRows(tbl1)
    local slotBinder = tbl1.slotBinder

    local isReadyOnAssignment = if FFlagViewRecyclerReact084 then tbl1.isReadyOnAssignment else nil

    local bool1 = false

    local tbl2 = {}
    local tbl3 = {}
    local bool2 = true
    local tbl4 = ({})
    local tbl5 = {}
    local isApplied = false
    local var5 = var1

    local var6 = if FFlagViewRecyclerReact084 then nil else nil

    local num1 = 0
    local var7 = nil
    local var8 = var4
    local num2 = 0
    local getMountedViews = var3

    local bool4 = false
    local bool5 = false
    local bool6 = false
    local tbl6 = ({})

    local var10 = nil
    local var11 = var1

    local function knownRange() -- Luacid: Inlined by compiler; 3 call sites recovered
        return if isApplied then var5 elseif var10 == nil then var1 else var11
    end

    local function noteDataChange(arg1)
        for _, value in arg1.changes do
            local type = value.type
            if type == DataSourceChangeType.Reset then
                bool4 = true
                bool5 = true
            elseif type == DataSourceChangeType.Reorder then
                bool4 = true
            elseif type == DataSourceChangeType.Update then
                for _, key in value.keys do
                    tbl6[key] = true
                end
            elseif type == DataSourceChangeType.Insert then
                for _, key in value.keys do
                    tbl6[key] = true
                end

                local var12 = knownRange()

                if not bool4 and not Types.isIndexRangeEmpty(var12) and value.index <= var12.lastIndex then
                    bool4 = true
                end
            elseif type == DataSourceChangeType.Remove then
                local var12 = knownRange()

                if not bool4 and not Types.isIndexRangeEmpty(var12) and value.index <= var12.lastIndex then
                    bool4 = true
                end
            elseif type == DataSourceChangeType.Move then
                local var12 = knownRange()

                if not (bool4 or Types.isIndexRangeEmpty(var12))
                    and math.min(value.fromIndex, value.toIndex) <= var12.lastIndex
                    and math.max(value.fromIndex, value.toIndex) >= var12.firstIndex
                then
                    bool4 = true
                end
            end
        end
    end

    local function publish(tbl7, itemLayout, canvasPlacement, viewportPlacement, contentStartOffset: number): boolean
        local state = tbl7.state
        local assignment = tbl7.assignment
        if state ~= nil
            and state.assignment == assignment
            and state.index == tbl7.index
            and state.pinnedPosition == tbl7.pinnedPosition
            and state.itemLayout == itemLayout
            and state.canvasPlacement == canvasPlacement
            and state.viewportPlacement == viewportPlacement
            and state.contentStartOffset == contentStartOffset
            and tbl7.record.itemView == tbl7.view
        then
            return false
        end
        local var2 = table.freeze({
            assignment = assignment,
            index = tbl7.index,
            pinnedPosition = tbl7.pinnedPosition,
            itemLayout = itemLayout,
            canvasPlacement = canvasPlacement,
            viewportPlacement = viewportPlacement,
            contentStartOffset = contentStartOffset
        })
        tbl7.state = var2
        tbl7.record = table.freeze({ itemView = tbl7.view, state = var2 })
        return true
    end

    local num3 = 0
    local dataSource = nil
    local layout = nil
    local scrollOffset = 0
    local contentStartOffset = 0
    local bool7 = false
    local firstIndex = 0
    local num4 = 0
    local tbl7 = {}
    local tbl8 = {}
    local num5 = 0

    local var12 = nil
    local var13 = nil
    if FFlagViewRecyclerReact084 then
        var12 = {}
        var13 = {}
    end
    local var14 = var3
    local var15 = var3
    local var16 = nil
    local tbl9 = {}

    local function enter(key: string, index: number?, value, viewType) -- Luacid: Inlined by compiler; 7 call sites recovered
        local tbl10 = {
            key = key,
            value = value,
            viewType = viewType,
            index = index,
            side = false,
            epoch = num3,
            entered = true,
            changed = true
        }

        num5 += 1
        table.insert(tbl7, tbl10)
        return tbl10
    end

    local function replace(tbl10, arg1, itemViewType) -- Luacid: Inlined by compiler; 2 call sites recovered
        table.insert(tbl8, tbl10.key)
        local tbl11 = enter(tbl10.key, tbl10.index, arg1, itemViewType)
        tbl11.side = tbl10.side
        return tbl11
    end

    local function claim(tbl10, str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        assert(tbl10.epoch ~= num3, `Virtualizer: duplicate key "{str1}"`)
        tbl10.epoch = num3
        tbl10.entered = false
        tbl10.changed = false
    end

    local function enterIndex(index: number)
        local itemKey = dataSource.getItemKey(index)
        local var17 = tbl4[itemKey]
        if var17 == nil then
            local item = dataSource.getItem(index)
            return enter(itemKey, index, item, (tbl1.getItemViewType(item, index)))
        end

        claim(var17, itemKey)
        var17.index = index
        var17.side = false
        return var17
    end

    local function reread(tbl10, changed: boolean): {changed: boolean, entered: boolean, epoch: number, index: number?, key: string, side: boolean, value: any, viewType: any}?
        local index = tbl10.index
        if index == nil or tbl10.entered then
            return nil
        end
        local value = dataSource.getItem(index)
        local viewType = tbl1.getItemViewType(value, index)
        if viewType ~= tbl10.viewType then
            local tbl11 = replace(tbl10, value, viewType)
            return tbl11
        end

        table.insert(tbl7, { key = tbl10.key, value = value, viewType = viewType, changed = changed })

        return nil
    end

    local function restate(tbl10)
        local state = tbl10.state
        local itemLayout = if state == nil then nil else state.itemLayout
        local var17 = tbl9[tbl10.key]
        local index = tbl10.index
        if index == nil then
            itemLayout = resolveLayout({ startOffset = 0, length = if var17 == nil then 0 else var17.mainAxisLength or 0 }, itemLayout, true)
        elseif itemLayout == nil or bool7 or state.index ~= index then
            if var16 ~= nil and firstIndex <= index and index <= num4 then
                itemLayout = resolveLayout(var16[index - firstIndex + 1], itemLayout, true)
            else
                itemLayout = resolveLayout(layout.getItemLayout(index), itemLayout)
            end
        end

        local var18 = placements
        local var19

        if var17 == nil and (state == nil or state.canvasPlacement == placements) then
            var19 = nil
        else
            var18, var19 = resolvePlacement(var17, scrollOffset, state)
        end
        if not publish(tbl10, itemLayout, var18, var19, contentStartOffset) then
            return
        end

        if tbl10.entered then
            var14 = table.isfrozen(var14) and {} or var14
            table.insert(var14, tbl10.record)
            return
        end
        var15 = table.isfrozen(var15) and {} or var15
        table.insert(var15, tbl10.record)
    end

    local var17 = nil
    var17 = FFlagViewRecyclerReact084 and function(tbl10, arg1, num6: number) -- name: keepReadyViewsAhead
        local var18 = isReadyOnAssignment
        local tbl11 = {}
        local tbl12 = {}
        for _, row in tbl10 do
            local index = row.index
            local bool8 = num6 > 0 and index < arg1.firstIndex or num6 < 0 and arg1.lastIndex < index
            local bool9 = index < arg1.firstIndex or arg1.lastIndex < index
            if var18(row.view) then
                if bool8 or num6 == 0 and bool9 then
                    table.insert(tbl12, { row = row, distance = distanceFrom(arg1, row) })
                end
            elseif not bool8 then
                table.insert(tbl11, { row = row, distance = distanceFrom(arg1, row) })
            end
        end
        if #tbl11 == 0 or #tbl12 == 0 then
            return
        end
        table.sort(tbl11, function(arg2, arg3): boolean
            return arg2.distance < arg3.distance
        end)
        table.sort(tbl12, function(arg2, arg3): boolean
            return arg2.distance > arg3.distance
        end)
        local tbl13 = ({})
        for _, value in tbl11 do
            local row = value.row
            for value2, value3 in tbl12 do
                if tbl13[value2] or value3.row.viewType ~= row.viewType then
                    continue
                end

                if num6 ~= 0 or not (value3.distance <= value.distance) then
                    tbl13[value2] = true
                    local row2 = value3.row
                    local view = row.view
                    row.view = row2.view
                    row2.view = view
                    tbl5[row.view] = row
                    tbl5[row2.view] = row2
                    row.entered = true
                    row2.entered = true
                end

                break
            end
        end
    end or var17

    local function release()
        if not isApplied then
            return var3
        end
        if bool2 and #tbl2 > 0 and not bool4 then
            local var18 = table.create(#tbl2)
            for value, value2 in tbl2 do
                var18[value] = value2.key
            end
            var10 = var18
            var11 = var5
        else
            var10 = nil
        end
        bool4 = false
        local var18 = slotBinder.releaseAll()
        tbl2 = {}
        tbl3 = {}
        bool2 = true
        tbl4 = {}
        tbl5 = {}
        isApplied = false
        var5 = var1

        if FFlagViewRecyclerReact084 then
            var6 = nil
        end
        var8 = var4
        var7 = nil
        getMountedViews = var3
        return var18
    end

    return {
        noteDataChange = noteDataChange,
        invalidateKeys = function()
            bool4 = true
        end,
        invalidatePayloads = function()
            bool5 = true
        end,
        invalidateLayout = function()
            bool6 = true
        end,
        apply = function(tbl10)
            if bool1 then
                return nil, nil
            end
            dataSource = tbl10.dataSource
            layout = tbl10.layout
            local var18 = tbl10.plan or var4
            local mountedRange = tbl10.mountedRange
            scrollOffset = tbl10.scrollOffset
            contentStartOffset = tbl10.contentStartOffset
            bool7 = bool6 or layout ~= var7
            local bool8 = contentStartOffset ~= num1
            local bool9 = not sameRange(mountedRange, var5)
            local bool10 = next(tbl6) ~= nil

            if isApplied
                and not bool4
                and not bool5
                and not bool7
                and not bool8
                and not bool9
                and not bool10
                and var18 == var8
            then
                return nil, nil
            end

            num2 += 1
            num3 = num2
            local itemCount = dataSource.getItemCount()
            firstIndex = mountedRange.firstIndex
            num4 = math.min(mountedRange.lastIndex, itemCount)
            local num6 = math.max(0, num4 - firstIndex + 1)
            local var19 = table.create(num6)
            local tbl11 = ({})
            table.clear(tbl7)
            local tbl12 = {}
            table.clear(tbl8)
            num5 = 0
            local bool11 = not isApplied or not bool2 or bool4
            local bool12 = bool11 or bool7 or bool8

            if not bool11 then
                local firstIndex2 = var5.firstIndex
                local lastIndex = var5.lastIndex
                local num7 = math.max(firstIndex2, firstIndex)
                local num8 = math.min(lastIndex, num4)
                local var20 = firstIndex - 1

                for i = firstIndex2, math.min(lastIndex, var20) do
                    table.insert(tbl12, tbl2[i - firstIndex2 + 1])
                end
                local num9 = num4 + 1

                for i = math.max(firstIndex2, num9), lastIndex do
                    table.insert(tbl12, tbl2[i - firstIndex2 + 1])
                end
                for _, value in tbl3 do
                    table.insert(tbl12, value)
                end
                if num7 <= num8 then
                    table.move(tbl2, num7 - firstIndex2 + 1, num8 - firstIndex2 + 1, num7 - firstIndex + 1, var19)

                    for i = num7 - firstIndex + 1, num8 - firstIndex + 1 do
                        local var21 = var19[i]
                        var21.epoch = num3
                        var21.entered = false
                        var21.changed = false
                    end
                end
                local var21 = firstIndex
                local num10 = num4
                local num11 = num7 - 1

                for i = var21, math.min(num10, num11) do
                    var19[i - firstIndex + 1] = enterIndex(i)
                end
                local var22 = firstIndex
                local num12 = num8 + 1

                for i = math.max(var22, num12), num4 do
                    var19[i - firstIndex + 1] = enterIndex(i)
                end
            else
                local var20 = if bool4 or isApplied then nil else var10

                for index = firstIndex, num4 do
                    local var21 = if var20 ~= nil and var11.firstIndex <= index and index <= var11.lastIndex then var20[index - var11.firstIndex + 1] else dataSource.getItemKey(index)
                    local var22 = tbl4[var21]
                    if var22 ~= nil then
                        claim(var22, var21)
                        var22.index = index
                        var22.side = false
                        var19[index - firstIndex + 1] = var22
                    else
                        local item = dataSource.getItem(index)
                        var19[index - firstIndex + 1] = enter(var21, index, item, (tbl1.getItemViewType(item, index)))
                    end
                end
                for _, value in tbl4 do
                    if value.epoch ~= num3 then
                        table.insert(tbl12, value)
                    end
                end
            end

            for _, retainedItem in var18.retainedItems do
                local bool13 = false

                if not (retainedItem.index < firstIndex) then
                    local index = retainedItem.index
                    bool13 = not (num4 < index)
                end

                if bool13 then
                    continue
                end

                local var20 = tbl4[retainedItem.key]
                if var20 ~= nil then
                    claim(var20, retainedItem.key)
                    var20.index = retainedItem.index
                    var20.side = true
                    table.insert(tbl11, var20)
                else
                    local item = dataSource.getItem(retainedItem.index)
                    local tbl13 = enter(retainedItem.key, retainedItem.index, item, (tbl1.getItemViewType(item, retainedItem.index)))
                    tbl13.side = true
                    table.insert(tbl11, tbl13)
                end
            end

            for _, additionalItem in var18.additionalItems do
                local position = additionalItem.identity.position
                local pinnedItem = tbl1.getPinnedItem(position)
                if pinnedItem == nil or pinnedItem.key ~= additionalItem.key then
                    continue
                end

                local var20 = tbl4[additionalItem.key]

                if var20 ~= nil then
                    claim(var20, additionalItem.key)

                    if var20.viewType ~= pinnedItem.itemViewType then
                        local tbl13 = replace(var20, pinnedItem.value, pinnedItem.itemViewType)
                        var20 = tbl13
                    elseif var20.value ~= pinnedItem.value then
                        table.insert(tbl7, { key = additionalItem.key, value = pinnedItem.value, viewType = pinnedItem.itemViewType })
                    end
                else
                    var20 = enter(additionalItem.key, nil, pinnedItem.value, pinnedItem.itemViewType)
                end
                var20.index = nil
                var20.side = true
                var20.pinnedPosition = position
                var20.pinnedRevision = additionalItem.identity.revision
                table.insert(tbl11, var20)
            end

            if bool5 then
                for value, value2 in var19 do
                    var19[value] = reread(value2, false) or value2
                end
                for value, value2 in tbl11 do
                    tbl11[value] = reread(value2, false) or value2
                end
            elseif bool10 then
                for value in tbl6 do
                    local var20 = tbl4[value]
                    if var20 == nil or var20.epoch ~= num3 then
                        continue
                    end

                    local var21 = reread(var20, true)
                    if var21 == nil then
                        continue
                    end

                    if var20.side then
                        tbl11[table.find(tbl11, var20)] = var21
                    else
                        var19[var20.index - firstIndex + 1] = var21
                    end
                end
            end

            for _, value in tbl12 do
                if value.epoch ~= num3 then
                    table.insert(tbl8, value.key)
                end
            end

            local visibleRange

            if FFlagViewRecyclerReact084 then
                visibleRange = tbl10.visibleRange
                if visibleRange ~= nil and isReadyOnAssignment ~= nil and num5 > 1 then
                    prioritizeSlots(tbl7, visibleRange, var12, var13)
                end
            else
                visibleRange = nil
            end

            local var20 = slotBinder.apply(tbl8, tbl7)

            for _, value in tbl8 do
                local var21 = tbl4[value]
                tbl4[value] = nil
                tbl5[var21.view] = nil
            end
            for _, value in var20.entered do
                tbl4[value.key] = value
                tbl5[value.view] = value
            end
            for _, value in var20.updated do
                value.changed = true
            end

            if FFlagViewRecyclerReact084 and visibleRange ~= nil and isReadyOnAssignment ~= nil then
                local var21 = if var6 == nil then 0 else math.sign(scrollOffset - var6)
                var17(var19, visibleRange, var21)
            end

            local reassigned = #tbl8 - #var20.departed

            var14 = var3
            var15 = var3

            var16 = nil

            if num6 > 1 and layout.getItemLayouts ~= nil and (bool12 and (bool7 or not isApplied) or num6 < num5 * 2) then
                local var21 = table.create(num6)
                layout.getItemLayouts(firstIndex, num4, var21)
                var16 = var21
            end
            tbl9 = var18.placements
            local placements = var8.placements

            if bool12 then
                for _, value in var19 do
                    restate(value)
                end
            else
                for _, value in var19 do
                    if value.entered or value.changed then
                        restate(value)
                    end
                end
                for value in tbl9 do
                    local var21 = tbl4[value]
                    if var21 ~= nil and not (var21.side or var21.entered or var21.changed) then
                        restate(var21)
                    end
                end
                for k in placements do
                    local var21 = tbl4[k]
                    if var21 ~= nil and tbl9[k] == nil and not (var21.side or var21.entered or var21.changed) then
                        restate(var21)
                    end
                end
            end
            for _, value in tbl11 do
                restate(value)
            end

            local bool13 = #var19 ~= #tbl2 or #tbl11 ~= #tbl3 or bool9
            if not bool13 and bool11 then
                for value, value2 in var19 do
                    if tbl2[value] ~= value2 then
                        bool13 = true
                        break
                    end
                end
            end

            if not bool13 then
                for value, value2 in tbl11 do
                    if tbl3[value] ~= value2 then
                        bool13 = true
                        break
                    end
                end
            end

            tbl2 = var19
            tbl3 = tbl11
            bool2 = num6 == math.max(0, mountedRange.lastIndex - mountedRange.firstIndex + 1)
            isApplied = true
            var5 = mountedRange

            if FFlagViewRecyclerReact084 then
                var6 = scrollOffset
            end
            num1 = contentStartOffset
            var7 = layout
            var8 = var18
            bool4 = false
            bool5 = false
            bool6 = false
            if bool10 then
                table.clear(tbl6)
            end
            var10 = nil

            local departed = var20.departed
            if not bool13 and #var14 == 0 and #var15 == 0 and #departed == 0 then
                return nil, nil
            end
            local var21 = table.create(#tbl2 + #tbl3)
            for value, value2 in tbl2 do
                var21[value] = value2.record
            end
            local num8 = #tbl2
            for value, value2 in tbl3 do
                var21[num8 + value] = value2.record
            end
            getMountedViews = table.freeze(var21)
            local touched = #var14 + #var15 + #departed
            local tbl13 = { entered = var14, updated = var15, departed = departed }

            if touched == 0 then
                return tbl13, nil
            end

            return tbl13, {
                kind = Diagnostics.EventKind.ItemViewsSynchronized,
                retained = #var21 - #var14 - #var15,
                reassigned = reassigned,
                acquired = #var14 - reassigned,
                released = #departed,
                touched = touched
            }
        end,
        release = release,
        destroy = function()
            if bool1 then
                return
            end
            release()
            var10 = nil
            slotBinder.destroy()
            bool1 = true
        end,
        isApplied = function()
            return isApplied
        end,
        getMountedViews = function()
            return getMountedViews
        end,
        validate = function(arg1)
            local tbl10 = {}
            local num6 = 0
            for _, value in arg1 do
                local var18 = tbl5[value.itemView]
                local state = value.state

                if var18 ~= nil and measuresSameContent(var18.state, state) then
                    table.insert(tbl10, {
                        index = var18.index,
                        key = var18.key,
                        pinnedPosition = var18.pinnedPosition,
                        pinnedRevision = var18.pinnedRevision,
                        length = value.length
                    })
                elseif state.index ~= nil and state.pinnedPosition == nil and tbl4[state.assignment.key] == nil then
                    table.insert(tbl10, { index = state.index, key = state.assignment.key, length = value.length })
                else
                    num6 += 1
                end
            end
            return tbl10, num6
        end
    }
end

return createListRows
