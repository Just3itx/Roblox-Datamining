-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)

local function finishModelSetup(model)
    model:PivotTo(CFrame.new())

    local humanoidRootPart = model:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
        model.PrimaryPart = humanoidRootPart

        humanoidRootPart.Anchored = true
    end

    local humanoid = model:FindFirstChildOfClass("Humanoid")
    local var1 = if humanoid then humanoid:FindFirstChildOfClass("Animator") else nil

    if humanoid and not var1 then
        var1 = Instance.new("Animator")
        var1.Parent = humanoid
    end

    return { model = model, humanoid = humanoid, animator = var1 }
end

return finishModelSetup
