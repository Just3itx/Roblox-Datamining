-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function compare(vec1: vector?, vec2: vector?, func1: (...any) -> (...any)): vector? | Vector3 -- Luacid: unused: defined but never referenced
    if not (vec1 and vec2) then
        return vec1 or vec2
    end

    return Vector3.new(func1(vec1.X, vec2.X), func1(vec1.Y, vec2.Y), func1(vec1.Z, vec2.Z))
end

local function calculateMinMax(vec1: vector?, vec2: vector?, vec3: vector?, vec4: vector?): (vector? | Vector3, vector? | Vector3)
    local min = math.min
    local vec3_2 = if vec1 and vec3 then Vector3.new(min(vec1.X, vec3.X), min(vec1.Y, vec3.Y), (min(vec1.Z, vec3.Z))) else vec1 or vec3
    local max = math.max

    if not (vec2 and vec4) then
        return vec3_2, vec2 or vec4
    end

    return vec3_2, Vector3.new(max(vec2.X, vec4.X), max(vec2.Y, vec4.Y), (max(vec2.Z, vec4.Z)))
end

return calculateMinMax
