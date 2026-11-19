-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local AvatarUtil = require(CorePackages.Workspace.Packages.CoreScriptsCommon).AvatarUtil
local ConnectionUtil = require(CorePackages.Workspace.Packages.CoreScriptsCommon).ConnectionUtil

local throttlingPercentage = game:DefineFastInt("VRAvatarGesturesAnalyticsThrottleHundrethsPercent", 0)

local bool1 = game:DefineFastFlag("VRAvatarGesturesUseNilForHandChainRootRebuild", false)

local bool2 = game:DefineFastFlag("VRAvatarGesturesFixJointLimits", false)

local tbl1 = { "UpperArm", "LowerArm", "Hand" }
local tbl2 = { "Left", "Right" }

local module = {}
module.__index = module

local function isRagdollBallSocket(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1:IsA("BallSocketConstraint") and string.sub(arg1.Name, -10) == "BallSocket"
end

local function forEachArmRagdollBallSocket(arg1, str1: string, callback: (...any) -> (...any))
    for _, value in ipairs(tbl1) do
        local var1 = arg1:FindFirstChild(str1 .. value)
        if not var1 then
            continue
        end

        for _, child in ipairs(var1:GetChildren()) do
            if isRagdollBallSocket(child) then
                callback(child)
            end
        end
    end
end

local function suppressArmRagdollLimits(arg1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    forEachArmRagdollBallSocket(arg1, str1, function(arg2)
        if arg2:GetAttribute("VRAvatarGesturesPriorLimitsEnabled") == nil then
            arg2:SetAttribute("VRAvatarGesturesPriorLimitsEnabled", arg2.LimitsEnabled)
            arg2:SetAttribute("VRAvatarGesturesPriorTwistLimitsEnabled", arg2.TwistLimitsEnabled)
        end
        arg2.LimitsEnabled = false
        arg2.TwistLimitsEnabled = false
    end)
end

local function restoreArmRagdollLimits(arg1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    forEachArmRagdollBallSocket(arg1, str1, function(arg2)
        local vrAvatarGesturesPriorLimitsEnabled = arg2:GetAttribute("VRAvatarGesturesPriorLimitsEnabled")
        if vrAvatarGesturesPriorLimitsEnabled ~= nil then
            arg2.LimitsEnabled = vrAvatarGesturesPriorLimitsEnabled
            arg2.TwistLimitsEnabled = arg2:GetAttribute("VRAvatarGesturesPriorTwistLimitsEnabled")
            arg2:SetAttribute("VRAvatarGesturesPriorLimitsEnabled", nil)
            arg2:SetAttribute("VRAvatarGesturesPriorTwistLimitsEnabled", nil)
        end
    end)
end

function module.new()
    local self = setmetatable({}, module)

    self.connections = ConnectionUtil.new()

    self.VRPlayers = {}

    self.connections:connect("AvatarGestures", VRService:GetPropertyChangedSignal("AvatarGestures"), function()
        self:onAvatarGesturesChanged()
    end)

    if VRService.AvatarGestures then
        self:onAvatarGesturesChanged()
    end
    return self
end

function cleanCharacter(arg1)
    if not arg1.Character then
        return
    end

    if bool2 then
        for _, value in ipairs(tbl2) do
            restoreArmRagdollLimits(arg1.Character, value)
        end
    end

    local humanoid = arg1.Character:FindFirstChild("Humanoid")
    if humanoid then
        for _, value in pairs({ "TrackedIKLeftHand", "TrackedIKRightHand", "TrackedIKHead" }) do
            local var1 = humanoid:FindFirstChild(value)

            if var1 then
                var1:Destroy()
            end
        end
    end

    for _, value in pairs({ "TrackedLeftHand", "TrackedRightHand", "TrackedHead" }) do
        local var1 = arg1.Character:FindFirstChild(value)

        if var1 then
            var1:Destroy()
        end
    end
end

function module:onPlayerChanged(arg1, arg2)
    self.VRPlayers[arg1] = arg2 or nil

    if not arg2 then
        cleanCharacter(arg1)

        return
    end

    if not self.avatarUtil then
        self.avatarUtil = AvatarUtil.new()
    end

    self.avatarUtil:connectPlayerCharacterChanges(arg1, function(arg3)
        self:onCharacterChanged(arg3)
    end)
end

function module:onPlayerAdded(arg1)
    if next(self.VRPlayers) == nil then
        return
    end

    RbxAnalyticsService:ReportInfluxSeries(
        "VRAvatarGestures",
        {
            placeId = game.PlaceId,
            calledFrom = "ServerPlayerAddedWithVRPlayer",
            playerUserID = arg1.UserId
        },
        throttlingPercentage
    )
end

function module:onAvatarGesturesChanged()
    if not VRService.AvatarGestures then
        for k in pairs(self.VRPlayers) do
            self:onPlayerChanged(k, false)
        end

        self.connections:disconnectAll()
        self.connections:connect("AvatarGestures", VRService:GetPropertyChangedSignal("AvatarGestures"), function()
            self:onAvatarGesturesChanged()
        end)

        return
    end

    local avatarGesturesVrPlayer = RobloxReplicatedStorage:FindFirstChild("AvatarGesturesVRPlayer")
    if not avatarGesturesVrPlayer then
        avatarGesturesVrPlayer = Instance.new("RemoteEvent")
        avatarGesturesVrPlayer.Name = "AvatarGesturesVRPlayer"
        avatarGesturesVrPlayer.Parent = RobloxReplicatedStorage
    end

    self.connections:connect("VRPlayerOnServerEvent", avatarGesturesVrPlayer.OnServerEvent, function(arg1, arg2)
        self:onPlayerChanged(arg1, arg2)
    end)

    self.connections:connect("PlayerAdded", Players.PlayerAdded, function(arg1)
        self:onPlayerAdded(arg1)
    end)

    self.connections:connect("PlayerRemoving", Players.PlayerRemoving, function(arg1)
        self:onPlayerChanged(arg1, false)
    end)
end

function module:findOrCreateColliders(arg1, model: Model)
    local player = Players:GetPlayerFromCharacter(model)

    local var1 = "Tracked" .. arg1
    local var2 = model:FindFirstChild(var1)
    if not var2 then
        var2 = Instance.new("Part")
        var2.Name = var1
        var2.Transparency = 1
        var2.CanCollide = false
        var2.Parent = model
        var2:SetNetworkOwner(player)
    end

    local var3 = var2:FindFirstChild(var1 .. "Attachment")
    if not var3 then
        var3 = Instance.new("Attachment")
        var3.Name = var1 .. "Attachment"

        var3.Parent = var2
    end

    local var4 = var2:FindFirstChild(var1 .. "AlignPosition")
    if not var4 then
        var4 = Instance.new("AlignPosition")
        var4.Name = var1 .. "AlignPosition"
        var4.Mode = Enum.PositionAlignmentMode.OneAttachment
        var4.Attachment0 = var3
        var4.RigidityEnabled = true
        var4.Parent = var2
    end

    local var5 = var2:FindFirstChild(var1 .. "AlignOrientation")
    if not var5 then
        var5 = Instance.new("AlignOrientation")
        var5.Name = var1 .. "AlignOrientation"
        var5.Mode = Enum.OrientationAlignmentMode.OneAttachment
        var5.Attachment0 = var3
        var5.RigidityEnabled = true
        var5.Parent = var2
    end

    local var6 = model:FindFirstChild(arg1)
    if var6 then
        var2.Size = var6.Size
        var2.CFrame = var6.CFrame
        var4.Position = var6.Position
        var5.CFrame = var6.CFrame
    else
        var2.Size = Vector3.new(1, 1, 1)
        var2.CFrame = model.WorldPivot
        var4.Position = model.WorldPivot.Position
        var5.CFrame = model.WorldPivot
    end

    local humanoid = model:FindFirstChild("Humanoid")
    if not humanoid then
        return
    end

    local var7 = "TrackedIK" .. arg1
    local var8 = humanoid:FindFirstChild(var7)

    if not var8 then
        var8 = Instance.new("IKControl")
        var8.Name = var7
    end

    var8.SmoothTime = 0.1
    var8.Parent = humanoid
    var8.Target = var2
end

function module:createHandCollider(arg1, arg2)
    self:findOrCreateColliders(arg1 .. "Hand", arg2)
    local var1 = arg2:FindFirstChild(arg1 .. "Hand")

    local humanoid = arg2:FindFirstChild("Humanoid")
    if humanoid then
        local var2 = humanoid:FindFirstChild("TrackedIK" .. arg1 .. "Hand")

        if var2 then
            var2.Type = Enum.IKControlType.Transform

            local chainRoot = arg2:FindFirstChild(arg1 .. "UpperArm")
            if chainRoot then
                if bool1 then
                    var2.ChainRoot = nil
                else
                    var2.ChainRoot = var1
                end
                coroutine.wrap(function()
                    task.wait(0.1)
                    var2.ChainRoot = chainRoot
                end)()
            end

            if var1 then
                var2.EndEffector = var1
            end
            var2.Priority = 1
        end
    end

    if bool2 then
        suppressArmRagdollLimits(arg2, arg1)
        return
    end
    if not var1 then
        return
    end

    local ragdollBallSocket = var1:FindFirstChild("RagdollBallSocket")
    if ragdollBallSocket then
        ragdollBallSocket.LimitsEnabled = false
    end
end

function module:createHeadCollider(arg1)
    self:findOrCreateColliders("Head", arg1)
    local head = arg1:FindFirstChild("Head")

    local humanoid = arg1:FindFirstChild("Humanoid")
    if not humanoid then
        return
    end
    local trackedIkHead = humanoid:FindFirstChild("TrackedIKHead")

    if not trackedIkHead then
        return
    end

    trackedIkHead.Type = Enum.IKControlType.Rotation

    local upperTorso = arg1:FindFirstChild("UpperTorso")
    if upperTorso then
        trackedIkHead.ChainRoot = upperTorso
    end

    if head then
        trackedIkHead.EndEffector = head
    end
end

function module:onCharacterChanged(model: Model)
    local player = Players:GetPlayerFromCharacter(model)
    if self.VRPlayers[player] and VRService.AvatarGestures then
        self:createHandCollider("Left", model)
        self:createHandCollider("Right", model)
        self:createHeadCollider(model)
    end
end

module._suppressArmRagdollLimits = suppressArmRagdollLimits
module._restoreArmRagdollLimits = restoreArmRagdollLimits

return module
