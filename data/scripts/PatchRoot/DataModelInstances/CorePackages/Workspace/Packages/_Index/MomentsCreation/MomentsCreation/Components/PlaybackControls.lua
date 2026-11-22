-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:19Z
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

local GradientBackdrop = MomentsCommon.Components.GradientBackdrop

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens
local useSignalBinding = SignalsReact.useSignalBinding
local useSignalState = SignalsReact.useSignalState

local getFormatTime = require(MomentsCreation.Utils.getFormatTime)

local function PlaybackControls(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local playback = tbl1.preview.playback

    local size, var4 = React.useBinding(UDim2.fromScale(1, 0))
    local var5 = React.useRef(false)

    local var6 = React.useMemo(function()
        return Signals.createComputed(function(arg1): number
            local duration = playback.getDuration(arg1)
            if duration <= 0 then
                return 0
            end
            return math.clamp(playback.getPosition(arg1) / duration, 0, 1)
        end)
    end, { playback })
    local value = useSignalBinding(var6)

    local var8 = React.useMemo(function()
        return Signals.createComputed(function(arg1): string
            return `{getFormatTime(playback.getPosition(arg1))} / {getFormatTime(playback.getDuration(arg1))}`
        end)
    end, { playback })
    local var9 = useSignalBinding(var8)

    local var10 = useSignalState(playback.getIsPlaying)
    local var11 = useSignalState(playback.getIsMuted)

    local onDragStarted = React.useCallback(function()
        if playback.getIsPlaying(false) then
            var5.current = true
            playback.toggle()
        end
    end, { playback })

    local onDragEnded = React.useCallback(function()
        if var5.current and not playback.getIsPlaying(false) then
            playback.toggle()
        end
        var5.current = false
    end, { playback })

    local onSeek = tbl1.onSeek
    local onValueChanged = React.useCallback(function(num1: number)
        local var14 = num1 * playback.getDuration(false)
        playback.seek(var14)
        if onSeek then
            onSeek(var14)
        end
    end, { playback, onSeek })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var4(UDim2.new(0, arg1.AbsoluteSize.X, 1, 0))
    end, {})

    local onActivated = React.useCallback(function()
        playback.toggle()
    end, { playback })

    local var3 = React.useCallback(function()
        playback.toggleMute()
    end, { playback })

    local createElement = React.createElement
    local var18 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "size-full-0 auto-y"
    }
    local tbl3 = {
        GradientBackdrop = React.createElement(GradientBackdrop, { color3 = var2.Color.Common.Scrim.Color3, rotation = 270, size = size }),
        Controls = 0
    }

    local createElement2 = React.createElement
    local var19 = View
    local tbl4 = {
        LayoutOrder = 1,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        tag = "col gap-xxsmall size-full-0 auto-y",
        padding = {
            bottom = UDim.new(0, var2.Padding.Medium),
            left = UDim.new(0, math.max(var1.left, var2.Padding.Large)),
            right = UDim.new(0, math.max(var1.right, var2.Padding.Large))
        }
    }
    local tbl5 = {
        Slider = React.createElement(Slider, {
            value = value,
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
    local var20 = View
    local tbl6 = { tag = "size-full-0 auto-y", LayoutOrder = 2 }

    local tbl7 = { LeftControlButtons = 0, DurationDisplay = 0, RightControlButtons = 0 }
    local createElement4 = React.createElement
    local var21 = View
    local tbl8 = {
        tag = "row gap-xsmall position-top-left anchor-top-left auto-xy",
        LayoutOrder = 1
    }

    local tbl9 = {
        PlaybackToggle = React.createElement(IconButton, {
            icon = if var10 then PauseLarge else PlayLarge,
            onActivated = onActivated,
            size = Foundation.Enums.InputSize.Small,
            LayoutOrder = 1
        }),
        MuteToggle = React.createElement(IconButton, {
            icon = if var11 then SpeakerSlash else Speaker,
            onActivated = var3,
            size = Foundation.Enums.InputSize.Small,
            LayoutOrder = 2
        })
    }
    tbl7.LeftControlButtons = createElement4(var21, tbl8, tbl9)

    tbl7.DurationDisplay = React.createElement(FoundationText, {
        LayoutOrder = 2,
        tag = "position-center-center anchor-center-center auto-xy text-body-medium content-emphasis",
        Text = var9
    })

    local createElement5 = React.createElement
    local var22 = View
    local tbl10 = {
        tag = "row gap-xsmall position-top-right anchor-top-right auto-xy",
        LayoutOrder = 3
    }

    local tbl11 = {
        FitModeToggle = React.createElement(IconButton, {
            icon = if tbl1.isFitMode then TwoArrowsFromCenter else TwoArrowsToCenter,
            onActivated = tbl1.toggleFitMode,
            size = Foundation.Enums.InputSize.Small,
            LayoutOrder = 1
        })
    }
    tbl7.RightControlButtons = createElement5(var22, tbl10, tbl11)
    tbl5.ControlBar = createElement3(var20, tbl6, tbl7)
    tbl3.Controls = createElement2(var19, tbl4, tbl5)
    return createElement(var18, tbl2, tbl3)
end

return PlaybackControls
