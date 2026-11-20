-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local VideoService = game:GetService("VideoService")

local BuilderIcons = require(MomentsCreationFlowParent.BuilderIcons)
local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Button = Foundation.Button
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View

local PlayLarge = BuilderIcons.Icon.PlayLarge
local PauseLarge = BuilderIcons.Icon.PauseLarge
local Speaker = BuilderIcons.Icon.Speaker
local SpeakerSlash = BuilderIcons.Icon.SpeakerSlash

local DragHandle = require(MomentsCreationFlow.Components.DragHandle)
local TrimTooltip = require(MomentsCreationFlow.Components.TrimTooltip)

local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens
local useTrimDragController = require(MomentsCreationFlow.Hooks.useTrimDragController)

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)
local getContentFromCapture = require(MomentsCreationFlow.Utils.getContentFromCapture)

local DragHandle2 = require(MomentsCreationFlow.Enums.DragHandle)

local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = React.useContext(CreationFlowContext)

    local var4 = React.useRef(false)
    local var5 = React.useRef(false)
    local activeHandle, var7 = React.useState(nil)

    local var8 = React.useRef(nil)
    local contentFromCapture = getContentFromCapture(tbl1.selectedCapture)

    local var9, var10 = React.useState({})
    React.useEffect(function()
        task.spawn(function()
            local success, result = pcall(function()
                var8.current = VideoService:CreateVideoSamplerAsync(contentFromCapture)
            end)

            if not success then
                warn("Failed to create VideoSampler:", result)

                return
            end

            local tbl2 = {}
            local timeLength = tbl1.playbackController.timeline.timeLength

            for i = 0, math.floor(timeLength) - 1 do
                table.insert(tbl2, i)
            end

            var10(var8.current:GetSamplesAtTimesAsync(tbl2))
        end)
    end, { tbl1.selectedCapture })

    local var11 = useCallback(function(arg1)
        var4.current = tbl1.playbackController.playback.isPlaying
        var5.current = tbl1.playbackController.volume.isMuted
        tbl1.playbackController.volume.mute()
        tbl1.playbackController.playback.pause()
        var7(arg1)
    end, { tbl1.playbackController.playback.isPlaying, tbl1.playbackController.volume.isMuted })

    local var12 = useCallback(function()
        if var4.current then
            tbl1.playbackController.playback.play()
        end
        if not var5.current then
            tbl1.playbackController.volume.unmute()
        end
        var4.current = false
        var5.current = false
        var7(nil)
    end, {})

    local var13 = useCallback(function(num1: number?, num2: number?)
        local var13 = num1 or tbl1.trimEdit and tbl1.trimEdit.startTime or 0
        local var14 = num2 or tbl1.trimEdit and tbl1.trimEdit.endTime or tbl1.playbackController.timeline.timeLength

        local startTime = math.clamp(var13, 0, tbl1.playbackController.timeline.timeLength)
        local endTime = math.clamp(var14, 0, tbl1.playbackController.timeline.timeLength)

        tbl1.onTrimUpdate({ startTime = startTime, endTime = endTime })

        tbl1.playbackController.timeline.seek(0)
    end, { tbl1.onTrimUpdate, tbl1.trimEdit, tbl1.playbackController.timeline.timeLength })

    local var14 = useCallback(function(num1: number)
        tbl1.playbackController.timeline.seek(num1 * tbl1.playbackController.timeline.duration)
    end, { tbl1.playbackController.timeline.seek, tbl1.playbackController.timeline.duration })

    local var15 = useTrimDragController(true, var12, var11, var13, var14, tbl1.trimEdit, tbl1.playbackController.timeline.timeLength)

    local dragContainerRef = var15.dragContainerRef
    local leftHandleRef = var15.leftHandleRef
    local rightHandleRef = var15.rightHandleRef
    local scrubberDisplayRef = var15.scrubberDisplayRef
    local scrubberRef = var15.scrubberRef
    local segmentRef = var15.segmentRef
    local leftHandlePosition = var15.leftHandlePosition
    local rightHandlePosition = var15.rightHandlePosition

    local onActivated = useCallback(function()
        if tbl1.onTrimDiscard then
            tbl1.onTrimDiscard()
        end
    end, { tbl1.onTrimDiscard })

    local var6 = useCallback(function()
        if tbl1.onTrimSave then
            tbl1.onTrimSave()
        end
    end, { tbl1.onTrimSave })

    local var16 = useCallback(function()
        tbl1.playbackController.playback.toggle()
    end, { tbl1.playbackController })

    local var17 = useCallback(function()
        tbl1.playbackController.volume.toggle()
    end, { tbl1.playbackController })

    local var20 = React.useMemo(function()
        local result = ({})
        local timeLength = tbl1.playbackController.timeline.timeLength

        for i = 1, math.floor(timeLength) do
            local createElement = React.createElement
            local var20 = View

            local tbl2 = {
                content = React.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    ImageContent = var9[i] and var9[i].Image,
                    ScaleType = Enum.ScaleType.Crop
                })
            }
            result[i] = createElement(var20, { tag = "size-full-full bg-system-neutral shrink" }, tbl2)
        end

        return result
    end, { tbl1.playbackController.timeline.timeLength, var9 })

    local createElement = React.createElement
    local var21 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "align-x-center auto-y align-y-bottom anchor-bottom-center col gap-large position-bottom-center size-full-0"
    }
    local tbl3 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var2.Padding.Small),
            PaddingBottom = UDim.new(0, math.max(var1.bottom, var2.Padding.Small)),
            PaddingLeft = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            PaddingRight = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }),
        Nav = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "align-x-center align-y-center auto-y gap-small row size-full-0 flex-x-between"
            },
            {
                BackButton = React.createElement(Button, {
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 1,
                    text = var3.getLocalization(CreationFlowLocalization.GeneralCtaBack),
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = onActivated,
                    size = Foundation.Enums.InputSize.Medium
                }),
                DoneButton = React.createElement(Button, {
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 2,
                    text = var3.getLocalization(CreationFlowLocalization.GeneralCtaDone),
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = var6,
                    size = Foundation.Enums.InputSize.Medium
                })
            }
        ),
        Trimmer = 0,
        VideoControls = 0
    }

    local createElement2 = React.createElement
    local var22 = View
    local tbl4 = { LayoutOrder = 2, tag = "padding-x-small size-full-1000", ZIndex = 2 }

    local tbl5 = { PaddedContainer = 0, Timeline = 0 }
    local createElement3 = React.createElement
    local var23 = View
    local tbl6 = { ref = dragContainerRef, tag = "padding-x-medium size-full-full", ZIndex = 2 }

    local tbl7 = { TrimmerBar = 0 }
    local createElement4 = React.createElement
    local var24 = View
    local tbl8 = { tag = "size-full" }

    local tbl9 = {
        TrimTooltip = React.createElement(TrimTooltip, {
            activeHandle = activeHandle,
            leftHandlePosition = leftHandlePosition,
            rightHandlePosition = rightHandlePosition,
            timeLength = tbl1.playbackController.timeline.timeLength
        }),
        LeftHandle = React.createElement(DragHandle, {
            anchorPoint = Vector2.new(1, 0.5),
            position = leftHandlePosition:map(function(xScale: number): UDim2
                return UDim2.fromScale(xScale, 0.5)
            end),
            dragDetectorRef = leftHandleRef
        }),
        RightHandle = React.createElement(DragHandle, {
            anchorPoint = Vector2.new(0, 0.5),
            isFlipped = true,
            position = rightHandlePosition:map(function(xScale: number): UDim2
                return UDim2.fromScale(xScale, 0.5)
            end),
            dragDetectorRef = rightHandleRef
        }),
        Outline = 0,
        ShadowBlockLeft = 0,
        ShadowBlockRight = 0
    }

    local createElement5 = React.createElement
    local var25 = View

    local tbl10 = {
        Position = leftHandlePosition:map(function(xScale: number): UDim2
            return UDim2.fromScale(xScale, 0.5)
        end),
        Size = React.joinBindings({ leftHandlePosition = leftHandlePosition, rightHandlePosition = rightHandlePosition }):map(
            function(arg1): UDim2
                local leftHandlePosition2 = arg1.leftHandlePosition
                local rightHandlePosition2 = arg1.rightHandlePosition
                return UDim2.fromScale(rightHandlePosition2 - leftHandlePosition2, 1)
            end
        ),
        tag = "anchor-center-left",
        ZIndex = 2
    }

    local tbl11 = {
        OutlineStroke = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = var2.Color.System.Contrast.Color3,
            Transparency = var2.Color.System.Contrast.Transparency,
            Thickness = var2.Stroke.Thicker
        }),
        Scrubber = 0,
        DragDetector = 0
    }
    local element

    if activeHandle and activeHandle ~= DragHandle2.Scrubber then
        element = nil
    else
        element = React.createElement(View, {
            ref = scrubberDisplayRef,
            tag = "anchor-center-center bg-system-contrast size-100-1400 radius-circle",
            Position = UDim2.fromScale(tbl1.playbackController.timeline.elapsed / tbl1.playbackController.timeline.duration, 0.5)
        }, {
            DragDetector = React.createElement("UIDragDetector", {
                DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
                ref = scrubberRef,
                ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale
            })
        })
    end

    tbl11.Scrubber = element

    tbl11.DragDetector = React.createElement("UIDragDetector", {
        DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
        ref = segmentRef,
        ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale
    })
    tbl9.Outline = createElement5(var25, tbl10, tbl11)

    tbl9.ShadowBlockLeft = React.createElement(View, {
        backgroundStyle = var2.Color.Extended.Black.Black_50,
        Size = leftHandlePosition:map(function(xScale: number): UDim2
            return UDim2.fromScale(xScale, 1)
        end),
        tag = "anchor-center-left position-center-left",
        ZIndex = 0
    })

    tbl9.ShadowBlockRight = React.createElement(View, {
        backgroundStyle = var2.Color.Extended.Black.Black_50,
        Size = rightHandlePosition:map(function(arg1): UDim2
            return UDim2.fromScale(1 - arg1, 1)
        end),
        tag = "anchor-center-right position-center-right",
        ZIndex = 0
    })

    tbl7.TrimmerBar = createElement4(var24, tbl8, tbl9)
    tbl5.PaddedContainer = createElement3(var23, tbl6, tbl7)

    tbl5.Timeline = React.createElement(View, {
        tag = "bg-surface-100 radius-medium size-full-full",
        ZIndex = 1
    }, {
        OutlineStroke = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = var2.Color.Surface.Surface_100.Color3,
            Transparency = var2.Color.Surface.Surface_100.Transparency,
            Thickness = var2.Stroke.Thicker
        }),
        TimelineBar = React.createElement(
            View,
            {
                layout = {
                    Padding = UDim.new(0, var2.Size.Size_50)
                },
                tag = "padding-x-medium size-full-full row"
            },
            var20
        )
    })
    tbl3.Trimmer = createElement2(var22, tbl4, tbl5)

    local createElement6 = React.createElement
    local var26 = View

    local tbl12 = {
        PlaybackToggle = React.createElement(IconButton, {
            LayoutOrder = 1,
            icon = tbl1.playbackController.playback.isPlaying and PauseLarge or PlayLarge,
            onActivated = var16,
            size = Foundation.Enums.InputSize.Medium
        }),
        DurationDisplay = 0,
        MuteToggle = 0
    }

    local createElement7 = React.createElement
    local var27 = FoundationText
    local tbl13 = { LayoutOrder = 2, tag = "auto-xy text-label-medium content-default", Text = 0 }

    local format = string.format
    local elapsed = tbl1.playbackController.timeline.elapsed
    tbl13.Text = `{format("%.1f", math.max(0, elapsed))} / {string.format("%.1f", tbl1.playbackController.timeline.duration)}`
    tbl12.DurationDisplay = createElement7(var27, tbl13)

    tbl12.MuteToggle = React.createElement(IconButton, {
        LayoutOrder = 3,
        icon = tbl1.playbackController.volume.isMuted and SpeakerSlash or Speaker,
        onActivated = var17,
        size = Foundation.Enums.InputSize.Medium
    })
    tbl3.VideoControls = createElement6(
        var26,
        {
            LayoutOrder = 3,
            tag = "align-x-center align-y-center auto-y gap-small row size-full-0 flex-x-between"
        },
        tbl12
    )
    return createElement(var21, tbl2, tbl3)
end
