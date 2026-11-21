-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local AppPage = require(GameFiltersParent.RobloxAppEnums).AppPage

local mutedError = require(GameFiltersParent.Loggers).mutedError
local t = require(GameFiltersParent.t)

local FFlagLuaAppChartsFilterOptionTextTag = require(GameFiltersParent.SharedFlags).FFlagLuaAppChartsFilterOptionTextTag

local var1 = t.strictInterface({
    buttonName = t.string,
    filterId = t.string,
    selectedOptionId = t.string,
    previousOptionId = t.optional(t.string),
    selectedOptionContextTag = if FFlagLuaAppChartsFilterOptionTextTag then t.optional(t.string) else nil,
    previousOptionContextTag = if FFlagLuaAppChartsFilterOptionTextTag then t.optional(t.string) else nil,
    gameSetTypeId = t.string,
    gameSetTargetId = t.optional(t.number),
    sortPos = t.number,
    isActive = t.optional(t.boolean)
})

local tbl1 = {
    [AppPage.Games] = var1
}

local function gamesFilterClickEvent(arg1, arg2, arg3)
    local var2 = tbl1[arg2]

    if var2 then
        local var3, var4 = var2(arg3)

        if not var3 then
            mutedError(var4)
        end
    else
        mutedError(string.format("Missing interface for eventContext %s to type check gamesFilterClick event parameters", arg2))
    end

    arg1:sendEventDeferred(arg2, "gamesFilterClick", arg3)
end

return gamesFilterClickEvent
