-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local Cryo = require(MediaPlayback.Parent.Cryo)
local Signals = require(MediaPlayback.Parent.Signals)
local SignalsExperimental = require(MediaPlayback.Parent.SignalsExperimental)

local createConsumerCounterStore = require(MediaPlayback.Stores.getAudioPlaybackStore.createConsumerCounterStore)
local createAudioStore = require(MediaPlayback.Stores.getAudioPlaybackStore.createAudioStore)
local createPlaylistStore = require(MediaPlayback.Stores.getAudioPlaybackStore.createPlaylistStore)
local createVolumeStore = require(MediaPlayback.Stores.getAudioPlaybackStore.createVolumeStore)
local _types = require(MediaPlayback.Stores.getAudioPlaybackStore.types)
local getFFlagAudioPreviewLua = require(MediaPlayback.Flags.getFFlagAudioPreviewLua)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local function createEffect(arg1, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 5 call sites recovered
    SignalsExperimental.onDisposed(arg1, Signals.createEffect(func1))
end

local function audioStoreKey(arg1, bool1: boolean?): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if getFFlagAudioPreviewLua() and bool1 then
        return tostring(arg1) .. ":preview"
    end
    return tostring(arg1)
end

local function createAudioPlaybackStore(arg1)
    local getAudioStores, var2 = createSignal({})

    local consumerCounterStore = createConsumerCounterStore()
    local volumeStore = createVolumeStore()
    local playlistStore = createPlaylistStore()

    local function getOrCreateAudioStore(arg2, bool1: boolean?)
        local str1 = audioStoreKey(arg2, bool1)
        local var3 = getAudioStores(false)[str1]

        if not var3 then
            var3 = createAudioStore(arg2, bool1)

            var2(function(arg3)
                return Cryo.Dictionary.join(arg3, { [str1] = var3 })
            end)
        end

        consumerCounterStore.subscribe(str1)

        return var3
    end

    local getPlayingAudioStores, var4 = createSignal({})

    local var5 = nil
    local getLastPlayedAudioStore = createComputed(function(arg2)
        local var6 = getPlayingAudioStores(arg2)
        local var7 = var6[#var6]

        if var7 then
            var5 = var7
        end

        return var5
    end)

    local function getNextSong() -- Luacid: Inlined by compiler; 1 call site recovered
        local var6 = getLastPlayedAudioStore(false)
        if var6 then
            local next = playlistStore.getNext(var6.assetId)

            if next then
                return (getOrCreateAudioStore(next))
            end
        end
        return nil
    end

    local hasNextSong = createComputed(function(arg2): boolean
        local var6 = getLastPlayedAudioStore(arg2)
        return if var6 then playlistStore.getNext(var6.assetId) ~= nil else false
    end)

    local hasPrevSong = createComputed(function(arg2): boolean
        local var6 = getLastPlayedAudioStore(arg2)
        return if var6 then playlistStore.getPrev(var6.assetId) ~= nil else false
    end)

    local function destroyByKey(str1: string)
        local var6 = getAudioStores(false)[str1]

        if not var6 then
            return
        end

        if consumerCounterStore.unsubscribe(str1) > 0 then
            return
        end

        var6.destroy()

        var2(function(arg2)
            return Cryo.Dictionary.join(arg2, { [str1] = Cryo.None })
        end)
    end

    local function destroyAudioStore(arg2, bool1: boolean?)
        destroyByKey((audioStoreKey(arg2, bool1)))
    end

    createEffect(arg1, function(arg2)
        for value, value2 in consumerCounterStore.getConsumerCounts(arg2) do
            if value2 <= 0 then
                destroyByKey(value)
            end
        end
    end)

    createEffect(arg1, function(arg2)
        for value, value2 in getAudioStores(arg2) do
            if value2.getIsDestroyed(arg2) then
                destroyByKey(value)
            end
        end
    end)

    createEffect(arg1, function(arg2)
        for _, value in getAudioStores(arg2) do
            local isPlaying = value.getIsPlaying(arg2)

            local var6 = Cryo.List.find(getPlayingAudioStores(arg2), value)
            local bool1 = var6 ~= nil

            if bool1 and not isPlaying then
                var4(function(arg3)
                    return Cryo.List.removeIndex(arg3, var6)
                end)
            elseif isPlaying and not bool1 then
                var4(function(arg3)
                    return Cryo.List.join(arg3, { value })
                end)
            end
        end
    end)

    createEffect(arg1, function(arg2)
        local volume = volumeStore.getVolume(arg2)
        for _, value in getAudioStores(arg2) do
            value.setVolume(volume)
        end
    end)

    createEffect(arg1, function(arg2)
        local var6 = getLastPlayedAudioStore(arg2)
        if not var6 or not var6.getIsElapsed(arg2) or not hasNextSong(arg2) then
            return
        end

        local nextSong = getNextSong()

        if nextSong then
            nextSong.play()
        end
    end)

    return {
        getAudioStores = getAudioStores,
        stopAll = function()
            for _, value in getAudioStores(false) do
                value.stop()
            end
        end,
        pauseAll = function()
            for _, value in getAudioStores(false) do
                value.pause()
            end
        end,
        getLastPlayedAudioStore = getLastPlayedAudioStore,
        getOrCreateAudioStore = getOrCreateAudioStore,
        getPlayingAudioStores = getPlayingAudioStores,
        destroyAudioStore = destroyAudioStore,
        destroy = function()
            for _, value in getAudioStores(false) do
                value.destroy()
            end
            var2({})
            var4({})
        end,
        getGlobalVolume = volumeStore.getVolume,
        setGlobalVolume = volumeStore.setVolume,
        mute = volumeStore.mute,
        unmute = volumeStore.unmute,
        getIsMuted = volumeStore.getIsMuted,
        hasNextSong = hasNextSong,
        hasPrevSong = hasPrevSong,
        playNextSong = function()
            local var6 = getLastPlayedAudioStore(false)
            if not var6 then
                return
            end

            local next = playlistStore.getNext(var6.assetId)

            if next then
                local orCreateAudioStore = getOrCreateAudioStore(next)

                var6.stop()
                orCreateAudioStore.play()
            end
        end,
        playPrevSong = function()
            local var6 = getLastPlayedAudioStore(false)
            if not var6 then
                return
            end

            local prev = playlistStore.getPrev(var6.assetId)

            if prev then
                local orCreateAudioStore = getOrCreateAudioStore(prev)

                var6.stop()
                orCreateAudioStore.play()
            end
        end,
        setPlaylist = playlistStore.set
    }
end

return createAudioPlaybackStore
