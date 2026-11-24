-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function advanceHistoryScroll(tbl1, canvasHeight: number, historicalCount: number): number
    local canvasHeight2 = tbl1.canvasHeight
    local var1 = if canvasHeight2 then canvasHeight - canvasHeight2 else 0
    local bool1 = tbl1.historicalCount < historicalCount

    tbl1.canvasHeight = canvasHeight
    tbl1.historicalCount = historicalCount

    return if bool1 and var1 > 0 then var1 else 0
end

return advanceHistoryScroll
