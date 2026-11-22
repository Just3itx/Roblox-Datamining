-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isLandscape(vector2: Vector2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return vector2.X > vector2.Y
end

local function resolveMaxCropFraction(vector2: Vector2, vector2_2: Vector2?, num1: number, bool1: boolean): number
    if vector2_2 == nil or vector2.X == 0 or vector2.Y == 0 then
        return 0
    end

    local bool2 = not not isLandscape(vector2_2)
    return if bool2 == not not isLandscape(vector2) then if bool2 and not bool1 then 0 else num1 else 0
end

return resolveMaxCropFraction
