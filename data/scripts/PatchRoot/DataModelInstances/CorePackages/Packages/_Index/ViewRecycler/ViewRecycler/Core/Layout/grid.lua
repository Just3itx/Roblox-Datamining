-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _LayoutRuntime = require(ViewRecycler.Core.Layout.LayoutRuntime)
local Types = require(ViewRecycler.Core.Types)
local staticParts = require(ViewRecycler.Core.Layout.staticParts)

local function grid(tbl1)
    assert(tbl1.itemLength > 0, "Layout.grid: itemLength must be positive")
    assert(
        tbl1.crossAxisCount ~= nil ~= (tbl1.crossAxisItemLength ~= nil),
        "Layout.grid: provide exactly one of crossAxisCount or crossAxisItemLength"
    )

    local itemLength = tbl1.itemLength
    local spacing = tbl1.spacing or 0
    local paddingBefore = tbl1.paddingBefore or 0
    local paddingAfter = tbl1.paddingAfter or 0
    local var1 = itemLength + spacing

    local crossAxisCount = tbl1.crossAxisCount or 1
    local getItemCount = 0

    local function rowCount(): number -- Luacid: Inlined by compiler; 3 call sites recovered
        return math.ceil(getItemCount / crossAxisCount)
    end

    return {
        getItemCount = function()
            return getItemCount
        end,
        getContentLength = function()
            local num2 = rowCount()

            if num2 == 0 then
                return 0
            end

            return paddingBefore + num2 * itemLength + (num2 - 1) * spacing + paddingAfter
        end,
        getIntersectingIndexRange = function(num2: number, num3: number)
            if getItemCount == 0 or num3 <= num2 then
                return Types.EMPTY_INDEX_RANGE
            end

            local var2 = num2 - paddingBefore
            local var3

            if var2 > 0 then
                var3 = var2 // var1 + 1
                if paddingBefore + (var3 - 1) * var1 + itemLength <= num2 then
                    var3 += 1
                end
            else
                var3 = 1
            end

            local var4 = num3 - paddingBefore
            if var4 <= 0 then
                return Types.EMPTY_INDEX_RANGE
            end
            local var5 = var4 // var1 + 1
            if num3 <= paddingBefore + (var5 - 1) * var1 then
                var5 -= 1
            end

            local num4 = math.max(1, var3)
            local num5 = math.min(rowCount(), var5)
            if num5 < num4 then
                return Types.EMPTY_INDEX_RANGE
            end

            return {
                firstIndex = (num4 - 1) * crossAxisCount + 1,
                lastIndex = math.min(getItemCount, num5 * crossAxisCount)
            }
        end,
        expandIndexRange = function(arg1, num2: number, num3: number?)
            local var2 = (arg1.firstIndex - 1) // crossAxisCount + 1
            local var3 = (arg1.lastIndex - 1) // crossAxisCount + 1
            local num4 = math.max(1, var2 - num2)
            local num5 = math.min(rowCount(), var3 + (num3 or num2))
            return {
                firstIndex = (num4 - 1) * crossAxisCount + 1,
                lastIndex = math.min(getItemCount, num5 * crossAxisCount)
            }
        end,
        getItemLayout = function(num2: number)
            local var2 = (num2 - 1) // crossAxisCount + 1
            return {
                startOffset = paddingBefore + (var2 - 1) * var1,
                length = itemLength,
                crossAxisIndex = (num2 - 1) % crossAxisCount + 1,
                crossAxisCount = crossAxisCount
            }
        end,
        updateItemMeasurement = staticParts.updateItemMeasurementNoop,
        requiresItemMeasurement = staticParts.requiresItemMeasurementFalse,
        applyDataSourceChange = function(arg1): boolean
            local num2 = getItemCount
            if arg1.type == DataSourceChangeType.Reset then
                getItemCount = #arg1.keys
            elseif arg1.type == DataSourceChangeType.Insert then
                getItemCount += #arg1.keys
            elseif arg1.type == DataSourceChangeType.Remove then
                getItemCount -= #arg1.keys
            end
            return getItemCount ~= num2
        end,
        setViewportCrossAxisLength = function(num2: number): boolean
            if tbl1.crossAxisItemLength == nil then
                return false
            end
            local num3 = math.max(1, num2 // tbl1.crossAxisItemLength)
            if num3 == crossAxisCount then
                return false
            end

            crossAxisCount = num3
            return true
        end,
        destroy = staticParts.noop
    }
end

return grid
