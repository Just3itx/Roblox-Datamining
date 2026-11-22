-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local Signals = require(MediaPlayback.Parent.Signals)
local SignalsExperimental = require(MediaPlayback.Parent.SignalsExperimental)

local enableAudioPlaybackInApp = require(MediaPlayback.Common.enableAudioPlaybackInApp)
local createAudioSystem = require(MediaPlayback.Stores.getAudioPlaybackStore.createAudioSystem)
local createVolumeStore = require(MediaPlayback.Stores.getAudioPlaybackStore.createVolumeStore)
local _types = require(MediaPlayback.Stores.getAudioPlaybackStore.types)

local createSignal = Signals.createSignal
local createEffect = Signals.createEffect
local onDisposed = SignalsExperimental.onDisposed

local tbl1 = {
    spawn = function(arg1)
        return task.spawn(arg1)
    end,
    wait = function(arg1)
        return task.wait(arg1)
    end
}

local function createAudioStore(assetId, usePreview: boolean?, tbl2)
    local var1 = tbl2 or tbl1
    local getDuration, var3 = createSignal(0)
    local getElapsed, var5 = createSignal(0)
    local getIsPlaying, var7 = createSignal(false)
    local getIsElapsed, var9 = createSignal(false)
    local getIsDestroyed, var11 = createSignal(false)
    local getIsLoaded, var13 = createSignal(false)

    local tbl3 = {}

    local volumeStore = createVolumeStore()

    enableAudioPlaybackInApp()

    local audioSystem = createAudioSystem(assetId, usePreview)
    local audioPlayer = audioSystem.audioPlayer

    local function pause() -- Luacid: Inlined by compiler; 2 call sites recovered
        var7(false)
        audioPlayer.PlaybackSpeed = 0
    end

    local function stop() -- Luacid: Inlined by compiler; 1 call site recovered
        pause()
        audioPlayer.TimePosition = 0
        var5(0)
    end

    audioPlayer:GetPropertyChangedSignal("TimeLength"):Connect(function()
        var3(audioPlayer.TimeLength)
    end)
    var3(audioPlayer.TimeLength)

    audioPlayer:GetPropertyChangedSignal("IsReady"):Connect(function()
        var13(audioPlayer.IsReady)
    end)
    var13(audioPlayer.IsReady)

    table.insert(tbl3, createEffect(function(arg1)
        if not getIsPlaying(arg1) then
            return
        end

        if not audioPlayer.IsPlaying then
            audioPlayer:Play()
        end

        local bool1 = true

        var1.spawn(function()
            while bool1 do
                if not audioPlayer.IsPlaying then
                    var9(true)
                    stop()
                    return
                end

                var5(audioPlayer.TimePosition)
                var1.wait(0.0625)
            end
        end)

        onDisposed(arg1, function()
            bool1 = false
        end)
    end))

    table.insert(tbl3, createEffect(function(arg1)
        audioPlayer.Volume = volumeStore.getVolume(arg1)
    end))

    return {
        assetId = assetId,
        usePreview = usePreview,
        getDuration = getDuration,
        getElapsed = getElapsed,
        getIsPlaying = getIsPlaying,
        getIsElapsed = getIsElapsed,
        getIsDestroyed = getIsDestroyed,
        getIsLoaded = getIsLoaded,
        destroy = function()
            audioSystem.destroy()
            for _, value in tbl3 do
                value()
            end
            var11(true)
        end,
        play = function()
            var7(true)
            var9(false)
            audioPlayer.PlaybackSpeed = 1
        end,
        pause = pause,
        stop = stop,
        seek = function(num1: number)
            local timePosition = math.clamp(num1, 0, audioPlayer.TimeLength)
            audioPlayer.TimePosition = timePosition
            var5(timePosition)
        end,
        getIsMuted = volumeStore.getIsMuted,
        getVolume = volumeStore.getVolume,
        mute = volumeStore.mute,
        setVolume = volumeStore.setVolume,
        unmute = volumeStore.unmute
    }
end

return createAudioStore
