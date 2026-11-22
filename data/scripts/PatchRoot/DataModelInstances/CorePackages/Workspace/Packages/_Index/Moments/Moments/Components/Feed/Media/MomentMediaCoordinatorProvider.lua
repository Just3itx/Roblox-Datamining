-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local UserInputService = game:GetService("UserInputService")

local AppLifecycleObserverService = nil
pcall(function()
    AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
end)

local React = require(MomentsParent.React)
local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)

local useSignalState = require(MomentsParent.SignalsReact).useSignalState

local enableAudioPlaybackInApp = require(MomentsParent.MediaPlayback).enableAudioPlaybackInApp

local MomentsCommon = require(MomentsParent.MomentsCommon)
local Media = MomentsCommon.Media
local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities
local FFlagMomentsAutoplayAmpPolicy = SharedFlags.FFlagMomentsAutoplayAmpPolicy

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local createFeedMediaSource = require(script.Parent.createFeedMediaSource)

local function shouldPauseWhenAppHidden(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return UserInputService:GetDeviceType() ~= Enum.DeviceType.Desktop
end

local function defaultCreateCoordinator(arg1)
    enableAudioPlaybackInApp()

    local momentMediaAudioOutput = Instance.new("AudioDeviceOutput")
    momentMediaAudioOutput.Name = "MomentMediaAudioOutput"
    momentMediaAudioOutput.Parent = CoreGui

    local folder = Instance.new("Folder")
    folder.Name = "MomentMediaRoot_" .. HttpService:GenerateGUID(false)
    folder.Parent = CoreGui

    local tbl1 = { runService = RunService, contentProvider = ContentProvider }

    local provider = Media.createMediaPreloadCoordinator(
        arg1,
        Media.selectPreloadPolicy(),
        Media.mediaTelemetry.noopSink,
        momentMediaAudioOutput,
        tbl1,
        { parent = folder }
    )

    return {
        provider = provider,
        dispose = function()
            provider.dispose()
            momentMediaAudioOutput:Destroy()
            folder:Destroy()
        end
    }
end

local function MomentMediaCoordinatorProvider(tbl1)
    local pager = tbl1.pager
    local var1 = if FFlagMomentsAutoplayAmpPolicy then useSignalState(GetMomentsCapabilities(false).getIsAutoPlayEnabled) else nil
    local playbackActive = tbl1.playbackActive
    local var2 = tbl1.createCoordinator or defaultCreateCoordinator

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
        var3.set(playbackActive)
    end, { playbackActive, var3 })
    if FFlagMomentsAutoplayAmpPolicy then
        React.useEffect(function()
            var4.set(var1)
        end, { var1, var4 })
    end

    React.useEffect(function()
        if not shouldPauseWhenAppHidden() then
            return
        end

        local function onHidden()
            var5.set(false)
        end
        local function onShown()
            var5.set(true)
        end
        local tbl2 = {}
        if AppLifecycleObserverService ~= nil then
            local onHide = AppLifecycleObserverService.OnHide
            table.insert(tbl2, onHide:Connect(onHidden))
            local onUnhide = AppLifecycleObserverService.OnUnhide
            table.insert(tbl2, onUnhide:Connect(onShown))
        end
        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { var5 })

    local var6 = React.useMemo(function()
        return function(arg1)
            return var3.get(arg1) and var5.get(arg1)
        end
    end, { var3, var5 })

    local useMemo = React.useMemo

    local function func1()
        local feedMediaSource = createFeedMediaSource(pager, var6, if FFlagMomentsAutoplayAmpPolicy then var4.get else nil)

        return var2(feedMediaSource)
    end

    local var7 = if FFlagMomentsAutoplayAmpPolicy then var4 else nil
    local var8 = useMemo(func1, { pager, var2, var6, var7 })

    React.useEffect(function()
        return function()
            var8.dispose()
        end
    end, { var8 })

    React.useEffect(function()
        local onMediaItemLoadAttempted = tbl1.onMediaItemLoadAttempted
        local onMediaItemFailed = tbl1.onMediaItemFailed
        if onMediaItemLoadAttempted == nil and onMediaItemFailed == nil then
            return
        end

        local tbl2 = ({})
        local tbl3 = ({})
        local bool1 = false
        local effect = Signals.createEffect(function(arg1)
            for value, value2 in (var8.provider.getControllerMap(arg1)) do
                if onMediaItemLoadAttempted ~= nil and not tbl2[value] then
                    tbl2[value] = true

                    task.defer(function()
                        if not bool1 then
                            onMediaItemLoadAttempted(value)
                        end
                    end)
                end

                local state = if onMediaItemFailed == nil then nil else value2.getState(arg1)

                if state == nil or state.readiness ~= "Failed" or tbl3[value] then
                    continue
                end

                tbl3[value] = true

                local failureReason = state.failureReason
                task.defer(function()
                    if not bool1 then
                        onMediaItemFailed(value, failureReason)
                    end
                end)
            end
        end)

        return function()
            bool1 = true
            effect()
        end
    end, { var8, tbl1.onMediaItemLoadAttempted, tbl1.onMediaItemFailed })

    return React.createElement(Media.MediaPreloadProvider.Provider, { controllerProvider = var8.provider }, tbl1.children)
end

return MomentMediaCoordinatorProvider
