-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local module = {}

function module.createDefaultCharacter(bool1: boolean)
    local model = if game:GetEngineFeature("AsyncRenamesUsedInLuaApps") then Players:CreateHumanoidModelFromDescriptionAsync(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15) else game.Players:CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15)

    for _, descendant in model:GetDescendants() do
        if descendant:IsA("Decal") then
            descendant.Transparency = 1
        elseif descendant:IsA("MeshPart") then
            descendant.Transparency = 0
            descendant.CanCollide = false
        elseif descendant:IsA("Motor6D") and bool1 then
            descendant:Destroy()
        end
    end

    return model
end

return module
