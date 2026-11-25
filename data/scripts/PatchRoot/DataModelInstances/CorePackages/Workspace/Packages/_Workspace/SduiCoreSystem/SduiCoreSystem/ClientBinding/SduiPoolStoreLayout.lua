-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local _CollectionViews = require(SduiCoreSystemParent.CollectionViews)
local tutils = require(SduiCoreSystemParent.tutils)

local _SduiPoolStoreTypes = require(SduiCoreSystem.ClientBinding.SduiPoolStoreTypes)

local EMPTY_CELLS = table.freeze({})

local function getSpanConfigAt(tbl1, num1: number)
    local var2 = tbl1[num1]
    if var2 == nil then
        return nil
    end
    local colSpan = var2.colSpan or 1
    local rowSpan = var2.rowSpan or 1
    local alignmentType = var2.alignmentType
    local minRowPadding = var2.minRowPadding or 0
    return if colSpan == 1 and rowSpan == 1 and alignmentType == nil and minRowPadding == 0 then nil else {
        colSpan = colSpan,
        rowSpan = rowSpan,
        alignmentType = alignmentType,
        minRowPadding = minRowPadding
    }
end

return {
    EMPTY_CELLS = EMPTY_CELLS,
    getSpanConfigAt = getSpanConfigAt,
    makePoolGetSpanConfig = function(tbl1)
        return function(_, num1: number)
            return (getSpanConfigAt(tbl1, num1))
        end
    end,
    layoutToCells = function(tbl1, num1: number, tbl2, tbl3)
        if tbl1 == nil then
            return EMPTY_CELLS, 0
        end
        local num2 = 0
        for value in tbl1 do
            if num2 < value then
                num2 = value
            end
        end

        if num2 == 0 then
            return EMPTY_CELLS, 0
        end
        local tbl4 = {}
        for i = 1, num2 do
            local var2 = tbl1[i] or {}
            for j = 1, num1 do
                local realIndex = var2[j]
                if realIndex ~= nil and realIndex > 0 then
                    table.insert(tbl4, {
                        item = tbl2[realIndex],
                        realIndex = realIndex,
                        spanOverride = if tbl3 == nil then nil else getSpanConfigAt(tbl3, realIndex)
                    })
                else
                    table.insert(tbl4, {})
                end
            end
        end
        return tbl4, num2
    end,
    cellsEqual = function(tbl1, tbl2)
        if tbl1 == tbl2 then
            return true
        end
        if tbl1 == nil or tbl2 == nil then
            return false
        end
        if #tbl1 ~= #tbl2 then
            return false
        end
        for value, value2 in tbl1 do
            if not tutils.shallowEqual(value2, tbl2[value]) then
                return false
            end
        end
        return true
    end
}
