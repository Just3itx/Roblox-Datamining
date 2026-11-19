-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local _StarterPlayer = game:GetService("StarterPlayer")

local Common = CoreGui:FindFirstChild("RobloxGui"):FindFirstChild("Modules"):FindFirstChild("Common")

local engineFeature = game:GetEngineFeature("AvatarJointUpgradeFeature")
local engineFeature2 = game:GetEngineFeature("AvatarJointUpgradeDefaultOnFeature")
local function jointUpgradeActive(): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return engineFeature and engineFeature2
end

local RagdollRigging = require(Common:FindFirstChild("RagdollRigging"))
local HumanoidReadyUtil = require(Common:FindFirstChild("HumanoidReadyUtil"))

local function getDefaultDeathType(): string
    if not game:GetEngineFeature("PolicyInfoForServerRobloxOnlyAsyncEnabled") then
        return game:DefineFastString("DeathTypeValue", "Classic")
    end

    local defaultAvatarDeathType = game:GetService("PolicyService"):GetPolicyInfoForServerRobloxOnlyAsync().DefaultAvatarDeathType
    if defaultAvatarDeathType == nil then
        error("PolicyService did not have death type policy")
    end
    return defaultAvatarDeathType
end

local DeathTypeValue = getDefaultDeathType()

local DeathType = Instance.new("StringValue")
DeathType.Name = "DeathType"
DeathType.Value = DeathTypeValue
DeathType.Parent = RobloxReplicatedStorage

if not engineFeature and DeathTypeValue ~= "Ragdoll" then
    return
end

local tbl1 = ({})

if not engineFeature then
    local onRagdoll = Instance.new("RemoteEvent")
    onRagdoll.Name = "OnRagdoll"
    onRagdoll.OnServerEvent:Connect(function(player: Player, arguments)
        if not arguments or tbl1[player] ~= arguments then
            return
        end

        local argumentsParent = arguments and arguments.Parent
        if argumentsParent and argumentsParent:IsA("Model") then
            RagdollRigging.disableMotors(argumentsParent, arguments.RigType)
        end

        tbl1[player] = nil
    end)

    onRagdoll.Parent = RobloxReplicatedStorage
end

HumanoidReadyUtil.registerHumanoidReady(function(arg1, arg2, arg3)
    if engineFeature then
        if arg3.RigType == Enum.HumanoidRigType.R15 and jointUpgradeActive() then
            RagdollRigging.createRagdollJoints(arg2, arg3.RigType, (jointUpgradeActive()))
        elseif DeathTypeValue == "Ragdoll" then
            RagdollRigging.createRagdollJoints(arg2, arg3.RigType, false)
        end
    end
    if DeathTypeValue ~= "Ragdoll" then
        return
    end
    local connection = nil
    local function disconnect() -- Luacid: Inlined by compiler; 1 call site recovered
        connection:Disconnect()
        if tbl1[arg1] == arg3 then
            tbl1[arg1] = nil
        end
    end

    connection = arg1.CharacterRemoving:Connect(function(character: Model)
        if character == arg2 then
            disconnect()
        end
    end)

    arg3.BreakJointsOnDeath = false

    if not engineFeature then
        RagdollRigging.createRagdollJoints(arg2, arg3.RigType, (jointUpgradeActive()))
    end
    tbl1[arg1] = arg3

    if not engineFeature then
        return
    end

    arg3.Died:Connect(function()
        tbl1[arg1] = nil

        local parent = arg3.Parent
        if not parent or not parent:IsA("Model") then
            return
        end

        RagdollRigging.disableMotors(parent, arg3.RigType)

        if jointUpgradeActive() then
            RagdollRigging.easeNongraphicJointFriction(parent, 0.85)
        end
    end)
end)
