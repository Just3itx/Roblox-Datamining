-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local EditedVideoFrame = require(VideoUtils.EditedVideoFrame)
local VideoFrameWrapper = require(VideoUtils.VideoFrameWrapper)
local getAuthorizedVideoUri = require(VideoUtils.getAuthorizedVideoUri)

local ArgCheck = require(VideoUtilsParent.ArgCheck)
local LoadableImage = require(VideoUtilsParent.UIBlox).App.Loading.LoadableImage
local React = require(VideoUtilsParent.React)

local Foundation = require(VideoUtilsParent.Foundation)
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton

local getVideoEdits = require(script.Parent.getVideoEdits)

local FFlagLuaAppEdpMediaGalleryAutoAdvance = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpMediaGalleryAutoAdvance
local FFlagLuaAppEdpMediaGalleryFullScreen = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpMediaGalleryFullScreen
local FFlagLuaAppEdpConsoleMediaGalleryVideo = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpConsoleMediaGalleryVideo
local FFlagLuaAppEnableNxMRoduxApportioning = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning

local FFlagLuaAppHomePageFirstImageLoadObserver = require(VideoUtilsParent.SharedFlags).FFlagLuaAppHomePageFirstImageLoadObserver
local FFlagLuaAppSduiVideoThumbnail = require(VideoUtilsParent.SharedFlags).FFlagLuaAppSduiVideoThumbnail
local FFlagLuaAppHomeMomentVideoFallback = require(VideoUtilsParent.SharedFlags).FFlagLuaAppHomeMomentVideoFallback
local FFlagLuaAppVideoLoadFailureFallback = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoLoadFailureFallback
local FFlagLuaAppVideoPlayerTrimAndMusic = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoPlayerTrimAndMusic

local function LoadableVideoFrame(tbl1, videoFrameRef)
    local var1, var2 = React.useState(false)

    local var3 = nil
    local var4 = nil
    local var5 = nil
    local var6 = nil
    if FFlagLuaAppVideoLoadFailureFallback then
        local var7
        var3, var7 = React.useState(false)
        var4 = var7
        var5 = React.useRef(nil)

        var6 = React.useRef(tbl1.onVideoLoadFailed)
        local onVideoLoadFailed = tbl1.onVideoLoadFailed
        var6.current = onVideoLoadFailed
    end

    local var7 = if FFlagLuaAppEdpMediaGalleryAutoAdvance
        or FFlagLuaAppEdpMediaGalleryFullScreen
        or FFlagLuaAppEdpConsoleMediaGalleryVideo
        or FFlagLuaAppEnableNxMRoduxApportioning then nil else React.useRef(nil)
    local var8 = React.useRef(nil)

    if tbl1.shouldStartPlayback and var8.current == nil then
        var8.current = tick()
    elseif not tbl1.shouldStartPlayback then
        var8.current = nil
    end

    local bool1 = not (tbl1.thumbnail == nil) and tbl1.thumbnail ~= ""
    local contentId = nil
    if FFlagLuaAppVideoLoadFailureFallback then
        if FFlagLuaAppHomeMomentVideoFallback then
            contentId = getAuthorizedVideoUri(tbl1.video, tbl1.accessContext)
        else
            contentId = tbl1.video
        end

        React.useEffect(function()
            var4(false)

            if not tbl1.shouldStartPlayback or contentId == "" then
                return nil
            end

            local current = { finished = false, failed = false, connection = nil }
            var5.current = current
            local function onFetchStatus(assetFetchStatus)
                if current.finished
                    or assetFetchStatus ~= Enum.AssetFetchStatus.Failure and assetFetchStatus ~= Enum.AssetFetchStatus.TimedOut
                then
                    return
                end
                current.finished = true
                current.failed = true
                if current.connection then
                    current.connection:Disconnect()
                end
                var4(true)
                if var6.current then
                    var6.current(assetFetchStatus.Name)
                end
            end

            current.connection = ContentProvider:GetAssetFetchStatusChangedSignal(contentId):Connect(onFetchStatus)
            onFetchStatus(ContentProvider:GetAssetFetchStatus(contentId))

            return function()
                current.finished = true
                var5.current = nil
                if current.connection then
                    current.connection:Disconnect()
                end
            end
        end, {
            contentId,
            tbl1.shouldStartPlayback,
            var5,
            var6
        })
    end
    local useCallback = React.useCallback
    local function func1()
        if FFlagLuaAppVideoLoadFailureFallback and var5.current then
            local current = var5.current
            if current.failed then
                return
            end
            current.finished = true
            if current.connection then
                current.connection:Disconnect()
            end
        end

        local current = nil

        if FFlagLuaAppEdpMediaGalleryAutoAdvance
            or FFlagLuaAppEdpMediaGalleryFullScreen
            or FFlagLuaAppEdpConsoleMediaGalleryVideo
            or FFlagLuaAppEnableNxMRoduxApportioning
        then
            if typeof(videoFrameRef) == "table" then
                current = videoFrameRef.current
            else
                warn(`unsupported ref type: {typeof(videoFrameRef)}`)
            end
        else
            current = var7.current
        end

        if current == nil then
            return
        end

        local now = tick()
        ArgCheck.assert(var8.current and var8.current <= now)

        local var9 = if var8.current and var8.current <= now then now - var8.current else -1

        if tbl1.onVideoLoaded then
            local timeLength

            if FFlagLuaAppVideoPlayerTrimAndMusic and tbl1.edits and tbl1.edits.trim then
                local var10, var11 = getVideoEdits.getPlaybackRange(current.TimeLength, tbl1.edits.trim)
                timeLength = var11 - var10
            else
                timeLength = current.TimeLength
            end

            local onVideoLoaded = tbl1.onVideoLoaded
            if not FFlagLuaAppVideoPlayerTrimAndMusic then
                timeLength = current.TimeLength
            end

            onVideoLoaded(timeLength, var9)
        end

        var2(true)
    end

    local onVideoLoaded = tbl1.onVideoLoaded
    local startTime = if FFlagLuaAppVideoPlayerTrimAndMusic and tbl1.edits and tbl1.edits.trim then tbl1.edits.trim.startTime else nil
    local endTime = if FFlagLuaAppVideoPlayerTrimAndMusic and tbl1.edits and tbl1.edits.trim then tbl1.edits.trim.endTime else nil
    local var9 = if FFlagLuaAppEdpMediaGalleryAutoAdvance or FFlagLuaAppEdpMediaGalleryFullScreen or FFlagLuaAppEdpConsoleMediaGalleryVideo then videoFrameRef elseif FFlagLuaAppEnableNxMRoduxApportioning then videoFrameRef else var7
    local var10 = if FFlagLuaAppVideoLoadFailureFallback then var5 else nil
    local onLoaded = useCallback(func1, { onVideoLoaded, startTime, endTime, var9, var8, var10 })

    local var12 = if FFlagLuaAppEdpMediaGalleryAutoAdvance then React.useCallback(function()
        if tbl1.onVideoEnded then
            tbl1.onVideoEnded()
        end
    end, { tbl1.onVideoEnded }) else nil

    local onLooped = React.useCallback(function()
        if tbl1.onVideoLooped then
            tbl1.onVideoLooped()
        end
    end, { tbl1.onVideoLooped })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        [React.Tag] = if FFlagLuaAppHomePageFirstImageLoadObserver then "observed-image" else nil,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true
    }
    local tbl3 = { VideoFrame = 0, VideoThumbnail = 0, Skeleton = 0 }
    local createElement2 = React.createElement
    local var14 = if FFlagLuaAppVideoPlayerTrimAndMusic and tbl1.edits then EditedVideoFrame else VideoFrameWrapper
    local tbl4 = {
        videoFrameRef = if FFlagLuaAppEdpMediaGalleryAutoAdvance or FFlagLuaAppEdpMediaGalleryFullScreen or FFlagLuaAppEdpConsoleMediaGalleryVideo then videoFrameRef elseif FFlagLuaAppEnableNxMRoduxApportioning then videoFrameRef else var7,
        video = if FFlagLuaAppVideoLoadFailureFallback then contentId elseif FFlagLuaAppHomeMomentVideoFallback then getAuthorizedVideoUri(tbl1.video, tbl1.accessContext) else tbl1.video,
        isPlaying = tbl1.shouldStartPlayback and not (FFlagLuaAppVideoLoadFailureFallback and var3),
        looped = tbl1.looped,
        edits = if FFlagLuaAppVideoPlayerTrimAndMusic then tbl1.edits else nil,
        volume = if tbl1.muted then 0 else nil,
        onLoaded = onLoaded,
        onLooped = onLooped,
        onEnded = 0,
        cornerRadius = 0,
        zIndex = 4
    }

    if not FFlagLuaAppEdpMediaGalleryAutoAdvance then
        var12 = nil
    end

    tbl4.onEnded = var12
    tbl4.cornerRadius = tbl1.cornerRadius
    tbl3.VideoFrame = createElement2(var14, tbl4)
    local element

    if FFlagLuaAppSduiVideoThumbnail and tbl1.thumbnailComponentOverride then
        element = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 2
            },
            {
                Thumbnail = tbl1.thumbnailComponentOverride
            }
        )
    elseif bool1 then
        element = React.createElement(LoadableImage, {
            BackgroundTransparency = 1,
            Image = tbl1.thumbnail,
            Size = UDim2.new(1, 0, 1, if tbl1.ScaleType ~= Enum.ScaleType.Tile then 0 else tbl1.cornerRadius),
            cornerRadius = UDim.new(0, tbl1.cornerRadius),
            showFailedStateWhenLoadingFailed = true,
            useShimmerAnimationWhileLoading = true,
            ZIndex = 2,
            ScaleType = tbl1.ScaleType,
            TileSize = if tbl1.ScaleType == Enum.ScaleType.Tile and tbl1.cornerRadius then UDim2.new(1, 0, 1, -tbl1.cornerRadius) else nil
        })
    else
        element = nil
    end

    tbl3.VideoThumbnail = element
    local element2 = if tbl1.shouldStartPlayback and not var1 and not (FFlagLuaAppVideoLoadFailureFallback and var3) then React.createElement(
        Skeleton,
        {
            Size = UDim2.fromScale(1, 1),
            radius = if tbl1.cornerRadius then Radius.Medium else nil,
            ZIndex = 3
        }
    ) else nil
    tbl3.Skeleton = element2
    return createElement(str1, tbl2, tbl3)
end

if FFlagLuaAppEdpMediaGalleryAutoAdvance
    or FFlagLuaAppEdpMediaGalleryFullScreen
    or FFlagLuaAppEdpConsoleMediaGalleryVideo
    or FFlagLuaAppEnableNxMRoduxApportioning
then
    return React.forwardRef(LoadableVideoFrame)
end

return LoadableVideoFrame
