-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local RunService = game:GetService("RunService")

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)

local Icon = Foundation.Icon
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local getCropSize = MomentsCommon.Utils.getCropSize
local getFitSize = MomentsCommon.Utils.getFitSize

local Constants = require(MomentsCreation.Constants)
local getCaptureContent = require(MomentsCreation.Capture.getCaptureContent)
local getCaptureVideoContent = require(MomentsCreation.Capture.getCaptureVideoContent)
local useCreationMusicSync = require(MomentsCreation.Hooks.useCreationMusicSync)
local GetFFlagMomentsTTSAudioOverlay = require(MomentsCreation.Flags.GetFFlagMomentsTTSAudioOverlay)
local getTtsDuckScalar = require(MomentsCreation.Audio.getTtsDuckScalar)
local fadeVolume = require(MomentsCreation.Audio.fadeVolume)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function VideoPreviewSurface(tbl1)
    local preview = tbl1.preview
    local capture = tbl1.capture
    local timeLength = tbl1.timeLength
    local ref = React.useRef(nil)

    local var2, var3 = React.useState(Vector2.new(0, 0))
    local var4, var5 = React.useState(Vector2.new(0, 0))

    local var6, var7 = React.useState(preview.playback.getRegion(false))
    React.useEffect(function()
        return Signals.createEffect(function(arg1)
            var7(preview.playback.getRegion(arg1))
        end)
    end, { preview })

    local var8 = if var6 == nil then timeLength else math.max(0, var6.endTime - var6.startTime)
    local var9 = useCreationMusicSync(preview, var8, tbl1.ttsAudio)
    local audio = var9.audio
    local music = var9.music
    local userMuted = var9.userMuted
    local isDucking = var9.isDucking

    local var10 = React.useRef(nil)
    React.useEffect(function()
        function var10.current()
            if music ~= nil then
                audio.timeline.seek(0)
            end
        end
    end, { audio.timeline.seek, music })

    React.useEffect(function()
        local current = ref.current
        if current == nil then
            return
        end

        if not GetFFlagMomentsTTSAudioOverlay then
            current.Volume = if music == nil and not userMuted then 1 else 0
            return
        end

        if music ~= nil or userMuted then
            fadeVolume(current, 0, true)
        else
            fadeVolume(current, if isDucking then 1 * getTtsDuckScalar() else 1)
        end
    end, { music, userMuted, isDucking })

    React.useEffect(function()
        local current = ref.current
        if current == nil then
            return
        end

        if typeof(capture) == "table" then
            local captureVideoContent = getCaptureVideoContent(capture)
            if captureVideoContent ~= nil then
                current.Video = captureVideoContent.Uri
            end
        else
            local success, result = pcall(Content.fromObject, capture)
            if success and result then
                current.VideoContent = result
            end
        end
        current.Looped = true

        preview.setDuration(timeLength)
        preview.setTimeLength(timeLength)
        preview.setReadiness("Ready")

        local bool1 = false

        preview.bindEngine({
            play = function()
                current.Playing = true
            end,
            pause = function()
                current.Playing = false
            end,
            seek = function(timePosition: number)
                current.TimePosition = timePosition
            end
        })

        local tbl2 = {
            current.Loaded:Connect(function()
                bool1 = true
                if current.TimeLength > 0 then
                    preview.setDuration(current.TimeLength)
                    preview.setTimeLength(current.TimeLength)
                end
                current.Playing = true
                preview.setIsPlaying(true)
            end),
            current.Played:Connect(function()
                bool1 = true
                preview.setIsPlaying(true)
            end),
            current.Paused:Connect(function()
                if bool1 then
                    preview.setIsPlaying(false)
                end
            end),
            RunService.RenderStepped:Connect(function()
                preview.setPosition(current.TimePosition)

                local region = preview.playback.getRegion(false)
                if region == nil then
                    return
                end
                local timePosition = current.TimePosition

                if not (region.endTime - 0.05 <= timePosition) and not (timePosition < region.startTime - 0.05) then
                    return
                end
                current.TimePosition = region.startTime
                if var10.current ~= nil then
                    var10.current()
                end
            end)
        }

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
            preview.bindEngine(nil)
        end
    end, { preview, capture, timeLength })

    local createElement = React.createElement
    local var11 = View

    local tbl2 = {
        tag = "size-full",
        ClipsDescendants = true,
        onAbsoluteSizeChanged = function(arg1)
            var3(arg1.AbsoluteSize)
        end
    }

    local tbl3 = { Media = 0, Overlay = 0 }
    local createElement2 = React.createElement
    local str1 = "VideoFrame"
    local tbl4 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        InternalVideoUsage = Enum.InternalVideoUsage.WatchPage,
        Looped = true,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = if tbl1.scaleType == Enum.ScaleType.Fit then getFitSize(var2, var4) else getCropSize(var2, var4),
        Visible = var4.X > 0 and var4.Y > 0,
        ref = ref
    }

    tbl4[React.Change.Resolution] = function(arg1)
        var5(arg1.Resolution)
        if tbl1.onResolutionChanged ~= nil then
            tbl1.onResolutionChanged(arg1.Resolution)
        end
    end

    tbl3.Media = createElement2(str1, tbl4)

    tbl3.Overlay = React.createElement(View, { tag = "size-full", ZIndex = 2 }, tbl1.children)
    return createElement(var11, tbl2, tbl3)
end

local function ScreenshotPreviewSurface(tbl1)
    local preview = tbl1.preview
    local capture = tbl1.capture

    local var1 = useCreationMusicSync(preview, Constants.ScreenshotMusicDuration, tbl1.ttsAudio)
    local music = var1.music

    local elapsed = var1.audio.timeline.elapsed

    React.useEffect(function()
        preview.bindEngine(nil)
        preview.setDuration(Constants.ScreenshotMusicDuration)
        preview.setTimeLength(Constants.ScreenshotMusicDuration)
        preview.setPosition(0)
        preview.setReadiness("Ready")
    end, { preview, capture })

    React.useEffect(function()
        local setPosition = preview.setPosition
        local var2 = if music == nil then 0 else math.clamp(elapsed, 0, Constants.ScreenshotMusicDuration)
        setPosition(var2)
    end, { preview, music, elapsed })

    return React.createElement(View, {
        tag = "size-full",
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged
    }, {
        Overlay = React.createElement(React.Fragment, {}, tbl1.children),
        Media = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            ImageContent = getCaptureContent(tbl1.capture),
            ScaleType = tbl1.scaleType,
            Size = UDim2.fromScale(1, 1)
        })
    })
end

return function(tbl1)
    local var1 = useTokens()

    local capture, var3 = React.useState(tbl1.preview.getCapture(false))
    React.useEffect(function()
        local preview = tbl1.preview

        local var4 = nil
        local var5 = nil
        local bool1 = false

        local function onWindowElapsed()
            if not bool1 then
                var4 = nil

                return
            end

            bool1 = false
            local var6 = var5
            var5 = nil
            var3(var6)
            var4 = task.delay(0.2, onWindowElapsed)
        end
        local effect = Signals.createEffect(function(arg1)
            local capture = preview.getCapture(arg1)
            if var4 == nil then
                var3(capture)
                var4 = task.delay(0.2, onWindowElapsed)
                return
            end
            var5 = capture
            bool1 = true
        end)

        return function()
            if var4 ~= nil then
                task.cancel(var4)
                var4 = nil
            end
            effect()
        end
    end, { tbl1.preview })

    if capture == nil then
        return React.createElement(
            View,
            {
                tag = "size-full radius-large bg-shift-200",
                onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged
            },
            {
                EmptyState = React.createElement(Icon, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    name = BuilderIcons.Icon.Image,
                    Position = UDim2.fromScale(0.5, 0.5),
                    size = var1.Size.Size_1200,
                    style = var1.Color.Shift.Shift_400
                })
            }
        )
    elseif capture.CaptureType == Enum.CaptureType.Video then
        return React.createElement(View, {
            tag = "size-full",
            onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged
        }, {
            Preview = React.createElement(VideoPreviewSurface, {
                preview = tbl1.preview,
                capture = capture,
                scaleType = tbl1.scaleType,
                timeLength = capture.TimeLength or 0,
                onResolutionChanged = tbl1.onResolutionChanged,
                ttsAudio = tbl1.ttsAudio
            }, tbl1.children)
        })
    end

    return React.createElement(ScreenshotPreviewSurface, {
        preview = tbl1.preview,
        capture = capture,
        scaleType = tbl1.scaleType,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        ttsAudio = tbl1.ttsAudio
    }, tbl1.children)
end
