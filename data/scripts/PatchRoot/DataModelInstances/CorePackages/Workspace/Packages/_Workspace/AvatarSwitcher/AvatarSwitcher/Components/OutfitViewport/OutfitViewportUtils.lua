-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local AvatarEditorService = game:GetService("AvatarEditorService")

local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local module = {}

local str1 = game:DefineFastString("AvatarSwitcherEmoteIds", "3344650532,3344585679,5911729486")

local FFlagAvatarSwitcherAccurateAvatarWarning = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherAccurateAvatarWarning
local bool1 = game:DefineFastFlag("AvatarSwitcherMakeupSupport", false)

function module.buildOutfitModel(outfitId: number, humanoidRigType: Enum.HumanoidRigType)
    local humanoidDescription = Players:GetHumanoidDescriptionFromOutfitIdAsync(outfitId)
    local humanoidDescription2 = AvatarEditorService:ConformToAvatarRulesAsync(humanoidDescription)
    local model = Players:CreateHumanoidModelFromDescriptionAsync(humanoidDescription2, humanoidRigType)
    if FFlagAvatarSwitcherAccurateAvatarWarning then
        return model, humanoidDescription2
    end
    return model
end

function module.getCameraDistance(arg1, num1: number)
    local _, var1 = arg1:GetBoundingBox()
    return (var1 / 2).Magnitude / math.sin(math.rad(num1 / 2))
end

function module.loadIdleAnimationForAvatar(arg1)
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    local var1 = humanoid and humanoid:FindFirstChildOfClass("Animator")
    if not var1 then
        return nil
    end

    local animate = arg1:FindFirstChild("Animate")
    if not animate then
        return nil
    end

    local idle = animate:FindFirstChild("idle")
    if not idle then
        return nil
    end

    local animation = idle:FindFirstChildOfClass("Animation")
    if not animation then
        return nil
    end

    local animationResult = var1:LoadAnimation(animation)
    animationResult.Looped = true
    return animationResult
end

function module.loadAnimationTrackForAvatar(str2: string, arg1)
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    local var1 = humanoid and humanoid:FindFirstChildOfClass("Animator")
    if not var1 then
        return nil
    end

    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. str2
    return (var1:LoadAnimation(animation))
end

local var1 = nil
function module.playRandomEmote(arg1)
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    local var2 = humanoid and humanoid.RigType == Enum.HumanoidRigType.R15
    local var3 = nil

    local success, result = pcall(function(): {string}
        return string.split(str1)
    end)

    if var2 and success and #result > 0 then
        local var4

        repeat
            var4 = result[math.random(#result)]
        until var4 ~= var1 or #result == 1

        var3 = module.loadAnimationTrackForAvatar(var4, arg1)
        var1 = var4
    end

    task.spawn(function()
        if var3 then
            var3.Looped = false
            var3:Play()
            var3.Stopped:Wait()
        end

        if arg1.Parent == nil then
            return
        end

        local var4 = module.loadIdleAnimationForAvatar(arg1)
        if var4 then
            var4.Looped = true
            var4:Play()
        end
    end)
end

function module.hasMissingAccessoriesInHumanoid(arg1, arg2): boolean
    local accessories = arg2:GetAccessories(true)
    local accessories2 = arg1:GetAccessories()

    return #accessories > #accessories2
end

local function getAssetIdsInHumanoidDescription(arg1)
    local assetIdsInHumanoidDescription = {}

    for _, value in arg1:GetAccessories(true) do
        assetIdsInHumanoidDescription[value.AssetId] = true
    end

    assetIdsInHumanoidDescription[arg1.Face] = true
    assetIdsInHumanoidDescription[arg1.Head] = true
    assetIdsInHumanoidDescription[arg1.Torso] = true
    assetIdsInHumanoidDescription[arg1.LeftArm] = true
    assetIdsInHumanoidDescription[arg1.RightArm] = true
    assetIdsInHumanoidDescription[arg1.LeftLeg] = true
    assetIdsInHumanoidDescription[arg1.RightLeg] = true

    assetIdsInHumanoidDescription[arg1.GraphicTShirt] = true
    assetIdsInHumanoidDescription[arg1.Pants] = true
    assetIdsInHumanoidDescription[arg1.Shirt] = true

    assetIdsInHumanoidDescription[arg1.ClimbAnimation] = true
    assetIdsInHumanoidDescription[arg1.FallAnimation] = true
    assetIdsInHumanoidDescription[arg1.IdleAnimation] = true
    assetIdsInHumanoidDescription[arg1.JumpAnimation] = true
    assetIdsInHumanoidDescription[arg1.MoodAnimation] = true
    assetIdsInHumanoidDescription[arg1.RunAnimation] = true
    assetIdsInHumanoidDescription[arg1.SwimAnimation] = true
    assetIdsInHumanoidDescription[arg1.WalkAnimation] = true

    if bool1 then
        for _, child in arg1:GetChildren() do
            if child:IsA("MakeupDescription") then
                assetIdsInHumanoidDescription[child.AssetId] = true
            end
        end
    end

    return assetIdsInHumanoidDescription
end

function module.hasMissingAssetsInDescription(arg1, tbl1)
    local assetIdsInHumanoidDescription = getAssetIdsInHumanoidDescription(arg1)

    for _, value in tbl1 do
        if not assetIdsInHumanoidDescription[value] then
            return true
        end
    end

    return false
end

return module
