-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local num1 = game:DefineFastInt("WidgetPaddingSizing", 32)

local function resolveWidgetListItemBottomPaddingPx(tbl1)
    local xxLarge = tbl1.Padding.XXLarge
    return ({
        [32] = xxLarge,
        [24] = tbl1.Padding.XXLarge,
        [20] = tbl1.Padding.XLarge,
        [16] = tbl1.Padding.Large
    })[num1]
        or xxLarge
end

return resolveWidgetListItemBottomPaddingPx
