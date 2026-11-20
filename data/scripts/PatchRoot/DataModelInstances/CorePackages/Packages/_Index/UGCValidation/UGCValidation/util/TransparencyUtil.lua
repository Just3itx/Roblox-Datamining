-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.transformTriangleToWorld(vec1: vector, vec2: vector, vec3: vector, cFrame: CFrame, vec4: vector)
    local var1 = cFrame * (vec1 * vec4)
    local var2 = cFrame * (vec2 * vec4)
    local var3 = cFrame * (vec3 * vec4)

    return var1, var2, var3, (var2 - var1):Cross(var3 - var1).Unit
end

return module
