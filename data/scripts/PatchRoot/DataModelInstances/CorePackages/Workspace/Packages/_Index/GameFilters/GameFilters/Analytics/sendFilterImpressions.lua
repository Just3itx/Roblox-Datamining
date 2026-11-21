-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFilters = script:FindFirstAncestor("GameFilters")

local GameFiltersParent = GameFilters.Parent
local ArgCheck = require(GameFiltersParent.ArgCheck)
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)

local filterImpressionsEvent = require(GameFilters.Analytics.filterImpressionsEvent)
local getOptionContextTag = require(GameFilters.Analytics.getOptionContextTag)

local FFlagLuaAppChartsFilterOptionTextTag = require(GameFiltersParent.SharedFlags).FFlagLuaAppChartsFilterOptionTextTag

local function sendFilterImpressions(arg1, tbl1, tbl2, str1: string, arg2)
    if not arg1 or not tbl1 or #tbl1 == 0 or not tbl2 or #tbl2 == 0 then
        return
    end

    local tbl3 = {
        gameSetTypeId = arg2.gameSetTypeId,
        gameSetTargetId = arg2.gameSetTargetId,
        sortPos = arg2.sortPos
    }

    local tbl4 = {}
    local tbl5 = {}
    local tbl6 = {}
    local var1 = FFlagLuaAppChartsFilterOptionTextTag and {} or nil

    for _, value in tbl1 do
        local var2 = tbl2[value]

        if not var2 then
            continue
        end

        table.insert(tbl4, value)
        table.insert(tbl5, var2.filterId)
        table.insert(tbl6, var2.selectedOptionId)
        if FFlagLuaAppChartsFilterOptionTextTag then
            table.insert(var1, getOptionContextTag(var2, var2.selectedOptionId) or "0")
        end
    end

    local num1 = #tbl5
    ArgCheck.assert(num1 == #tbl4)
    ArgCheck.assert(num1 == #tbl6)
    if FFlagLuaAppChartsFilterOptionTextTag then
        ArgCheck.assert(num1 == #var1)
    end

    tbl3.absPositions = table.concat(tbl4, ",")
    tbl3.filterIds = table.concat(tbl5, ",")
    tbl3.selectedOptionIds = table.concat(tbl6, ",")
    tbl3.selectedOptionContextTags = if FFlagLuaAppChartsFilterOptionTextTag then table.concat(var1, ",") else nil

    filterImpressionsEvent(arg1, str1, tbl3)
end

return sendFilterImpressions
