-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local function fromSrgb(vec1: vector): vector -- Luacid: Inlined by compiler; 3 call sites recovered
    local num1 = vector.dot(vec1, Vector3.new(0.41222146, 0.53633255, 0.051445995)) ^ (1 / 3)
    local num2 = vector.dot(vec1, Vector3.new(0.2119035, 0.6806995, 0.10739696)) ^ (1 / 3)
    local num3 = vector.dot(vec1, Vector3.new(0.08830246, 0.28171885, 0.6299787)) ^ (1 / 3)

    return vector.create(
        num1 * 0.2104542553 + num2 * 0.793617785 - num3 * 0.0040720468,
        num1 * 1.9779984951 - num2 * 2.428592205 + num3 * 0.4505937099,
        num1 * 0.0259040371 + num2 * 0.7827717662 - num3 * 0.808675766
    )
end

local function toSrgb(vec1: vector): vector
    local vec = vector.create(
        vec1.x + vec1.y * 0.3963377774 + vec1.z * 0.2158037573,
        vec1.x - vec1.y * 0.1055613458 - vec1.z * 0.0638541728,
        vec1.x - vec1.y * 0.0894841775 - vec1.z * 1.291485548
    )

    local var1 = vec * vec * vec

    local x = var1.x
    local y = var1.y
    local z = var1.z

    return vector.create(
        x * 4.0767416621 - y * 3.3077115913 + z * 0.2309699292,
        x * -1.2684380046 + y * 2.6097574011 - z * 0.3413193965,
        x * -0.0041960863 - y * 0.7034186147 + z * 1.707614701
    )
end

function module.fromColor3(color3: Color3): vector
    local r = color3.R
    local g = color3.G
    local b = color3.B
    return fromSrgb(vector.create(r, g, b))
end

function module.toColor3(vec1: vector): Color3
    local vec = toSrgb(vec1)
    return Color3.new(vec.x, vec.y, vec.z)
end

function module.lerp(color3: Color3, color3_2: Color3, num1: number): Color3
    local r = color3.R
    local g = color3.G
    local b = color3.B
    local vec = fromSrgb(vector.create(r, g, b))
    local r2 = color3_2.R
    local g2 = color3_2.G
    local b2 = color3_2.B
    local vec2 = vector.lerp(vec, fromSrgb(vector.create(r2, g2, b2)), num1)

    local vec3 = vector.clamp(toSrgb(vec2), Vector3.new(0, 0, 0), Vector3.new(1, 1, 1))
    return Color3.new(vec3.x, vec3.y, vec3.z)
end

return module
