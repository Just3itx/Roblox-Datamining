-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(): Model
    local model = Instance.new("Model")
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Parent = model
    local humanoid = Instance.new("Humanoid")
    humanoid.Name = "Humanoid"
    humanoid.Parent = model
    local humanoidDescription = Instance.new("HumanoidDescription")
    humanoidDescription.Name = "HumanoidDescription"
    humanoidDescription.Parent = humanoid

    return model
end
