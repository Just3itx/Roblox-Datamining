-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

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

function module.reportBanMessageEventV2(tbl1, eventType: string, banReason: number, userId: number, voiceSessionId: string)
    tbl1:_report(
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

function module:reportVoiceMuteIndividual(tbl1)
    self._impl:SendEventDeferred("client", "voice", "voiceUIMuteUnmuteIndividual", {
        user_id = tbl1.userId,
        client_session_id = tbl1.clientSessionId,
        target_user_id = tbl1.targetUserId,
        channel_id = tbl1.channelId,
        context = tbl1.context,
        muted = tbl1.muted
    })
end

function module:reportVoiceMuteGroup(tbl1)
    self._impl:SendEventDeferred("client", "voice", "voiceUIMuteUnmuteGroup", {
        user_id = tbl1.userId,
        client_session_id = tbl1.clientSessionId,
        channel_id = tbl1.channelId,
        context = tbl1.context,
        group_type = tbl1.groupType,
        muted = tbl1.muted
    })
end

function module:reportVoiceMuteSelf(tbl1)
    self._impl:SendEventDeferred("client", "voice", "voiceUIMuteUnmuteSelf", {
        user_id = tbl1.userId,
        client_session_id = tbl1.clientSessionId,
        channel_id = tbl1.channelId,
        context = tbl1.context,
        muted = tbl1.muted
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

return module
