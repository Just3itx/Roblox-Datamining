-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VRService = game:GetService("VRService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local CorePackages = game:GetService("CorePackages")
local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CoreScriptsCommon = require(CorePackages.Workspace.Packages.CoreScriptsCommon)
local ConnectionUtil = CoreScriptsCommon.ConnectionUtil
local AvatarUtil = CoreScriptsCommon.AvatarUtil

local bool1 = game:DefineFastFlag("DebugImmersionModeNonVR", false)

local bool2 = game:DefineFastFlag("VRAvatarGesturesFixFirstPersonHeadScale", false)

local throttlingPercentage = game:DefineFastInt("VRAvatarGesturesAnalyticsThrottleHundrethsPercent", 0)

local function isVRFirstPerson(currentCamera: Camera): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return (if bool2 then 5 * currentCamera.HeadScale else 5) >= (currentCamera.CFrame.Position - currentCamera.Focus.Position).Magnitude
end

local tbl1 = ({})
tbl1.__index = tbl1

function tbl1.new()
    local self = setmetatable({}, tbl1)
    self.partCFrameMap = {}
    self.connections = ConnectionUtil.new()
    self.analyticsSendEnabled = true
    self.connections:connect("AvatarGestures", VRService:GetPropertyChangedSignal("AvatarGestures"), function()
        self:onAvatarGesturesChanged()
    end)

    if VRService.AvatarGestures then
        self:onAvatarGesturesChanged()
    end

    return self
end

function tbl1:onCharacterChanged(arg1)
    local humanoid = arg1:FindFirstChild("Humanoid")
    if not humanoid then
        return
    end

    for _, value in pairs({ "TrackedIKLeftHand", "TrackedIKRightHand", "TrackedIKHead" }) do
        local var1 = humanoid:FindFirstChild(value)

        if var1 then
            var1.SmoothTime = 0
        end
    end

    local currentCamera = workspace.CurrentCamera
    if not currentCamera then
        return
    end

    local function updateSeated(arg2)
        local isVehicleSeat = currentCamera.CameraSubject and currentCamera.CameraSubject:IsA("VehicleSeat")
        local bool3 = isVRFirstPerson(currentCamera)

        local trackedIkHead = humanoid:FindFirstChild("TrackedIKHead")
        if not trackedIkHead then
            return
        end

        if arg2 and not isVehicleSeat and bool3 then
            trackedIkHead.Type = Enum.IKControlType.Transform
            return
        end
        trackedIkHead.Type = Enum.IKControlType.Rotation
    end

    updateSeated(humanoid.Sit)
    self.connections:connect("Seated", humanoid.Seated, function(arg2)
        updateSeated(arg2)

        if arg2 and isVRFirstPerson(currentCamera) then
            VRService:RecenterUserHeadCFrame()
        end
    end)
end

function tbl1:onAvatarGesturesChanged()
    if not VRService.AvatarGestures then
        if VRService.VREnabled or bool1 then
            local avatarGesturesVrPlayer = RobloxReplicatedStorage:FindFirstChild("AvatarGesturesVRPlayer")
            if avatarGesturesVrPlayer then
                avatarGesturesVrPlayer:FireServer(false)
            end
        end

        self.connections:disconnectAll()
        self.connections:connect("AvatarGestures", VRService:GetPropertyChangedSignal("AvatarGestures"), function()
            self:onAvatarGesturesChanged()
        end)

        return
    end

    if not VRService.VREnabled and not bool1 then
        return
    end

    local avatarGesturesVrPlayer = RobloxReplicatedStorage:WaitForChild("AvatarGesturesVRPlayer", 5)
    if not avatarGesturesVrPlayer then
        warn("VRService.AvatarGestures failed to connect to server")
        return
    end
    avatarGesturesVrPlayer:FireServer(true)

    self:connectInputCFrames()

    if not self.avatarUtil then
        self.avatarUtil = AvatarUtil.new()
        self.avatarUtil:connectLocalCharacterChanges(function(arg1)
            self:onCharacterChanged(arg1)
        end)
    elseif Players.LocalPlayer and Players.LocalPlayer.Character then
        self:onCharacterChanged(Players.LocalPlayer.Character)
    end

    if not self.analyticsSendEnabled then
        return
    end

    self.analyticsSendEnabled = nil

    RbxAnalyticsService:ReportInfluxSeries(
        "VRAvatarGestures",
        {
            placeId = game.PlaceId,
            calledFrom = "ClientJoined"
        },
        throttlingPercentage
    )
end

function tbl1:updateCFrames(name, arg1)
    local localPlayer = Players.LocalPlayer
    if not Players.LocalPlayer then
        return
    end

    local character = localPlayer.Character
    if not localPlayer.Character then
        return
    end

    local var1 = character:FindFirstChild(name)
    if not var1 then
        return
    end

    local currentCamera = workspace.CurrentCamera
    if not currentCamera or not var1:FindFirstChild(name .. "Attachment") then
        return
    end

    local var2 = var1:FindFirstChild(name .. "AlignPosition")
    if not var2 then
        return
    end

    local var3 = var1:FindFirstChild(name .. "AlignOrientation")
    if not var3 then
        return
    end

    if VRService.VREnabled then
        arg1 = arg1.Rotation + arg1.Position * currentCamera.HeadScale
        local var4 = currentCamera.CFrame * arg1

        local head = character:FindFirstChild("Head")

        if not isVRFirstPerson(currentCamera) and head then
            local cFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head)
            local var5 = cFrame.Rotation + cFrame.Position * currentCamera.HeadScale
            local var6 = currentCamera.CFrame * var5 * CFrame.new(0, 0, 0.5)

            if name ~= "TrackedHead" then
                local var7 = head.CFrame:ToWorldSpace(var6:ToObjectSpace(var4))
                var2.Position = var7.Position
                var3.CFrame = var7 * CFrame.Angles(math.pi / 2, 0, 0)
            else
                local primaryPartCFrame = character.PrimaryPart.CFrame
                var2.Position = (primaryPartCFrame * CFrame.new(0, primaryPartCFrame.Position.Y * 0.25, -primaryPartCFrame.Position.Y * 0.125)).Position

                var3.CFrame = primaryPartCFrame * arg1
            end
        else
            var2.Position = var4.Position

            if name ~= "TrackedHead" then
                var3.CFrame = var4 * CFrame.Angles(math.pi / 2, 0, 0)
            else
                var3.CFrame = var4
            end
        end
    else
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local var4 = if name ~= "TrackedHead" then humanoidRootPart.CFrame * arg1 * CFrame.Angles(0, 0, math.rad(time() * 30)) * CFrame.new(1, 0, -0.5) else humanoidRootPart.CFrame * arg1

        if humanoidRootPart then
            var2.Position = var4.Position
            var3.CFrame = var4
        end
    end

    var1.CFrame = CFrame.new(var2.Position) * var3.CFrame.Rotation
end

function tbl1:steppedCframes()
    for k, value in pairs(self.partCFrameMap) do
        self:updateCFrames(k, value)
    end
end

function tbl1:connectInputCFrames()
    if VRService.VREnabled then
        self.connections:connect("UserCFrameChanged", VRService.UserCFrameChanged, function(userCFrame, arg1)
            if userCFrame == Enum.UserCFrame.LeftHand then
                self.partCFrameMap.TrackedLeftHand = arg1
            elseif userCFrame == Enum.UserCFrame.RightHand then
                self.partCFrameMap.TrackedRightHand = arg1
            elseif userCFrame == Enum.UserCFrame.Head then
                self.partCFrameMap.TrackedHead = arg1
            end
        end)
    elseif bool1 then
        self.connections:connect("NonVRSimulateInput", RunService.RenderStepped, function(_)
            self.partCFrameMap.TrackedLeftHand = CFrame.new(-0.5, 0, -0.5)
            self.partCFrameMap.TrackedRightHand = CFrame.new(0.5, 0, -0.5)
            self.partCFrameMap.TrackedHead = CFrame.new(0, 1, 0)
        end)
    end

    if VRService.VREnabled or bool1 then
        self.connections:connect("RenderStepped", RunService.RenderStepped, function(_)
            self:steppedCframes()
        end)
    end
end

return tbl1.new()
