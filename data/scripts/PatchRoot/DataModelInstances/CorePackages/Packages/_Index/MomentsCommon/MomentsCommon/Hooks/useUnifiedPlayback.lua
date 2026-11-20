-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Cryo = require(MomentsCommonParent.Cryo)
local React = require(MomentsCommonParent.React)

local useAudioPlayback = require(MomentsCommon.Hooks.useAudioPlayback)
local useCallback = React.useCallback
local useEffect = React.useEffect
local useImageDisplay = require(MomentsCommon.Hooks.useImageDisplay)
local useMemo = React.useMemo
local useRef = React.useRef
local useToggleState = require(MomentsCommon.Hooks.useToggleState)
local useVideoPlayback = require(MomentsCommon.Hooks.useVideoPlayback)

local Signal = require(MomentsCommon.Utils.Signal)

local Constants = require(MomentsCommon.Constants)
local _Types = require(MomentsCommon.Types)

local tbl1 = {
    autoplay = false,
    edits = { music = nil, trim = nil },
    looping = false,
    content = nil,
    captureType = nil
}

local function useUnifiedPlayback(bool1: boolean, tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = useToggleState(false)
    local var3 = useToggleState(false)
    local onContentLoadedSignalRef = useRef(Signal.new())

    local var5 = useMemo(function()
        if var1.edits.music then
            return var1.edits.music.assetId
        end

        return nil
    end, { var1.edits })

    local playbackRegion = useMemo(function(): NumberRange
        if var1.captureType == Enum.CaptureType.Screenshot then
            return NumberRange.new(0, Constants.ScreenshotMusicDuration)
        elseif var1.edits.trim then
            return NumberRange.new(var1.edits.trim.startTime, var1.edits.trim.endTime)
        end

        return NumberRange.new(0, math.huge)
    end, { var1.edits, var1.captureType })

    local var4 = useMemo(function(): NumberRange
        if var1.edits.music then
            return NumberRange.new(var1.edits.music.startTime, var1.edits.music.startTime + (playbackRegion.Max - playbackRegion.Min))
        end

        return NumberRange.new(0, math.huge)
    end, { var1.edits, playbackRegion })

    local var8 = useAudioPlayback(bool1, var5, { playbackRegion = var4, looping = tbl2.looping })

    local var9 = useVideoPlayback
    local content = if var1.captureType == Enum.CaptureType.Screenshot then nil else var1.content
    local var10 = var9(bool1, content, { playbackRegion = playbackRegion, looping = tbl2.looping })

    local var11 = useImageDisplay
    local content2 = if var1.captureType == Enum.CaptureType.Screenshot then var1.content else nil
    local var12 = var11(bool1, content2)

    local seek = useCallback(function(num1: number)
        if not (var10.ref.current and var10.ref.current.IsLoaded) then
            return
        end

        var10.timeline.seek(num1)
        var8.timeline.seek(num1)
    end, { var10.timeline.seek, var8.timeline.seek })

    useEffect(function()
        if not (var10.ref.current and var10.ref.current.IsLoaded or var12.ref.current and var12.isLoadedRef.current) then
            return
        end

        if bool1 then
            var2.enable()
        else
            var2.disable()
        end
    end, { bool1 })

    useEffect(function()
        if not (var10.ref.current and var10.ref.current.IsLoaded or var12.ref.current and var12.isLoadedRef.current) then
            return
        end

        if var2.enabled then
            var10.playback.play()
            var8.playback.play()
        else
            var10.playback.pause()
            var8.playback.pause()
        end
    end, { var2.enabled })

    useEffect(function()
        if var3.enabled then
            var8.volume.mute()
        else
            var8.volume.unmute()
        end

        if var5 or var3.enabled then
            var10.volume.mute()
            return
        end
        var10.volume.unmute()
    end, { var3.enabled, var5 })

    local var14 = useCallback(function(arg1)
        if bool1 and var1.autoplay then
            var2.enable()
        end
        onContentLoadedSignalRef.current:fire(arg1)
    end, { bool1, var1.autoplay })

    local var15 = useCallback(function()
        var14(Enum.AssetType.Image)
    end, { var14 })

    local var16 = useCallback(function()
        var14(Enum.AssetType.Video)
    end, { var14 })

    local var17 = useCallback(function()
        var8.timeline.seek(0)
    end, { var8.timeline.seek })

    useEffect(function()
        local tbl3 = {}

        if var10.onVideoDidLoopSignalRef.current then
            local current = var10.onVideoDidLoopSignalRef.current
            table.insert(tbl3, current:connect(var17))
        end

        if var10.onVideoLoadedSignalRef.current then
            local current = var10.onVideoLoadedSignalRef.current
            table.insert(tbl3, current:connect(var16))
        end

        if var12.onImageLoadedSignalRef.current then
            local current = var12.onImageLoadedSignalRef.current
            table.insert(tbl3, current:connect(var15))
        end

        return function()
            for _, value in tbl3 do
                value.disconnect()
            end
        end
    end, { var16, var17, var15 })

    return {
        timeline = var1.captureType == Enum.CaptureType.Video
            and {
                duration = var10.timeline.duration,
                elapsed = var10.timeline.elapsed,
                seek = seek,
                timeLength = var10.timeline.timeLength,
                timePosition = var10.timeline.timePosition
            }
            or {
                duration = Constants.ScreenshotMusicDuration,
                elapsed = var8.timeline.elapsed,
                seek = seek,
                timeLength = Constants.ScreenshotMusicDuration,
                timePosition = var8.timeline.timePosition
            },
        playback = {
            isPlaying = var2.enabled,
            pause = var2.disable,
            play = var2.enable,
            toggle = var2.toggle
        },
        volume = {
            isMuted = var3.enabled,
            mute = var3.enable,
            unmute = var3.disable,
            toggle = var3.toggle
        },
        audio = {
            timeLength = var8.timeline.timeLength,
            timePosition = var8.timeline.timePosition
        },
        onContentLoadedSignalRef = onContentLoadedSignalRef,
        imageRef = var12.updateRef,
        videoRef = var10.updateRef,
        audioRef = var8.ref
    }
end

return useUnifiedPlayback
