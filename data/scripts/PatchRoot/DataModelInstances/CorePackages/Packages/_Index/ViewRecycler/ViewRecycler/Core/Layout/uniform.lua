-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _LayoutRuntime = require(ViewRecycler.Core.Layout.LayoutRuntime)
local Types = require(ViewRecycler.Core.Types)
local staticParts = require(ViewRecycler.Core.Layout.staticParts)

local function uniform(tbl1)
    assert(tbl1.itemLength > 0, "Layout.uniform: itemLength must be positive")

    local itemLength = tbl1.itemLength
    local spacing = tbl1.spacing or 0
    local paddingBefore = tbl1.paddingBefore or 0
    local paddingAfter = tbl1.paddingAfter or 0
    local var1 = itemLength + spacing

    local getItemCount = 0

    return {
        getItemCount = function()
            return getItemCount
        end,
        getContentLength = function()
            if getItemCount == 0 then
                return 0
            end

            return paddingBefore + getItemCount * itemLength + (getItemCount - 1) * spacing + paddingAfter
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

            local firstIndex = math.max(1, var3)
            local lastIndex = math.min(getItemCount, var5)
            return if lastIndex < firstIndex then Types.EMPTY_INDEX_RANGE else {
                firstIndex = firstIndex,
                lastIndex = lastIndex
            }
        end,
        expandIndexRange = function(arg1, arg2, arg3)
            return staticParts.expandItemRange(arg1, arg2, arg3 or arg2, getItemCount)
        end,
        getItemLayout = function(num2: number)
            return {
                startOffset = paddingBefore + (num2 - 1) * var1,
                length = itemLength
            }
        end,
        getItemLayouts = function(num2: number, num3: number, tbl2)
            for i = num2, num3 do
                local num4 = i - num2 + 1
                tbl2[num4] = {
                    startOffset = paddingBefore + (i - 1) * var1,
                    length = itemLength
                }
            end
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
        setViewportCrossAxisLength = staticParts.geometryUnchanged,
        destroy = staticParts.noop
    }
end

return uniform
