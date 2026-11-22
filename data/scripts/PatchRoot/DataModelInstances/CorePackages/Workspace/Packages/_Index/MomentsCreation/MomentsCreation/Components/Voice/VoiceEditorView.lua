-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local Button = Foundation.Button
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local TextArea = Foundation.TextArea
local View = Foundation.View

local InputSize = Foundation.Enums.InputSize
local InputVariant = Foundation.Enums.InputVariant
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local AudioWaveformOverlay = require(MomentsCreation.Components.Voice.AudioWaveformOverlay)
local VideoTimeline = require(MomentsCreation.Components.VideoTimeline)
local VoiceActionBar = require(MomentsCreation.Components.Voice.VoiceActionBar)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local GetFFlagMomentsTTSStartTimePositioning = require(MomentsCreation.Flags.GetFFlagMomentsTTSStartTimePositioning)
local size = if require(MomentsCreation.Flags.FFlagMomentsTTSCompactActionBar) then InputSize.Medium else InputSize.Large

local function VoiceEditorView(tbl1)
    local var2 = useDeviceInsets()
    local var3 = useTokens()

    local isGenerating = tbl1.isGenerating
    local isInputInvalid = tbl1.isInputInvalid

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col align-x-center align-y-top gap-xlarge size-full-0 auto-y",
        padding = {
            top = UDim.new(0, var3.Padding.XLarge),
            bottom = UDim.new(0, math.max(var2.bottom, var3.Padding.XLarge)),
            left = UDim.new(0, math.max(var2.left, var3.Padding.XLarge)),
            right = UDim.new(0, math.max(var2.right, var3.Padding.XLarge))
        }
    }
    local tbl3 = {
        Timeline = React.createElement(VideoTimeline, {
            playback = tbl1.playback,
            capture = tbl1.capture,
            interactive = true,
            dragOnly = GetFFlagMomentsTTSStartTimePositioning,
            onSeek = tbl1.onTimelineSeek,
            playheadPosition = tbl1.playheadPosition,
            layoutOrder = 1
        }, {
            AudioWaveform = if tbl1.showAudioWaveform then React.createElement(AudioWaveformOverlay, {
                audioDuration = tbl1.audioDuration,
                videoDuration = tbl1.videoDuration,
                startTime = tbl1.startTime,
                dragDetectorRef = tbl1.waveformDragDetectorRef,
                isSelected = tbl1.waveformSelected,
                samples = tbl1.waveformSamples
            }) else nil
        }),
        ComposerSection = 0,
        ActionButton = 0
    }

    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = { LayoutOrder = 2, tag = "col size-full-0 auto-y" }

    local tbl5 = { InputContainer = 0, HelperRow = 0 }
    local createElement3 = React.createElement
    local var6 = View
    local tbl6 = {
        LayoutOrder = 1,
        tag = {
            ["col size-full-0 auto-y"] = tbl1.showVoiceSelector,
            ["size-full-0 auto-y"] = not tbl1.showVoiceSelector
        },
        stroke = {
            Color = if isInputInvalid then var3.Color.System.Alert.Color3 else var3.Color.Stroke.Emphasis.Color3,
            Transparency = if isInputInvalid then 0 else var3.Color.Stroke.Emphasis.Transparency,
            Thickness = var3.Stroke.Standard
        },
        cornerRadius = UDim.new(0, var3.Radius.Medium),
        onAbsoluteSizeChanged = tbl1.onComposerResize,
        ref = tbl1.composerContainerRef
    }
    local tbl7 = {
        Composer = React.createElement(TextArea, {
            LayoutOrder = 1,
            text = tbl1.text,
            width = UDim.new(1, 0),
            placeholder = tbl1.placeholderText,
            numLines = tbl1.numLines,
            label = "",
            size = InputSize.Medium,
            variant = InputVariant.Utility,
            onChanged = tbl1.onTextChanged,
            onFocusLost = tbl1.onTextBoxFocusLost,
            isDisabled = isGenerating,
            textBoxRef = tbl1.textBoxRef
        }),
        VoicePill = 0
    }
    local element

    if tbl1.showVoiceSelector then
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "auto-xy",
            padding = {
                top = UDim.new(0, var3.Padding.Small),
                bottom = UDim.new(0, var3.Padding.Small),
                left = UDim.new(0, var3.Padding.Small),
                right = UDim.new(0, var3.Padding.Small)
            }
        }, {
            Pill = React.createElement(View, {
                ref = tbl1.voiceSelectorButtonRef,
                onActivated = tbl1.onOpenVoiceSelector,
                stateLayer = {
                    affordance = StateLayerAffordance.Background
                },
                tag = "row align-y-center gap-small auto-xy radius-circle bg-surface-300",
                padding = {
                    top = UDim.new(0, var3.Padding.Small),
                    bottom = UDim.new(0, var3.Padding.Small),
                    left = UDim.new(0, var3.Padding.Medium),
                    right = UDim.new(0, var3.Padding.Medium)
                }
            }, {
                Label = React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 1,
                        tag = "auto-xy text-label-small content-emphasis",
                        Text = tbl1.selectedVoiceName or ""
                    }
                ),
                Chevron = React.createElement(Icon, {
                    LayoutOrder = 2,
                    name = BuilderIcons.Icon.ChevronSmallDown,
                    size = Foundation.Enums.IconSize.Small,
                    style = var3.Color.Content.Default
                })
            })
        })
    else
        element = nil
    end

    tbl7.VoicePill = element
    tbl5.InputContainer = createElement3(var6, tbl6, tbl7)

    tbl5.HelperRow = React.createElement(View, {
        LayoutOrder = 2,
        tag = "row flex-x-between align-y-center size-full-0 auto-y",
        padding = {
            top = UDim.new(0, var3.Gap.Small)
        }
    }, {
        HelperText = React.createElement(FoundationText, {
            LayoutOrder = 1,
            tag = {
                ["auto-xy text-caption-small content-alert"] = isInputInvalid,
                ["auto-xy text-caption-small content-default"] = not isInputInvalid
            },
            Text = tbl1.helperText
        }),
        CharCount = React.createElement(FoundationText, {
            LayoutOrder = 2,
            tag = {
                ["auto-xy text-caption-small content-alert"] = tbl1.isOverLimit,
                ["auto-xy text-caption-small content-default"] = not tbl1.isOverLimit
            },
            Text = `{tbl1.charCount} / {tbl1.maxChars}`
        })
    })
    tbl3.ComposerSection = createElement2(var5, tbl4, tbl5)
    local element2

    if tbl1.showDelete then
        element2 = React.createElement(VoiceActionBar, {
            layoutOrder = 3,
            onDelete = tbl1.onDelete,
            primaryRef = tbl1.createButtonRef,
            deleteRef = tbl1.deleteButtonRef,
            primaryText = if tbl1.showSave then tbl1.saveText elseif isGenerating then "" else tbl1.createText,
            primaryOnActivated = if tbl1.showSave then tbl1.onSave else tbl1.onCreateVoiceover,
            primaryIsDisabled = not tbl1.showSave and not (tbl1.canGenerate or isGenerating),
            primaryIsLoading = not tbl1.showSave and isGenerating,
            primaryVariant = if tbl1.showSave or tbl1.canGenerate or isGenerating then Foundation.Enums.ButtonVariant.Emphasis else Foundation.Enums.ButtonVariant.Standard
        })
    elseif tbl1.showSave then
        element2 = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = 3,
            onActivated = tbl1.onSave,
            size = size,
            text = tbl1.saveText,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            width = UDim.new(1, 0)
        })
    else
        local createElement4 = React.createElement
        local str1 = "Frame"
        local tbl8 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 3,
            Size = UDim2.new(1, 0, 0, 0),
            ref = tbl1.createButtonRef
        }
        local tbl9 = {
            Button = React.createElement(Button, {
                fillBehavior = Foundation.Enums.FillBehavior.Fill,
                isDisabled = not (tbl1.canGenerate or isGenerating),
                isLoading = isGenerating,
                onActivated = tbl1.onCreateVoiceover,
                size = size,
                text = if isGenerating then "" else tbl1.createText,
                variant = if tbl1.canGenerate or isGenerating then Foundation.Enums.ButtonVariant.Emphasis else Foundation.Enums.ButtonVariant.Standard,
                width = UDim.new(1, 0)
            })
        }
        element2 = createElement4(str1, tbl8, tbl9)
    end

    tbl3.ActionButton = element2
    return createElement(var4, tbl2, tbl3)
end

return VoiceEditorView
