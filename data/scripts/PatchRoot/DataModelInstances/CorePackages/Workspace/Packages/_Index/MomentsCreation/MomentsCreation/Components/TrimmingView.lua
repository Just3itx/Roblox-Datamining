-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local Button = Foundation.Button
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View

local PlayLarge = BuilderIcons.Icon.PlayLarge
local PauseLarge = BuilderIcons.Icon.PauseLarge
local Speaker = BuilderIcons.Icon.Speaker
local SpeakerSlash = BuilderIcons.Icon.SpeakerSlash

local useCallback = React.useCallback
local useEffect = React.useEffect
local useMemo = React.useMemo
local useRef = React.useRef
local useState = React.useState
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState
local useSignalBinding = SignalsReact.useSignalBinding

local DragHandle = require(MomentsCreation.Components.DragHandle)
local TrimTooltip = require(MomentsCreation.Components.TrimTooltip)
local useTrimDragController = require(MomentsCreation.Hooks.useTrimDragController)
local getCaptureVideoContent = require(MomentsCreation.Capture.getCaptureVideoContent)
local sampleVideoFrames = require(MomentsCreation.Capture.sampleVideoFrames)

local DragHandle2 = require(MomentsCreation.Enums.DragHandle)
local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

return function(tbl1)
    local controller = tbl1.controller
    local playback = controller.preview.playback

    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = useCreationFlowStrings()

    local var4 = useSignalState(controller.getSelectedCapture)
    local timeLength = useSignalState(playback.getTimeLength)
    local var6 = useSignalState(playback.getIsPlaying)
    local var7 = useSignalState(playback.getIsMuted)

    local var8 = useMemo(function()
        return Signals.createComputed(function(arg1)
            local activeSession = controller.getActiveSession(arg1)
            if activeSession ~= nil then
                return (activeSession.getDraft(arg1))
            end

            return nil
        end)
    end, { controller })
    local var9 = useSignalState(var8)

    local var10 = useRef(false)
    local var11 = useRef(false)
    local activeHandle, var13 = useState(nil)

    local var14, var15 = useState({})
    useEffect(function()
        if var4 == nil or timeLength <= 0 then
            return
        end

        local captureVideoContent = getCaptureVideoContent(var4)
        if captureVideoContent == nil and typeof(var4) ~= "table" then
            local success, result = pcall(Content.fromObject, var4)
            if success then
                captureVideoContent = result
            end
        end

        if captureVideoContent ~= nil then
            sampleVideoFrames(captureVideoContent, timeLength, var15)
        end
    end, { var4, timeLength })

    local var16 = useCallback(function(arg1)
        var10.current = playback.getIsPlaying(false)
        var11.current = playback.getIsMuted(false)
        playback.setMuted(true)
        playback.pause()
        var13(arg1)
    end, { playback })

    local var17 = useCallback(function()
        if var10.current then
            playback.play()
        end
        if not var11.current then
            playback.setMuted(false)
        end
        var10.current = false
        var11.current = false
        var13(nil)
    end, { playback })

    local var18 = useCallback(function(num1: number?, num2: number?)
        local activeSession = controller.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        local timeLength = playback.getTimeLength(false)
        local var18 = num1 or draft and draft.startTime or 0
        if not num2 then
            if draft then
                num2 = draft.endTime or timeLength
            else
                num2 = timeLength
            end
        end

        activeSession.update({ startTime = math.clamp(var18, 0, timeLength), endTime = math.clamp(num2, 0, timeLength) })

        playback.seek(0)
    end, { controller, playback })

    local var19 = useCallback(function(num1: number)
        playback.seek(num1 * playback.getDuration(false))
    end, { playback })

    local var20 = useTrimDragController(true, var17, var16, var18, var19, var9, timeLength)

    local dragContainerRef = var20.dragContainerRef
    local leftHandleRef = var20.leftHandleRef
    local rightHandleRef = var20.rightHandleRef
    local scrubberDisplayRef = var20.scrubberDisplayRef
    local scrubberRef = var20.scrubberRef
    local segmentRef = var20.segmentRef
    local leftHandlePosition = var20.leftHandlePosition
    local rightHandlePosition = var20.rightHandlePosition

    local onActivated = useCallback(function()
        controller.discardActiveTool()
    end, { controller })

    local var5 = useCallback(function()
        controller.commitActiveTool()
    end, { controller })

    local var12 = useCallback(function()
        playback.toggle()
    end, { playback })

    local var21 = useCallback(function()
        playback.toggleMute()
    end, { playback })

    local var25 = useMemo(function()
        return Signals.createComputed(function(arg1): number
            local duration = playback.getDuration(arg1)
            if duration <= 0 then
                return 0
            end
            return math.clamp(playback.getPosition(arg1) / duration, 0, 1)
        end)
    end, { playback })
    local var26 = useSignalBinding(var25)

    local var27 = useMemo(function()
        return Signals.createComputed(function(arg1): string
            local format = string.format
            local getPosition = playback.getPosition
            return `{format("%.1f", math.max(0, getPosition(arg1)))} / {string.format("%.1f", playback.getDuration(arg1))}`
        end)
    end, { playback })
    local var28 = useSignalBinding(var27)

    local var29 = useMemo(function()
        local result = ({})
        for i = 1, math.floor(timeLength) do
            local var29 = var14[i]
            local str1 = "frame_" .. i
            local createElement = React.createElement
            local var30 = View

            local tbl2 = {
                content = React.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    ImageContent = var29 and var29.Image,
                    ScaleType = Enum.ScaleType.Crop
                })
            }
            result[str1] = createElement(var30, { tag = "shrink size-full-full bg-system-neutral" }, tbl2)
        end

        return result
    end, { timeLength, var14 })

    local createElement = React.createElement
    local var30 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col align-x-center align-y-bottom gap-large position-bottom-center anchor-bottom-center size-full-0 auto-y",
        padding = {
            top = UDim.new(0, var2.Padding.Small),
            bottom = UDim.new(0, math.max(var1.bottom, var2.Padding.Small)),
            left = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            right = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }
    }

    local tbl3 = {
        Nav = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row flex-x-between align-x-center align-y-center gap-small size-full-0 auto-y"
            },
            {
                BackButton = React.createElement(Button, {
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 1,
                    text = var3.GeneralCtaBack,
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = onActivated,
                    size = Foundation.Enums.InputSize.Medium
                }),
                DoneButton = React.createElement(Button, {
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 2,
                    text = var3.GeneralCtaDone,
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = var5,
                    size = Foundation.Enums.InputSize.Medium
                })
            }
        ),
        Trimmer = React.createElement(View, {
            LayoutOrder = 2,
            tag = "size-full-1000 padding-x-small",
            ZIndex = 2
        }, {
            PaddedContainer = React.createElement(
                View,
                { ref = dragContainerRef, tag = "size-full-full padding-x-medium", ZIndex = 2 },
                {
                    TrimmerBar = React.createElement(View, { tag = "size-full" }, {
                        TrimTooltip = React.createElement(TrimTooltip, {
                            activeHandle = activeHandle,
                            leftHandlePosition = leftHandlePosition,
                            rightHandlePosition = rightHandlePosition,
                            timeLength = timeLength
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
                        Outline = React.createElement(View, {
                            Position = leftHandlePosition:map(function(xScale: number): UDim2
                                return UDim2.fromScale(xScale, 0.5)
                            end),
                            Size = React.joinBindings({ leftHandlePosition = leftHandlePosition, rightHandlePosition = rightHandlePosition }):map(
                                function(tbl3): UDim2
                                    return UDim2.fromScale(tbl3.rightHandlePosition - tbl3.leftHandlePosition, 1)
                                end
                            ),
                            tag = "anchor-center-left",
                            ZIndex = 2,
                            stroke = {
                                Color = var2.Color.System.Contrast.Color3,
                                Transparency = var2.Color.System.Contrast.Transparency,
                                Thickness = var2.Stroke.Thicker
                            }
                        }, {
                            Scrubber = React.createElement(View, {
                                ref = scrubberDisplayRef,
                                Visible = not activeHandle or activeHandle == DragHandle2.Scrubber,
                                tag = "anchor-center-center size-100-1400 radius-circle bg-system-contrast",
                                Position = var26:map(function(xScale: number): UDim2
                                    return UDim2.fromScale(xScale, 0.5)
                                end)
                            }, {
                                DragDetector = React.createElement("UIDragDetector", {
                                    DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
                                    ref = scrubberRef,
                                    ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale
                                })
                            }),
                            DragDetector = React.createElement("UIDragDetector", {
                                DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
                                ref = segmentRef,
                                ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale
                            })
                        }),
                        ShadowBlockLeft = React.createElement(View, {
                            backgroundStyle = var2.Color.Extended.Black.Black_50,
                            Size = leftHandlePosition:map(function(xScale: number): UDim2
                                return UDim2.fromScale(xScale, 1)
                            end),
                            tag = "position-center-left anchor-center-left",
                            ZIndex = 0
                        }),
                        ShadowBlockRight = React.createElement(View, {
                            backgroundStyle = var2.Color.Extended.Black.Black_50,
                            Size = rightHandlePosition:map(function(arg1): UDim2
                                return UDim2.fromScale(1 - arg1, 1)
                            end),
                            tag = "position-center-right anchor-center-right",
                            ZIndex = 0
                        })
                    })
                }
            ),
            Timeline = React.createElement(View, {
                tag = "size-full-full radius-medium bg-surface-100",
                ZIndex = 1,
                stroke = {
                    Color = var2.Color.Surface.Surface_100.Color3,
                    Transparency = var2.Color.Surface.Surface_100.Transparency,
                    Thickness = var2.Stroke.Thicker
                }
            }, {
                TimelineBar = React.createElement(View, {
                    layout = {
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, var2.Size.Size_50),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    },
                    tag = "size-full-full padding-x-medium"
                }, var29)
            })
        }),
        VideoControls = 0
    }

    local createElement2 = React.createElement
    local var31 = View
    local tbl4 = {
        LayoutOrder = 3,
        tag = "row flex-x-between align-x-center align-y-center gap-small size-full-0 auto-y"
    }

    local tbl5 = {
        PlaybackToggle = React.createElement(IconButton, {
            LayoutOrder = 1,
            icon = if var6 then PauseLarge else PlayLarge,
            onActivated = var12,
            size = Foundation.Enums.InputSize.Medium
        }),
        DurationDisplay = React.createElement(
            FoundationText,
            { LayoutOrder = 2, tag = "auto-xy text-label-medium content-default", Text = var28 }
        ),
        MuteToggle = React.createElement(IconButton, {
            LayoutOrder = 3,
            icon = if var7 then SpeakerSlash else Speaker,
            onActivated = var21,
            size = Foundation.Enums.InputSize.Medium
        })
    }
    tbl3.VideoControls = createElement2(var31, tbl4, tbl5)
    return createElement(var30, tbl2, tbl3)
end
