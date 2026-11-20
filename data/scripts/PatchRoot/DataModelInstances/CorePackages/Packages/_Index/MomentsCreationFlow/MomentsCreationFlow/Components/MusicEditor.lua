-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Button = Foundation.Button
local Loading = Foundation.Loading
local View = Foundation.View

local GradientBackdrop = MomentsCommon.GradientBackdrop
local MusicPreviewItem = require(MomentsCreationFlow.Components.MusicPreviewItem)
local Waveform = require(MomentsCreationFlow.Components.Waveform)

local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useMusicEditorController = require(MomentsCreationFlow.Hooks.useMusicEditorController)
local useToggleState = MomentsCommon.Hooks.useToggleState
local useTokens = Foundation.Hooks.useTokens

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)

local Constants = require(MomentsCreationFlow.Constants)
local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)

local SegmentSelectorWidth = Constants.AudioWaveform.SegmentSelectorWidth

local uDim2 = UDim2.new(0, 48, 1, 0)

local function MusicEditor(tbl1)
    local var1 = useTokens()
    local var2 = useDeviceInsets()
    local var3 = React.useContext(CreationFlowContext)

    local var4 = useToggleState(false)
    local var5 = useToggleState(false)

    local var6 = useCallback(function()
        tbl1.playbackController.volume.mute()
        tbl1.playbackController.timeline.seek(0)
        tbl1.playbackController.playback.pause()
        var5.enable()
    end, { tbl1.playbackController.timeline.seek })

    local var7 = useCallback(function()
        tbl1.playbackController.volume.unmute()
        tbl1.playbackController.playback.play()
        var5.disable()
    end, {})

    local onWaveformReady = useCallback(function()
        tbl1.playbackController.volume.unmute()
        tbl1.playbackController.playback.play()
        var4.enable()
    end, {})

    React.useEffect(function()
        var4.disable()
    end, { tbl1.musicEdit.assetId })

    local var9 = useMusicEditorController(
        var4.enabled,
        var7,
        var6,
        tbl1.onStartTimeChanged,
        tbl1.musicEdit,
        tbl1.playbackController.audio.timeLength
    )

    local waveformRef = var9.waveformRef
    local waveformPosition = var9.waveformPosition
    local waveformDisplayRef = var9.waveformDisplayRef

    local createElement = React.createElement
    local var10 = View
    local tbl2 = {
        tag = "auto-y align-x-center align-y-top anchor-bottom-center bg-surface-100 col gap-large position-bottom-center radius-medium size-full-0",
        ZIndex = 5
    }

    local tbl3 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var1.Padding.Small),
            PaddingBottom = UDim.new(0, math.max(var2.bottom, var1.Padding.Small)),
            PaddingLeft = UDim.new(0, math.max(var2.left, var1.Padding.Large)),
            PaddingRight = UDim.new(0, math.max(var2.right, var1.Padding.Large))
        }),
        Nav = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "align-x-center align-y-center auto-y gap-small row size-full-0 flex-x-between"
            },
            {
                BackButton = React.createElement(Button, {
                    ZIndex = 6,
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 1,
                    text = var3.getLocalization(CreationFlowLocalization.GeneralCtaBack),
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = tbl1.onBack,
                    size = Foundation.Enums.InputSize.Medium
                }),
                DoneButton = React.createElement(Button, {
                    ZIndex = 6,
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 2,
                    text = var3.getLocalization(CreationFlowLocalization.GeneralCtaDone),
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = tbl1.onDone,
                    size = Foundation.Enums.InputSize.Medium
                })
            }
        ),
        SegmentSelector = 0,
        MusicPreviewItemWrapper = 0
    }

    local createElement2 = React.createElement
    local var11 = View
    local tbl4 = { LayoutOrder = 2, tag = "size-full-1600" }

    local tbl5 = {
        Timeline = React.createElement(View, { tag = "clip size-full-full", ZIndex = 1 }, {
            DragDetector = React.createElement("UIDragDetector", {
                DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
                ref = waveformRef,
                ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset
            }),
            LeftGradientBackdrop = React.createElement(
                GradientBackdrop,
                {
                    color3 = var1.Color.Surface.Surface_100.Color3,
                    rotation = 0,
                    size = uDim2,
                    startingTransparency = 0,
                    zIndex = 2
                }
            ),
            RightGradientBackdrop = React.createElement(GradientBackdrop, {
                anchorPoint = Vector2.new(1, 0),
                color3 = var1.Color.Surface.Surface_100.Color3,
                position = UDim2.fromScale(1, 0),
                rotation = 180,
                size = uDim2,
                startingTransparency = 0,
                zIndex = 2
            }),
            WaveformContainer = React.createElement(
                View,
                {
                    tag = "anchor-center-center position-center-center radius-medium",
                    Size = UDim2.new(0, SegmentSelectorWidth, 1, 0)
                },
                {
                    WaveformDisplay = React.createElement(Waveform, {
                        audioAssetId = tbl1.musicEdit.assetId,
                        position = waveformPosition:map(function(xScale: number): UDim2
                            return UDim2.fromScale(xScale, 0.5)
                        end),
                        onWaveformReady = onWaveformReady,
                        ref = waveformDisplayRef,
                        videoDuration = tbl1.playbackController.timeline.duration,
                        zIndex = 1
                    })
                }
            )
        }),
        SegmentOutline = React.createElement(View, {
            tag = "anchor-center-center position-center-center radius-medium",
            Size = UDim2.new(0, SegmentSelectorWidth, 1, -var1.Size.Size_100),
            ZIndex = 2
        }, {
            Scrubber = if var4.enabled and not var5.enabled then React.createElement(View, {
                tag = "anchor-center-center bg-system-contrast size-100-1900 radius-circle",
                Position = UDim2.fromScale(tbl1.playbackController.timeline.elapsed / tbl1.playbackController.timeline.duration, 0.5)
            }) else nil,
            LoadingIndicator = if var4.enabled then nil else React.createElement(
                Loading,
                {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    size = Foundation.Enums.IconSize.Medium
                }
            ),
            OutlineStroke = React.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = var1.Color.System.Contrast.Color3,
                Transparency = var1.Color.System.Contrast.Transparency,
                Thickness = var1.Stroke.Thick
            })
        })
    }

    tbl3.SegmentSelector = createElement2(var11, tbl4, tbl5)

    tbl3.MusicPreviewItemWrapper = React.createElement(
        View,
        { tag = "auto-y size-full-0", LayoutOrder = 3 },
        {
            MusicPreviewItem = React.createElement(MusicPreviewItem, { musicAssetId = tbl1.musicEdit.assetId })
        }
    )
    return createElement(var10, tbl2, tbl3)
end

return MusicEditor
