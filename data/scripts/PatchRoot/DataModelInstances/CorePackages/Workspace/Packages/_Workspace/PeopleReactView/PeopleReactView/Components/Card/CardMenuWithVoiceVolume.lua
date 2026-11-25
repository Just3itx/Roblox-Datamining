-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local Foundation = require(PeopleReactViewParent.Foundation)
local useLocalization = require(PeopleReactViewParent.Localization).Hooks.useLocalization
local PeopleService = require(PeopleReactViewParent.PeopleService)

local InputSize = Foundation.Enums.InputSize
local Popover = Foundation.Popover
local Radius = Foundation.Enums.Radius
local FoundationText = Foundation.Text
local View = Foundation.View

local BaseMenu = Foundation.UNSTABLE.BaseMenu
local useTokens = Foundation.Hooks.useTokens

local FFlagVoiceChatVolumePerUserMuteVolumeSync = require(PeopleReactView.Flags.FFlagVoiceChatVolumePerUserMuteVolumeSync)

local FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted = require(PeopleReactView.Flags.FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted)

local FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry = PeopleService.getService("Flags").FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry
local ENTRY_POINT = PeopleService.getService("Constants").ANALYTICS.ENTRY_POINT

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local function VoiceVolumeSlider(tbl1)
    local var1 = useLocalization({ volumeLabel = "CoreScripts.InGameMenu.GameSettings.Volume" })

    local var2 = nil
    local var3 = nil
    if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then
        var2 = React.useMemo(function()
            return PeopleService.getService("PeopleAnalyticsManager")
        end, {})
        var3 = React.useRef(nil)
    end

    local isDisabled = FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted and tbl1.isMutedByLocalUser == true

    local var5 = React.useRef(false)
    local value, var7 = React.useBinding(tbl1.getPlayerVoiceVolume(tbl1.userId))

    React.useEffect(function()
        return tbl1.subscribePlayerVoiceVolume(tbl1.userId, function(arg1)
            if not var5.current then
                var7(arg1)
            end
        end)
    end, { tbl1.userId, tbl1.subscribePlayerVoiceVolume })

    local onValueChanged = React.useCallback(function(num1: number)
        var7(num1)
        tbl1.setPlayerVoiceVolume(tbl1.userId, num1)
    end, { tbl1.userId, tbl1.setPlayerVoiceVolume })

    local onDragStarted = React.useCallback(function()
        var5.current = true

        if not FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry or not var2 or not var3 then
            return
        end

        local wasMutedAtStart = if tbl1.getPlayerIsLocalMuted then tbl1.getPlayerIsLocalMuted(tbl1.userId) else tbl1.isMutedByLocalUser == true
        var3.current = {
            oldVolume = tbl1.getPlayerVoiceVolume(tbl1.userId),
            wasMutedAtStart = wasMutedAtStart,
            startTimestampMs = DateTime.now().UnixTimestampMillis
        }
        var2:trackPerUserVoiceVolumeSliderTouch(ENTRY_POINT.PEOPLE_CARD)
    end, {
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then tbl1.userId else nil,
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then tbl1.getPlayerVoiceVolume else nil,
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then tbl1.getPlayerIsLocalMuted else nil,
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then tbl1.isMutedByLocalUser else nil,
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then var2 else nil,
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then var3 else nil
    })

    local onDragEnded = React.useCallback(function()
        var5.current = false

        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry and var2 and var3 then
            local current = var3.current
            var3.current = nil
            if current then
                local newVolume = tbl1.getPlayerVoiceVolume(tbl1.userId)
                local playSessionId = if engineFeature then RbxAnalyticsService:GetPlaySessionId() else nil
                var2:trackPerUserVoiceVolumeChanged({
                    entryPoint = ENTRY_POINT.PEOPLE_CARD,
                    targetUserId = tbl1.userId,
                    oldVolume = current.oldVolume,
                    newVolume = newVolume,
                    wasMutedAtStart = current.wasMutedAtStart,
                    playSessionId = playSessionId,
                    voiceSessionId = if tbl1.getVoiceSessionId then tbl1.getVoiceSessionId() else nil,
                    dragDurationMs = math.max(0, DateTime.now().UnixTimestampMillis - current.startTimestampMs)
                })
            end
        end

        if FFlagVoiceChatVolumePerUserMuteVolumeSync then
            return
        end
        var7(tbl1.getPlayerVoiceVolume(tbl1.userId))
    end, {
        tbl1.userId,
        tbl1.getPlayerVoiceVolume,
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then tbl1.getVoiceSessionId else nil,
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then var2 else nil,
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then var3 else nil
    })

    return React.createElement(
        View,
        {
            tag = "col gap-small size-full-0 auto-y padding-x-medium padding-y-small",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            Title = React.createElement(FoundationText, {
                Text = var1.volumeLabel,
                tag = {
                    ["auto-xy text-body-medium content-muted"] = isDisabled,
                    ["auto-xy text-body-medium content-emphasis"] = not isDisabled
                }
            }),
            VolumeSlider = React.createElement(Foundation.Slider, {
                key = FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted and (if isDisabled then "disabled" else "enabled") or nil,
                value = value,
                range = NumberRange.new(tbl1.voiceVolumeMin, tbl1.voiceVolumeMax),
                knobVisibility = Foundation.Enums.Visibility.Always,
                isContained = true,
                step = 0.1,
                width = UDim.new(1, 0),
                isDisabled = isDisabled,
                onValueChanged = onValueChanged,
                onDragStarted = onDragStarted,
                onDragEnded = onDragEnded
            })
        }
    )
end
return React.memo(function(tbl1) -- name: CardMenuWithVoiceVolume
    local var1 = useTokens()
    local standard = var1.Stroke.Standard
    local padding = {
        left = UDim.new(0, var1.Size.Size_250),
        right = UDim.new(0, var1.Size.Size_250),
        top = UDim.new(0, var1.Padding.XSmall),
        bottom = UDim.new(0, var1.Padding.XSmall)
    }

    local tbl3 = {}

    for layoutOrder, menuGroup in tbl1.menuGroups do
        local tbl4 = {}
        for k, item in menuGroup.items do
            local str1 = tostring(item.id)
            tbl4[str1] = React.createElement(
                BaseMenu.Item,
                {
                    LayoutOrder = k,
                    id = item.id,
                    text = item.text,
                    icon = item.icon,
                    onActivated = item.onActivated
                }
            )
        end
        if menuGroup.title ~= nil then
            local createElement = React.createElement
            local var2 = View

            local tbl5 = {
                Label = React.createElement(
                    FoundationText,
                    {
                        Text = menuGroup.title,
                        tag = "fill auto-xy text-align-x-left text-truncate-end text-caption-small content-muted"
                    }
                )
            }
            tbl4.SectionTitle = createElement(var2, { LayoutOrder = 0, tag = "row align-y-center size-full-0 auto-y", padding = padding }, tbl5)
        end

        if menuGroup.showVolumeSlider then
            tbl4.VoiceVolumeSlider = React.createElement(VoiceVolumeSlider, {
                userId = tbl1.userId,
                voiceVolumeMin = tbl1.voiceVolumeMin,
                voiceVolumeMax = tbl1.voiceVolumeMax,
                getPlayerVoiceVolume = tbl1.getPlayerVoiceVolume,
                subscribePlayerVoiceVolume = tbl1.subscribePlayerVoiceVolume,
                setPlayerVoiceVolume = tbl1.setPlayerVoiceVolume,
                isMutedByLocalUser = tbl1.isMutedByLocalUser,
                getPlayerIsLocalMuted = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then tbl1.getPlayerIsLocalMuted else nil,
                getVoiceSessionId = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then tbl1.getVoiceSessionId else nil,
                layoutOrder = #menuGroup.items + 1
            })
        end

        tbl3[`Group_{layoutOrder}`] = React.createElement(BaseMenu.Group, { LayoutOrder = layoutOrder }, tbl4)
    end

    return React.createElement(Popover.Root, {
        isOpen = tbl1.isOpen,
        testId = "--foundation-menu"
    }, {
        Anchor = React.createElement(Popover.Anchor, nil, tbl1.children),
        Content = React.createElement(Popover.Content, {
            side = {
                position = Foundation.Enums.PopoverSide.Bottom,
                offset = standard + var1.Padding.Small
            },
            align = Foundation.Enums.PopoverAlign.Start,
            hasArrow = false,
            onPressedOutside = tbl1.onPressedOutside,
            backgroundStyle = var1.Color.Surface.Surface_200,
            radius = Radius.Medium
        }, {
            Menu = React.createElement(
                BaseMenu.Root,
                {
                    size = InputSize.Medium,
                    onNestedLeafActivated = tbl1.onPressedOutside,
                    radius = Radius.Medium
                },
                tbl3
            )
        })
    })
end)
