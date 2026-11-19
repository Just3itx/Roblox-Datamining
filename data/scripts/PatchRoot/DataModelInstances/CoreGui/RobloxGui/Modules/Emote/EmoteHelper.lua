-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local CorePackages = game:GetService("CorePackages")

local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)

module.EMOTE_LOOP_TRANSITION_WAIT_TIME = 0.3
module.EMOTE_LOOP_WAIT_TIMEOUT = 5

module.LegacyDefaultEmotes = {
    wave = true,
    point = true,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = true,
    cheer = true
}

local function clearConnection(connection) -- Luacid: Inlined by compiler; 2 call sites recovered
    if connection then
        connection:Disconnect()
    end
end

function module.getAnyActiveDefaultChatTriggeredEmoteTrack(arg1)
    if not arg1.Character then
        return nil
    end

    local humanoid = arg1.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return nil
    end

    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        return nil
    end

    local playingAnimationTracks = animator:GetPlayingAnimationTracks()

    for _, playingAnimationTrack in pairs(playingAnimationTracks) do
        if not (playingAnimationTrack.Animation
            and playingAnimationTrack.Animation.Parent
            and playingAnimationTrack:IsA("AnimationTrack")) then
            continue
        end

        local animationParentName = playingAnimationTrack.Animation.Parent.Name
        if module.LegacyDefaultEmotes[animationParentName] and playingAnimationTrack.IsPlaying then
            return playingAnimationTrack
        end
    end

    return nil
end

local function waitForEmoteEventInternal(arg1, arg2, arg3, callback)
    local bindableEvent = Instance.new("BindableEvent")

    local num1 = os.clock()
    local bool1 = true

    local function func1() -- Luacid: Inlined by compiler; 3 call sites recovered
        if bool1 and bindableEvent then
            bool1 = false
            bindableEvent:Fire()
        end
    end

    local connection = arg2.Stopped:Connect(function()
        var1:trace("EmoteHelper.waitForEmoteEventInternal: Stopped")
        func1()
    end)

    local connection2 = arg2.KeyframeReached:Connect(function(keyframeName: string)
        if keyframeName == "End" and (not arg2.Looped or arg3) then
            var1:trace("EmoteHelper.waitForEmoteEventInternal: KeyframeReached")
            func1()
            return
        end

        num1 = os.clock()
    end)

    task.spawn(function()
        local var2 = os.clock() - num1

        while bool1 and var2 < module.EMOTE_LOOP_WAIT_TIMEOUT do
            wait(module.EMOTE_LOOP_WAIT_TIMEOUT - var2)

            var2 = os.clock() - num1
        end
        if bool1 then
            var1:trace("EmoteHelper.waitForEmoteEventInternal: Timeout!")
            func1()
        end
    end)

    bindableEvent.Event:Wait()
    bindableEvent:Destroy()
    clearConnection(connection)
    clearConnection(connection2)

    if not arg3 then
        if callback then
            callback()
        end

        return
    end

    wait(module.EMOTE_LOOP_TRANSITION_WAIT_TIME)
    local anyActiveDefaultChatTriggeredEmoteTrack = module.getAnyActiveDefaultChatTriggeredEmoteTrack(arg1)
    if anyActiveDefaultChatTriggeredEmoteTrack then
        waitForEmoteEventInternal(arg1, anyActiveDefaultChatTriggeredEmoteTrack, arg3, callback)
    elseif callback then
        callback()
    end
end

function module.createEmoteFinishEvent(arg1, arg2, arg3): RBXScriptSignal
    local bindableEvent = Instance.new("BindableEvent")

    task.spawn(waitForEmoteEventInternal, arg1, arg2, arg3, function()
        bindableEvent:Fire()
        bindableEvent:Destroy()
    end)

    return bindableEvent.Event
end

return module
