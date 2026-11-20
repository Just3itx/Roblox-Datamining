-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function heightForCharacter(arg1)
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = arg1:FindFirstChild("HumanoidRootPart")
    if humanoid == nil or humanoidRootPart == nil or not humanoidRootPart:IsA("BasePart") then
        return nil
    end
    local num1 = humanoid.HipHeight + 0.5 * humanoidRootPart.Size.Y
    if humanoid.RigType == Enum.HumanoidRigType.R6 then
        local leftLeg = arg1:FindFirstChild("Left Leg")
        if leftLeg ~= nil and leftLeg:IsA("BasePart") then
            num1 += leftLeg.Size.Y
        end
    end
    return num1
end

return {
    heightForCharacter = heightForCharacter,
    positionOnFloor = function(arg1, x: number, cFrame: CFrame?)
        local var1 = cFrame or CFrame.new()
        local y = heightForCharacter(arg1)
        if y == nil then
            arg1:PivotTo(var1 * CFrame.new(x, 0, 0) * CFrame.Angles(0, math.pi, 0))
            return
        end
        local humanoidRootPart = arg1:FindFirstChild("HumanoidRootPart")
        humanoidRootPart.Anchored = true

        arg1.PrimaryPart = humanoidRootPart
        arg1:PivotTo(var1 * CFrame.new(x, y, 0) * CFrame.Angles(0, math.pi, 0))
    end
}
