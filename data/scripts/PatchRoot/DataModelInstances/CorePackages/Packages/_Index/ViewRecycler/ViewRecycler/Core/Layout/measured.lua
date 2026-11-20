-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local AveragePropagation = require(ViewRecycler.Core.Layout.Policies.AveragePropagation)
local CollapsedEstimatedTree = require(ViewRecycler.Core.Layout.SizeTree.CollapsedEstimatedTree)
local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local DetachedMeasurementCache = require(ViewRecycler.Core.Layout.Policies.DetachedMeasurementCache)
local _LayoutRuntime = require(ViewRecycler.Core.Layout.LayoutRuntime)
local Types = require(ViewRecycler.Core.Types)
local createDebugLogger = require(ViewRecycler.Internal.createDebugLogger)
local staticParts = require(ViewRecycler.Core.Layout.staticParts)

local debugLogger = createDebugLogger("Layout.measured")

local function measured(tbl1)
    local tbl2 = tbl1 or {}
    local estimatedItemLength = tbl2.estimatedItemLength or 50
    local var1 = tbl2.estimationPolicy or AveragePropagation.new({ initialAverage = estimatedItemLength })
    local detachedMeasurementCache = DetachedMeasurementCache.new(tbl2.detachedMeasurementCapacity)

    local getEstimatedItemLength = if FFlagViewRecyclerReact084 then tbl2.getEstimatedItemLength else nil

    local collapsedEstimatedTree = CollapsedEstimatedTree.new(estimatedItemLength)
    local tbl3 = ({})
    local tbl4 = ({})
    local tbl5 = {}
    local num1 = 0
    local num2 = 0
    local var2 = nil
    local num3 = 0
    local num4 = 0

    local var3 = nil
    local var4 = nil
    local var5 = nil
    local queueEstimate = nil
    if FFlagViewRecyclerReact084 then
        var3 = {}
        var4 = {}
        var5 = {}

        queueEstimate = function(str1: string, num5: number)
            if getEstimatedItemLength ~= nil then
                table.insert(var4, str1)
                table.insert(var5, num5)
            end
        end
    end

    local function average() -- Luacid: Inlined by compiler; 3 call sites recovered
        return if num2 > 0 then num1 / num2 else estimatedItemLength
    end

    local function addActiveMeasurement(str1: string, num5: number) -- Luacid: Inlined by compiler; 5 call sites recovered
        tbl3[str1] = num5
        num1 += num5
        num2 += 1
    end

    local function restoreActiveMeasurement(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        local var6 = detachedMeasurementCache.take(str1)
        if var6 ~= nil then
            addActiveMeasurement(str1, var6)
        end
    end

    local function detachActiveMeasurement(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var6 = tbl3[str1]
        if var6 == nil then
            return
        end
        tbl3[str1] = nil
        num1 -= var6
        num2 -= 1
        detachedMeasurementCache.put(str1, var6)
    end

    local function getItemCount()
        return collapsedEstimatedTree.length()
    end

    local function getContentLength()
        return collapsedEstimatedTree.totalSum()
    end

    local function getItemLayout(num5: number)
        if var2 == num5 then
            return { startOffset = num3, length = num4 }
        end

        return {
            startOffset = collapsedEstimatedTree.prefixSum(num5),
            length = collapsedEstimatedTree.getSize(num5)
        }
    end

    local function getItemLayouts(num5: number, num6: number, tbl6)
        collapsedEstimatedTree.fillRange(num5, num6, tbl6)
    end

    local function getIntersectingIndexRange(num5: number, num6: number)
        local var6 = collapsedEstimatedTree.length()
        if var6 == 0 or num6 <= num5 then
            var2 = nil
            return Types.EMPTY_INDEX_RANGE
        end
        local var7, var8, var9 = collapsedEstimatedTree.entryAtPrefixSum(num5)
        local firstIndex = math.clamp(var7, 1, var6)
        if var7 == firstIndex then
            var2 = firstIndex
            num3 = var8
            num4 = var9
        else
            var2 = nil
        end
        local num8 = math.clamp(collapsedEstimatedTree.indexAtPrefixSum(num6), firstIndex, var6)

        if num6 <= collapsedEstimatedTree.prefixSum(num8) then
            num8 -= 1
        end
        return if num8 < firstIndex then Types.EMPTY_INDEX_RANGE else {
            firstIndex = firstIndex,
            lastIndex = num8
        }
    end
    local function updateItemMeasurement(arg1)
        local itemIndex = arg1.itemIndex
        local itemKey = arg1.itemKey
        local length = arg1.length
        if tbl5[itemIndex] ~= itemKey then
            debugLogger("measurement DROPPED key=%s index=%d (index now holds %s)", itemKey, itemIndex, tostring(tbl5[itemIndex]))
            return { accepted = false, geometryChanged = false }
        end

        local var6 = tbl3[itemKey]
        if var6 == length then
            return { accepted = true, geometryChanged = false }
        end

        var2 = nil

        if var6 == nil then
            addActiveMeasurement(itemKey, length)
        else
            num1 += length - var6
            tbl3[itemKey] = length
        end

        local bool1 = collapsedEstimatedTree.getSize(itemIndex) ~= length

        collapsedEstimatedTree.update(itemIndex, length)

        if var1.recordMeasurementAndShouldUpdateEstimates((average())) then
            bool1 = collapsedEstimatedTree.setEstimatedItemLength(math.round((average()))) or bool1
        end

        debugLogger(
            "measurement key=%s index=%d length=%.1f (avg=%.2f, changed=%s)",
            itemKey,
            itemIndex,
            length,
            average(),
            tostring(bool1)
        )

        return { accepted = true, geometryChanged = bool1 }
    end

    local function requiresItemMeasurement(): boolean
        return true
    end

    local function rebuildFromKeys(tbl6)
        tbl5 = tbl6

        if FFlagViewRecyclerReact084 then
            collapsedEstimatedTree.buildFromMeasurements(#tbl6, function(arg1)
                return tbl3[tbl6[arg1]]
            end, getEstimatedItemLength ~= nil and function(arg1)
                return var3[tbl6[arg1]]
            end or nil)

            return
        end

        collapsedEstimatedTree.buildFromMeasurements(#tbl6, function(arg1)
            return tbl3[tbl6[arg1]]
        end)
    end

    local function applyReset(keys)
        local keysLen = #keys
        local var6 = table.create(keysLen)
        local tbl6 = ({})
        for i = 1, keysLen do
            local key = keys[i]
            if tbl6[key] ~= nil then
                error(`Layout.measured: duplicate key "{key}"`, 2)
            end
            var6[i] = key
            tbl6[key] = true
        end

        for value in tbl6 do
            if tbl4[value] == nil then
                restoreActiveMeasurement(value)
            end
        end

        for _, value in tbl5 do
            if tbl6[value] ~= nil then
                continue
            end

            detachActiveMeasurement(value)

            if FFlagViewRecyclerReact084 then
                var3[value] = nil
            end
        end

        tbl4 = tbl6

        if FFlagViewRecyclerReact084 then
            for value, value2 in var6 do
                queueEstimate(value2, value)
            end
        end
        rebuildFromKeys(var6)
    end

    local function applyInsert(index: number, keys)
        local keysLen = #keys
        local tbl6 = ({})
        for i = 0, keysLen - 1 do
            local key = keys[i + 1]
            if tbl4[key] ~= nil or tbl6[key] ~= nil then
                error(`Layout.measured: duplicate key "{key}"`, 2)
            end
            tbl6[key] = true
        end

        if FFlagViewRecyclerReact084 then
            for k, key in keys do
                restoreActiveMeasurement(key)
                tbl4[key] = true
                queueEstimate(key, index + k - 1)
            end
        else
            for _, key in keys do
                restoreActiveMeasurement(key)
                tbl4[key] = true
            end
        end

        if collapsedEstimatedTree.prefersIncremental(keysLen) then
            for k, key in keys do
                local var6 = index + k - 1
                table.insert(tbl5, var6, key)
                collapsedEstimatedTree.insert(var6, tbl3[key])
            end
            return
        end

        local num5 = #tbl5
        local var6 = table.create(num5 + keysLen)
        table.move(tbl5, 1, index - 1, 1, var6)
        for k, key in keys do
            var6[index + k - 1] = key
        end
        table.move(tbl5, index, num5, index + keysLen, var6)
        rebuildFromKeys(var6)
    end

    local function applyRemove(index: number, keys)
        local keysLen = #keys
        for i = index, index + keysLen - 1 do
            local var6 = tbl5[i]
            assert(var6 == keys[i - index + 1], "Layout.measured: remove keys do not match current order")
            tbl4[var6] = nil
            detachActiveMeasurement(var6)

            if FFlagViewRecyclerReact084 then
                var3[var6] = nil
            end
        end

        if collapsedEstimatedTree.prefersIncremental(keysLen) then
            for _ = 1, keysLen do
                table.remove(tbl5, index)
                collapsedEstimatedTree.remove(index)
            end
            return
        end

        local num5 = #tbl5
        local var6 = table.create(num5 - keysLen)
        table.move(tbl5, 1, index - 1, 1, var6)
        table.move(tbl5, index + keysLen, num5, index, var6)
        rebuildFromKeys(var6)
    end

    local function applyMove(fromIndex: number, toIndex: number, key: string)
        assert(tbl5[fromIndex] == key, "Layout.measured: move key does not match current order")
        table.remove(tbl5, fromIndex)
        collapsedEstimatedTree.remove(fromIndex)
        table.insert(tbl5, toIndex, key)

        if FFlagViewRecyclerReact084 then
            collapsedEstimatedTree.insert(toIndex, tbl3[key], var3[key])
            return
        end
        collapsedEstimatedTree.insert(toIndex, tbl3[key])
    end

    local function applyReorder(keys)
        assert(#keys == #tbl5, "Layout.measured: reorder must contain every active key")
        local tbl6 = ({})
        for _, key in keys do
            assert(tbl4[key] == true and tbl6[key] == nil, "Layout.measured: reorder must contain every active key once")

            tbl6[key] = true
        end
        rebuildFromKeys(table.clone(keys))
    end

    local function applyDataSourceChange(arg1)
        var2 = nil
        local bool1 = true
        if arg1.type == DataSourceChangeType.Reset then
            applyReset(arg1.keys)
            return bool1
        elseif arg1.type == DataSourceChangeType.Insert then
            applyInsert(arg1.index, arg1.keys)
            return bool1
        elseif arg1.type == DataSourceChangeType.Remove then
            applyRemove(arg1.index, arg1.keys)
            return bool1
        else
            if arg1.type == DataSourceChangeType.Update then
                bool1 = false

                if FFlagViewRecyclerReact084 then
                    for _, key in arg1.keys do
                        queueEstimate(key, 0)
                    end

                    return bool1
                end
            else
                if arg1.type == DataSourceChangeType.Move then
                    applyMove(arg1.fromIndex, arg1.toIndex, arg1.key)
                    return bool1
                end

                if arg1.type == DataSourceChangeType.Reorder then
                    applyReorder(arg1.keys)
                end
            end

            return bool1
        end
    end
    local readEstimate = nil
    local resolveItemEstimates

    if FFlagViewRecyclerReact084 then
        readEstimate = function(arg1, num5: number)
            local estimatedItemLength2 = getEstimatedItemLength(arg1, num5)
            if estimatedItemLength2 ~= nil then
                assert(
                    type(estimatedItemLength2) == "number" and estimatedItemLength2 >= 0 and estimatedItemLength2 < math.huge,
                    "Layout.measured: getEstimatedItemLength must return nil or a finite, non-negative number"
                )
            end

            return estimatedItemLength2
        end

        resolveItemEstimates = function(func1: (...any) -> (...any))
            local num5 = #var4
            if num5 == 0 then
                return false
            end
            var2 = nil

            local var6 = nil
            for i = 1, num5 do
                local var7 = var4[i]
                if tbl4[var7] ~= nil and tbl5[var5[i]] ~= var7 then
                    var6 = var6 or {}
                    var6[var7] = 0
                end
            end
            if var6 ~= nil then
                for value, value2 in tbl5 do
                    if var6[value2] ~= nil then
                        var6[value2] = value
                    end
                end
            end

            local bool1 = not collapsedEstimatedTree.prefersIncremental(num5)
            local bool2 = false
            for i = 1, num5 do
                local var7 = var4[i]
                if tbl4[var7] == nil then
                    continue
                end

                local var8 = if var6 ~= nil and var6[var7] ~= nil then var6[var7] else var5[i]
                local var9 = readEstimate(func1(var8), var8)
                if bool1 then
                    if not bool2 then
                        if var3[var7] == var9 then
                            bool2 = false
                        else
                            bool2 = tbl3[var7] == nil
                        end
                    end
                else
                    bool2 = collapsedEstimatedTree.setItemEstimate(var8, var9) or bool2
                end
                var3[var7] = var9
            end

            table.clear(var4)
            table.clear(var5)
            if bool1 then
                rebuildFromKeys(tbl5)
            end
            return bool2
        end
    else
        resolveItemEstimates = nil
    end

    local module = {
        getItemCount = getItemCount,
        getContentLength = getContentLength,
        getIntersectingIndexRange = getIntersectingIndexRange,
        expandIndexRange = function(arg1, arg2, arg3)
            return staticParts.expandItemRange(arg1, arg2, arg3 or arg2, collapsedEstimatedTree.length())
        end,
        getItemLayout = getItemLayout,
        getItemLayouts = getItemLayouts,
        updateItemMeasurement = updateItemMeasurement,
        requiresItemMeasurement = requiresItemMeasurement,
        isItemMeasured = function(arg1): boolean
            local var6 = tbl5[arg1]
            return not (var6 == nil) and tbl3[var6] ~= nil
        end,
        applyDataSourceChange = applyDataSourceChange,
        resolveItemEstimates = 0,
        setViewportCrossAxisLength = 0,
        stackedSpacing = 0,
        destroy = 0
    }

    if not FFlagViewRecyclerReact084 or getEstimatedItemLength == nil then
        resolveItemEstimates = nil
    end

    module.resolveItemEstimates = resolveItemEstimates

    module.setViewportCrossAxisLength = staticParts.geometryUnchanged
    function module.stackedSpacing(): number
        return 0
    end
    function module.destroy() end

    return module
end

return measured
