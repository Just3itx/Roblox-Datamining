-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.pointInAxisAlignedBounds(vec1: vector, vec2: vector, vec3: vector): boolean
    local var1 = vec1 - vec2

    if var1.X >= -vec3.X / 2
        and var1.X <= vec3.X / 2
        and var1.Y >= -vec3.Y / 2
        and var1.Y <= vec3.Y / 2
        and var1.Z >= -vec3.Z / 2
    then
        return var1.Z <= vec3.Z / 2
    end

    return false
end

return module
