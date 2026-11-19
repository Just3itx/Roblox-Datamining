-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local CorePackages = game:GetService("CorePackages")

local Promise = require(CorePackages.Packages.Promise)

local cFrame = CFrame.new(Vector3.new(0, 150, 0))

local num1 = game:DefineFastInt("InspectAndBuyClusterCompositionTimeoutMs", 3000)

local module = {}
module.__index = module

local function setupCharacterModels(pos: Vector3)
    local model = Players:CreateHumanoidModelFromDescriptionAsync(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R6)

    local model2 = Players:CreateHumanoidModelFromDescriptionAsync(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15)

    model.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    model2.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    model.HumanoidRootPart.Anchored = true
    model2.HumanoidRootPart.Anchored = true
    model.Parent = RobloxReplicatedStorage
    model2.Parent = RobloxReplicatedStorage

    model.HumanoidRootPart.CFrame = CFrame.new(pos)

    model2:SetPrimaryPartCFrame(model.HumanoidRootPart.CFrame)

    return model, model2
end

function module.new(worldModelRef, pos, avatarType, mockApplyDescription)
    local result = {}
    setmetatable(result, module)

    result.mockApplyDescription = mockApplyDescription

    local model, model2 = setupCharacterModels(pos)

    result.r6 = model
    result.r15current = model2
    result.r15offScreen = model2:Clone()
    result.r15offScreen.Parent = RobloxReplicatedStorage

    result.avatarType = avatarType
    result.worldModelRef = worldModelRef

    result.inProgressPromise = nil

    result.waitingPromise = nil

    result.r6Promise = nil

    result.destroyed = false

    return result
end

function module:setupAnimations(arg1, arg2)
    arg1.Parent = self.r6
    arg2.Parent = self.r15current
    arg2.Archivable = true
    local argClone = arg2:Clone()
    argClone.Parent = self.r15offScreen
    argClone.Archivable = false
    arg2.Archivable = false
end

function module:getCurrentCharacter()
    return if self.avatarType == Enum.HumanoidRigType.R15 then self.r15current else self.r6
end

function module:isR15(): boolean
    return self.avatarType == Enum.HumanoidRigType.R15
end

function module:syncRotation(arg1, arg2)
    local _, _, _, r00, r01, r02, r10, r11, r12, r20, r21, r22 = arg1.HumanoidRootPart.CFrame:components()
    local p = arg2.HumanoidRootPart.CFrame.p
    arg2.HumanoidRootPart.CFrame = CFrame.new(p.X, p.Y, p.Z, r00, r01, r02, r10, r11, r12, r20, r21, r22)
end

local function hasLayeredAccessoryUpdates(appliedDescription, arg1)
    local accessories = appliedDescription:GetAccessories(false)
    local accessories2 = arg1:GetAccessories(false)

    if #accessories2 == 0 then
        return false
    end

    if #accessories ~= #accessories2 then
        return true
    end

    local tbl1 = {}
    for _, value in ipairs(accessories) do
        tbl1[value.AssetId] = true
    end

    for _, value in ipairs(accessories2) do
        if not tbl1[value.AssetId] then
            return true
        end
    end

    return false
end

local function hasWrapLayer(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1:FindFirstChildWhichIsA("WrapLayer", true) ~= nil
end

function module:_doUpdateR6(arg1)
    return Promise.new(function(callback, _)
        self.r6.Parent = self.worldModelRef:getValue()
        if self.mockApplyDescription then
            self.mockApplyDescription(self.r6, arg1)
        else
            self.r6.Humanoid:ApplyDescriptionAsync(arg1)
        end

        callback(self:getCurrentCharacter())
    end)
end

function module:_doSimpleUpdateR15(arg1)
    return Promise.new(function(callback, _)
        self.r15current.Parent = self.worldModelRef:getValue()
        if self.mockApplyDescription then
            self.mockApplyDescription(self.r15current, arg1)
        else
            self.r15current.Humanoid:ApplyDescriptionAsync(arg1)
        end

        callback(self.r15current)
    end)
end

function module:_updateOffscreenR15(arg1)
    return Promise.new(function(callback, _)
        self.r15offScreen.HumanoidRootPart.CFrame = cFrame
        self.r15offScreen.Parent = self.worldModelRef:getValue()

        if self.mockApplyDescription then
            self.mockApplyDescription(self.r15offScreen, arg1)
        else
            self.r15offScreen.Humanoid:ApplyDescriptionAsync(arg1)
        end

        callback(self.r15offScreen)
    end)
end

local function waitForClusterCompositionFinished(arg1)
    if not hasWrapLayer(arg1) then
        return Promise.resolve(false)
    end

    return Promise.race({ Promise.fromEvent(arg1.Humanoid.ClusterCompositionFinished), Promise.delay(num1 * 0.001) }):andThen(
        function(): boolean
            return true
        end
    )
end

function module:_completeUpdate()
    local humanoidRootPartCFrame = self.r15current.HumanoidRootPart.CFrame
    self.r15offScreen.HumanoidRootPart.CFrame = humanoidRootPartCFrame

    self.r15current.HumanoidRootPart.CFrame = cFrame
    self.r15current.Parent = RobloxReplicatedStorage

    local r15current = self.r15current
    local r15offScreen = self.r15offScreen
    self.r15offScreen = r15current
    self.r15current = r15offScreen

    return self.r15current
end

function module:_doUpdateR15(arg1)
    local appliedDescription = self.r15current.Humanoid:GetAppliedDescription()
    if not hasLayeredAccessoryUpdates(appliedDescription, arg1) then
        return self:_doSimpleUpdateR15(arg1)
    end

    self.inProgressPromise = self:_updateOffscreenR15(arg1):andThen(waitForClusterCompositionFinished):andThen(function()
        return self:_completeUpdate()
    end)
    return self.inProgressPromise
end

function module:maybeUpdateCharacter(arg1)
    if self.avatarType == Enum.HumanoidRigType.R6 then
        self.r6Promise = self:_doUpdateR6(arg1)
        return self.r6Promise
    end

    if not self.inProgressPromise or self.inProgressPromise:getStatus() ~= Promise.Status.Started then
        return self:_doUpdateR15(arg1)
    end

    local waitingPromise = self.waitingPromise

    self.waitingPromise = self.inProgressPromise:andThen(function()
        return self:_doUpdateR15(arg1)
    end)

    if waitingPromise then
        waitingPromise:cancel()
    end

    return self.waitingPromise
end

function module:switchAvatarType(avatarType)
    if avatarType == self.avatarType then
        return self:getCurrentCharacter()
    end

    self:_cancelPromises()

    self.avatarType = avatarType
    local var1, var2

    if avatarType == Enum.HumanoidRigType.R6 then
        var1 = self.r6
        var2 = self.r15current
    else
        var1 = self.r15current
        var2 = self.r6
    end

    var2.Parent = RobloxReplicatedStorage
    var2.Humanoid:UnequipTools()

    self:syncRotation(var2, var1)

    return var1
end

function module.start(_) end

local function cancelPromise(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1 then
        arg1:cancel()
    end
end

function module:_cancelPromises()
    cancelPromise(self.inProgressPromise)
    cancelPromise(self.waitingPromise)
    cancelPromise(self.r6Promise)
    self.inProgressPromise = nil
    self.waitingPromise = nil
    self.r6Promise = nil
end

function module:stop()
    self.r6.Parent = RobloxReplicatedStorage
    self.r15current.Parent = RobloxReplicatedStorage
    self.r15offScreen.Parent = RobloxReplicatedStorage

    self:_cancelPromises()
end

function module:onDestroy()
    self:_cancelPromises()

    self.r6:Destroy()
    self.r15current:Destroy()
    self.r15offScreen:Destroy()
end

return module
