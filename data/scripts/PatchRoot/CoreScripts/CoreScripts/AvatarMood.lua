-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LocalPlayer = Players.LocalPlayer
local _RobloxGui = CoreGui.RobloxGui
require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)
local var1 = nil
local var2 = nil
local Core = Enum.AnimationPriority.Core
local var3 = nil
local bool1 = true
local bool2 = false

local tbl1 = ({})

local tbl2 = {
    EmoteStopped = "currentEmoteTrackStopped",
    EmoteKeyframeReached = "emoteKeyframeReached",
    AnimationInstanceChanged = "animationInstanceChanged",
    EmoteTriggered = "localEmote",
    AnimateScriptAdded = "animateScriptAdded",
    AnimateScriptMoodAdded = "animateScriptMoodAdded",
    AnimateScriptMoodRemoved = "animateScriptMoodRemoved",
    MoodChildAdded = "moodChildAdded",
    HeadChildAdded = "headChildAdded",
    CharacterHumanoidAdded = "characterHumanoidAdded",
    HumanoidAnimatorAdded = "humanoidAnimatorAdded",
    CharacterChildAdded = "characterChildAdded",
    CharacterChildRemoved = "characterChildRemoved",
    DescendantAdded = "DescendantAdded",
    DescendantRemoving = "DescendantRemoving",
    AnimationStreamTrackPlayed = "AnimationStreamTrackPlayed",
    StreamTrackStopped = "StreamTrackStopped"
}

local tbl3 = {
    wave = true,
    point = true,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = true,
    cheer = true
}

local function getPlayerHumanoid(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1.Character then
        return arg1.Character:FindFirstChildOfClass("Humanoid")
    end

    return nil
end

local function getPlayerAnimator(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local playerHumanoid = getPlayerHumanoid(arg1)

    if playerHumanoid then
        return playerHumanoid:FindFirstChildOfClass("Animator")
    end

    return nil
end

local function switchPriority(animationPriority: Enum.AnimationPriority) -- Luacid: Inlined by compiler; 9 call sites recovered
    Core = animationPriority
    if var2 then
        var2.Priority = Core
    end
end

local function disconnectAndRemoveConnection(str1: string) -- Luacid: Inlined by compiler; 49 call sites recovered
    if tbl1[str1] ~= nil then
        tbl1[str1]:Disconnect()
        tbl1[str1] = nil
    end
end

local function resumeMoodAfterEmote() -- Luacid: unused: defined but never referenced
    var3 = nil
    if var2 ~= nil then
        var2:Play()
    end

    disconnectAndRemoveConnection("currentEmoteTrackStopped")
    disconnectAndRemoveConnection("emoteKeyframeReached")
end

local function onEmoteTriggered(success: boolean, animationTrack: AnimationTrack)
    if not bool1 or var2 == nil then
        return
    end

    if not success or not animationTrack then
        return
    end

    var2:Stop()
    var3 = animationTrack
    bool2 = true
    disconnectAndRemoveConnection("currentEmoteTrackStopped")
    disconnectAndRemoveConnection("emoteKeyframeReached")

    tbl1.currentEmoteTrackStopped = var3.Stopped:Connect(function()
        var3 = nil
        if var2 ~= nil then
            var2:Play()
        end

        disconnectAndRemoveConnection(tbl2.EmoteStopped)
        disconnectAndRemoveConnection(tbl2.EmoteKeyframeReached)

        bool2 = false
    end)

    tbl1.emoteKeyframeReached = var3.KeyframeReached:Connect(function(keyframeName: string)
        if keyframeName ~= "End" or var3.Looped then
            return
        end

        var3 = nil
        if var2 ~= nil then
            var2:Play()
        end

        disconnectAndRemoveConnection(tbl2.EmoteStopped)
        disconnectAndRemoveConnection(tbl2.EmoteKeyframeReached)

        bool2 = false
    end)
end

local function checkEmotePlaying(arg1): boolean
    local playingAnimationTracks = arg1:GetPlayingAnimationTracks()
    local bool3 = false

    for _, playingAnimationTrack in pairs(playingAnimationTracks) do
        if not (playingAnimationTrack.IsPlaying and playingAnimationTrack.Animation.Parent) then
            continue
        end

        local animationParentName = playingAnimationTrack.Animation.Parent.Name
        if not tbl3[animationParentName] then
            continue
        end

        disconnectAndRemoveConnection("currentEmoteTrackStopped")
        disconnectAndRemoveConnection("emoteKeyframeReached")
        var3 = playingAnimationTrack
        bool2 = false
        var2:Stop()

        tbl1.currentEmoteTrackStopped = var3.Stopped:Connect(function()
            wait(0.3)
            if checkEmotePlaying(arg1) or bool2 then
                return
            end

            var3 = nil
            if var2 ~= nil then
                var2:Play()
            end

            disconnectAndRemoveConnection(tbl2.EmoteStopped)
            disconnectAndRemoveConnection(tbl2.EmoteKeyframeReached)
        end)

        tbl1.emoteKeyframeReached = var3.KeyframeReached:Connect(function(keyframeName: string)
            if keyframeName ~= "End" then
                return
            end
            wait(0.3)
            if checkEmotePlaying(arg1) or bool2 then
                return
            end

            var3 = nil
            if var2 ~= nil then
                var2:Play()
            end

            disconnectAndRemoveConnection(tbl2.EmoteStopped)
            disconnectAndRemoveConnection(tbl2.EmoteKeyframeReached)
        end)

        bool3 = true
    end

    return bool3
end

local _connection = LocalPlayer.Chatted:Connect(function(message: string)
    if not bool1 or var2 == nil then
        return
    end

    if not LocalPlayer.Character then
        return
    end

    local humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then
        return
    end

    local str1 = ""
    if string.sub(message, 1, 3) == "/e " then
        str1 = string.sub(message, 4)
    elseif string.sub(message, 1, 7) == "/emote " then
        str1 = string.sub(message, 8)
    end

    if tbl3[str1] then
        wait(0.3)
        checkEmotePlaying(humanoid)
    end
end)

local function stopAndDestroyCurrentMoodTrack() -- Luacid: Inlined by compiler; 6 call sites recovered
    if var2 ~= nil then
        var2:Stop()
        var2:Destroy()
        var2 = nil
    end
end

local function stopAndDestroyCurrentMoodTrackConnections() -- Luacid: unused: defined but never referenced
    stopAndDestroyCurrentMoodTrack()
    disconnectAndRemoveConnection("currentEmoteTrackStopped")
    disconnectAndRemoveConnection("emoteKeyframeReached")
    disconnectAndRemoveConnection("animationInstanceChanged")
    disconnectAndRemoveConnection("localEmote")
    var1 = nil
end

local function updateCharacterMoodOnAnimatorAdded(_, _, humanoid, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    var2 = arg1:LoadAnimation(var1)
    var2.Priority = Core

    task.delay(0.1, function()
        if var3 == nil and var1 then
            var2 = var2 or arg1:LoadAnimation(var1)

            if var2 then
                var2.Priority = Core
                var2:Play()
            end
        end

        disconnectAndRemoveConnection("localEmote")
        tbl1.localEmote = humanoid.EmoteTriggered:Connect(onEmoteTriggered)
    end)
end

local function updateCharacterMoodOnHumanoidAdded(arg1, arg2, humanoid)
    local animator = humanoid:FindFirstChild("Animator")
    if animator then
        updateCharacterMoodOnAnimatorAdded(nil, nil, humanoid, animator)
    end

    if tbl1.humanoidAnimatorAdded then
        disconnectAndRemoveConnection("humanoidAnimatorAdded")
    end

    tbl1.humanoidAnimatorAdded = humanoid.ChildAdded:Connect(function(child: Instance)
        if child.Name == "Animator" then
            updateCharacterMoodOnAnimatorAdded(nil, nil, humanoid, child)
        end
    end)
end

local function updateCharacterMood(arg1, arg2)
    if arg1 == nil or arg2 == nil or not bool1 then
        return
    end

    if tbl1.animationInstanceChanged then
        disconnectAndRemoveConnection("animationInstanceChanged")
    end

    if tbl1.characterHumanoidAdded then
        disconnectAndRemoveConnection("characterHumanoidAdded")
    end

    stopAndDestroyCurrentMoodTrack()
    var1 = arg2
    tbl1.animationInstanceChanged = var1.Changed:Connect(function(_)
        updateCharacterMood(arg1, arg2)
    end)

    local humanoid = arg1:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        updateCharacterMoodOnHumanoidAdded(arg1, arg2, humanoid)
    end

    tbl1.characterHumanoidAdded = arg1.ChildAdded:Connect(function(child: Instance)
        if child:IsA("Humanoid") then
            updateCharacterMoodOnHumanoidAdded(arg1, arg2, humanoid)
        end
    end)
end

function initAvatarMood(arg1)
    local moodsEnabled = arg1:FindFirstChild("MoodsEnabled")
    disconnectAndRemoveConnection("animateScriptMoodAdded")
    disconnectAndRemoveConnection("animateScriptMoodRemoved")

    if moodsEnabled then
        bool1 = false
        return
    end

    local mood = arg1:FindFirstChild("mood")

    if mood then
        if #mood:GetChildren() > 0 then
            updateCharacterMood(LocalPlayer.Character, mood:FindFirstChildWhichIsA("Animation"))
        end

        disconnectAndRemoveConnection("moodChildAdded")

        tbl1.moodChildAdded = mood.ChildAdded:Connect(function(child: Instance)
            if child:IsA("Animation") then
                updateCharacterMood(LocalPlayer.Character, child)
            end
        end)
    else
        stopAndDestroyCurrentMoodTrack()
        disconnectAndRemoveConnection(tbl2.EmoteStopped)
        disconnectAndRemoveConnection(tbl2.EmoteKeyframeReached)
        disconnectAndRemoveConnection(tbl2.AnimationInstanceChanged)
        disconnectAndRemoveConnection(tbl2.EmoteTriggered)
        var1 = nil
    end

    tbl1.animateScriptMoodAdded = arg1.ChildAdded:Connect(function(child: Instance)
        if child.Name ~= "mood" then
            if child.Name == "MoodsEnabled" then
                bool1 = false
            end
            return
        end

        if #child:GetChildren() > 0 then
            local var4 = child:GetChildren()[1]
            updateCharacterMood(LocalPlayer.Character, var4)
        end

        disconnectAndRemoveConnection("moodChildAdded")

        tbl1.moodChildAdded = child.ChildAdded:Connect(function(child: Instance)
            updateCharacterMood(LocalPlayer.Character, child)
        end)
    end)

    tbl1.animateScriptMoodRemoved = arg1.ChildRemoved:Connect(function(child: Instance)
        if child.Name ~= "mood" then
            return
        end

        local mood2 = arg1:FindFirstChild("mood")
        if mood2 then
            updateCharacterMood(LocalPlayer.Character, mood2:FindFirstChildWhichIsA("Animation"))
            return
        end

        stopAndDestroyCurrentMoodTrack()
        disconnectAndRemoveConnection(tbl2.EmoteStopped)
        disconnectAndRemoveConnection(tbl2.EmoteKeyframeReached)
        disconnectAndRemoveConnection(tbl2.AnimationInstanceChanged)
        disconnectAndRemoveConnection(tbl2.EmoteTriggered)
        var1 = nil
    end)
end

local function waitForAnimateScript()
    local animate = LocalPlayer.Character:FindFirstChild("Animate")
    if animate then
        initAvatarMood(animate)
    end

    disconnectAndRemoveConnection("animateScriptAdded")

    tbl1.animateScriptAdded = LocalPlayer.Character.ChildAdded:Connect(function(child: Instance)
        if child.Name == "Animate" then
            initAvatarMood(child)
        end
    end)
end

local function onHeadAdded(arg1: Instance)
    if arg1:FindFirstChildWhichIsA("FaceControls") then
        waitForAnimateScript()
    end

    disconnectAndRemoveConnection("headChildAdded")

    tbl1.headChildAdded = arg1.ChildAdded:Connect(function(child: Instance)
        if child:IsA("FaceControls") then
            waitForAnimateScript()
        end
    end)
end

local function syncWithStreamTrack(arg1) -- Luacid: unused: defined but never referenced
    disconnectAndRemoveConnection("StreamTrackStopped")
    switchPriority(Enum.AnimationPriority.Idle)

    tbl1.StreamTrackStopped = arg1.Stopped:Connect(function()
        disconnectAndRemoveConnection("StreamTrackStopped")
        switchPriority(Enum.AnimationPriority.Core)
    end)
end

local function onAnimatorAdded(arg1)
    disconnectAndRemoveConnection("AnimationStreamTrackPlayed")

    tbl1.AnimationStreamTrackPlayed = arg1.AnimationStreamTrackPlayed:Connect(function(animationTrack: AnimationStreamTrack)
        disconnectAndRemoveConnection(tbl2.StreamTrackStopped)

        switchPriority(Enum.AnimationPriority.Idle)

        tbl1[tbl2.StreamTrackStopped] = animationTrack.Stopped:Connect(function()
            disconnectAndRemoveConnection("StreamTrackStopped")
            switchPriority(Enum.AnimationPriority.Core)
        end)
    end)

    local var4 = nil

    for _, value in (arg1:GetPlayingAnimationTracksCoreScript()) do
        if value:IsA("AnimationStreamTrack") then
            var4 = value
            break
        end
    end

    if not var4 then
        switchPriority(Enum.AnimationPriority.Core)

        return
    end

    disconnectAndRemoveConnection(tbl2.StreamTrackStopped)

    switchPriority(Enum.AnimationPriority.Idle)

    tbl1[tbl2.StreamTrackStopped] = var4.Stopped:Connect(function()
        disconnectAndRemoveConnection("StreamTrackStopped")
        switchPriority(Enum.AnimationPriority.Core)
    end)
end

local function onAnimatorRemoving(arg1, _) -- Luacid: unused: defined but never referenced
    disconnectAndRemoveConnection("AnimationStreamTrackPlayed")
    disconnectAndRemoveConnection("StreamTrackStopped")
    switchPriority(Enum.AnimationPriority.Core)
    local playerAnimator = getPlayerAnimator(arg1)

    if playerAnimator then
        onAnimatorAdded(playerAnimator)
    end
end

local function onCharacterAdded(player: Player, model: Model)
    local head = model:FindFirstChild("Head")
    if head then
        onHeadAdded(head)
    end

    tbl1.characterChildAdded = model.ChildAdded:Connect(function(child: Instance)
        if child.Name == "Head" then
            onHeadAdded(child)
        end
    end)

    tbl1.characterChildRemoved = model.ChildRemoved:Connect(function(child: Instance)
        if child.Name ~= "Head" then
            return
        end

        stopAndDestroyCurrentMoodTrack()
        local head2 = model:FindFirstChild("Head")
        if head2 then
            onHeadAdded(head2)
        end
    end)

    tbl1.DescendantAdded = model.DescendantAdded:Connect(function(descendant: Instance)
        if descendant:IsA("Animator") then
            onAnimatorAdded(descendant)
        end
    end)
    local var4 = model:FindFirstChildWhichIsA("Animator", true)
    if var4 then
        onAnimatorAdded(var4)
    end

    tbl1.DescendantRemoving = model.DescendantRemoving:Connect(function(descendant: Instance)
        if not descendant:IsA("Animator") then
            return
        end

        local player2 = player
        disconnectAndRemoveConnection(tbl2.AnimationStreamTrackPlayed)
        disconnectAndRemoveConnection(tbl2.StreamTrackStopped)

        switchPriority(Enum.AnimationPriority.Core)
        local playerAnimator = getPlayerAnimator(player2)

        if playerAnimator then
            onAnimatorAdded(playerAnimator)
        end
    end)
end

local function onCharacterRemoving(_model: Model)
    stopAndDestroyCurrentMoodTrack()

    for _, value in pairs(tbl1) do
        if value then
            value:Disconnect()
        end
    end
    table.clear(tbl1)
end

if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer, LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(character: Model)
    onCharacterAdded(LocalPlayer, character)
end)
LocalPlayer.CharacterRemoving:Connect(onCharacterRemoving)
