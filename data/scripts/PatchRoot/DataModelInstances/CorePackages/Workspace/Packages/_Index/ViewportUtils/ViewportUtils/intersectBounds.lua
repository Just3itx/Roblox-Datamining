-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local var1 = table.freeze({ min = Vector2.zero, max = Vector2.zero })

local function intersectBounds(tbl1, tbl2)
    local tbl3 = {
        min = Vector2.new(math.max(tbl1.min.X, tbl2.min.X), math.max(tbl1.min.Y, tbl2.min.Y)),
        max = Vector2.new(math.min(tbl1.max.X, tbl2.max.X), math.min(tbl1.max.Y, tbl2.max.Y))
    }

    if tbl3.min.X >= tbl3.max.X then
        return var1
    end

    if tbl3.min.Y >= tbl3.max.Y then
        return var1
    end

    return tbl3
end

return intersectBounds
