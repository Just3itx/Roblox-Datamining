-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

local BuilderIcons = require(MomentsCreationFlowParent.BuilderIcons)
local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local IconButton = Foundation.IconButton
local Slider = Foundation.Slider
local FoundationText = Foundation.Text
local View = Foundation.View

local PlayLarge = BuilderIcons.Icon.PlayLarge
local PauseLarge = BuilderIcons.Icon.PauseLarge
local Speaker = BuilderIcons.Icon.Speaker
local SpeakerSlash = BuilderIcons.Icon.SpeakerSlash
local TwoArrowsFromCenter = BuilderIcons.Icon.TwoArrowsFromCenter
local TwoArrowsToCenter = BuilderIcons.Icon.TwoArrowsToCenter

local GradientBackdrop = MomentsCommon.GradientBackdrop

local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local getFormatTime = MomentsCommon.Utils.getFormatTime

local function PlaybackControls(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()

    local size, var4 = React.useBinding(UDim2.fromScale(1, 0))
    local var5 = React.useRef(false)

    local onDragStarted = React.useCallback(function()
        if tbl1.playbackController.playback.isPlaying then
            var5.current = true
        end
        tbl1.playbackController.playback.pause()
    end, { tbl1.playbackController.playback.isPlaying })

    local onDragEnded = React.useCallback(function()
        if var5.current then
            tbl1.playbackController.playback.play()
        end
        var5.current = false
    end, {})

    local onValueChanged = React.useCallback(function(num1: number)
        tbl1.playbackController.timeline.seek(num1 * tbl1.playbackController.timeline.duration)
    end, { tbl1.playbackController.timeline.duration, tbl1.playbackController.timeline.seek })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var4(UDim2.new(0, arg1.AbsoluteSize.X, 1, 0))
    end, {})

    local onActivated = useCallback(function()
        tbl1.playbackController.playback.toggle()
    end, { tbl1.playbackController })

    local var3 = useCallback(function()
        tbl1.playbackController.volume.toggle()
    end, { tbl1.playbackController })

    local createElement = React.createElement
    local var12 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "auto-y size-full-0"
    }
    local tbl3 = {
        GradientBackdrop = React.createElement(GradientBackdrop, { color3 = var2.Color.Common.Scrim.Color3, rotation = 270, size = size }),
        Controls = 0
    }

    local createElement2 = React.createElement
    local var13 = View
    local tbl4 = {
        LayoutOrder = 1,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        tag = "auto-y col gap-xxsmall size-full-0"
    }
    local tbl5 = {
        Padding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, var2.Padding.Medium),
            PaddingLeft = UDim.new(0, math.max(var1.left, var2.Padding.Large)),
            PaddingRight = UDim.new(0, math.max(var1.right, var2.Padding.Large))
        }),
        Slider = React.createElement(Slider, {
            value = tbl1.playbackController.timeline.elapsed / tbl1.playbackController.timeline.duration,
            size = Foundation.Enums.InputSize.XSmall,
            knobVisibility = Foundation.Enums.Visibility.None,
            variant = Foundation.Enums.SliderVariant.Standard,
            onValueChanged = onValueChanged,
            onDragStarted = onDragStarted,
            onDragEnded = onDragEnded,
            LayoutOrder = 1
        }),
        ControlBar = 0
    }

    local createElement3 = React.createElement
    local var14 = View
    local tbl6 = { tag = "auto-y size-full-0", LayoutOrder = 2 }

    local tbl7 = {
        LeftControlButtons = React.createElement(
            View,
            { tag = "auto-xy row gap-xsmall anchor-top-left position-top-left", LayoutOrder = 1 },
            {
                PlaybackToggle = React.createElement(IconButton, {
                    icon = tbl1.playbackController.playback.isPlaying and PauseLarge or PlayLarge,
                    onActivated = onActivated,
                    size = Foundation.Enums.InputSize.Small,
                    LayoutOrder = 1
                }),
                MuteToggle = React.createElement(IconButton, {
                    icon = tbl1.playbackController.volume.isMuted and SpeakerSlash or Speaker,
                    onActivated = var3,
                    size = Foundation.Enums.InputSize.Small,
                    LayoutOrder = 2
                })
            }
        ),
        DurationDisplay = React.createElement(FoundationText, {
            LayoutOrder = 2,
            tag = "auto-xy anchor-center-center position-center-center text-body-medium content-emphasis",
            Text = `{getFormatTime(tbl1.playbackController.timeline.elapsed)} / {getFormatTime(tbl1.playbackController.timeline.duration)}`
        }),
        RightControlButtons = 0
    }

    local createElement4 = React.createElement
    local var15 = View
    local tbl8 = {
        tag = "auto-xy row gap-xsmall anchor-top-right position-top-right",
        LayoutOrder = 3
    }

    local tbl9 = {
        FitModeToggle = React.createElement(IconButton, {
            icon = if tbl1.isFitMode then TwoArrowsFromCenter else TwoArrowsToCenter,
            onActivated = tbl1.toggleFitMode,
            size = Foundation.Enums.InputSize.Small,
            LayoutOrder = 1
        })
    }
    tbl7.RightControlButtons = createElement4(var15, tbl8, tbl9)
    tbl5.ControlBar = createElement3(var14, tbl6, tbl7)
    tbl3.Controls = createElement2(var13, tbl4, tbl5)
    return createElement(var12, tbl2, tbl3)
end

return PlaybackControls
