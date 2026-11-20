-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _LayoutRuntime = require(ViewRecycler.Core.Layout.LayoutRuntime)
local Types = require(ViewRecycler.Core.Types)
local staticParts = require(ViewRecycler.Core.Layout.staticParts)

local function create(tbl1)
    local getItemLayout = tbl1.getItemLayout
    local getItemCount = 0

    return {
        getItemCount = function()
            return getItemCount
        end,
        getContentLength = function()
            if getItemCount == 0 then
                return 0
            end
            local itemLayout = getItemLayout(getItemCount)
            return itemLayout.startOffset + itemLayout.length
        end,
        getIntersectingIndexRange = function(num2: number, startOffset: number)
            if getItemCount == 0 or startOffset <= num2 then
                return Types.EMPTY_INDEX_RANGE
            end

            local num3 = getItemCount
            local num4 = 1

            while num4 < num3 do
                local num5 = (num4 + num3) // 2
                local itemLayout = getItemLayout(num5)
                if num2 < itemLayout.startOffset + itemLayout.length then
                    num3 = num5
                else
                    num4 = num5 + 1
                end
            end

            local itemLayout = getItemLayout(num4)
            if itemLayout.startOffset + itemLayout.length <= num2 then
                return Types.EMPTY_INDEX_RANGE
            end

            local num5 = getItemCount
            local num6 = 1

            while num6 < num5 do
                local num7 = (num6 + num5 + 1) // 2
                if getItemLayout(num7).startOffset < startOffset then
                    num6 = num7
                else
                    num5 = num7 - 1
                end
            end

            return if startOffset <= getItemLayout(num6).startOffset or num6 < num4 then Types.EMPTY_INDEX_RANGE else {
                firstIndex = num4,
                lastIndex = num6
            }
        end,
        expandIndexRange = function(arg1, arg2, arg3)
            return staticParts.expandItemRange(arg1, arg2, arg3 or arg2, getItemCount)
        end,
        getItemLayout = getItemLayout,
        updateItemMeasurement = staticParts.updateItemMeasurementNoop,
        requiresItemMeasurement = staticParts.requiresItemMeasurementFalse,
        applyDataSourceChange = function(arg1): boolean
            if arg1.type == DataSourceChangeType.Reset then
                getItemCount = #arg1.keys
            elseif arg1.type == DataSourceChangeType.Insert then
                getItemCount += #arg1.keys
            elseif arg1.type == DataSourceChangeType.Remove then
                getItemCount -= #arg1.keys
            end

            return true
        end,
        setViewportCrossAxisLength = staticParts.geometryUnchanged,
        destroy = staticParts.noop
    }
end

return create
