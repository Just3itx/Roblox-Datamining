-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local _StarterPlayer = game:GetService("StarterPlayer")

local Common = CoreGui:FindFirstChild("RobloxGui"):FindFirstChild("Modules"):FindFirstChild("Common")

local RagdollRigging = require(Common:FindFirstChild("RagdollRigging"))
local HumanoidReadyUtil = require(Common:FindFirstChild("HumanoidReadyUtil"))

local engineFeature = game:GetEngineFeature("AvatarJointUpgradeFeature")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local DeathType = RobloxReplicatedStorage:WaitForChild("DeathType", math.huge)

if not DeathType or not engineFeature and DeathType.Value ~= "Ragdoll" then
    return
end

local OnRagdoll = nil
if not engineFeature then
    OnRagdoll = RobloxReplicatedStorage:WaitForChild("OnRagdoll", math.huge)
    if not (OnRagdoll and OnRagdoll:IsA("RemoteEvent")) then
        return
    end
end

local function onOwnedHumanoidDeath(arg1, arg2)
    if engineFeature then
        if DeathType.Value == "Ragdoll" then
            RagdollRigging.disableMotors(arg1, arg2.RigType)
        end

        return
    end

    local motors = RagdollRigging.disableMotors(arg1, arg2.RigType)

    local animator = arg2:FindFirstChildWhichIsA("Animator")
    if animator then
        animator:ApplyJointVelocities(motors)
    end

    OnRagdoll:FireServer(arg2)

    wait(0.1)

    RagdollRigging.easeJointFriction_OLD(arg1, 0.85)
end

HumanoidReadyUtil.registerHumanoidReady(function(arg1, arg2, arg3)
    local connection = nil
    local connection2 = nil
    local function disconnect() -- Luacid: Inlined by compiler; 2 call sites recovered
        connection:Disconnect()
        connection2:Disconnect()
    end

    connection2 = arg3.Died:Connect(function()
        disconnect()

        if DeathType.Value == "Ragdoll" then
            delay(2, function()
                RagdollRigging.disableParticleEmittersAndFadeOut(arg2, 0.4)
            end)
        end

        if arg1 == LocalPlayer then
            onOwnedHumanoidDeath(arg2, arg3)
        end
    end)

    connection = arg1.CharacterRemoving:Connect(function(character: Model)
        if character == arg2 then
            disconnect()
        end
    end)
end)
