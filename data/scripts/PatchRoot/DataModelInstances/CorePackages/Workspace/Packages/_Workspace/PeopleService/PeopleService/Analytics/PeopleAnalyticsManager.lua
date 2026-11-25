-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local PeopleService = script:FindFirstAncestor("PeopleService")
local PeopleServiceParent = PeopleService.Parent

local GameInvite = require(PeopleServiceParent.GameInvite)

local Flags = require(PeopleService.Flags)
local Constants = require(PeopleService.Constants)

local GetFIntInspectButtonThrottleHundredthsPercent = Flags.GetFIntInspectButtonThrottleHundredthsPercent

local GetFIntGameInviteEntryPointThrottleHundredthsPercent = Flags.GetFIntGameInviteEntryPointThrottleHundredthsPercent
local GetFIntMuteAllThrottleHundredthsPercent = Flags.GetFIntMuteAllThrottleHundredthsPercent
local GetFIntUnmuteAllThrottleHundredthsPercent = Flags.GetFIntUnmuteAllThrottleHundredthsPercent
local GetFIntMutePlayerThrottleHundredthsPercent = Flags.GetFIntMutePlayerThrottleHundredthsPercent
local GetFIntUnmutePlayerThrottleHundredthsPercent = Flags.GetFIntUnmutePlayerThrottleHundredthsPercent
local GetFIntRequestFriendshipThrottleHundredthsPercent = Flags.GetFIntRequestFriendshipThrottleHundredthsPercent
local GetFIntMuteSelfThrottleHundredthsPercent = Flags.GetFIntMuteSelfThrottleHundredthsPercent
local GetFIntUnmuteSelfThrottleHundredthsPercent = Flags.GetFIntUnmuteSelfThrottleHundredthsPercent
local GetFIntBlockUserButtonClickThrottleHundredthsPercent = Flags.GetFIntBlockUserButtonClickThrottleHundredthsPercent
local GetFIntBlockUserThrottleHundredthsPercent = Flags.GetFIntBlockUserThrottleHundredthsPercent
local GetFIntUnblockUserThrottleHundredthsPercent = Flags.GetFIntUnblockUserThrottleHundredthsPercent

local GetFIntPeoplePageLayoutChangedThrottleHundredthsPercent = Flags.GetFIntPeoplePageLayoutChangedThrottleHundredthsPercent

local GetFIntPersonCardMenuToggledThrottleHundredthsPercent = Flags.GetFIntPersonCardMenuToggledThrottleHundredthsPercent
local GetFFlagAddPeoplePageCardLayout = Flags.GetFFlagAddPeoplePageCardLayout

local FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry = Flags.FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry
local FFlagVoiceVolumeControlsPerUserPlayerListButton = Flags.FFlagVoiceVolumeControlsPerUserPlayerListButton
local FFlagVoiceVolumeControlsPerUserPlayerGridMenu = Flags.FFlagVoiceVolumeControlsPerUserPlayerGridMenu

local FIntPerUserVoiceVolumeChangedThrottleHundredthsPercent = Flags.FIntPerUserVoiceVolumeChangedThrottleHundredthsPercent

local FIntPerUserVoiceVolumeSessionThrottleHundredthsPercent = Flags.FIntPerUserVoiceVolumeSessionThrottleHundredthsPercent

local FIntPerUserVoiceVolumeSliderTouchThrottleHundredthsPercent = Flags.FIntPerUserVoiceVolumeSliderTouchThrottleHundredthsPercent

local FIntPerUserVoiceVolumeMutedViaSliderThrottleHundredthsPercent = Flags.FIntPerUserVoiceVolumeMutedViaSliderThrottleHundredthsPercent

local FIntPerUserVoiceVolumeUnmutedViaSliderThrottleHundredthsPercent = Flags.FIntPerUserVoiceVolumeUnmutedViaSliderThrottleHundredthsPercent
local FFlagVoiceChatVolumePerUserMuteVolumeSync = Flags.FFlagVoiceChatVolumePerUserMuteVolumeSync

local FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted = Flags.FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted

local VOICE_VOLUME = Constants.VOICE_CHAT.VOICE_VOLUME
local ENTRY_POINT = Constants.ANALYTICS.ENTRY_POINT
local UX_VARIANT = Constants.ANALYTICS.UX_VARIANT

local module = {
    ButtonName = { SettingsHub = "settingsHub" },
    EventName = {
        GameInviteEntryPoint = "inputShareGameEntryPoint",
        GameInviteEntryPointCounter = settings():GetFVariable("LuaShareGameSettingsHubEntryCounter"),
        InspectButton = "ingame_menu_action",
        MuteAll = "mute_all",
        UnmuteAll = "unmute_all",
        MutePlayer = "mute_player",
        UnmutePlayer = "unmute_player",
        MuteSelf = "mute_self",
        UnmuteSelf = "unmute_self",
        PlayersMenu = "PlayersMenu",
        RequestFriendship = "RequestFriendship",
        BlockUserButtonClick = "blockUserButtonClick",
        BlockUser = "blockUser",
        UnblockUser = "unblockUser",
        PeoplePageLayoutChanged = "people_page_layout_changed",
        PersonCardMenuToggled = "person_card_menu_toggled",
        PerUserVoiceVolumeChanged = "PerUserVoiceVolumeChanged",
        PerUserVoiceVolumeSession = "PerUserVoiceVolumeSession",
        PerUserVoiceVolumeSliderTouch = "PerUserVoiceVolumeSliderTouch",
        PerUserVoiceVolumeMutedViaSlider = "PerUserVoiceVolumeMutedViaSlider",
        PerUserVoiceVolumeUnmutedViaSlider = "PerUserVoiceVolumeUnmutedViaSlider"
    }
}

local TelemetryConfigs = {
    GameInviteEntryPoint = {
        eventConfig = {
            eventName = module.EventName.GameInviteEntryPoint,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntGameInviteEntryPointThrottleHundredthsPercent(),
            lastUpdated = { 2025, 6, 25 },
            description = "Event to track game invite entry point from people tab."
        },
        counterConfig = {
            eventName = module.EventName.GameInviteEntryPointCounter,
            backends = { "RobloxTelemetryCounter" },
            throttlingPercentage = GetFIntGameInviteEntryPointThrottleHundredthsPercent(),
            lastUpdated = { 2025, 6, 25 },
            description = "Counter to track game invite entry point clicks from people tab."
        }
    },
    InspectButton = {
        eventConfig = {
            eventName = module.EventName.InspectButton,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntInspectButtonThrottleHundredthsPercent(),
            lastUpdated = { 2025, 7, 14 },
            description = "Event to track inspect button click from people tab."
        }
    },
    MuteAll = {
        eventConfig = {
            eventName = module.EventName.MuteAll,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntMuteAllThrottleHundredthsPercent(),
            lastUpdated = { 2025, 6, 26 },
            description = "Event to track mute all button click."
        }
    },
    UnmuteAll = {
        eventConfig = {
            eventName = module.EventName.UnmuteAll,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntUnmuteAllThrottleHundredthsPercent(),
            lastUpdated = { 2025, 6, 26 },
            description = "Event to track unmute all button click."
        }
    },
    MutePlayer = {
        eventConfig = {
            eventName = module.EventName.MutePlayer,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntMutePlayerThrottleHundredthsPercent(),
            lastUpdated = { 2025, 7, 9 },
            description = "Event to track individual player mute button click."
        }
    },
    UnmutePlayer = {
        eventConfig = {
            eventName = module.EventName.UnmutePlayer,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntUnmutePlayerThrottleHundredthsPercent(),
            lastUpdated = { 2025, 7, 9 },
            description = "Event to track individual player unmute button click."
        }
    },
    MuteSelf = {
        eventConfig = {
            eventName = module.EventName.MuteSelf,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntMuteSelfThrottleHundredthsPercent(),
            lastUpdated = { 2025, 7, 23 },
            description = "Event to track mute self button click."
        }
    },
    UnmuteSelf = {
        eventConfig = {
            eventName = module.EventName.UnmuteSelf,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntUnmuteSelfThrottleHundredthsPercent(),
            lastUpdated = { 2025, 7, 23 },
            description = "Event to track unmute self button click."
        }
    },
    RequestFriendship = {
        eventConfig = {
            eventName = if GetFFlagAddPeoplePageCardLayout() then module.EventName.RequestFriendship else module.EventName.PlayersMenu,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntRequestFriendshipThrottleHundredthsPercent(),
            lastUpdated = { 2025, 7, 9 },
            description = "Event to track players menu actions."
        },
        counterConfig = {
            eventName = module.EventName.PlayersMenu,
            backends = { "RobloxTelemetryCounter" },
            lastUpdated = { 2025, 7, 9 },
            description = "Counter to track players menu actions."
        }
    },
    BlockUserButtonClick = {
        eventConfig = {
            eventName = module.EventName.BlockUserButtonClick,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntBlockUserButtonClickThrottleHundredthsPercent(),
            lastUpdated = { 2025, 7, 22 },
            description = "Event to track block user button clicks from people tab."
        }
    },
    BlockUser = {
        eventConfig = {
            eventName = module.EventName.BlockUser,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntBlockUserThrottleHundredthsPercent(),
            lastUpdated = { 2025, 7, 22 },
            description = "Event to track successful user blocking from people tab."
        }
    },
    UnblockUser = {
        eventConfig = {
            eventName = module.EventName.UnblockUser,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntUnblockUserThrottleHundredthsPercent(),
            lastUpdated = { 2025, 7, 22 },
            description = "Event to track user unblocking from people tab."
        }
    },
    PeoplePageLayoutChanged = {
        eventConfig = {
            eventName = module.EventName.PeoplePageLayoutChanged,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntPeoplePageLayoutChangedThrottleHundredthsPercent(),
            lastUpdated = { 2025, 9, 2 },
            description = "Event to track people page layout change."
        }
    },
    PersonCardMenuToggled = {
        eventConfig = {
            eventName = module.EventName.PersonCardMenuToggled,
            backends = { "EventIngest" },
            throttlingPercentage = GetFIntPersonCardMenuToggledThrottleHundredthsPercent(),
            lastUpdated = { 2025, 9, 2 },
            description = "Event to track person card menu toggle."
        }
    },
    PerUserVoiceVolumeChanged = {
        eventConfig = {
            eventName = module.EventName.PerUserVoiceVolumeChanged,
            backends = { "EventIngest" },
            throttlingPercentage = FIntPerUserVoiceVolumeChangedThrottleHundredthsPercent,
            lastUpdated = { 2026, 7, 27 },
            description = "Per-user voice volume slider drag on People List / People Cards.",
            links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/voice/per_user_voice_volume_changed.proto"
        }
    },
    PerUserVoiceVolumeSession = {
        eventConfig = {
            eventName = module.EventName.PerUserVoiceVolumeSession,
            backends = { "EventIngest" },
            throttlingPercentage = FIntPerUserVoiceVolumeSessionThrottleHundredthsPercent,
            lastUpdated = { 2026, 7, 27 },
            description = "Session info for per-user voice volume UI open/change on People List / People Cards.",
            links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/voice/per_user_voice_volume_session.proto"
        }
    },
    PerUserVoiceVolumeSliderTouch = {
        counterConfig = {
            eventName = module.EventName.PerUserVoiceVolumeSliderTouch,
            backends = { "RobloxTelemetryCounter" },
            throttlingPercentage = FIntPerUserVoiceVolumeSliderTouchThrottleHundredthsPercent,
            lastUpdated = { 2026, 7, 27 },
            description = "Counter for per-user voice volume slider drag starts."
        }
    },
    PerUserVoiceVolumeMutedViaSlider = {
        counterConfig = {
            eventName = module.EventName.PerUserVoiceVolumeMutedViaSlider,
            backends = { "RobloxTelemetryCounter" },
            throttlingPercentage = FIntPerUserVoiceVolumeMutedViaSliderThrottleHundredthsPercent,
            lastUpdated = { 2026, 7, 27 },
            description = "Counter for muting a player by dragging per-user volume to MIN."
        }
    },
    PerUserVoiceVolumeUnmutedViaSlider = {
        counterConfig = {
            eventName = module.EventName.PerUserVoiceVolumeUnmutedViaSlider,
            backends = { "RobloxTelemetryCounter" },
            throttlingPercentage = FIntPerUserVoiceVolumeUnmutedViaSliderThrottleHundredthsPercent,
            lastUpdated = { 2026, 7, 27 },
            description = "Counter for unmuting a player by raising per-user volume above MIN."
        }
    }
}

module.TelemetryConfigs = TelemetryConfigs

local GameInviteAnalyticsManager = GameInvite.GameInviteAnalyticsManager

function module.trackGameInviteEntryPoint(_)
    local customFields = {
        btn = module.ButtonName.SettingsHub,
        placeId = tostring(game.PlaceId),
        gameId = tostring(game.GameId)
    }

    local gameInviteEntryPoint = TelemetryConfigs.GameInviteEntryPoint
    TelemetryService:LogEvent(gameInviteEntryPoint.eventConfig, { customFields = customFields })
    TelemetryService:LogCounter(gameInviteEntryPoint.counterConfig, {}, 1)

    GameInviteAnalyticsManager:withButtonName(module.ButtonName.SettingsHub)
end

function module.trackToggleMuteSelf(_, bool1: boolean)
    if bool1 then
        TelemetryService:LogEvent(TelemetryConfigs.UnmuteSelf.eventConfig, {})
        return
    end
    TelemetryService:LogEvent(TelemetryConfigs.MuteSelf.eventConfig, {})
end

function module.trackInspectButton(_, num1: number?, playsessionid: string?, entrypoint: string?)
    local customFields = {
        playsessionid = playsessionid,
        universeid = tostring(num1)
    }
    if GetFFlagAddPeoplePageCardLayout() then
        customFields.entrypoint = entrypoint
    end

    local inspectButton = TelemetryConfigs.InspectButton
    TelemetryService:LogEvent(
        inspectButton.eventConfig,
        {
            eventContext = if GetFFlagAddPeoplePageCardLayout() then "examine_avatar" else nil,
            customFields = customFields
        }
    )
end

function module.trackToggleMuteAll(_, bool1: boolean)
    if bool1 then
        TelemetryService:LogEvent(TelemetryConfigs.UnmuteAll.eventConfig, {})
        return
    end
    TelemetryService:LogEvent(TelemetryConfigs.MuteAll.eventConfig, {})
end

function module.trackToggleMutePlayer(_, mutedUserId: number, bool1: boolean, str1: string?)
    if bool1 then
        local telemetryService = TelemetryService
        local eventConfig = TelemetryConfigs.UnmutePlayer.eventConfig
        local tbl2 = { customFields = 0 }
        local customFields = { mutedUserId = mutedUserId, entryPoint = 0 }
        if not GetFFlagAddPeoplePageCardLayout() then
            str1 = nil
        end

        customFields.entryPoint = str1
        tbl2.customFields = customFields
        telemetryService:LogEvent(eventConfig, tbl2)
        return
    end

    local telemetryService = TelemetryService
    local eventConfig = TelemetryConfigs.MutePlayer.eventConfig
    local tbl2 = { customFields = 0 }
    local customFields = { mutedUserId = mutedUserId, entryPoint = 0 }
    if not GetFFlagAddPeoplePageCardLayout() then
        str1 = nil
    end

    customFields.entryPoint = str1
    tbl2.customFields = customFields
    telemetryService:LogEvent(eventConfig, tbl2)
end

function module.trackRequestFriendship(_, entryPoint: string?)
    local customFields = { selectedItem = "RequestFriendship", category = "Game", entryPoint = 0 }

    if not GetFFlagAddPeoplePageCardLayout() then
        entryPoint = nil
    end

    customFields.entryPoint = entryPoint

    local requestFriendship = TelemetryConfigs.RequestFriendship
    TelemetryService:LogEvent(
        requestFriendship.eventConfig,
        {
            eventContext = if GetFFlagAddPeoplePageCardLayout() then "PlayersMenu" else nil,
            customFields = customFields
        }
    )
    TelemetryService:LogCounter(
        requestFriendship.counterConfig,
        {
            customFields = { selectedItem = "RequestFriendship" }
        },
        1
    )
end

function module.trackBlockUserButtonClick(_, blockeeUserId: number, blockerUserId: number, source: string?)
    local blockUserButtonClick = TelemetryConfigs.BlockUserButtonClick
    TelemetryService:LogEvent(
        blockUserButtonClick.eventConfig,
        {
            customFields = {
                blockeeUserId = blockeeUserId,
                blockerUserId = blockerUserId,
                source = source
            }
        }
    )
end

function module.trackBlockUser(_, blockeeUserId: number, blockerUserId: number, source: string?)
    local blockUser = TelemetryConfigs.BlockUser
    TelemetryService:LogEvent(
        blockUser.eventConfig,
        {
            customFields = {
                blockeeUserId = blockeeUserId,
                blockerUserId = blockerUserId,
                source = source
            }
        }
    )
end

function module.trackUnblockUser(_, blockeeUserId: number, blockerUserId: number, entryPoint: string?)
    local customFields = {
        blockeeUserId = blockeeUserId,
        blockerUserId = blockerUserId,
        entryPoint = 0
    }

    if not GetFFlagAddPeoplePageCardLayout() then
        entryPoint = nil
    end

    customFields.entryPoint = entryPoint

    local unblockUser = TelemetryConfigs.UnblockUser
    TelemetryService:LogEvent(unblockUser.eventConfig, { customFields = customFields })
end

if GetFFlagAddPeoplePageCardLayout() then
    function module.trackPeoplePageLayoutChanged(_, arg1)
        local customFields = {
            layout = arg1.Name
        }

        local peoplePageLayoutChanged = TelemetryConfigs.PeoplePageLayoutChanged
        TelemetryService:LogEvent(peoplePageLayoutChanged.eventConfig, {
            customFields = customFields,
            standardizedFields = {
                "addPlaceId",
                "addUniverseId",
                "addPlaySessionId",
                "addSessionInfo"
            }
        })
    end
    function module.trackPersonCardMenuToggled(_, bool1: boolean)
        local customFields = {
            is_toggled_on = tostring(bool1)
        }

        local personCardMenuToggled = TelemetryConfigs.PersonCardMenuToggled
        TelemetryService:LogEvent(personCardMenuToggled.eventConfig, {
            customFields = customFields,
            standardizedFields = {
                "addPlaceId",
                "addUniverseId",
                "addPlaySessionId",
                "addSessionInfo"
            }
        })
    end
end

local tbl2 = {
    openedVolumeUiList = false,
    openedVolumeUiCard = false,
    changedPerUserVolume = false,
    reported = false
}

local function getPerUserVoiceVolumeUxVariant() -- Luacid: Inlined by compiler; 4 call sites recovered
    return if FFlagVoiceChatVolumePerUserDisableInteractionWhenMuted then UX_VARIANT.DISABLE_WHEN_MUTED elseif FFlagVoiceChatVolumePerUserMuteVolumeSync then UX_VARIANT.SYNC else UX_VARIANT.INDEPENDENT
end

local function resetPerUserVoiceVolumeSessionState() -- Luacid: Inlined by compiler; 1 call site recovered
    tbl2.openedVolumeUiList = false
    tbl2.openedVolumeUiCard = false
    tbl2.changedPerUserVolume = false
    tbl2.reported = false
end

function module.getPerUserVoiceVolumeUxVariant()
    return getPerUserVoiceVolumeUxVariant()
end

function module.recordPerUserVoiceVolumeUiOpened(_, str1: string)
    if not FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then
        return
    end

    if str1 == ENTRY_POINT.PEOPLE_LIST then
        tbl2.openedVolumeUiList = true
    elseif str1 == ENTRY_POINT.PEOPLE_CARD then
        tbl2.openedVolumeUiCard = true
    end
end

function module.trackPerUserVoiceVolumeSliderTouch(_, entryPoint: string)
    if not FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then
        return
    end

    local uxVariant = getPerUserVoiceVolumeUxVariant()
    TelemetryService:LogCounter(
        TelemetryConfigs.PerUserVoiceVolumeSliderTouch.counterConfig,
        {
            customFields = { entryPoint = entryPoint, uxVariant = uxVariant }
        },
        1
    )
end

function module.trackPerUserVoiceVolumeChanged(_, tbl3)
    if not FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry or tbl3.newVolume == tbl3.oldVolume then
        return
    end

    local uxVariant = getPerUserVoiceVolumeUxVariant()
    local wasMutedAtStart = tbl3.wasMutedAtStart
    local mutedViaSlider = if uxVariant ~= UX_VARIANT.SYNC then nil else wasMutedAtStart == false and tbl3.newVolume == VOICE_VOLUME.MIN
    local unmutedViaSlider = if uxVariant ~= UX_VARIANT.SYNC then nil else wasMutedAtStart == true and tbl3.newVolume > VOICE_VOLUME.MIN

    if uxVariant == UX_VARIANT.DISABLE_WHEN_MUTED then
        wasMutedAtStart = nil
    end
    local customFields = {
        playSessionId = tbl3.playSessionId,
        voiceSessionId = tbl3.voiceSessionId,
        entryPoint = tbl3.entryPoint,
        targetUserId = tbl3.targetUserId,
        oldVolume = tbl3.oldVolume,
        newVolume = tbl3.newVolume,
        wasMutedAtStart = wasMutedAtStart,
        mutedViaSlider = mutedViaSlider,
        unmutedViaSlider = unmutedViaSlider,
        uxVariant = uxVariant,
        masterVolume = UserGameSettings.MasterVolume,
        voiceChatVolume = UserGameSettings.VoiceChatVolume,
        dragDurationMs = tbl3.dragDurationMs
    }

    TelemetryService:LogEvent(
        TelemetryConfigs.PerUserVoiceVolumeChanged.eventConfig,
        {
            customFields = customFields,
            standardizedFields = { "addPlaceId", "addUniverseId" }
        }
    )
    tbl2.changedPerUserVolume = true

    if mutedViaSlider then
        TelemetryService:LogCounter(
            TelemetryConfigs.PerUserVoiceVolumeMutedViaSlider.counterConfig,
            {
                customFields = {
                    entryPoint = tbl3.entryPoint,
                    uxVariant = uxVariant
                }
            },
            1
        )
    end
    if not unmutedViaSlider then
        return
    end

    TelemetryService:LogCounter(
        TelemetryConfigs.PerUserVoiceVolumeUnmutedViaSlider.counterConfig,
        {
            customFields = {
                entryPoint = tbl3.entryPoint,
                uxVariant = uxVariant
            }
        },
        1
    )
end

function module.flushPerUserVoiceVolumeSession(_, playSessionId: string?, voiceSessionId: string?)
    if not FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry or tbl2.reported then
        return
    end

    tbl2.reported = true
    local openedVolumeUiList = if FFlagVoiceVolumeControlsPerUserPlayerListButton then tbl2.openedVolumeUiList else nil
    local openedVolumeUiCard = if FFlagVoiceVolumeControlsPerUserPlayerGridMenu then tbl2.openedVolumeUiCard else nil
    local uxVariant = getPerUserVoiceVolumeUxVariant()
    TelemetryService:LogEvent(TelemetryConfigs.PerUserVoiceVolumeSession.eventConfig, {
        customFields = {
            playSessionId = playSessionId,
            voiceSessionId = voiceSessionId,
            openedVolumeUi = openedVolumeUiList == true or openedVolumeUiCard == true,
            openedVolumeUiList = openedVolumeUiList,
            openedVolumeUiCard = openedVolumeUiCard,
            changedPerUserVolume = tbl2.changedPerUserVolume,
            uxVariant = uxVariant
        },
        standardizedFields = { "addPlaceId", "addUniverseId" }
    })

    tbl2.openedVolumeUiList = false
    tbl2.openedVolumeUiCard = false
    tbl2.changedPerUserVolume = false
end

function module.resetPerUserVoiceVolumeSession(_)
    if not FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then
        return
    end

    resetPerUserVoiceVolumeSessionState()
end

return module
