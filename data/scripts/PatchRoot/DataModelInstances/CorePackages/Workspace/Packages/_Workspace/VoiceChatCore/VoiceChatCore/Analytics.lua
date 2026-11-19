-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local SessionService = game:GetService("SessionService")
local TelemetryService = game:GetService("TelemetryService")
game:DefineFastInt("LuaVoiceChatThrottleHundrethsPercent", 10000)
game:DefineFastInt("LuaVoiceVolumeControlsEligibilityThrottleHundredthsPercent", 10000)
game:DefineFastInt("LuaVoiceVolumeControlsImpressionsThrottleHundredthsPercent", 10000)

game:DefineFastInt("LuaVoiceChatAnalyticsPointsThrottle", 0)
game:DefineFastFlag("LuaVoiceChatAnalyticsUsePointsV2", false)
game:DefineFastFlag("LuaVoiceChatAnalyticsUseCounterV2", false)
game:DefineFastFlag("LuaVoiceChatAnalyticsUseEventsV2", false)
game:DefineFastFlag("LuaVoiceChatAnalyticsBanMessage", true)
game:DefineFastFlag("LuaVoiceChatReconnectMissedSequence", false)

local module = ({})
module.__index = module

module.INFO = "info"
module.WARNING = "warning"
module.ERROR = "error"

local tbl1 = {
    Shown = {
        eventName = "VoiceRewarmShown",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 10, 22 },
        description = "The voice rewarm join-voice icon became available in the Chrome top bar, at most once per session. Rewarm clicks from VR or the settings menu have no matching Shown. customFields: rearmed (true when the user had already consumed a rewarm and FIntVoiceRewarmReArmCount re-armed it).",
        links = ""
    },
    Clicked = {
        eventName = "VoiceRewarmClicked",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 10, 22 },
        description = "The user clicked the voice rewarm join-voice icon, consuming the rewarm. customFields: rearmed, consequence (what JoinVoice did, e.g. FirstJoinSession, FaeUpsell, ConsentModal, or none).",
        links = ""
    }
}

local tbl2 = {
    Connected = {
        eventName = "VoiceConnected",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 11, 3 },
        description = "Counted wherever the voiceConnectEvent event stream event is sent, so the two stay comparable. customFields: source (the VOICE_CONNECTION_SOURCE that started the join: AUTO_CONNECT, IN_EXPERIENCE, SETTINGS_TOGGLE_ON, or none). User-initiated connects are every source except AUTO_CONNECT.",
        links = ""
    },
    Disconnected = {
        eventName = "VoiceDisconnected",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 11, 3 },
        description = "The voice session reached the Ended state, counted alongside the voiceDisconnectReasonEvent event stream event. customFields: reason (the VOICE_DISCONNECT_REASON: USER_DISCONNECT when the user turned voice off, MODERATED, or SYSTEM for everything else).",
        links = ""
    }
}

function module.new(_impl)
    _impl = _impl or RbxAnalyticsService

    assert(_impl, "Analytics impl must not be nil.")

    return (setmetatable({ _impl = _impl }, module))
end

local function stub() end

function module.stubService()
    return {
        SetRBXEvent = stub,
        SetRBXEventStream = stub,
        SendEventDeferred = stub,
        ReportCounter = stub,
        ReportStats = stub,
        ReportInfluxSeries = stub
    }
end

function module:setImpl(_impl)
    self._impl = _impl
end

function module:_report(arg1, arg2, arg3, arg4)
    local var1 = arg1 .. "-" .. arg2
    if game:GetFastFlag("LuaVoiceChatAnalyticsUsePointsV2") then
        self._impl:ReportInfluxSeries(var1, arg4, game:GetFastInt("LuaVoiceChatAnalyticsPointsThrottle"))
    end
    if game:GetFastFlag("LuaVoiceChatAnalyticsUseCounterV2") then
        if arg3 then
            var1 ..= "-" .. arg3
        end

        if arg4 and arg4.result then
            var1 ..= "-" .. arg4.result
        end

        self._impl:ReportCounter(var1, 1)
    end
    if game:GetFastFlag("LuaVoiceChatAnalyticsUseEventsV2") then
        self._impl:SendEventDeferred("client", arg1, arg2, arg4)
    end
end

function module.reportVoiceChatJoinResult(arg1, success, arg2, logLevel)
    arg1:_report(
        "voiceChat",
        "defaultChannelJoinResults",
        arg2,
        {
            success = success,
            result = arg2,
            logLevel = logLevel or module.INFO
        }
    )
end

function module:reportBanMessageEvent(str1: string)
    if game:GetFastFlag("LuaVoiceChatAnalyticsBanMessage") then
        self._impl:ReportCounter("voiceChat-reportBanMessage" .. str1, 1)
    end
end

function module.reportBanMessageEventV2(tbl3, eventType: string, banReason: number, userId: number, voiceSessionId: string)
    tbl3:_report(
        "voiceChat",
        "reportBanEvent",
        nil,
        {
            eventType = eventType,
            banReason = banReason,
            userId = userId,
            voiceSessionId = voiceSessionId
        }
    )
end

function module:reportReconnectDueToMissedSequence()
    if game:GetFastFlag("LuaVoiceChatReconnectMissedSequence") then
        self._impl:ReportCounter("voiceChat-reconnectMissedSequence", 1)
    end
end

function module:reportOutOfOrderSequence()
    self._impl:ReportCounter("voiceChat-outOfOrderSequence", 1)
end

function module:reportReceivedNudge(tbl3, userId: number, voiceSessionId: string)
    local unixTimestampMillis = DateTime.fromIsoDate(tbl3.deliveryTime).UnixTimestampMillis
    local durationInMs = DateTime.now().UnixTimestampMillis - unixTimestampMillis
    self._impl:ReportCounter("voicechat-receivednudge", 1)
    self._impl:ReportCounter("voicechat-receivednudgeduration", durationInMs)
    self._impl:SendEventDeferred(
        "client",
        "voiceChat",
        "receivedNudge",
        {
            type = tbl3.type,
            durationInMs = durationInMs,
            userId = userId,
            voiceSessionId = voiceSessionId
        }
    )
end

function module:reportClosedNudge(userId: number, voiceSessionId: string)
    self._impl:ReportCounter("voicechat-closednudge", 1)
    self._impl:SendEventDeferred(
        "client",
        "voiceChat",
        "closedNudge",
        { userId = userId, voiceSessionId = voiceSessionId, closeType = "CLOSED" }
    )
end

function module:reportAcknowledgedNudge(userId: number, voiceSessionId: string)
    self._impl:ReportCounter("voicechat-acknowledgednudge", 1)
    self._impl:SendEventDeferred(
        "client",
        "voiceChat",
        "closedNudge",
        { userId = userId, voiceSessionId = voiceSessionId, closeType = "ACKNOWLEDGED" }
    )
end

function module:reportDeniedNudge(userId: number, voiceSessionId: string)
    self._impl:ReportCounter("voicechat-deniednudge", 1)
    self._impl:SendEventDeferred(
        "client",
        "voiceChat",
        "closedNudge",
        { userId = userId, voiceSessionId = voiceSessionId, closeType = "DENIED" }
    )
end

function module:reportVoiceMuteIndividual(tbl3)
    self._impl:SendEventDeferred("client", "voice", "voiceUIMuteUnmuteIndividual", {
        user_id = tbl3.userId,
        client_session_id = tbl3.clientSessionId,
        target_user_id = tbl3.targetUserId,
        channel_id = tbl3.channelId,
        context = tbl3.context,
        muted = tbl3.muted
    })
end

function module:reportVoiceMuteGroup(tbl3)
    self._impl:SendEventDeferred("client", "voice", "voiceUIMuteUnmuteGroup", {
        user_id = tbl3.userId,
        client_session_id = tbl3.clientSessionId,
        channel_id = tbl3.channelId,
        context = tbl3.context,
        group_type = tbl3.groupType,
        muted = tbl3.muted
    })
end

function module:reportVoiceMuteSelf(tbl3)
    self._impl:SendEventDeferred("client", "voice", "voiceUIMuteUnmuteSelf", {
        user_id = tbl3.userId,
        client_session_id = tbl3.clientSessionId,
        channel_id = tbl3.channelId,
        context = tbl3.context,
        muted = tbl3.muted
    })
end

function module:reportJoinVoiceButtonEvent(eventType: string, universeId: number, placeId: number, playSessionId: string, buttonContext: string?, buttonConsequence: string?)
    self._impl:SendEventDeferred("client", "voice", "joinVoiceButtonEvent", {
        eventType = eventType,
        universeId = universeId,
        placeId = placeId,
        playSessionId = playSessionId,
        buttonContext = buttonContext,
        buttonConsequence = buttonConsequence
    })
end

function module:reportJoinVoiceButtonEventWithVoiceSessionId(eventType: string, universeId: number, placeId: number, playSessionId: string, voiceSessionId: string, buttonContext: string?, buttonConsequence: string?)
    self._impl:SendEventDeferred("client", "voice", "joinVoiceButtonEvent", {
        eventType = eventType,
        universeId = universeId,
        placeId = placeId,
        playSessionId = playSessionId,
        voiceSessionId = voiceSessionId,
        buttonContext = buttonContext,
        buttonConsequence = buttonConsequence
    })
end

function module.reportJoinVoiceUpsellEvent(_, str1: string, playSessionId: string, userIsAgeVerified: boolean, buttonContext: string?, buttonConsequence: string?)
    local config = {
        eventName = "joinVoiceUpsell" .. str1,
        backends = { "EventIngest" },
        throttlingPercentage = game:GetFastInt("LuaVoiceChatThrottleHundrethsPercent"),
        lastUpdated = { 2025, 10, 30 },
        description = "Event fired when user sees or interacts with Join Voice button",
        links = "https://github.rbx.com/Roblox/proto-schemas/pull/8530"
    }

    local customFields = {
        user_is_age_verified = userIsAgeVerified,
        button_context = buttonContext,
        button_consequence = buttonConsequence,
        clientTimeStamp = DateTime.now().UnixTimestampMillis,
        playSessionId = playSessionId,
        sd_platform_id = SessionService:GetSessionID("level0"),
        sd_logged_in_id = SessionService:GetSessionID("level1")
    }
    TelemetryService:LogEvent(
        config,
        {
            customFields = customFields,
            standardizedFields = { "addPlaceId", "addUniverseId", "addSessionInfo" }
        }
    )
end

function module:reportLeaveVoiceButtonEvent(eventType: string, universeId: number, placeId: number, playSessionId: string, voiceSessionId: string)
    self._impl:SendEventDeferred("client", "voice", "leaveVoiceButtonEvent", {
        eventType = eventType,
        universeId = universeId,
        placeId = placeId,
        playSessionId = playSessionId,
        voiceSessionId = voiceSessionId
    })
end

function module:reportInExpConsent(eventType: string, entry: string, universeId: number, placeId: number, playSessionId: string)
    self._impl:SendEventDeferred(
        "client",
        "voiceChat",
        "inExpConsentModalEvent",
        {
            eventType = eventType,
            entry = entry,
            universeId = universeId,
            placeId = placeId,
            playSessionId = playSessionId
        }
    )
end

function module:reportDevicePermissionsModalEvent(eventType: string, voiceSessionId: string, universeId: number, placeId: number, str1: string)
    local playSessionId = string.sub(str1, 2, #str1 - 1)

    self._impl:SendEventDeferred("client", "voiceChat", "devicePermissionsModalEvent", {
        eventType = eventType,
        universeId = universeId,
        placeId = placeId,
        playSessionId = playSessionId,
        voiceSessionId = voiceSessionId
    })
end

function module:reportConnectDisconnectEvents(arg1, arg2)
    self._impl:SendEventDeferred("client", "voiceChat", arg1, arg2)
end

function module:reportVoiceEvents(arg1, arg2)
    self._impl:SendEventDeferred("client", "voice", arg1, arg2)
end

function module.reportVoiceVolumeEligibility(_, tbl3)
    local config = {
        eventName = "VoiceVolumeControlsEligibility",
        backends = { "EventIngest" },
        throttlingPercentage = game:GetFastInt("LuaVoiceVolumeControlsEligibilityThrottleHundredthsPercent"),
        lastUpdated = { 2026, 7, 7 },
        description = "Records voice volume eligibility state on voice join for VVC telemetry",
        links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/voice/voice_volume_controls_eligibility.proto"
    }

    local customFields = {
        playSessionId = tbl3.playSessionId,
        voiceSessionId = tbl3.voiceSessionId,
        voiceChatVolume = tbl3.voiceChatVolume,
        usesNewAudioApi = tbl3.usesNewAudioApi,
        enablesVoiceVolumeControls = tbl3.enablesVoiceVolumeControls,
        isEligible = tbl3.isEligible
    }
    TelemetryService:LogEvent(
        config,
        {
            customFields = customFields,
            standardizedFields = { "addPlaceId", "addUniverseId" }
        }
    )
end

function module.reportVoiceVolumeImpressions(_, tbl3)
    local config = {
        eventName = "VoiceVolumeControlsImpressions",
        backends = { "EventIngest" },
        throttlingPercentage = game:GetFastInt("LuaVoiceVolumeControlsImpressionsThrottleHundredthsPercent"),
        lastUpdated = { 2026, 7, 7 },
        description = "Records whether the voice volume slider was seen during a voice session for Voice Volume Controls telemetry. Only recorded for voice volume control eligible users",
        links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/voice/voice_volume_controls_impressions.proto"
    }

    local customFields = {
        playSessionId = tbl3.playSessionId,
        voiceSessionId = tbl3.voiceSessionId,
        sliderSeen = tbl3.sliderSeen,
        voiceJoinTimestampMs = tbl3.voiceJoinTimestampMs,
        sliderSeenTimestampMs = tbl3.sliderSeenTimestampMs
    }
    TelemetryService:LogEvent(
        config,
        {
            customFields = customFields,
            standardizedFields = { "addPlaceId", "addUniverseId" }
        }
    )
end

function module.reportVoiceRewarmShown(_, bool1: boolean)
    TelemetryService:LogCounter(tbl1.Shown, { customFields = { rearmed = tostring(bool1) } }, 1)
end

function module.reportVoiceRewarmClicked(_, bool1: boolean, consequence: string?)
    TelemetryService:LogCounter(
        tbl1.Clicked,
        {
            customFields = {
                rearmed = tostring(bool1),
                consequence = consequence or "none"
            }
        },
        1
    )
end

function module.reportVoiceConnected(_, source: string?)
    TelemetryService:LogCounter(tbl2.Connected, { customFields = { source = source or "none" } }, 1)
end

function module.reportVoiceDisconnected(_, reason: string?)
    TelemetryService:LogCounter(tbl2.Disconnected, { customFields = { reason = reason or "none" } }, 1)
end

return module
