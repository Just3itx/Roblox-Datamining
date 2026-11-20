-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local Players = game:GetService("Players")
local AvatarUtil = require(CorePackages.Workspace.Packages.CoreScriptsCommon).AvatarUtil

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new()
    local self = setmetatable({}, tbl1)

    self.avatarUtil = AvatarUtil.new()
    VRService:GetPropertyChangedSignal("AutomaticScaling"):Connect(function()
        self:onScalingChanged()
    end)
    UserGameSettings:GetPropertyChangedSignal("PlayerHeight"):Connect(function()
        self:onPlayerHeightChanged()
    end)
    VRService.UserCFrameChanged:Connect(function(type: Enum.UserCFrame, _cFrame: CFrame)
        if type == Enum.UserCFrame.Floor then
            self:onPlayerHeightChanged()
        end
    end)

    self:onScalingChanged()
    return self
end

function tbl1:setHeadScale(arg1)
    if VRService.AutomaticScaling ~= Enum.VRScaling.World then
        return
    end

    local subjectHeight = self:GetSubjectHeight(arg1)
    if not subjectHeight or subjectHeight <= 0 then
        return
    end
    local num1 = -VRService:GetUserCFrame(Enum.UserCFrame.Floor).Position.Y
    local headScale = if num1 < 0.8 * UserGameSettings.PlayerHeight then subjectHeight / UserGameSettings.PlayerHeight else subjectHeight / num1
    local currentCamera = workspace.CurrentCamera
    if not currentCamera then
        return
    end
    currentCamera.HeadScale = headScale
end

function tbl1:GetSubjectHeight(arg1)
    local humanoid = arg1:FindFirstChild("Humanoid")
    if humanoid and humanoid:GetState() == Enum.HumanoidStateType.Dead then
        return
    end

    local var1 = humanoid and humanoid.RootPart or arg1:FindFirstChild("HumanoidRootPart")
    if not (var1 and humanoid) then
        return nil
    end

    local hipHeight = humanoid.HipHeight

    local var2 = if humanoid.RigType == Enum.HumanoidRigType.R6 then 2 else hipHeight

    if not humanoid.AutomaticScalingEnabled then
        return var1.Size.Y / 2 + var2 + 2 + humanoid.CameraOffset.Y
    end

    local var3 = var1.Size.Y / 2 + 0.5
    return var1.Size.Y / 2 + var2 + var3 + humanoid.CameraOffset.Y
end

function tbl1:onPlayerHeightChanged()
    if Players.LocalPlayer and Players.LocalPlayer.Character then
        self:setHeadScale(Players.LocalPlayer.Character)
    end
end

function tbl1:onScalingChanged()
    if VRService.AutomaticScaling == Enum.VRScaling.World then
        if not self.characterChangedConnection then
            self.characterChangedConnection = self.avatarUtil:connectLocalCharacterChanges(function(arg1)
                self:setHeadScale(arg1)
            end)
        end
    elseif self.characterChangedConnection then
        self.characterChangedConnection:Disconnect()
        self.characterChangedConnection = nil
    end
end

return tbl1.new()
