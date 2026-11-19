-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getWidth(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 * (188 / 285)
end

return {
    getSize = function(vector2: Vector2, bool1: boolean): Vector2
        local y = math.min(math.round(vector2.Y * 0.7), 285)
        local width = getWidth(y)

        if not bool1 then
            y *= 26 / 57
        end

        return Vector2.new(width, y)
    end
}
