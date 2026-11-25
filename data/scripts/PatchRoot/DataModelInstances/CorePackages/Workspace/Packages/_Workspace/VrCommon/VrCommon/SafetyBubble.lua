-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrCommonParent = script:FindFirstAncestor("VrCommon").Parent

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local module = {}
module.__index = module

local Create = require(VrCommonParent.AppCommonLib).Create
local FIntSafetyBubbleRadius = require(script.Parent.FIntSafetyBubbleRadius)
local var1 = require(script.Parent.FIntSafetyBubbleTransparencyPercent) * 0.01

function module.new()
    local self = setmetatable({}, module)

    self.subjects = {}

    self.mode = UserGameSettings.VRSafetyBubbleMode
    self.enabled = self.mode ~= Enum.VRSafetyBubbleMode.Anyone
    self.updateCadence = 0.2

    self.Toggled = Create("BindableEvent")({ Name = "SafetyBubbleToggled" })

    UserGameSettings:GetPropertyChangedSignal("VRSafetyBubbleMode"):Connect(function()
        self.mode = UserGameSettings.VRSafetyBubbleMode
        local enabled = self.mode ~= Enum.VRSafetyBubbleMode.Anyone
        if self.enabled ~= enabled then
            self.enabled = enabled
            self.Toggled:Fire()

            RbxAnalyticsService:ReportCounter("VR-SafetyBubble-" .. (if enabled then "On" else "Off"))
        end
    end)

    return self
end

function module:ToggleEnabled()
    UserGameSettings.VRSafetyBubbleMode = self.enabled and Enum.VRSafetyBubbleMode.Anyone or Enum.VRSafetyBubbleMode.NoOne
end

function module:HasToolAncestor(arg1)
    return not (arg1 == nil or arg1.Parent == nil) and (arg1.Parent:IsA("Tool") or self:HasToolAncestor(arg1.Parent))
end

function module:IsValidPartToModify(arg1): boolean
    return if arg1:IsA("BasePart") or arg1:IsA("Decal") then not self:HasToolAncestor(arg1) else false
end

function module:CachePartsRecursive(arg1, arg2)
    if not arg1 then
        return
    end

    if self:IsValidPartToModify(arg1) then
        self.subjects[arg2].cachedParts[arg1] = true
        self.subjects[arg2].transparencyDirty = true
    end
    for _, child in pairs(arg1:GetChildren()) do
        self:CachePartsRecursive(child, arg2)
    end
end

function module:TeardownTransparency(arg1)
    for k, _ in pairs(self.subjects[arg1].cachedParts) do
        k.LocalTransparencyModifier = 0
    end
    self.subjects[arg1].cachedParts = {}
    self.subjects[arg1].transparencyDirty = true
    self.subjects[arg1].lastTransparency = nil

    if self.subjects[arg1].descendantAddedConn then
        self.subjects[arg1].descendantAddedConn:disconnect()
        self.subjects[arg1].descendantAddedConn = nil
    end
    if self.subjects[arg1].descendantRemovingConn then
        self.subjects[arg1].descendantRemovingConn:disconnect()
        self.subjects[arg1].descendantRemovingConn = nil
    end
    for k, toolDescendantAddedConn in pairs(self.subjects[arg1].toolDescendantAddedConns) do
        toolDescendantAddedConn:Disconnect()
        self.subjects[arg1].toolDescendantAddedConns[k] = nil
    end
    for k, toolDescendantRemovingConn in pairs(self.subjects[arg1].toolDescendantRemovingConns) do
        toolDescendantRemovingConn:Disconnect()
        self.subjects[arg1].toolDescendantRemovingConns[k] = nil
    end
end

function module:GetSubjectIndex(character)
    local subjectsLen = #self.subjects
    local num1 = 1

    while num1 <= subjectsLen do
        if self.subjects[num1].character == character then
            return num1
        end
        num1 += 1
    end

    return 0
end

function module:SubjectExists(arg1): boolean
    return self:GetSubjectIndex(arg1) > 0
end

function module:SetupTransparency(arg1)
    local subjectIndex = self:GetSubjectIndex(arg1)
    if subjectIndex == 0 then
        return
    end

    if self.subjects[subjectIndex].descendantAddedConn then
        self.subjects[subjectIndex].descendantAddedConn:disconnect()
    end
    self.subjects[subjectIndex].descendantAddedConn = arg1.DescendantAdded:Connect(function(descendant: Instance)
        subjectIndex = self:GetSubjectIndex(arg1)
        if subjectIndex == 0 then
            return
        end

        if self:IsValidPartToModify(descendant) then
            self.subjects[subjectIndex].cachedParts[descendant] = true
            self.subjects[subjectIndex].transparencyDirty = true
        end
    end)
    if self.descendantRemovingConn then
        self.descendantRemovingConn:disconnect()
    end

    self.descendantRemovingConn = arg1.DescendantRemoving:connect(function(descendant: Instance)
        subjectIndex = self:GetSubjectIndex(arg1)
        if subjectIndex == 0 then
            return
        end

        if self.subjects[subjectIndex] and self.subjects[subjectIndex].cachedParts[descendant] then
            self.subjects[subjectIndex].cachedParts[descendant] = nil

            descendant.LocalTransparencyModifier = 0
        end
    end)

    self:CachePartsRecursive(arg1, subjectIndex)
end

function module:AddSubject(character)
    local subjectsLen = #self.subjects
    local num1 = 1

    while num1 <= subjectsLen do
        if self.subjects[num1].character == character then
            return
        end
        num1 += 1
    end

    table.insert(self.subjects, {
        transparencyDirty = false,
        lastTransparency = nil,
        descendantAddedConn = nil,
        descendantRemovingConn = nil,
        toolDescendantAddedConns = {},
        toolDescendantRemovingConns = {},
        cachedParts = {},
        character = nil
    })

    self.subjects[num1].character = character
    self:SetupTransparency(character)
end

function module:update(arg1)
    local currentCamera = workspace.CurrentCamera
    if not currentCamera then
        return
    end

    if not self.enabled then
        if self.subjects and #self.subjects > 0 then
            for i = 1, #self.subjects do
                self:TeardownTransparency(i)
            end
            self.subjects = {}
        end

        return
    end

    local num1 = math.max(FIntSafetyBubbleRadius * currentCamera.HeadScale, 0.1)

    local character = nil
    local num2 = num1 + 3
    local cFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head)
    local var2 = currentCamera.CFrame * cFrame

    self.updateCadence -= arg1
    if self.updateCadence <= 0 then
        self.updateCadence = 0.2

        for _, player in pairs(Players:GetPlayers()) do
            if not player.Character or player == Players.LocalPlayer then
                continue
            end
            if self.mode == Enum.VRSafetyBubbleMode.OnlyFriends and Players.LocalPlayer:IsFriendsWithAsync(player.UserId) then
                local subjectIndex = self:GetSubjectIndex(player.Character)
                if subjectIndex > 0 then
                    self:TeardownTransparency(subjectIndex)
                    table.remove(self.subjects, subjectIndex)
                end
            elseif not self:SubjectExists(player.Character) and player.Character then
                local var3, var4 = player.Character:GetBoundingBox()
                local var5 = (var3.Position - var2.Position).Magnitude - var4.Z

                if var5 < num2 then
                    character = player.Character
                    num2 = var5
                end
            end
        end

        if character then
            self:AddSubject(character)
        end
    end

    if not self.subjects or #self.subjects == 0 then
        return
    end

    local subjectsLen = #self.subjects

    while subjectsLen > 0 do
        local var3, var4 = self.subjects[subjectsLen].character:GetBoundingBox()
        if (var3.Position - var2.Position).Magnitude - var4.Z > num1 * 2 then
            self:TeardownTransparency(subjectsLen)
            table.remove(self.subjects, subjectsLen)
        end

        subjectsLen -= 1
    end

    local subjectsLen2 = #self.subjects
    local num3 = 1

    while num3 <= subjectsLen2 do
        local num4 = 0

        local character2 = self.subjects[num3].character
        local magnitude

        if character2.PrimaryPart then
            magnitude = (Vector3.new(character2:GetPrimaryPartCFrame().p.x, var2.Position.Y, character2:GetPrimaryPartCFrame().p.z) - var2.Position).Magnitude
        else
            local var3, var4 = character2:GetBoundingBox()
            magnitude = (var3.Position - var2.Position).Magnitude - var4.Z
        end

        if magnitude < num1 then
            if subjectsLen2 > 3 then
                num4 = 1
            else
                local num5 = num1 * 0.75
                if magnitude < num5 then
                    num4 = var1
                else
                    num4 = (1 - (magnitude - num5) / (num1 - num5)) * var1
                end
            end
        end

        if not self.subjects[num3].lastTransparency then
            self.subjects[num3].transparencyDirty = true
        end

        local num5 = math.clamp(num4, 0, 1)

        if self.subjects[num3].transparencyDirty or self.subjects[num3].lastTransparency ~= num5 then
            for k, _ in pairs(self.subjects[num3].cachedParts) do
                k.LocalTransparencyModifier = num5
            end
            self.subjects[num3].transparencyDirty = false
            self.subjects[num3].lastTransparency = num5
        end

        local tool = character2:FindFirstChildOfClass("Tool")
        if tool then
            for _, child in pairs(tool:GetChildren()) do
                if child:IsA("BasePart") then
                    child.LocalTransparencyModifier = num5
                end
            end
        end

        num3 += 1
    end
end

return module
