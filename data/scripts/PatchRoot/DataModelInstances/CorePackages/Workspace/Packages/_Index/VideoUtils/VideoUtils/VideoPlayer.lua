-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local VideoUtilsParent = script:FindFirstAncestor("VideoUtils").Parent

local LoggingProtocol = require(VideoUtilsParent.LoggingProtocol)
local React = require(VideoUtilsParent.React)
local Responsive = require(VideoUtilsParent.Responsive)
local _AppCommonLib = require(VideoUtilsParent.AppCommonLib)
local LoadableVideoFrame = require(script.Parent.LoadableVideoFrame)
local RoundIconButton = require(script.Parent.RoundIconButton)
local VideoActions = require(script.Parent.Analytics.Enums).VideoActions
local _VideoAnalyticsTypes = require(script.Parent.Analytics.VideoAnalyticsTypes)
local VideoLogger = require(script.Parent.Analytics.VideoLogger)
local VideoPlayerBottomOverlay = require(script.Parent.VideoPlayerBottomOverlay)
local DiscoveryEventErrorLogger = require(VideoUtilsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local reportWarning = require(VideoUtilsParent.DiscoveryAnalytics).Points.reportWarning
local getVideoEdits = require(script.Parent.getVideoEdits)

local FFlagLuaAppEdpMediaGalleryAutoAdvance = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpMediaGalleryAutoAdvance
local FFlagLuaAppEdpMediaGalleryFullScreen = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpMediaGalleryFullScreen
local FFlagLuaAppVideoTileDisableActivation = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoTileDisableActivation
local FFlagLuaAppVideoTileHideCenterPlayButton = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoTileHideCenterPlayButton
local FFlagLuaAppEdpConsoleMediaGalleryVideo = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpConsoleMediaGalleryVideo
local FFlagLuaAppMediaGalleryGamepadSupport = require(VideoUtilsParent.SharedFlags).FFlagLuaAppMediaGalleryGamepadSupport
local FFlagLuaAppEnableNxMRoduxApportioning = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning
local FFlagLuaAppSduiVideoThumbnail = require(VideoUtilsParent.SharedFlags).FFlagLuaAppSduiVideoThumbnail
local FFlagLuaAppHomeMomentVideoFallback = require(VideoUtilsParent.SharedFlags).FFlagLuaAppHomeMomentVideoFallback
local FFlagLuaAppVideoLoadFailureFallback = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoLoadFailureFallback
local FFlagLuaAppVideoPlayerTrimAndMusic = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoPlayerTrimAndMusic

local num1 = game:DefineFastInt("VideoPlayerPlaybackEndThresholdInMs", 100) / 1000

local function VideoPlayer(tbl1)
    local var1 = nil
    local var2 = nil
    if FFlagLuaAppVideoPlayerTrimAndMusic then
        var1, var2 = React.useMemo(function()
            return getVideoEdits.getVideoEdits({
                trimStartTime = tbl1.trimStartTime,
                trimEndTime = tbl1.trimEndTime,
                musicAssetId = tbl1.musicAssetId,
                musicStartTime = tbl1.musicStartTime
            })
        end, {
            tbl1.trimStartTime,
            tbl1.trimEndTime,
            tbl1.musicAssetId,
            tbl1.musicStartTime
        })
    end

    local var3 = tbl1.showMuteButton or FFlagLuaAppEdpMediaGalleryFullScreen and (tbl1.showPlayButton or tbl1.showProgressBar)

    local videoLoaded, var5 = React.useState(false)

    local muted, var7 = React.useState(tbl1.muted)

    local onVideoLoaded = React.useCallback(function(num2: number, num3: number)
        var5(true)

        if tbl1.onVideoLoaded then
            tbl1.onVideoLoaded(num2, num3)
        end
    end, { tbl1.onVideoLoaded })

    local var9 = if FFlagLuaAppVideoLoadFailureFallback then React.useCallback(function(reason: string)
        local videoAssetId = string.match(tbl1.video, "^rbxassetid://(%d+)") or "unknown"
        local videoAnalyticsData = if tbl1.videoAnalyticsContext then tbl1.videoAnalyticsContext.videoAnalyticsData else nil
        local message = `Video asset {videoAssetId} failed to load: {reason}`
        DiscoveryEventErrorLogger.reportError("VideoLoadFailure", message, {
            message = message,
            videoAssetId = videoAssetId,
            reason = reason,
            hasAccessContext = tostring(not (tbl1.accessContext == nil) and tbl1.accessContext ~= ""),
            source = if videoAnalyticsData then videoAnalyticsData.source else nil,
            sourceId = if videoAnalyticsData then videoAnalyticsData.sourceId else nil
        })

        if tbl1.onVideoLoadFailed then
            tbl1.onVideoLoadFailed(reason)
        end
    end, {
        tbl1.video,
        tbl1.accessContext,
        tbl1.videoAnalyticsContext,
        tbl1.onVideoLoadFailed
    }) else nil

    if FFlagLuaAppVideoPlayerTrimAndMusic then
        local var10 = React.useRef(var9)
        var10.current = var9
        React.useEffect(function()
            if not var2 and tbl1.shouldStartPlayback and var10.current then
                var10.current("InvalidEdits")
            end
        end, { var2, tbl1.shouldStartPlayback, tbl1.video })
    end

    React.useEffect(function()
        if tbl1.onMutedChanged then
            tbl1.onMutedChanged(muted)
        end
    end, { tbl1.onMutedChanged, muted })

    local onMuteButtonActivated = React.useCallback(function()
        var7(function(arg1): boolean
            if tbl1.onMuteButtonActivated then
                tbl1.onMuteButtonActivated(arg1)
            end

            return not arg1
        end)
    end, { tbl1.onMuteButtonActivated })
    local muteButtonConfig = React.useMemo(function(): {muted: any, onMuteButtonActivated: any}?
        return if tbl1.showMuteButton then {
            muted = muted,
            onMuteButtonActivated = onMuteButtonActivated
        } else nil
    end, { tbl1.showMuteButton, muted, onMuteButtonActivated })

    local var12 = if FFlagLuaAppEdpMediaGalleryAutoAdvance
        or FFlagLuaAppEdpMediaGalleryFullScreen
        or FFlagLuaAppEdpConsoleMediaGalleryVideo
        or FFlagLuaAppEnableNxMRoduxApportioning then React.useRef(nil) else nil

    local var13 = nil
    local var14 = nil
    if FFlagLuaAppEdpMediaGalleryFullScreen then
        var13, var14 = React.useBinding(0)
    end

    if FFlagLuaAppEdpMediaGalleryAutoAdvance or FFlagLuaAppEdpMediaGalleryFullScreen then
        React.useEffect(function()
            local current = var12.current

            if not (tbl1.shouldStartPlayback
                and (FFlagLuaAppEdpMediaGalleryAutoAdvance and tbl1.onVideoProgressChanged
                    or FFlagLuaAppEdpMediaGalleryFullScreen and tbl1.showProgressBar)
                and current) then
                return nil
            end

            local connection = RunService.RenderStepped:Connect(function()
                local var15

                if FFlagLuaAppVideoPlayerTrimAndMusic and var1 and var1.trim then
                    local var16, var17 = getVideoEdits.getPlaybackRange(current.TimeLength, var1.trim)
                    if var16 < var17 then
                        var15 = math.clamp((current.TimePosition - var16) / (var17 - var16), 0, 1)
                    else
                        var15 = 0
                    end
                else
                    var15 = nil
                end

                if FFlagLuaAppEdpMediaGalleryAutoAdvance and tbl1.onVideoProgressChanged then
                    tbl1.onVideoProgressChanged(
                        if FFlagLuaAppVideoPlayerTrimAndMusic and var15 ~= nil then var15 elseif current.TimeLength > 0 then current.TimePosition / current.TimeLength else 0
                    )
                end

                if not FFlagLuaAppEdpMediaGalleryFullScreen or not tbl1.showProgressBar then
                    return
                end

                local var16 = var14
                if not FFlagLuaAppVideoPlayerTrimAndMusic or var15 == nil then
                    var15 = if current.TimeLength > 0 then current.TimePosition / current.TimeLength else 0
                end

                var16(var15)
            end)

            return function()
                connection:Disconnect()

                if FFlagLuaAppEdpMediaGalleryAutoAdvance and tbl1.onVideoProgressChanged then
                    tbl1.onVideoProgressChanged(0)
                end

                if FFlagLuaAppEdpMediaGalleryFullScreen and tbl1.showProgressBar then
                    var14(0)
                end
            end
        end, {
            tbl1.shouldStartPlayback,
            if FFlagLuaAppEdpMediaGalleryAutoAdvance then tbl1.onVideoProgressChanged else nil,
            if FFlagLuaAppEdpMediaGalleryFullScreen then tbl1.showProgressBar else nil,
            if FFlagLuaAppVideoPlayerTrimAndMusic then var1 else nil
        })
    end

    if FFlagLuaAppEnableNxMRoduxApportioning then
        React.useEffect(function()
            local onAspectRatioChanged = tbl1.onAspectRatioChanged
            local current = var12 and var12.current
            if not onAspectRatioChanged or not current then
                return
            end

            local var15 = nil
            local function report() -- Luacid: Inlined by compiler; 1 call site recovered
                local resolution = current.Resolution
                if not (resolution.X > 0) or not (resolution.Y > 0) then
                    return
                end

                local var16 = resolution.X / resolution.Y
                if var16 ~= var15 then
                    var15 = var16
                    onAspectRatioChanged(var16)
                end
            end

            local connection = current:GetPropertyChangedSignal("Resolution"):Connect(report)
            report()

            return function()
                connection:Disconnect()
            end
        end, { tbl1.onAspectRatioChanged })
    end

    local var15 = nil
    local var16 = nil
    local var17 = nil
    local bool1, var18, var19, var20

    if FFlagLuaAppEdpMediaGalleryFullScreen or FFlagLuaAppEdpConsoleMediaGalleryVideo then
        var15, var16 = React.useState(false)

        local var21 = React.useCallback(function(arg1)
            local current = var12.current

            if not current then
                reportWarning(LoggingProtocol.default, "EventLogging", "reportVideoAction requires a valid videoFrame")

                return
            end

            local source, sourceId, playbackSessionId

            if tbl1.videoAnalyticsContext then
                source = tbl1.videoAnalyticsContext.videoAnalyticsData.source
                sourceId = tbl1.videoAnalyticsContext.videoAnalyticsData.sourceId
                playbackSessionId = tbl1.videoAnalyticsContext.getPlaybackSessionId()

                if not (source and sourceId and playbackSessionId) then
                    reportWarning(
                        LoggingProtocol.default,
                        "EventLogging",
                        `reportVideoAction requires a valid {if source then "" else "source "}{if sourceId then "" else "sourceId "}{if playbackSessionId then "" else "playbackSessionId"}`
                    )
                end
            else
                source = nil
                sourceId = nil
                playbackSessionId = nil
            end

            local timeLength

            if FFlagLuaAppVideoPlayerTrimAndMusic and var1 then
                local var21, var22 = getVideoEdits.getPlaybackRange(current.TimeLength, var1.trim)
                timeLength = var22 - var21
            else
                timeLength = nil
            end

            local reportVideoAction = VideoLogger.reportVideoAction
            local var21 = nil
            local tbl2 = {
                videoAssetId = tbl1.video,
                source = source or "",
                sourceId = sourceId or "",
                playbackSessionId = playbackSessionId or "",
                videoAssetDuration = 0,
                isVisible = true,
                isAudible = 0,
                volumeLevel = 0
            }

            if not FFlagLuaAppVideoPlayerTrimAndMusic or timeLength == nil then
                timeLength = current.TimeLength
            end

            tbl2.videoAssetDuration = timeLength

            tbl2.isAudible = if FFlagLuaAppVideoPlayerTrimAndMusic then not muted else current.Volume ~= 0
            tbl2.volumeLevel = FFlagLuaAppVideoPlayerTrimAndMusic and (if muted then 0 else 1) or (if current.Volume == 0 then 0 else 1)
            reportVideoAction(arg1, var21, tbl2)
        end, {
            tbl1.video,
            tbl1.videoAnalyticsContext,
            if FFlagLuaAppVideoPlayerTrimAndMusic then var1 else nil,
            if FFlagLuaAppVideoPlayerTrimAndMusic then muted else nil
        })

        var17 = React.useCallback(function()
            local current = var12.current

            if not current then
                return
            end

            if var15 then
                current:Pause()
            else
                if math.abs(current.TimePosition - current.TimeLength) <= num1 then
                    current.TimePosition = 0
                end

                current:Play()
            end
        end, { var15 })

        bool1 = Responsive.usePreferredInput() == Responsive.Input.Directional
        React.useEffect(function()
            local tbl2 = {}
            if tbl1.toggleVideoPlaybackSignal then
                local toggleVideoPlaybackSignal = tbl1.toggleVideoPlaybackSignal
                table.insert(tbl2, toggleVideoPlaybackSignal:connect(var17))
            end
            if tbl1.toggleMuteSignal then
                local toggleMuteSignal = tbl1.toggleMuteSignal
                table.insert(tbl2, toggleMuteSignal:connect(onMuteButtonActivated))
            end
            return function()
                for _, value in tbl2 do
                    if value then
                        value:disconnect()
                    end
                end
            end
        end, {
            tbl1.toggleVideoPlaybackSignal,
            tbl1.toggleMuteSignal,
            var17,
            onMuteButtonActivated
        })

        var18 = React.useCallback(function()
            if tbl1.onVideoPlayerActivated then
                tbl1.onVideoPlayerActivated()
                return
            end

            var17()
        end, { tbl1.onVideoPlayerActivated, var17 })

        var19 = React.useMemo(function(): {isVideoPlaying: any, onPlayButtonActivated: any}?
            return if tbl1.showPlayButton then {
                isVideoPlaying = var15,
                onPlayButtonActivated = var17
            } else nil
        end, { tbl1.showPlayButton, var15, var17 })

        var20 = React.useMemo(function(): {progressBinding: any}?
            return if tbl1.showProgressBar then { progressBinding = var13 } else nil
        end, { tbl1.showProgressBar, var13 })

        React.useEffect(function()
            local current = var12.current

            if not (tbl1.shouldStartPlayback and current) then
                return nil
            end

            local connection = current.Played:Connect(function()
                var16(true)
                var21(VideoActions.play)
            end)

            local connection2 = current.Paused:Connect(function()
                var16(false)
                var21(VideoActions.pause)
            end)

            local connection3 = current.Ended:Connect(function()
                var16(false)
            end)

            return function()
                connection:Disconnect()
                connection2:Disconnect()
                connection3:Disconnect()
            end
        end, { tbl1.shouldStartPlayback, var21 })

        React.useEffect(function()
            if not tbl1.shouldStartPlayback then
                var5(false)
                var16(false)
            end

            return nil
        end, { tbl1.shouldStartPlayback })

        if FFlagLuaAppMediaGalleryGamepadSupport then
            React.useEffect(function()
                if tbl1.onPlayingChanged then
                    tbl1.onPlayingChanged(var15)
                end
            end, { tbl1.onPlayingChanged, var15 })

            React.useEffect(function()
                if tbl1.onVideoLoadedChanged then
                    tbl1.onVideoLoadedChanged(videoLoaded)
                end
            end, { tbl1.onVideoLoadedChanged, videoLoaded })
        end
    else
        var18 = nil
        var19 = nil
        var20 = nil
        bool1 = nil
    end

    local createElement = React.createElement
    local str1 = if FFlagLuaAppVideoTileDisableActivation and tbl1.disableActivation then "Frame" elseif FFlagLuaAppEdpMediaGalleryFullScreen then "TextButton" else "Frame"
    local tbl2 = {
        Size = tbl1.Size,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = tbl1.ZIndex,
        Text = if FFlagLuaAppVideoTileDisableActivation and tbl1.disableActivation then nil elseif FFlagLuaAppEdpMediaGalleryFullScreen then "" else nil
    }

    local activated = React.Event.Activated

    if FFlagLuaAppVideoTileDisableActivation and tbl1.disableActivation or not FFlagLuaAppEdpMediaGalleryFullScreen then
        var18 = nil
    end

    tbl2[activated] = var18

    tbl2.Selectable = false

    local tbl3 = {
        Corner = if tbl1.cornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) else nil,
        Video = 0,
        PlayButton = 0,
        BottomOverlay = 0
    }

    local createElement2 = React.createElement
    local var21 = LoadableVideoFrame
    local tbl4 = {
        video = tbl1.video,
        accessContext = if FFlagLuaAppHomeMomentVideoFallback then tbl1.accessContext else nil,
        edits = if FFlagLuaAppVideoPlayerTrimAndMusic then var1 else nil,
        thumbnail = tbl1.thumbnail,
        thumbnailComponentOverride = if FFlagLuaAppSduiVideoThumbnail then tbl1.thumbnailComponentOverride else nil,
        shouldStartPlayback = tbl1.shouldStartPlayback and (not FFlagLuaAppVideoPlayerTrimAndMusic or var2),
        muted = muted,
        looped = tbl1.looped,
        ScaleType = tbl1.ScaleType,
        cornerRadius = tbl1.cornerRadius,
        onVideoLoaded = onVideoLoaded,
        onVideoLooped = tbl1.onVideoLooped,
        onVideoEnded = if FFlagLuaAppEdpMediaGalleryAutoAdvance then tbl1.onVideoEnded else nil,
        onVideoLoadFailed = 0,
        ref = 0
    }

    if not FFlagLuaAppVideoLoadFailureFallback then
        var9 = nil
    end

    tbl4.onVideoLoadFailed = var9
    tbl4.ref = if FFlagLuaAppEdpMediaGalleryAutoAdvance
        or FFlagLuaAppEdpMediaGalleryFullScreen
        or FFlagLuaAppEdpConsoleMediaGalleryVideo
        or FFlagLuaAppEnableNxMRoduxApportioning then var12 else nil
    tbl3.Video = createElement2(var21, tbl4)
    local element

    if (FFlagLuaAppVideoTileHideCenterPlayButton or FFlagLuaAppEnableNxMRoduxApportioning) and tbl1.hideCenterPlayButton
        or not (FFlagLuaAppEdpMediaGalleryFullScreen or FFlagLuaAppMediaGalleryGamepadSupport)
        or not videoLoaded
        or var15
        or FFlagLuaAppMediaGalleryGamepadSupport and var17 == nil
    then
        element = nil
    else
        element = React.createElement(RoundIconButton, {
            icon = "play-large",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            ZIndex = 2,
            Selectable = not bool1 and nil,
            onActivated = var17
        })
    end

    tbl3.PlayButton = element
    local var22

    if var3 then
        local createElement3 = React.createElement
        local var23 = VideoPlayerBottomOverlay
        local tbl5 = {
            cornerRadius = tbl1.cornerRadius,
            ZIndex = 10,
            videoLoaded = videoLoaded,
            muteButtonConfig = muteButtonConfig,
            playButtonConfig = 0,
            progressBarConfig = 0
        }

        if not FFlagLuaAppEdpMediaGalleryFullScreen then
            var19 = nil
        end

        tbl5.playButtonConfig = var19
        if not FFlagLuaAppEdpMediaGalleryFullScreen then
            var20 = nil
        end

        tbl5.progressBarConfig = var20
        var22 = createElement3(var23, tbl5)
    else
        var22 = nil
    end

    tbl3.BottomOverlay = var22
    return createElement(str1, tbl2, tbl3)
end

return VideoPlayer
