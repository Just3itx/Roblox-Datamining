-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.getCenterOffsetX(tbl1)
    local var1 = tbl1.containerPosition + tbl1.ratio * tbl1.containerWidth

    local var2 = tbl1.insetLeft + tbl1.margin
    local var3 = tbl1.screenWidth - tbl1.insetRight - tbl1.margin
    local var4 = var3 - var2

    if var4 <= 0 or tbl1.popoverWidth <= 0 then
        return var1 - tbl1.containerPosition
    end

    local var5 = var2 + tbl1.popoverWidth / 2
    local var6 = var3 - tbl1.popoverWidth / 2

    return (if var6 < var5 then var2 + var4 / 2 else math.clamp(var1, var5, var6)) - tbl1.containerPosition
end

return module
