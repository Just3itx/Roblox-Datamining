-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local Cryo = require(Songbird.Parent.Cryo)
local Foundation = require(Songbird.Parent.Foundation)
local MediaPlayback = require(Songbird.Parent.MediaPlayback)
local React = require(Songbird.Parent.React)
local ReactUtils = require(Songbird.Parent.ReactUtils)
local SignalsReact = require(Songbird.Parent.SignalsReact)

local useLocalization = require(Songbird.Parent.Localization).Hooks.useLocalization

local RoundIconButton = require(Songbird.Components.RoundIconButton)
local AudioPlaybackTimeline = require(Songbird.Components.AudioPlaybackTimeline)
local _types = require(Songbird.types)
local AnalyticActions = require(Songbird.Analytics.AnalyticActions)
local sendAudioPlayerAnalytics = require(Songbird.Analytics.sendAudioPlayerAnalytics)
local useStopSongOnPageNavigation = require(Songbird.Hooks.useStopSongOnPageNavigation)

local GetFFlagAudioPlayerCanSkipTracks = require(Songbird.Parent.SharedFlags).GetFFlagAudioPlayerCanSkipTracks
local getFFlagAudioPreviewLua = MediaPlayback.getFFlagAudioPreviewLua

local getAudioPlaybackStore = MediaPlayback.getAudioPlaybackStore
local useAudioStore = MediaPlayback.useAudioStore
local useCallback = React.useCallback
local useRef = React.useRef
local useEffect = React.useEffect
local createNextOrder = ReactUtils.createNextOrder
local usePrevious = ReactUtils.usePrevious
local useSignalState = SignalsReact.useSignalState
local useSignalBinding = SignalsReact.useSignalBinding

local tbl1 = { isNavigationFocus = true }

local vector2 = Vector2.new(320, 320)

local function AudioPlayer(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local nextOrder = createNextOrder()

    local var2 = useLocalization({ songPreview = "Feature.SongDetails.Label.SongPreview" })

    local var3 = useAudioStore(var1.audio.assetId, if getFFlagAudioPreviewLua() then var1.audio.isPrivate else nil)
    local current = useSignalState(var3.getIsPlaying)
    local var5 = useSignalState(var3.getIsElapsed)
    local duration = useSignalState(var3.getDuration)
    local elapsed = useSignalBinding(var3.getElapsed)
    local var8 = if GetFFlagAudioPlayerCanSkipTracks() then useSignalState(getAudioPlaybackStore) else nil
    local var9 = if GetFFlagAudioPlayerCanSkipTracks() then useSignalState(var8.hasNextSong) else nil
    local var10 = if GetFFlagAudioPlayerCanSkipTracks() then useSignalState(var8.hasPrevSong) else nil
    local var11 = var9 or var10

    local var12 = useCallback(function(action)
        local songId = var1.audio.assetId:gsub("rbxassetid://", "")
        local thumbnailId = if var1.audio.thumbnailAssetId then var1.audio.thumbnailAssetId:gsub("rbxassetid://", "") else nil
        sendAudioPlayerAnalytics({
            action = action,
            songId = songId,
            thumbnailId = thumbnailId or "-1",
            source = var1.analyticsSource,
            listenDurationSeconds = elapsed:getValue()
        })
    end, {
        var1.audio.assetId,
        var1.audio.thumbnail,
        var1.analyticsSource,
        elapsed
    })

    local var13 = useCallback(function()
        var12(AnalyticActions.AudioElapsed)
        var12(AnalyticActions.AudioStopped)
    end, { var12 })

    local var14 = useRef(false)

    local onDragTimelineStart = useCallback(function()
        var14.current = current
        var3.pause()
    end, { var3.pause, current })

    local onDragTimeline = useCallback(function(num1: number)
        var3.seek(duration * num1)
    end, { var3.seek, duration })

    local onDragTimelineEnd = useCallback(function()
        if var14.current then
            var3.play()
        end
    end, { var3.play })

    local var18 = useCallback
    local function func1()
        if current then
            var12(AnalyticActions.AudioPause)
            var12(AnalyticActions.AudioStopped)
            var3.pause()
            return
        end
        var12(AnalyticActions.AudioPlay)
        if GetFFlagAudioPlayerCanSkipTracks() then
            var8.pauseAll()
        else
            getAudioPlaybackStore(false).pauseAll()
        end
        var3.play()
    end

    local play = var3.play
    local pause = var3.pause
    local var19 = if GetFFlagAudioPlayerCanSkipTracks() then var8 else nil
    local onActivated = var18(func1, { play, pause, current, var19 })

    local var21 = useCallback(function()
        var12(AnalyticActions.AudioStopped)
    end, { var12 })
    useStopSongOnPageNavigation(var1.isNavigationFocus, var21)

    local var22 = usePrevious(var5)
    useEffect(function()
        if var5 and not var22 then
            var13()
        end
    end, { var5 })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        tag = "auto-xy col align-x-center gap-large",
        LayoutOrder = var1.LayoutOrder
    }
    local tbl4 = { AudioDetails = 0, PlaybackProgress = 0, PlaybackControls = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl5 = { tag = "size-full-0 auto-y col align-x-center gap-xlarge" }

    local tbl6 = {
        AlbumArt = React.createElement(Foundation.Image, {
            tag = "size-full shrink bg-surface-100 radius-medium",
            sizeConstraint = { MaxSize = vector2 },
            aspectRatio = 1,
            Image = var1.audio.thumbnail,
            LayoutOrder = nextOrder()
        }),
        Info = 0
    }

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl7 = {
        tag = "size-full-0 auto-y grow col align-x-center gap-medium",
        LayoutOrder = nextOrder()
    }
    local tbl8 = {
        Title = React.createElement(Foundation.Text, {
            tag = "auto-xy text-heading-small content-emphasis text-truncate-end",
            Text = var1.audio.title,
            LayoutOrder = nextOrder()
        }),
        Artist = if getFFlagAudioPreviewLua() then nil else React.createElement(Foundation.Text, {
            tag = "auto-xy text-body-large content-default text-truncate-end",
            Text = var1.audio.artist,
            LayoutOrder = nextOrder()
        }),
        ArtistRow = 0
    }
    local element

    if getFFlagAudioPreviewLua() then
        element = React.createElement(
            Foundation.View,
            {
                tag = "row align-x-center align-y-center gap-xsmall auto-xy",
                LayoutOrder = nextOrder()
            },
            {
                Artist = React.createElement(
                    Foundation.Text,
                    {
                        tag = "auto-xy text-body-large text-truncate-end content-default",
                        Text = var1.audio.artist,
                        LayoutOrder = 1
                    }
                ),
                SongPreviewSeparator = if var1.audio.isPrivate then React.createElement(Foundation.Text, { tag = "auto-xy text-body-large content-default", Text = "·", LayoutOrder = 2 }) else nil,
                SongPreviewLabel = if var1.audio.isPrivate then React.createElement(
                    Foundation.Text,
                    {
                        tag = "auto-xy text-body-large content-default",
                        Text = var2.songPreview,
                        LayoutOrder = 3
                    }
                ) else nil
            }
        )
    else
        element = nil
    end

    tbl8.ArtistRow = element
    tbl6.Info = createElement3(view3, tbl7, tbl8)
    tbl4.AudioDetails = createElement2(view2, tbl5, tbl6)

    tbl4.PlaybackProgress = React.createElement(AudioPlaybackTimeline, {
        LayoutOrder = nextOrder(),
        duration = duration,
        elapsed = elapsed,
        onDragTimeline = onDragTimeline,
        onDragTimelineStart = onDragTimelineStart,
        onDragTimelineEnd = onDragTimelineEnd
    })

    local createElement4 = React.createElement
    local view4 = Foundation.View
    local tbl9 = {
        tag = "auto-xy row gap-medium align-y-center",
        LayoutOrder = nextOrder()
    }
    local tbl10 = {
        PrevButton = if GetFFlagAudioPlayerCanSkipTracks() and var11 then React.createElement(Foundation.IconButton, {
            icon = Foundation.Enums.IconName.SkipStartLarge,
            isDisabled = not var10,
            onActivated = var8.playPrevSong,
            LayoutOrder = nextOrder()
        }) else nil,
        PlaybackToggleButton = 0,
        NextButton = 0
    }
    local element2

    if GetFFlagAudioPlayerCanSkipTracks() then
        element2 = React.createElement(Foundation.IconButton, {
            icon = if current then Foundation.Enums.IconName.PauseLarge else Foundation.Enums.IconName.PlayLarge,
            isCircular = true,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            onActivated = onActivated,
            LayoutOrder = nextOrder()
        })
    else
        element2 = React.createElement(RoundIconButton, {
            icon = if current then "icons/controls/media-pause-medium" else "icons/controls/media-play-medium",
            onActivated = onActivated,
            LayoutOrder = nextOrder()
        })
    end

    tbl10.PlaybackToggleButton = element2

    tbl10.NextButton = if GetFFlagAudioPlayerCanSkipTracks() and var11 then React.createElement(Foundation.IconButton, {
        icon = Foundation.Enums.IconName.SkipEndLarge,
        isDisabled = not var9,
        onActivated = var8.playNextSong,
        LayoutOrder = nextOrder()
    }) else nil
    tbl4.PlaybackControls = createElement4(view4, tbl9, tbl10)
    return createElement(view, tbl3, tbl4)
end

return AudioPlayer
