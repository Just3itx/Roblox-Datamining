-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChartsParent = script:FindFirstAncestor("Charts").Parent

local FFlagSduiChartsRequestPlaceholders = require(ChartsParent.SharedFlags).FFlagSduiChartsRequestPlaceholders

local _SduiSharedUtilities = require(ChartsParent.SduiSharedUtilities)

local function hasAnyOverlap(tbl1, tbl2)
    if tbl1 == nil or #tbl1 == 0 then
        return false
    end

    local tbl3 = ({})
    for _, value in tbl1 do
        tbl3[value] = true
    end

    for _, value in tbl2 do
        if tbl3[value] then
            return true
        end
    end

    return false
end

local function chartsMergeStrategy(tbl1, arg1, arg2): string?
    return if FFlagSduiChartsRequestPlaceholders and #tbl1 == 1 and tbl1[1] == "entry_order" then if hasAnyOverlap(arg2, arg1) then "replace" else "append" else nil
end

return chartsMergeStrategy
