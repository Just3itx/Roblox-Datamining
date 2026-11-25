-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local Foundation = require(PeopleReactViewParent.Foundation)
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local Menu = Foundation.Menu
local View = Foundation.View

local useLocalization = require(PeopleReactViewParent.Localization).Hooks.useLocalization

local PersonButtonConfigs = require(PeopleReactView.Configs.PersonButtonConfigs)
local useGetPeopleService = require(PeopleReactView.Hooks.useGetPeopleService)

local PersonButton = require(PeopleReactView.Components.Buttons.PersonButton)
local CardMenuWithVoiceVolume = require(PeopleReactView.Components.Card.CardMenuWithVoiceVolume)
local useDismissWhenOutOfView = require(PeopleReactView.Hooks.useDismissWhenOutOfView)

local Constants = require(PeopleReactView.Constants)

local var1 = require(PeopleReactViewParent.PeopleService).getService("Flags")
local FFlagVoiceVolumeControlsPerUserPlayerGridMenu = var1.FFlagVoiceVolumeControlsPerUserPlayerGridMenu
local FFlagPeoplePageDismissCardMenuOnScrollOutOfView = var1.FFlagPeoplePageDismissCardMenuOnScrollOutOfView

local FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted = require(PeopleReactView.Flags.FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted)

local FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry = var1.FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry

return React.memo(function(tbl1) -- name: CardMenu
    local var2 = useLocalization({
        unblock = Constants.PEOPLEPAGE.PERSON_BUTTONS.LOCALIZED_STRINGS.UNBLOCK,
        block = Constants.PEOPLEPAGE.PERSON_BUTTONS.LOCALIZED_STRINGS.BLOCK,
        unmute = Constants.PEOPLEPAGE.PERSON_BUTTONS.LOCALIZED_STRINGS.UNMUTE,
        mute = Constants.PEOPLEPAGE.PERSON_BUTTONS.LOCALIZED_STRINGS.MUTE,
        report = Constants.PEOPLEPAGE.PERSON_BUTTONS.LOCALIZED_STRINGS.REPORT,
        voiceSectionTitle = if FFlagVoiceVolumeControlsPerUserPlayerGridMenu then Constants.PEOPLEPAGE.CARD_MENU.LOCALIZED_STRINGS.VOICE_SECTION_TITLE else nil
    })

    local var3 = useGetPeopleService("PeopleBlockStatusStore")
    local var4 = useGetPeopleService("PeopleVoiceChatStore")
    local var5 = useGetPeopleService("PeopleAnalyticsManager")
    local var6 = useGetPeopleService("Constants")

    local var7 = PersonButtonConfigs(tbl1.person.UserId)

    local var8 = SignalsReact.useSignalState(var3.getPlayerBlockStatus(tbl1.person.UserId))
    local var9 = SignalsReact.useSignalState(var4.getPlayerIsLocalMuted(tbl1.person.UserId))
    local var10 = SignalsReact.useSignalState(var4.getPlayerIsTalking(tbl1.person.UserId))
    local var11 = if FFlagVoiceVolumeControlsPerUserPlayerGridMenu then SignalsReact.useSignalState(var4.getShowVolumeControl) else false
    local var12 = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then var11 and var7[var6.PERSON_BUTTONS.MUTE_PLAYER].shouldShow() else false
    local isOpen, var14 = React.useState(false)

    local var15 = React.useCallback(function(bool1: boolean)
        tbl1.onIsOpenChanged(bool1)
        var14(bool1)
    end, { tbl1.onIsOpenChanged })

    local onPressedOutside = React.useCallback(function()
        var5:trackPersonCardMenuToggled(false)
        var15(false)
    end, { var15 })

    local useCallback = React.useCallback
    local function func1()
        local bool1 = not isOpen
        var5:trackPersonCardMenuToggled(bool1)

        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry and bool1 and var12 then
            var5:recordPerUserVoiceVolumeUiOpened(var6.ANALYTICS.ENTRY_POINT.PEOPLE_CARD)
        end

        var15(bool1)
    end

    local var17 = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then var12 else nil
    local var18 = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then var6 else nil
    local onActivated = useCallback(func1, { isOpen, var15, var17, var18 })
    local var20

    if FFlagPeoplePageDismissCardMenuOnScrollOutOfView then
        var20 = React.useRef(nil)
        useDismissWhenOutOfView(isOpen, onPressedOutside, var20)
    else
        var20 = nil
    end

    local var21 = React.useMemo(function()
        return var7[var6.PERSON_BUTTONS.MUTE_PLAYER].animatedIcon
    end, { var7 })

    local var22

    if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then
        local getPlayerIsLocalMuted = var4.getPlayerIsLocalMuted
        var22 = React.useCallback(function(num1: number)
            if num1 and getPlayerIsLocalMuted then
                return getPlayerIsLocalMuted(num1)(false)
            end
            return false
        end, { getPlayerIsLocalMuted })
    else
        var22 = nil
    end

    local var23 = if FFlagVoiceVolumeControlsPerUserPlayerGridMenu then React.useMemo(function()
        local var23 = var7[var6.PERSON_BUTTONS.MUTE_PLAYER]
        local var24 = var7[var6.PERSON_BUTTONS.BLOCK_PLAYER]
        local var25 = var7[var6.PERSON_BUTTONS.REPORT_PLAYER]
        local peopleCard = var6.ANALYTICS.ENTRY_POINT.PEOPLE_CARD

        local result = {}
        local items = {}
        local tbl3

        if var23.shouldShow() then
            tbl3 = {
                id = "mute",
                text = if var9 then var2.unmute else var2.mute,
                icon = if var9 then IconName.SpeakerSlash else IconName.Speaker,
                onActivated = 0
            }

            function tbl3.onActivated()
                var23.onActivated(peopleCard)
            end
        else
            tbl3 = nil
        end

        if tbl3 and not var11 then
            table.insert(items, tbl3)
        end

        if var24.shouldShow() then
            local tbl4 = {
                id = "block",
                text = if var8 then var2.unblock else var2.block,
                icon = IconName.CircleSlash,
                onActivated = 0
            }

            function tbl4.onActivated()
                var24.onActivated(peopleCard)
                var15(false)
            end

            table.insert(items, tbl4)
        end

        if var25.shouldShow() then
            table.insert(items, {
                id = "report",
                text = var2.report,
                icon = IconName.Flag,
                onActivated = function()
                    var25.onActivated(peopleCard)
                end
            })
        end
        if #items > 0 then
            table.insert(result, { items = items })
        end

        if tbl3 and var11 then
            table.insert(result, { title = var2.voiceSectionTitle, showVolumeSlider = true, items = { tbl3 } })
        end

        return result
    end, {
        var8,
        var9,
        var15,
        var7,
        var2,
        var11
    }) else React.useMemo(function()
        local var23 = var7[var6.PERSON_BUTTONS.MUTE_PLAYER]
        local var24 = var7[var6.PERSON_BUTTONS.BLOCK_PLAYER]
        local var25 = var7[var6.PERSON_BUTTONS.REPORT_PLAYER]

        local result = {}

        if var23.shouldShow() then
            local tbl2 = {
                id = "mute",
                text = if var9 then var2.unmute else var2.mute,
                icon = if var9 then IconName.SpeakerSlash else IconName.Speaker,
                onActivated = 0
            }

            function tbl2.onActivated()
                var23.onActivated(var6.ANALYTICS.ENTRY_POINT.PEOPLE_CARD)
            end

            table.insert(result, tbl2)
        end

        if var24.shouldShow() then
            local tbl2 = {
                id = "block",
                text = if var8 then var2.unblock else var2.block,
                icon = IconName.CircleSlash,
                onActivated = 0
            }

            function tbl2.onActivated()
                var24.onActivated(var6.ANALYTICS.ENTRY_POINT.PEOPLE_CARD)
                var15(false)
            end

            table.insert(result, tbl2)
        end

        if var25.shouldShow() then
            table.insert(result, {
                id = "report",
                text = var2.report,
                icon = IconName.Flag,
                onActivated = function()
                    var25.onActivated(var6.ANALYTICS.ENTRY_POINT.PEOPLE_CARD)
                end
            })
        end

        return result
    end, {
        var8,
        var9,
        var15,
        var7,
        var2
    })

    local createElement = React.createElement
    local var24 = PersonButton
    local tbl2 = {
        icon = {
            on = if var10 then nil else IconName.ThreeDotsHorizontal
        },
        animatedIcon = 0,
        onActivated = 0,
        isBuilderIcon = 0,
        isBackgroundTransparent = true,
        LayoutOrder = 1
    }
    if not var10 then
        var21 = nil
    end

    tbl2.animatedIcon = var21
    tbl2.onActivated = onActivated
    tbl2.isBuilderIcon = not var10
    local button = createElement(var24, tbl2)
    local menuAnchor = if FFlagPeoplePageDismissCardMenuOnScrollOutOfView then React.createElement(View, { ref = var20, LayoutOrder = 1, tag = "auto-xy" }, { Button = button }) else nil

    if next(var23) == nil then
        return nil
    end

    if not FFlagVoiceVolumeControlsPerUserPlayerGridMenu then
        return React.createElement(
            Menu,
            {
                isOpen = isOpen,
                items = var23,
                size = InputSize.Medium,
                onPressedOutside = onPressedOutside
            },
            {
                MenuAnchor = menuAnchor or button
            }
        )
    end

    local createElement2 = React.createElement
    local var25 = CardMenuWithVoiceVolume
    local tbl3 = {
        isOpen = isOpen,
        menuGroups = var23,
        onPressedOutside = onPressedOutside,
        userId = tbl1.person.UserId,
        voiceVolumeMin = var6.VOICE_CHAT.VOICE_VOLUME.MIN,
        voiceVolumeMax = var6.VOICE_CHAT.VOICE_VOLUME.MAX,
        getPlayerVoiceVolume = var4.getPlayerVoiceVolume,
        subscribePlayerVoiceVolume = var4.subscribePlayerVoiceVolume,
        setPlayerVoiceVolume = var4.setPlayerVoiceVolume,
        isMutedByLocalUser = if FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted then var9 else nil,
        getPlayerIsLocalMuted = 0,
        getVoiceSessionId = 0
    }

    if not FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then
        var22 = nil
    end

    tbl3.getPlayerIsLocalMuted = var22

    tbl3.getVoiceSessionId = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then var4.getVoiceSessionId else nil
    return createElement2(var25, tbl3, { MenuAnchor = menuAnchor or button })
end)
