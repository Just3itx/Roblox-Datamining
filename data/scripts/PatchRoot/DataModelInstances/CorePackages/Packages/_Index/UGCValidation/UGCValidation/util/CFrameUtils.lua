-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local valueToString = require(script.Parent.valueToString)
local floatEquals = require(scriptParentParent.util.floatEquals)

local module = {}

function module.fuzzyEq(cFrame: CFrame, cFrame2: CFrame, num1: number?)
    local num2, num3, num4, num5, num6, num7, num8, num9, num10, num11, num12, num13 = cFrame:GetComponents()
    local num14, num15, num16, num17, num18, num19, num20, num21, num22, num23, num24, num25 = cFrame2:GetComponents()
    return floatEquals(num2, num14, num1)
        and floatEquals(num3, num15, num1)
        and floatEquals(num4, num16, num1)
        and floatEquals(num5, num17, num1)
        and floatEquals(num6, num18, num1)
        and floatEquals(num7, num19, num1)
        and floatEquals(num8, num20, num1)
        and floatEquals(num9, num21, num1)
        and floatEquals(num10, num22, num1)
        and floatEquals(num11, num23, num1)
        and floatEquals(num12, num24, num1)
        and floatEquals(num13, num25, num1)
end

function module.getRotationString(cFrame: CFrame)
    local vec3 = Vector3.new(cFrame:ToOrientation())
    local vec3_2 = Vector3.new(math.deg(vec3.X), math.deg(vec3.Y), math.deg(vec3.Z))
    return valueToString(vec3_2)
end

return module
