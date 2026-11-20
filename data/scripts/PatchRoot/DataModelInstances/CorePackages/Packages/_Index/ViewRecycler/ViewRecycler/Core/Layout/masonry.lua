-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _LayoutRuntime = require(ViewRecycler.Core.Layout.LayoutRuntime)
local Types = require(ViewRecycler.Core.Types)
local staticParts = require(ViewRecycler.Core.Layout.staticParts)

local function validateNonNegative(str1: string, num1: number) -- Luacid: unused: defined but never referenced
    if num1 < 0 or num1 >= math.huge then
        assert(false, `Layout.masonry: {str1} must be finite and non-negative`)
    end
end

local function masonry(tbl1)
    assert(type(tbl1.getItemLength) == "function", "Layout.masonry: getItemLength must be a function")
    assert(
        tbl1.crossAxisCount ~= nil ~= (tbl1.crossAxisItemLength ~= nil),
        "Layout.masonry: provide exactly one of crossAxisCount or crossAxisItemLength"
    )

    if tbl1.crossAxisCount ~= nil then
        assert(
            tbl1.crossAxisCount > 0 and tbl1.crossAxisCount % 1 == 0,
            "Layout.masonry: crossAxisCount must be a positive integer"
        )
    end

    if tbl1.crossAxisItemLength ~= nil then
        assert(
            tbl1.crossAxisItemLength > 0 and tbl1.crossAxisItemLength < math.huge,
            "Layout.masonry: crossAxisItemLength must be finite and positive"
        )
    end

    local getItemLength = tbl1.getItemLength
    local spacing = tbl1.spacing or 0
    local crossAxisSpacing = tbl1.crossAxisSpacing or 0
    local paddingBefore = tbl1.paddingBefore or 0
    local paddingAfter = tbl1.paddingAfter or 0

    if spacing < 0 or spacing >= math.huge then
        assert(false, "Layout.masonry: spacing must be finite and non-negative")
    end

    if crossAxisSpacing < 0 or crossAxisSpacing >= math.huge then
        assert(false, "Layout.masonry: crossAxisSpacing must be finite and non-negative")
    end

    if paddingBefore < 0 or paddingBefore >= math.huge then
        assert(false, "Layout.masonry: paddingBefore must be finite and non-negative")
    end

    if paddingAfter < 0 or paddingAfter >= math.huge then
        assert(false, "Layout.masonry: paddingAfter must be finite and non-negative")
    end

    local crossAxisCount = tbl1.crossAxisCount or 1
    local tbl2 = {}
    local tbl3 = ({})
    local tbl4 = ({})
    local num1 = 0
    local bool1 = true

    local function markGeometryDirty() -- Luacid: Inlined by compiler; 2 call sites recovered
        bool1 = true
    end

    local function rebuildGeometry()
        if not bool1 then
            return
        end
        table.clear(tbl3)
        table.clear(tbl4)

        local tbl5 = table.create(crossAxisCount, paddingBefore)
        for i = 1, crossAxisCount do
            tbl5[i] = paddingBefore
            tbl4[i] = {}
        end

        for i = 1, #tbl2 do
            local length = getItemLength(i)
            if type(length) ~= "number" or length <= 0 or length >= math.huge then
                assert(false, `Layout.masonry: getItemLength({i}) must return a finite positive number`)
            end

            local num2 = 1
            local var1 = tbl5[1]
            for j = 2, crossAxisCount do
                local var2 = tbl5[j]
                if var2 < var1 then
                    num2 = j
                    var1 = var2
                end
            end

            tbl3[i] = {
                startOffset = var1,
                length = length,
                crossAxisIndex = num2,
                crossAxisCount = crossAxisCount,
                crossAxisSpacing = crossAxisSpacing
            }
            table.insert(tbl4[num2], i)
            tbl5[num2] = var1 + length + spacing
        end

        if #tbl2 == 0 then
            num1 = 0
            bool1 = false
            return
        end
        local var1 = paddingBefore
        for i = 1, crossAxisCount do
            var1 = math.max(var1, tbl5[i])
        end
        num1 = var1 - spacing + paddingAfter
        bool1 = false
    end

    local function firstIntersectingInColumn(tbl5, num2: number, startOffset: number)
        if #tbl5 == 0 then
            return nil, nil
        end

        local num3 = #tbl5
        local num4 = 1

        while num4 < num3 do
            local num5 = (num4 + num3) // 2
            local var1 = tbl3[tbl5[num5]]
            if num2 < var1.startOffset + var1.length then
                num3 = num5
            else
                num4 = num5 + 1
            end
        end

        local var1 = tbl3[tbl5[num4]]

        if var1.startOffset + var1.length <= num2 or startOffset <= var1.startOffset then
            return nil, nil
        end

        local num5 = #tbl5
        local num6 = num4

        while num4 < num5 do
            local num7 = (num4 + num5 + 1) // 2
            if tbl3[tbl5[num7]].startOffset < startOffset then
                num4 = num7
            else
                num5 = num7 - 1
            end
        end
        return tbl5[num6], tbl5[num4]
    end

    return {
        getItemCount = function(): number
            return #tbl2
        end,
        getContentLength = function()
            rebuildGeometry()
            return num1
        end,
        getIntersectingIndexRange = function(num2: number, startOffset: number)
            rebuildGeometry()
            if #tbl2 == 0 or startOffset <= num2 then
                return Types.EMPTY_INDEX_RANGE
            end

            local var1 = nil
            local var2 = nil
            for i = 1, crossAxisCount do
                local var3, var4 = firstIntersectingInColumn(tbl4[i], num2, startOffset)
                if var3 == nil then
                    continue
                end

                if var1 == nil then
                    var1 = var3
                else
                    var1 = math.min(var1, var3)
                end

                if var2 == nil then
                    var2 = var4
                else
                    var2 = math.max(var2, var4)
                end
            end
            return if var1 == nil then Types.EMPTY_INDEX_RANGE else {
                firstIndex = var1,
                lastIndex = var2
            }
        end,
        expandIndexRange = function(arg1, arg2, arg3)
            return staticParts.expandItemRange(arg1, arg2, arg3 or arg2, #tbl2)
        end,
        getItemLayout = function(num2: number)
            rebuildGeometry()
            local var1 = tbl3[num2]
            if var1 == nil then
                assert(false, `Layout.masonry: item index {num2} is out of bounds`)
            end
            return var1
        end,
        updateItemMeasurement = staticParts.updateItemMeasurementNoop,
        requiresItemMeasurement = staticParts.requiresItemMeasurementFalse,
        applyDataSourceChange = function(arg1): boolean
            if arg1.type == DataSourceChangeType.Reset then
                tbl2 = table.clone(arg1.keys)
            elseif arg1.type == DataSourceChangeType.Insert then
                for k, key in arg1.keys do
                    table.insert(tbl2, arg1.index + k - 1, key)
                end
            elseif arg1.type == DataSourceChangeType.Remove then
                for _, key in arg1.keys do
                    assert(tbl2[arg1.index] == key, "Layout.masonry: remove keys do not match current order")

                    table.remove(tbl2, arg1.index)
                end
            elseif arg1.type == DataSourceChangeType.Move then
                assert(tbl2[arg1.fromIndex] == arg1.key, "Layout.masonry: move key does not match current order")

                table.remove(tbl2, arg1.fromIndex)
                table.insert(tbl2, arg1.toIndex, arg1.key)
            elseif arg1.type == DataSourceChangeType.Reorder then
                tbl2 = table.clone(arg1.keys)
            end

            markGeometryDirty()
            return true
        end,
        setViewportCrossAxisLength = function(num2: number): boolean
            if tbl1.crossAxisItemLength == nil then
                return false
            end
            local crossAxisItemLength = tbl1.crossAxisItemLength
            local num3 = math.max(1, (num2 + crossAxisSpacing) // (crossAxisItemLength + crossAxisSpacing))
            if num3 == crossAxisCount then
                return false
            end

            crossAxisCount = num3
            markGeometryDirty()
            return true
        end,
        destroy = staticParts.noop
    }
end

return masonry
