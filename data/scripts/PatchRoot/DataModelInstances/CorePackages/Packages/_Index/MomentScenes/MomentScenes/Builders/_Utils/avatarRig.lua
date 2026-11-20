-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local loadAsset = require(script.Parent.loadAsset)

local C0 = CFrame.new(0, -1, 0) * CFrame.Angles(-(math.pi / 2), 0, 0)

local function staged(arg1, parent, callback: (...any) -> (...any))
    local parent2 = arg1.Parent
    local momentScenesStaging = Instance.new("Folder")
    momentScenesStaging.Name = "MomentScenesStaging"
    momentScenesStaging.Parent = parent
    arg1.Parent = momentScenesStaging

    local success, result = pcall(function()
        callback()
        return nil
    end)
    arg1.Parent = parent2
    momentScenesStaging:Destroy()
    if not success then
        error(result)
    end
end

local function solveJoints(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    staged(arg1, Workspace, function()
        for _, descendant in arg1:GetDescendants() do
            if descendant:IsA("BasePart") then
                local _descendantCFrame = descendant.CFrame
            end
        end
    end)
end

local function emoteAnimationId(num1: number): string | ContentId
    local str1 = `rbxassetid://{num1}`
    local success, result = pcall(loadAsset.loadAsset, num1)
    if not success or result == nil or typeof(result) ~= "Instance" then
        return str1
    end
    local animation = result:FindFirstChildWhichIsA("Animation")
    if animation ~= nil and animation.AnimationId ~= "" then
        str1 = animation.AnimationId
    end

    result:Destroy()
    return str1
end

local function playAnimation(parent, animationName: string, animationId: string)
    local humanoid = parent:FindFirstChildOfClass("Humanoid")
    if humanoid == nil then
        return nil
    end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    local var2

    if animator ~= nil then
        var2 = animator
    else
        var2 = Instance.new("Animator")
        var2.Parent = humanoid
    end
    local animation = Instance.new("Animation")
    animation.Name = animationName
    animation.AnimationId = animationId
    animation.Parent = parent

    local var3 = nil

    staged(parent, ReplicatedStorage, function()
        local success, result = pcall(function()
            return var2:LoadAnimation(animation)
        end)
        if not success or result == nil then
            return
        end
        result.Looped = true
        result:Play(0)
        local startTime = os.clock()

        while result.Length == 0 do
            if RunService:IsRunning() then
                task.wait()
            else
                wait(0)
            end
            if os.clock() - startTime > 2 then
                break
            end
        end

        result:AdjustSpeed(0)
        var3 = result
    end)
    return var3
end

local function equippedAnimationId(humanoidRigType): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if humanoidRigType == Enum.HumanoidRigType.R6 then 182393478 else 507768375
end

local function applyGearGrip(arg1, arg2: Instance, basePart: BasePart, humanoidRigType)
    local part0 = arg1:FindFirstChild(if humanoidRigType == Enum.HumanoidRigType.R6 then "Right Arm" else "RightHand")
    if part0 == nil or not part0:IsA("BasePart") then
        return
    end
    local rightGrip = part0:FindFirstChild("RightGrip")
    if rightGrip == nil then
        local rightGripAttachment = part0:FindFirstChild("RightGripAttachment")
        if rightGripAttachment == nil or not rightGripAttachment:IsA("Attachment") then
            return
        end
        rightGrip = Instance.new("Weld")
        rightGrip.Name = "RightGrip"
        rightGrip.Part0 = part0
        local c0 = if humanoidRigType == Enum.HumanoidRigType.R6 then C0 else rightGripAttachment.CFrame
        rightGrip.C0 = c0
        rightGrip.Parent = part0
    end

    if rightGrip == nil or not rightGrip:IsA("JointInstance") then
        return
    end

    if humanoidRigType == Enum.HumanoidRigType.R6 then
        rightGrip.C0 = C0
    end
    rightGrip.Part1 = basePart
    rightGrip.C1 = arg2.Grip
end

return {
    createAvatar = function(humanoidDescription: HumanoidDescription, humanoidRigType: Enum.HumanoidRigType)
        local success, result = pcall(function(): Model
            return Players:CreateHumanoidModelFromDescriptionAsync(humanoidDescription, humanoidRigType)
        end)
        if not success or result == nil then
            error(`avatarRig.createAvatar: CreateHumanoidModelFromDescriptionAsync failed: {result}`)
        end
        local humanoidRootPart = result:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart ~= nil and humanoidRootPart:IsA("BasePart") then
            humanoidRootPart.Anchored = true
            result.PrimaryPart = humanoidRootPart
        end

        solveJoints(result)
        return result
    end,
    solveJoints = solveJoints,
    playEmote = function(arg1, num1: number)
        if arg1:FindFirstChildOfClass("Humanoid") == nil then
            return nil
        end
        return (playAnimation(arg1, "Live3DEmote", (emoteAnimationId(num1))))
    end,
    emoteAnimationId = emoteAnimationId,
    equipGear = function(arg1, num1: number, humanoidRigType)
        local success, result = pcall(loadAsset.loadAsset, num1)
        if not success then
            warn(`avatarRig.equipGear: Gear {num1} failed to load ({result})`)
            return nil
        end
        if typeof(result) ~= "Instance" then
            warn(`avatarRig.equipGear: Gear {num1} loaded a {typeof(result)}, expected an Instance`)
            return nil
        end

        local var2 = result:FindFirstChildWhichIsA("Tool", true)
        if var2 == nil then
            result:Destroy()
            return nil
        end
        local handle = var2:FindFirstChild("Handle")
        if handle == nil or not handle:IsA("BasePart") then
            result:Destroy()
            return nil
        end
        for _, descendant in var2:GetDescendants() do
            if descendant:IsA("LuaSourceContainer") then
                descendant:Destroy()
            end
        end
        var2.Parent = arg1
        applyGearGrip(arg1, var2, handle, humanoidRigType)
        result:Destroy()
        local num2 = equippedAnimationId(humanoidRigType)
        return (playAnimation(arg1, "Live3DGearEquipped", `rbxassetid://{num2}`))
    end,
    equippedAnimationId = equippedAnimationId
}
