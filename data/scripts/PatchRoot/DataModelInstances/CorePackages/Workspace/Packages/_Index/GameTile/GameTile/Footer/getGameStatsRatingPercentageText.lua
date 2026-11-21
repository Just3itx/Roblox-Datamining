-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getGameStatsRatingPercentageText(arg1, arg2): string
    arg1 = if arg1 == nil or arg1 < 0 then 0 else arg1

    local var1 = arg1 + (if arg2 == nil or arg2 < 0 then 0 else arg2)

    return if var1 > 0 then tostring(math.floor(arg1 / var1 * 100)) else "--"
end

return getGameStatsRatingPercentageText
