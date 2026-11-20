-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.isInRange(vec1: vector, vec2: vector, vec3: vector, bool1: boolean?)
    if bool1 == true then
        if vec1.X > vec2.X and vec1.X < vec3.X and vec1.Y > vec2.Y and vec1.Y < vec3.Y and vec1.Z > vec2.Z then
            return vec1.Z < vec3.Z
        end

        return false
    end

    if vec1.X >= vec2.X and vec1.X <= vec3.X and vec1.Y >= vec2.Y and vec1.Y <= vec3.Y and vec1.Z >= vec2.Z then
        return vec1.Z <= vec3.Z
    end

    return false
end

function module.isFirstLessOrEqual(vec1: vector, vec2: vector): boolean
    return vec1.X <= vec2.X and vec1.Y <= vec2.Y and vec1.Z <= vec2.Z
end

return module
