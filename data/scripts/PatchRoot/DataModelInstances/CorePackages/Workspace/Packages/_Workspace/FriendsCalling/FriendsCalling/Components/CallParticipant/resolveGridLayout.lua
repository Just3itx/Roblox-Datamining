-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    columns = 0,
    rows = 0,
    cardSize = Vector2.zero
}

local function resolveGridLayout(vector2: Vector2, num1: number, num2: number)
    if num1 <= 0 or vector2.X <= 0 or vector2.Y <= 0 then
        return tbl1
    end

    local tbl2 = tbl1
    local num3 = 0
    for columns = 1, num1 do
        local rows = math.ceil(num1 / columns)
        local num5 = math.min((vector2.X - (columns - 1) * num2) / columns, (vector2.Y - (rows - 1) * num2) / rows * 0.75)
        if not (num3 < num5) then
            continue
        end
        tbl2 = { columns = columns, rows = rows, cardSize = 0 }
        local new = Vector2.new
        local num6 = math.floor(num5)
        local num7 = num5 / 0.75
        tbl2.cardSize = new(num6, math.floor(num7))
        num3 = num5
    end

    return tbl2
end

return resolveGridLayout
