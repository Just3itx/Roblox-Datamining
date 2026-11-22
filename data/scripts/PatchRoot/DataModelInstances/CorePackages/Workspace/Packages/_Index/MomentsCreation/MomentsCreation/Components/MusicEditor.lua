-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local Button = Foundation.Button
local Loading = Foundation.Loading
local View = Foundation.View

local EditorTopNav = require(MomentsCreation.Components.EditorTopNav)
local GradientBackdrop = MomentsCommon.Components.GradientBackdrop
local MusicPreviewItem = require(MomentsCreation.Components.MusicPreviewItem)
local Waveform = require(MomentsCreation.Components.Waveform)

local useCallback = React.useCallback
local useContext = React.useContext
local useEffect = React.useEffect
local useMemo = React.useMemo
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useToggleState = MomentsCommon.Hooks.useToggleState
local useTokens = Foundation.Hooks.useTokens
local useSignalBinding = SignalsReact.useSignalBinding

local useMusicEditorController = require(MomentsCreation.Hooks.useMusicEditorController)
local useMusicInfo = require(MomentsCreation.Hooks.useMusicInfo)

local Constants = require(MomentsCreation.Constants)
local DockedEditorContext = require(MomentsCreation.Contexts.DockedEditorContext)
local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)
local FFlagMomentsCreationMusicEditorRedesign = require(MomentsCreation.Flags.FFlagMomentsCreationMusicEditorRedesign)
local FFlagMomentsCreationStartAudioOnLoad = require(MomentsCreation.Flags.FFlagMomentsCreationStartAudioOnLoad)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local SegmentSelectorWidth = Constants.AudioWaveform.SegmentSelectorWidth

local uDim2 = UDim2.new(0, 48, 1, 0)

local function MusicEditor(tbl1)
    local playback = tbl1.controller.preview.playback
    local var1 = useTokens()
    local var2 = useDeviceInsets()
    local var3 = useCreationFlowStrings()

    local var4 = useToggleState(false)
    local var5 = useToggleState(false)
    local var6 = React.useRef(nil)

    local var7 = useMusicInfo(tbl1.musicEdit.assetId)
    local var8 = if var7 == nil then 0 elseif var7.Duration == nil then 0 else var7.Duration

    local videoDuration, var10 = React.useState(playback.getDuration(false))
    useEffect(function()
        return Signals.createEffect(function(arg1)
            var10(playback.getDuration(arg1))
        end)
    end, { playback })

    local var11 = useCallback(function()
        playback.setMuted(true)
        playback.seek(0)
        playback.pause()
        var5.enable()
    end, { playback, var5.enable })

    local var12 = useCallback(function()
        playback.setMuted(false)
        playback.play()
        var5.disable()
    end, { playback, var5.disable })

    local onWaveformReady = useCallback(function()
        if FFlagMomentsCreationStartAudioOnLoad and var6.current ~= tbl1.musicEdit.assetId then
            var6.current = tbl1.musicEdit.assetId
            playback.seek(0)
        end
        playback.setMuted(false)
        playback.play()
        var4.enable()
    end, { playback, tbl1.musicEdit.assetId, var4.enable })

    useEffect(function()
        var4.disable()
    end, { tbl1.musicEdit.assetId, var4.disable })

    local var14 = useMusicEditorController(var4.enabled, var12, var11, tbl1.onStartTimeChanged, tbl1.musicEdit, var8)
    local var15

    if FFlagMomentsCreationMusicEditorRedesign then
        local var16 = useContext(DockedEditorContext)

        var15 = useCallback(function(arg1)
            var16.setDockedEditorHeight(arg1.AbsoluteSize.Y)
        end, { var16 })

        useEffect(function()
            return function()
                var16.setDockedEditorHeight(0)
            end
        end, { var16 })
    else
        var15 = nil
    end

    local waveformRef = var14.waveformRef
    local waveformPosition = var14.waveformPosition
    local waveformDisplayRef = var14.waveformDisplayRef

    local var16 = useMemo(function()
        return Signals.createComputed(function(arg1): number
            local duration = playback.getDuration(arg1)
            if duration <= 0 then
                return 0
            end
            return math.clamp(playback.getPosition(arg1) / duration, 0, 1)
        end)
    end, { playback })
    local var17 = useSignalBinding(var16)
    local color3 = if FFlagMomentsCreationMusicEditorRedesign then var1.Color.Surface.Surface_0.Color3 else var1.Color.Surface.Surface_100.Color3
    local createElement = React.createElement
    local var18 = View
    local tbl2 = { LayoutOrder = 2, tag = "size-full-1600" }

    local tbl3 = {
        Timeline = React.createElement(View, { tag = "size-full-full clip", ZIndex = 1 }, {
            DragDetector = React.createElement("UIDragDetector", {
                CursorIcon = "",
                DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
                ref = waveformRef,
                ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset
            }),
            LeftGradientBackdrop = React.createElement(
                GradientBackdrop,
                {
                    color3 = color3,
                    rotation = 0,
                    size = uDim2,
                    startingTransparency = 0,
                    zIndex = 2
                }
            ),
            RightGradientBackdrop = React.createElement(GradientBackdrop, {
                anchorPoint = Vector2.new(1, 0),
                color3 = color3,
                position = UDim2.fromScale(1, 0),
                rotation = 180,
                size = uDim2,
                startingTransparency = 0,
                zIndex = 2
            }),
            WaveformContainer = React.createElement(
                View,
                {
                    tag = "position-center-center anchor-center-center radius-medium",
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
                        videoDuration = videoDuration,
                        zIndex = 1
                    })
                }
            )
        }),
        SegmentOutline = React.createElement(View, {
            tag = "position-center-center anchor-center-center radius-medium",
            Size = UDim2.new(0, SegmentSelectorWidth, 1, -var1.Size.Size_100),
            ZIndex = 2,
            stroke = {
                Color = var1.Color.System.Contrast.Color3,
                Transparency = var1.Color.System.Contrast.Transparency,
                Thickness = var1.Stroke.Thick
            }
        }, {
            Scrubber = if var4.enabled and not var5.enabled then React.createElement(View, {
                tag = "anchor-center-center size-100-1900 radius-circle bg-system-contrast",
                Position = var17:map(function(xScale: number): UDim2
                    return UDim2.fromScale(xScale, 0.5)
                end)
            }) else nil,
            LoadingIndicator = if var4.enabled then nil else React.createElement(
                Loading,
                {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    size = Foundation.Enums.IconSize.Medium
                }
            )
        })
    }

    local segmentSelector = createElement(var18, tbl2, tbl3)

    local musicPreviewItemWrapper = React.createElement(View, {
        tag = "size-full-0 auto-y",
        LayoutOrder = 3,
        padding = FFlagMomentsCreationMusicEditorRedesign
            and {
                left = UDim.new(0, var1.Padding.Large),
                right = UDim.new(0, var1.Padding.Large)
            }
            or nil
    }, {
        MusicPreviewItem = React.createElement(MusicPreviewItem, { layoutOrder = 1, musicAssetId = tbl1.musicEdit.assetId, isPreviewing = false })
    })

    if FFlagMomentsCreationMusicEditorRedesign then
        local createElement2 = React.createElement
        local var19 = View

        local tbl4 = {
            TopNav = React.createElement(EditorTopNav, {
                onBack = tbl1.onBack,
                onSave = tbl1.onDone,
                backTestId = "--moments-creation-view-musiceditor-back",
                saveTestId = "--moments-creation-button-musiceditor-save"
            }),
            DockedPanel = React.createElement(
                View,
                {
                    tag = "col align-x-center align-y-top gap-large position-bottom-center anchor-bottom-center size-full-0 auto-y radius-large bg-surface-0",
                    onAbsoluteSizeChanged = var15,
                    padding = {
                        top = UDim.new(0, var1.Padding.XLarge),
                        bottom = UDim.new(0, math.max(var2.bottom, var1.Padding.Small)),
                        left = UDim.new(0, var2.left),
                        right = UDim.new(0, var2.right)
                    }
                },
                {
                    SegmentSelector = segmentSelector,
                    MusicPreviewItemWrapper = musicPreviewItemWrapper
                }
            )
        }
        return createElement2(var19, { tag = "size-full", ZIndex = 5 }, tbl4)
    end

    return React.createElement(View, {
        tag = "col align-x-center align-y-top gap-large position-bottom-center anchor-bottom-center size-full-0 auto-y radius-medium bg-surface-100",
        ZIndex = 5,
        padding = {
            top = UDim.new(0, var1.Padding.Small),
            bottom = UDim.new(0, math.max(var2.bottom, var1.Padding.Small)),
            left = UDim.new(0, math.max(var2.left, var1.Padding.Large)),
            right = UDim.new(0, math.max(var2.right, var1.Padding.Large))
        }
    }, {
        Nav = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row flex-x-between align-x-center align-y-center gap-small size-full-0 auto-y"
            },
            {
                BackButton = React.createElement(Button, {
                    ZIndex = 6,
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 1,
                    text = var3.GeneralCtaBack,
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = tbl1.onBack,
                    size = Foundation.Enums.InputSize.Medium
                }),
                DoneButton = React.createElement(Button, {
                    ZIndex = 6,
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 2,
                    text = var3.GeneralCtaDone,
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = tbl1.onDone,
                    size = Foundation.Enums.InputSize.Medium
                })
            }
        ),
        SegmentSelector = segmentSelector,
        MusicPreviewItemWrapper = musicPreviewItemWrapper
    })
end

return MusicEditor
