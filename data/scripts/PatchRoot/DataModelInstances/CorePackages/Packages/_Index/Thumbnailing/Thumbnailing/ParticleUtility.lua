-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.InstanceIsAParticleEffect(arg1)
    return arg1:IsA("ParticleEmitter") or arg1:IsA("Fire") or arg1:IsA("Smoke") or arg1:IsA("Sparkles")
end

local function recurFastForwardParticles(arg1)
    if module.InstanceIsAParticleEffect(arg1) then
        arg1:FastForward(240)
    end
    for _, child in (arg1:GetChildren()) do
        recurFastForwardParticles(child)
    end
end

function module.FastForwardParticles(arg1)
    recurFastForwardParticles(arg1)
end

local function findNearestBasePart(arg1)
    local parent = arg1.Parent
    while parent do
        if parent:IsA("BasePart") then
            return parent
        end

        if parent:IsA("Tool") then
            local handle = parent:FindFirstChild("Handle")
            if handle and handle:IsA("BasePart") then
                return handle
            end
        end

        if parent:IsA("Model") then
            local primaryPart = parent.PrimaryPart
            if primaryPart then
                return primaryPart
            end
        end
        parent = parent.Parent
    end
    return nil
end

local function recurReparentOrphanedEffects(arg1)
    if not module.InstanceIsAParticleEffect(arg1) then
        for _, child in arg1:GetChildren() do
            recurReparentOrphanedEffects(child)
        end
        return
    end

    local parent = arg1.Parent
    if not parent or parent:IsA("BasePart") or parent:IsA("Attachment") then
        return
    end

    local nearestBasePart = findNearestBasePart(arg1)
    if nearestBasePart then
        arg1.Parent = nearestBasePart
    end
end

function module.ReparentOrphanedParticleEffects(arg1)
    recurReparentOrphanedEffects(arg1)
end

return module
