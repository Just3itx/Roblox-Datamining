-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local Foundation = require(PeopleReactViewParent.Foundation)
local PeopleService = require(PeopleReactViewParent.PeopleService)
local Signals = require(PeopleReactViewParent.Signals)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)
local useLocalization = require(PeopleReactViewParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local Popover = Foundation.Popover
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign
local Radius = Foundation.Enums.Radius
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState

local FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted = require(PeopleReactView.Flags.FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted)
local FFlagVoiceChatVolumePerUserMuteVolumeSync = require(PeopleReactView.Flags.FFlagVoiceChatVolumePerUserMuteVolumeSync)

local FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView = PeopleService.getService("Flags").FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView
local useDismissWhenOutOfView = require(PeopleReactView.Hooks.useDismissWhenOutOfView)

local FFlagPeoplePageFlipVolumePopoverToFitViewport = PeopleService.getService("Flags").FFlagPeoplePageFlipVolumePopoverToFitViewport

local usePopoverSideToFitScrollingViewport = require(PeopleReactView.Hooks.usePopoverSideToFitScrollingViewport)

local FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry = PeopleService.getService("Flags").FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local VOICE_VOLUME = PeopleService.getService("Constants").VOICE_CHAT.VOICE_VOLUME
local ENTRY_POINT = PeopleService.getService("Constants").ANALYTICS.ENTRY_POINT
local signal = Signals.createSignal(false)

local function VoiceVolumePopover(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization({ voiceChatVolume = "CoreScripts.InGameMenu.VoiceChatVolumeLower" })

    local var3 = React.useMemo(function()
        return PeopleService.getService("PeopleVoiceChatStore")
    end, {})

    local var4 = nil
    local var5 = nil
    local var6 = nil
    local var7 = nil
    if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then
        var4 = React.useMemo(function()
            return PeopleService.getService("PeopleAnalyticsManager")
        end, {})
        var5 = tbl1.entryPoint or ENTRY_POINT.PEOPLE_LIST
        local getPlayerIsLocalMuted = var3.getPlayerIsLocalMuted
        var6 = React.useCallback(function()
            if tbl1.userId and getPlayerIsLocalMuted then
                return getPlayerIsLocalMuted(tbl1.userId)(false)
            end
            return false
        end, { tbl1.userId, getPlayerIsLocalMuted })
        var7 = React.useRef(nil)
    end

    local var8 = if FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted then useSignalState(tbl1.isMutedByLocalUser or signal) else false
    local isDisabled = FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted and var8

    local xOffset = useScaledValue(260)
    local size2800 = if FFlagPeoplePageFlipVolumePopoverToFitViewport then var1.Size.Size_2800 else nil
    local var10 = React.useRef(false)

    local var11 = React.useCallback(function()
        if tbl1.userId and var3.getPlayerVoiceVolume then
            return var3.getPlayerVoiceVolume(tbl1.userId)
        end
        return VOICE_VOLUME.DEFAULT
    end, { tbl1.userId, var3 })

    local value, var13 = React.useBinding(var11())

    React.useEffect(function()
        if not (tbl1.isOpen and tbl1.userId) then
            var10.current = false
            if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry and var7 then
                var7.current = nil
            end
            return
        end

        var13(var11())
        if not var3.subscribePlayerVoiceVolume then
            return
        end

        return var3.subscribePlayerVoiceVolume(tbl1.userId, function(arg1)
            if not var10.current then
                var13(arg1)
            end
        end)
    end, {
        tbl1.isOpen,
        tbl1.userId,
        var11,
        var3
    })
    local onValueChanged = React.useCallback(function(num1: number)
        var13(num1)
        if tbl1.userId and var3.setPlayerVoiceVolume then
            var3.setPlayerVoiceVolume(tbl1.userId, num1)
        end
    end, { tbl1.userId, var3 })

    local onDragStarted = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then React.useCallback(function()
        var10.current = true
        if not var4 or not var7 or not var6 or not var5 then
            return
        end

        var7.current = {
            oldVolume = var11(),
            wasMutedAtStart = var6(),
            startTimestampMs = DateTime.now().UnixTimestampMillis
        }
        var4:trackPerUserVoiceVolumeSliderTouch(var5)
    end, {
        var11,
        var6,
        var4,
        var5,
        var7
    }) else React.useCallback(function()
        var10.current = true
    end, {})

    local onDragEnded = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then React.useCallback(function()
        var10.current = false

        if var4 and tbl1.userId and var7 and var5 then
            local current = var7.current
            var7.current = nil
            if current then
                local newVolume = var11()
                local playSessionId = if engineFeature then RbxAnalyticsService:GetPlaySessionId() else nil
                var4:trackPerUserVoiceVolumeChanged({
                    entryPoint = var5,
                    targetUserId = tbl1.userId,
                    oldVolume = current.oldVolume,
                    newVolume = newVolume,
                    wasMutedAtStart = current.wasMutedAtStart,
                    playSessionId = playSessionId,
                    voiceSessionId = if var3.getVoiceSessionId then var3.getVoiceSessionId() else nil,
                    dragDurationMs = math.max(0, DateTime.now().UnixTimestampMillis - current.startTimestampMs)
                })
            end
        end

        if FFlagVoiceChatVolumePerUserMuteVolumeSync then
            return
        end
        var13(var11())
    end, {
        var11,
        var4,
        tbl1.userId,
        var5,
        var7,
        var3
    }) else React.useCallback(function()
        var10.current = false
        if FFlagVoiceChatVolumePerUserMuteVolumeSync then
            return
        end
        var13(var11())
    end, { var11 })

    local onPressedOutside = React.useCallback(function()
        if tbl1.onClose then
            tbl1.onClose()
        end
    end, { tbl1.onClose })

    local var18 = if FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView or FFlagPeoplePageFlipVolumePopoverToFitViewport then React.useRef(nil) else nil

    if FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView then
        useDismissWhenOutOfView(tbl1.isOpen, onPressedOutside, var18)
    end

    local var19 = nil

    local var20 = nil
    local var21, top

    if FFlagPeoplePageFlipVolumePopoverToFitViewport then
        var19 = React.useRef(nil)
        local var22, var23 = React.useState(0)
        var20 = var23

        var21 = React.useCallback(function(arg1)
            local var24 = var19
            if var24.current then
                var24.current:Disconnect()
                var24.current = nil
            end

            local var25 = var20
            if arg1 == nil then
                var25(0)
                return
            end

            var25(arg1.AbsoluteSize.Y)
            var24.current = arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var25(arg1.AbsoluteSize.Y)
            end)
        end, {})

        React.useEffect(function()
            return function()
                local var24 = var19
                if var24.current then
                    var24.current:Disconnect()
                    var24.current = nil
                end
            end
        end, {})

        local num1 = math.max(size2800, var22)
        top = usePopoverSideToFitScrollingViewport(
            tbl1.isOpen,
            PopoverSide.Top,
            var18,
            num1,
            var1.Stroke.Standard + var1.Padding.Small
        )
    else
        top = nil
        var21 = nil
    end

    local createElement = React.createElement
    local root = Popover.Root
    local tbl2 = {
        isOpen = tbl1.isOpen
    }
    local tbl3 = { Anchor = 0, Content = 0 }
    local createElement2 = React.createElement
    local anchor = Popover.Anchor
    local var22 = nil
    local tbl4 = { Pill = 0 }
    local createElement3 = React.createElement
    local var23 = View
    local tbl5 = {
        tag = "row gap-xxsmall",
        Size = UDim2.fromOffset(tbl1.pillWidth, tbl1.pillHeight),
        LayoutOrder = tbl1.layoutOrder,
        ref = 0
    }

    if not (FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView or FFlagPeoplePageFlipVolumePopoverToFitViewport) then
        var18 = nil
    end

    tbl5.ref = var18
    tbl4.Pill = createElement3(var23, tbl5, { MuteHalf = tbl1.muteHalf, ChevronHalf = tbl1.chevronHalf })
    tbl3.Anchor = createElement2(anchor, var22, tbl4)

    local createElement4 = React.createElement
    local content = Popover.Content
    local tbl6 = {
        side = 0,
        align = 0,
        hasArrow = false,
        onPressedOutside = 0,
        backgroundStyle = 0,
        radius = 0
    }
    local side = { position = 0, offset = 0 }
    if not FFlagPeoplePageFlipVolumePopoverToFitViewport then
        top = PopoverSide.Top
    end

    side.position = top

    side.offset = var1.Stroke.Standard + var1.Padding.Small
    tbl6.side = side

    tbl6.align = {
        position = PopoverAlign.Start,
        offset = tbl1.alignOffset or 0
    }
    tbl6.onPressedOutside = onPressedOutside
    tbl6.backgroundStyle = {
        Color3 = var1.Color.Surface.Surface_100.Color3,
        Transparency = 1
    }

    tbl6.radius = Radius.Medium
    local tbl8 = { Container = 0 }
    local createElement5 = React.createElement
    local var24 = View
    local tbl9 = {
        tag = "col gap-medium auto-y padding-large stroke-standard stroke-default radius-medium bg-surface-100",
        Size = UDim2.new(0, xOffset, 0, 0),
        ref = 0
    }

    if not FFlagPeoplePageFlipVolumePopoverToFitViewport then
        var21 = nil
    end

    tbl9.ref = var21
    tbl8.Container = createElement5(var24, tbl9, {
        Content = React.createElement(View, {
            tag = "col gap-medium size-full-0 auto-y padding-x-medium padding-y-small"
        }, {
            Title = React.createElement(FoundationText, {
                Text = var2.voiceChatVolume,
                tag = {
                    ["auto-xy text-body-medium content-muted"] = isDisabled,
                    ["auto-xy text-body-medium content-emphasis"] = not isDisabled
                }
            }),
            VolumeSlider = React.createElement(Foundation.Slider, {
                key = FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted and (if isDisabled then "disabled" else "enabled") or nil,
                value = value,
                range = NumberRange.new(VOICE_VOLUME.MIN, VOICE_VOLUME.MAX),
                knobVisibility = Foundation.Enums.Visibility.Always,
                isContained = true,
                step = 0.1,
                isDisabled = isDisabled,
                onValueChanged = onValueChanged,
                onDragStarted = onDragStarted,
                onDragEnded = onDragEnded
            })
        })
    })
    tbl3.Content = createElement4(content, tbl6, tbl8)
    return createElement(root, tbl2, tbl3)
end

return VoiceVolumePopover
