-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoPlayerParent = script:FindFirstAncestor("VideoPlayer").Parent

local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local React = require(VideoPlayerParent.React)
local ArgCheck = require(VideoPlayerParent.ArgCheck)

local VideoPlayerWrapper = require(script.Parent.VideoPlayerWrapper)
local VideoLoadingState = require(script.Parent.VideoLoadingState)

local function VideoDisplay(tbl1)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)
    local videoPlayerRef = tbl1.videoPlayerRef or var2
    local var4 = React.useRef(0)
    local var5 = React.useRef(0)
    local var6 = React.useRef(false)
    local var7, var8 = React.useState(false)
    local var9, var10 = React.useState(VideoLoadingState.Idle)
    local var11 = tbl1.shouldStartPlayback or tbl1.loadImmediately == true

    local var12 = React.useRef(nil)
    var12.current = tbl1.onLoadingStateChanged
    local var13 = React.useRef(nil)
    var13.current = tbl1.onVideoLoaded
    local var14 = React.useRef(nil)
    var14.current = tbl1.onAspectRatioChanged
    local var15 = React.useRef(nil)
    var15.current = tbl1.onVideoProgressChanged

    local var16 = React.useRef(tbl1.startPlaybackProgress)
    var16.current = tbl1.startPlaybackProgress
    local var17 = React.useRef(false)

    local var18 = React.useCallback(function(arg1)
        var10(arg1)
        if var12.current then
            var12.current(arg1)
        end
    end, {})

    local onVideoLooped = React.useCallback(function()
        local var19 = var4
        var19.current += 1
        if tbl1.onVideoLooped then
            tbl1.onVideoLooped()
        end
    end, { tbl1.onVideoLooped })

    React.useEffect(function()
        var4.current = 0
        var5.current = 0
        var6.current = false
    end, { tbl1.video })

    React.useEffect(function()
        local videoPlaybackStateRef = tbl1.videoPlaybackStateRef
        if videoPlaybackStateRef == nil then
            return
        end

        local function current(): {audioLevel: number, endedCount: number, isPlaying: any, loopCount: number, playbackPositionMs: number, videoLengthMs: number}?
            local current = videoPlayerRef.current
            if not current then
                return nil
            end

            local tbl2 = {
                isPlaying = current.IsPlaying,
                playbackPositionMs = math.round(math.max(0, current.TimePosition) * 1000),
                videoLengthMs = if current.TimeLength > 0 then math.round(current.TimeLength * 1000) else nil,
                loopCount = var4.current,
                endedCount = var5.current,
                audioLevel = math.clamp(current.Volume * UserGameSettings.MasterVolume, 0, 1)
            }
            return tbl2
        end

        videoPlaybackStateRef.current = current

        return function()
            if videoPlaybackStateRef.current == current then
                videoPlaybackStateRef.current = nil
            end
        end
    end, { tbl1.videoPlaybackStateRef })

    React.useEffect(function()
        var8(false)
        if not var11 then
            var18(VideoLoadingState.Idle)
            return
        end

        local current = videoPlayerRef.current
        ArgCheck.assert(current ~= nil, "VideoDisplay expects videoPlayer ref to be set before loading")
        var18(VideoLoadingState.Loading)
        local bool1 = false
        task.spawn(function()
            local startTime = tick()
            local success, result = pcall(function()
                return current:LoadAsync()
            end)
            if bool1 then
                return
            end

            if not success or result ~= Enum.AssetFetchStatus.Success then
                var18(VideoLoadingState.Failed)
                return
            end

            local current2 = var16.current
            if current2 ~= nil then
                current.TimePosition = math.clamp(current2, 0, 1) * current.TimeLength
                var17.current = true
            end
            if var13.current then
                var13.current(current.TimeLength, tick() - startTime)
            end
            local resolution = current.Resolution
            if var14.current and resolution and resolution.Y > 0 then
                var14.current(resolution.X / resolution.Y)
            end
            var8(true)
            var18(VideoLoadingState.Loaded)
        end)
        return function()
            bool1 = true
        end
    end, { tbl1.video, var11 })

    local onVideoEnded = React.useCallback(function()
        var6.current = true
        local var20 = var5
        var20.current += 1
        if tbl1.onVideoEnded then
            tbl1.onVideoEnded()
        end
    end, { tbl1.onVideoEnded })

    React.useEffect(function()
        if not var7 then
            return
        end
        local current = videoPlayerRef.current
        ArgCheck.assert(current ~= nil, "VideoDisplay expects videoPlayer ref to be set before playback")
        if var17.current then
            var17.current = false
        elseif var6.current and tbl1.shouldStartPlayback then
            current.TimePosition = 0
            var6.current = false
        elseif tbl1.shouldStartPlayback and not tbl1.preservePlaybackPosition then
            current.TimePosition = 0
        end

        if tbl1.shouldStartPlayback then
            current:Play()
            return
        end
        current:Pause()
    end, { var7, tbl1.preservePlaybackPosition, tbl1.shouldStartPlayback })

    React.useEffect(function()
        if not var7 then
            return
        end

        local current = videoPlayerRef.current
        ArgCheck.assert(current ~= nil, "VideoDisplay expects videoPlayer ref to be set before reporting progress")
        local connection = RunService.RenderStepped:Connect(function()
            local current2 = var15.current
            if current2 then
                current2(if current.TimeLength > 0 then current.TimePosition / current.TimeLength else 0)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { var7 })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = tbl1.Size,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = tbl1.ZIndex,
        Selectable = false
    }
    local tbl3 = {
        Corner = if tbl1.cornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) else nil,
        Thumbnail = 0,
        VideoDisplay = 0
    }
    local element

    if tbl1.thumbnail and tbl1.thumbnail ~= "" then
        element = React.createElement("ImageLabel", {
            Image = tbl1.thumbnail,
            Size = UDim2.fromScale(1, 1),
            ScaleType = tbl1.ScaleType,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 1
        }, {
            Corner = if tbl1.cornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) else nil
        })
    else
        element = nil
    end

    tbl3.Thumbnail = element

    tbl3.VideoDisplay = React.createElement("VideoDisplay", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScaleType = tbl1.ScaleType,
        Visible = not (var9 == VideoLoadingState.Failed) and (tbl1.shouldStartPlayback or tbl1.showVideoWhenPaused == true),
        ZIndex = 2,
        ref = var1
    }, {
        Corner = if tbl1.cornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) else nil,
        VideoPlayer = React.createElement(VideoPlayerWrapper, {
            video = tbl1.video,
            muted = tbl1.muted,
            looped = tbl1.looped,
            videoPlayerRef = videoPlayerRef,
            videoDisplayRef = var1,
            onVideoLooped = onVideoLooped,
            onVideoEnded = onVideoEnded
        })
    })
    return createElement(str1, tbl2, tbl3)
end

return VideoDisplay
