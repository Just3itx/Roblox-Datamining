-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")

local bool1 = game:DefineFastFlag("EmoteSkinningDisableUseClassLookup", false)

local bool2 = game:DefineFastFlag("EmoteSkinningDisableCleanupCharacterConnections", false)
local num1 = game:DefineFastInt("UGCEmoteSkinningDisableTranslationThresholdMillistuds", 100) * 0.001

local tbl1 = ({})

local function getClipMetadata(animationId: string)
    if tbl1[animationId] then
        return tbl1[animationId]
    end

    local assetId = tonumber(animationId:match("%d+"))
    if not assetId then
        return nil
    end

    local success, result = pcall(function(): Instance
        return InsertService:LoadAsset(assetId)
    end)

    if not (success and result) then
        return nil
    end

    local var1 = result:FindFirstChildWhichIsA("AnimationClip", true)
    if not var1 then
        result:Destroy()
        return nil
    end

    local isUgcEmote = var1:GetAttribute("isUGCEmote")
    local maxPartTranslation = var1:GetAttribute("maxPartTranslation")

    result:Destroy()

    local tbl2 = {
        isUGCEmote = isUgcEmote == true,
        maxTranslation = typeof(maxPartTranslation) == "number" and maxPartTranslation or 0
    }
    tbl1[animationId] = tbl2
    return tbl2
end

local function setAllJointsSkinning(arg1, enableSkinning: boolean)
    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("Motor6D")
            or descendant:IsA("AnimationConstraint")
            or descendant:IsA("BallSocketConstraint")
            or descendant:IsA("Weld")
            or descendant:IsA("RigidConstraint")
        then
            descendant.EnableSkinning = enableSkinning
        end
    end
end

local tbl2 = ({})
local tbl3 = ({})

local function clearActiveEmoteConnection(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    if tbl2[arg1] then
        tbl2[arg1]:Disconnect()
        tbl2[arg1] = nil
    end
end

local function clearAnimationPlayedConnection(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if tbl3[arg1] then
        tbl3[arg1]:Disconnect()
        tbl3[arg1] = nil
    end
end

local function onCharacterRemoving(character: Model)
    clearActiveEmoteConnection(character)

    if bool2 then
        clearAnimationPlayedConnection(character)
    end
end

local function onAnimationPlayed(arg1, animationTrack: AnimationTrack) -- Luacid: Inlined by compiler; 1 call site recovered
    local animation = animationTrack.Animation
    if not animation then
        return
    end

    local animationId = animation.AnimationId
    if animationId == "" then
        return
    end

    task.spawn(function()
        local clipMetadata = getClipMetadata(animationId)
        if not clipMetadata or not clipMetadata.isUGCEmote or clipMetadata.maxTranslation <= num1 or not animationTrack.IsPlaying then
            return
        end

        clearActiveEmoteConnection(arg1)

        setAllJointsSkinning(arg1, false)

        tbl2[arg1] = animationTrack.Stopped:Connect(function()
            setAllJointsSkinning(arg1, true)
            clearActiveEmoteConnection(arg1)
        end)
    end)
end

local function onCharacterAdded(arg1)
    local animator

    if bool1 then
        local humanoid = arg1:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return
        end

        animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            return
        end
    else
        animator = arg1:WaitForChild("Humanoid"):WaitForChild("Animator")
    end

    local connection = animator.AnimationPlayed:Connect(function(animationTrack: AnimationTrack)
        onAnimationPlayed(arg1, animationTrack)
    end)

    if bool2 then
        clearAnimationPlayedConnection(arg1)
        tbl3[arg1] = connection
    end
end

local function onPlayerAdded(player: Player)
    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
    player.CharacterRemoving:Connect(onCharacterRemoving)
end

for _, player in Players:GetPlayers() do
    task.spawn(onPlayerAdded, player)
end
Players.PlayerAdded:Connect(onPlayerAdded)
