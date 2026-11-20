-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.translationExceedsThreshold(arg1, num1: number)
    local position = arg1:FindFirstChild("Position")
    if not (position and position:IsA("Vector3Curve")) then
        return false, 0
    end

    local vec3 = Vector3.new(unpack(position:GetValueAtTime(0)))

    local tbl1 = {}
    for _, value in { "X", "Y", "Z" } do
        local var1 = position:FindFirstChild(value)
        if not (var1 and var1:IsA("FloatCurve")) then
            continue
        end

        for _, key in var1:GetKeys() do
            table.insert(tbl1, key.Time)
        end
    end

    local num2 = 0
    for _, value in tbl1 do
        local magnitude = (Vector3.new(unpack(position:GetValueAtTime(value))) - vec3).Magnitude
        if num2 < magnitude then
            num2 = magnitude
        end
    end

    return num1 < num2, num2
end

return module
