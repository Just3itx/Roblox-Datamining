-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local UserInputService = game:GetService("UserInputService")

local AppLifecycleObserverService = nil
pcall(function()
    AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
end)

local React = require(ProfilePlatformParent.React)
local Signals = require(ProfilePlatformParent.Signals)
local SignalsReact = require(ProfilePlatformParent.SignalsReact)
local enableAudioPlaybackInApp = require(ProfilePlatformParent.MediaPlayback).enableAudioPlaybackInApp

local MomentsCommon = require(ProfilePlatformParent.MomentsCommon)
local Media = MomentsCommon.Media
local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities
local _MomentsStoreTypes = require(ProfilePlatformParent.DataHydration.MomentsStoreTypes)
local ToMediaItem = require(ProfilePlatformParent.Moments.ToMediaItem)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local FFlagMomentsAutoplayAmpPolicy = SharedFlags.FFlagMomentsAutoplayAmpPolicy
local FFlagProfileMomentSceneOutfitPoster = SharedFlags.FFlagProfileMomentSceneOutfitPoster

local useSignalState = SignalsReact.useSignalState

local function shouldPauseWhenAppHidden(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return UserInputService:GetDeviceType() ~= Enum.DeviceType.Desktop
end

local function defaultCreateCoordinator(arg1, masterVolume: number?)
    enableAudioPlaybackInApp()

    local profileMomentsAudioOutput = Instance.new("AudioDeviceOutput")
    profileMomentsAudioOutput.Name = "ProfileMomentsAudioOutput"
    profileMomentsAudioOutput.Parent = CoreGui

    local profileMomentsMediaHost = Instance.new("Folder")
    if profileMomentsMediaHost ~= nil then
        profileMomentsMediaHost.Name = "ProfileMomentsMediaHost"
        profileMomentsMediaHost.Parent = CoreGui
    end

    local tbl1 = { runService = RunService, contentProvider = ContentProvider }

    local provider = Media.createMediaPreloadCoordinator(
        arg1,
        Media.selectPreloadPolicy(),
        Media.mediaTelemetry.noopSink,
        profileMomentsAudioOutput,
        tbl1,
        { parent = profileMomentsMediaHost, masterVolume = masterVolume }
    )

    local bool1 = false

    return {
        provider = provider,
        dispose = function()
            if bool1 then
                return
            end
            bool1 = true
            provider.dispose()
            profileMomentsAudioOutput:Destroy()
            if profileMomentsMediaHost ~= nil then
                profileMomentsMediaHost:Destroy()
            end
        end
    }
end

local function MomentsCarouselMediaProvider(tbl1)
    local activeIndex = tbl1.activeIndex
    local playbackActive = tbl1.playbackActive
    local var1 = if FFlagMomentsAutoplayAmpPolicy then useSignalState(GetMomentsCapabilities(false).getIsAutoPlayEnabled) else nil

    local var2 = React.useMemo(function()
        local get, set = Signals.createSignal(activeIndex)
        return { get = get, set = set }
    end, {})

    local var3 = React.useMemo(function()
        local get, set = Signals.createSignal(playbackActive)
        return { get = get, set = set }
    end, {})

    local var4 = if FFlagMomentsAutoplayAmpPolicy then React.useMemo(function()
        local get, set = Signals.createSignal(var1)
        return { get = get, set = set }
    end, {}) else nil

    local var5 = React.useMemo(function()
        local get, set = Signals.createSignal(true)
        return { get = get, set = set }
    end, {})

    React.useEffect(function()
        var2.set(activeIndex)
    end, { activeIndex, var2 })

    React.useEffect(function()
        var3.set(playbackActive)
    end, { playbackActive, var3 })

    if FFlagMomentsAutoplayAmpPolicy then
        React.useEffect(function()
            var4.set(var1)
        end, { var1, var4 })
    end

    React.useEffect(function()
        if not shouldPauseWhenAppHidden() or AppLifecycleObserverService == nil then
            return
        end

        local function onShown()
            var5.set(true)
        end
        local tbl2 = {
            AppLifecycleObserverService.OnHide:Connect(function() -- name: onHidden
                var5.set(false)
            end),
            AppLifecycleObserverService.OnUnhide:Connect(onShown)
        }

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { var5 })

    local getItems = React.useMemo(function()
        local result = {}
        for _, moment in tbl1.moments do
            local var6 = ToMediaItem({ kind = "moment", moment = moment })
            if var6 == nil then
                continue
            end
            var6.cornerRadius = tbl1.mediaCornerRadius

            if FFlagProfileMomentSceneOutfitPoster and moment.metadata.isMomentScene == true then
                var6.captureType = Enum.CaptureType.Screenshot
                var6.posterContent = nil
            end
            table.insert(result, var6)
        end

        return result
    end, { tbl1.moments, tbl1.mediaCornerRadius })

    local getPlaybackActive = React.useMemo(function()
        return function(arg1)
            return var3.get(arg1) and var5.get(arg1)
        end
    end, { var3, var5 })

    local useMemo = React.useMemo

    local function func1()
        return {
            getActiveIndex = var2.get,
            getItems = function(_)
                return getItems
            end,
            getPlaybackActive = getPlaybackActive,
            getCanAutoPlay = if FFlagMomentsAutoplayAmpPolicy then var4.get else nil
        }
    end

    local var8 = if FFlagMomentsAutoplayAmpPolicy then var4 else nil
    local var9 = useMemo(func1, { getItems, var2, getPlaybackActive, var8 })

    local var10 = tbl1.createCoordinator or defaultCreateCoordinator

    local var11 = React.useMemo(function()
        return var10(var9, 0)
    end, { var9, var10, 0 })

    React.useEffect(function()
        return function()
            var11.dispose()
        end
    end, { var11 })
    React.useImperativeHandle(tbl1.handoffRef, function()
        return {
            release = var11.dispose
        }
    end, { var11 })

    return React.createElement(Media.MediaPreloadProvider.Provider, { controllerProvider = var11.provider }, tbl1.children)
end

return MomentsCarouselMediaProvider
