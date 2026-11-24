-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isShopInstanceVisible(arg1, tbl1): boolean
    local var1 = tbl1.max - tbl1.min
    if var1.X <= 0 or var1.Y <= 0 then
        return false
    end

    local var2 = arg1.AbsolutePosition + arg1.AbsoluteSize / 2
    local bool1 = var2.X > tbl1.min.X and var2.X < tbl1.max.X
    local bool2 = var2.Y > tbl1.min.Y and var2.Y < tbl1.max.Y
    return bool1 and bool2
end

return isShopInstanceVisible
