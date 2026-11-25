-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getCollectionSlotsLayout(num1: number, tbl1)
    local num2 = math.max(num1, 1)
    local sideMargin = tbl1.sideMargin
    local columnGap = tbl1.columnGap
    local function getColumnStep(num3: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        return (num2 - sideMargin * 2 - tbl1.carouselPeek + (tbl1.fractionalItemAmount + 1) * columnGap) / (num3 + tbl1.fractionalItemAmount)
    end

    local function getSlotLayout(num3: number, num4: number, num5: number, num6: number, yScale: number)
        local num7 = math.max(num4 - num3, 1)
        return {
            clipPosition = UDim2.fromScale(num3 / num2, 0),
            clipSize = UDim2.fromScale(num7 / num2, yScale),
            position = UDim2.fromScale((num5 - num3) / num7, 0),
            size = UDim2.fromScale(math.max(num6, 0) / num7, yScale)
        }
    end

    local leadingColumns = tbl1.leadingColumns
    local var1 = leadingColumns * getColumnStep(tbl1.leadingNumColumns)

    local trailingColumns = tbl1.trailingColumns
    local var2 = trailingColumns * getColumnStep(tbl1.trailingNumColumns)

    local var3 = sideMargin + var1
    local var4 = num2 - sideMargin - var2
    local leading = if tbl1.leadingColumns > 0 then getSlotLayout(sideMargin - columnGap / 2, var3 - columnGap / 2, sideMargin, var1 - columnGap, 1) else nil
    local trailing = if tbl1.trailingColumns > 0 then getSlotLayout(var4 + columnGap / 2, num2 - sideMargin + columnGap / 2, var4 + columnGap, var2 - columnGap, 1) else nil
    return {
        leading = leading,
        content = getSlotLayout(
            if leading then var3 - tbl1.hoverOverflow else -tbl1.bleed,
            if trailing then var4 + tbl1.hoverOverflow else num2 + tbl1.bleed,
            var3,
            var4 - var3,
            0
        ),
        trailing = trailing
    }
end

return getCollectionSlotsLayout
