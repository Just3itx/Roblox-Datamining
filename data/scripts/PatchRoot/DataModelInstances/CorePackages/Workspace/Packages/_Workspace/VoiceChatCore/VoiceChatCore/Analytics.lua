-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:20:57Z
-- Luau bytecode version: 9 | Luau type version: 3
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

function module.reportBanMessageEventV2(tbl2, eventType: string, banReason: number, userId: number, voiceSessionId: string)
    tbl2:_report(
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

function module:reportReceivedNudge(tbl2, userId: number, voiceSessionId: string)
    local unixTimestampMillis = DateTime.fromIsoDate(tbl2.deliveryTime).UnixTimestampMillis
    local durationInMs = DateTime.now().UnixTimestampMillis - unixTimestampMillis
    self._impl:ReportCounter("voicechat-receivednudge", 1)
    self._impl:ReportCounter("voicechat-receivednudgeduration", durationInMs)
    self._impl:SendEventDeferred(
        "client",
        "voiceChat",
        "receivedNudge",
        {
            type = tbl2.type,
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

function module:reportVoiceMuteIndividual(tbl2)
    self._impl:SendEventDeferred("client", "voice", "voiceUIMuteUnmuteIndividual", {
        user_id = tbl2.userId,
        client_session_id = tbl2.clientSessionId,
        target_user_id = tbl2.targetUserId,
        channel_id = tbl2.channelId,
        context = tbl2.context,
        muted = tbl2.muted
    })
end

function module:reportVoiceMuteGroup(tbl2)
    self._impl:SendEventDeferred("client", "voice", "voiceUIMuteUnmuteGroup", {
        user_id = tbl2.userId,
        client_session_id = tbl2.clientSessionId,
        channel_id = tbl2.channelId,
        context = tbl2.context,
        group_type = tbl2.groupType,
        muted = tbl2.muted
    })
end

function module:reportVoiceMuteSelf(tbl2)
    self._impl:SendEventDeferred("client", "voice", "voiceUIMuteUnmuteSelf", {
        user_id = tbl2.userId,
        client_session_id = tbl2.clientSessionId,
        channel_id = tbl2.channelId,
        context = tbl2.context,
        muted = tbl2.muted
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

function module.reportVoiceVolumeEligibility(_, tbl2)
    local config = {
        eventName = "VoiceVolumeControlsEligibility",
        backends = { "EventIngest" },
        throttlingPercentage = game:GetFastInt("LuaVoiceVolumeControlsEligibilityThrottleHundredthsPercent"),
        lastUpdated = { 2026, 7, 7 },
        description = "Records voice volume eligibility state on voice join for VVC telemetry",
        links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/voice/voice_volume_controls_eligibility.proto"
    }

    local customFields = {
        playSessionId = tbl2.playSessionId,
        voiceSessionId = tbl2.voiceSessionId,
        voiceChatVolume = tbl2.voiceChatVolume,
        usesNewAudioApi = tbl2.usesNewAudioApi,
        enablesVoiceVolumeControls = tbl2.enablesVoiceVolumeControls,
        isEligible = tbl2.isEligible
    }
    TelemetryService:LogEvent(
        config,
        {
            customFields = customFields,
            standardizedFields = { "addPlaceId", "addUniverseId" }
        }
    )
end

function module.reportVoiceVolumeImpressions(_, tbl2)
    local config = {
        eventName = "VoiceVolumeControlsImpressions",
        backends = { "EventIngest" },
        throttlingPercentage = game:GetFastInt("LuaVoiceVolumeControlsImpressionsThrottleHundredthsPercent"),
        lastUpdated = { 2026, 7, 7 },
        description = "Records whether the voice volume slider was seen during a voice session for Voice Volume Controls telemetry. Only recorded for voice volume control eligible users",
        links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/voice/voice_volume_controls_impressions.proto"
    }

    local customFields = {
        playSessionId = tbl2.playSessionId,
        voiceSessionId = tbl2.voiceSessionId,
        sliderSeen = tbl2.sliderSeen,
        voiceJoinTimestampMs = tbl2.voiceJoinTimestampMs,
        sliderSeenTimestampMs = tbl2.sliderSeenTimestampMs
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

return module
