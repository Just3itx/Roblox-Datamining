-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { ice = "ICE", sdp = "SDP", ssrc = "SSRC", acs = "ACS", rtc = "RTC" }

local tbl2 = { "State", "Operation", "Event" }

local function stripTrailingSuffix(str1: string)
    for _, value in tbl2 do
        local num1 = #str1 - #value
        if num1 > 0 and str1:sub(num1 + 1) == value then
            return str1:sub(1, num1)
        end
    end
    return str1
end

local function splitPascalCase(str1: string)
    local result = {}
    local str2 = ""
    for i = 1, #str1 do
        local str3 = str1:sub(i, i)
        local str4 = str1:sub(i + 1, i + 1)
        str2 ..= str3
        local bool1 = str3:match("%u") ~= nil
        local bool2 = str4:match("%u") ~= nil
        if not bool1 and bool2 or bool1 and bool2 and str1:sub(i + 2, i + 2):match("%l") then
            result[#result + 1] = str2
            str2 = ""
        end
    end

    if str2 ~= "" then
        result[#result + 1] = str2
    end
    return result
end

local function canonicalizeWord(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[str1:lower()] or str1
end

local function humanizeName(str1: string): string
    local tbl3 = splitPascalCase(stripTrailingSuffix(str1))
    for value, value2 in tbl3 do
        tbl3[value] = canonicalizeWord(value2)
    end
    return table.concat(tbl3, " ")
end

local operationTypeLabels = {
    ClientJoinOperation = "Join",
    ClientLeaveOperation = "Leave",
    ClientPublishOperation = "Publish",
    ClientSubscribeOperation = "Subscribe",
    ClientMuteUnmuteOperation = "Mute/Unmute",
    ClientPeerLocalMuteUnmuteOperation = "Peer Local Mute/Unmute",
    ClientPeerRemoteMuteUnmuteOperation = "Peer Remote Mute/Unmute",
    ClientCullingOperation = "Culling",
    ClientICETrickleOperation = "ICE Trickle",
    ClientTurnAuthOperation = "TURN Auth",
    ClientSubscriberAudioQualityOperation = "Subscriber Audio Quality",
    ClientVoiceRtcStatsOperation = "Voice RTC Stats",
    ClientVoiceRtcStatsMonitorOperation = "Voice RTC Stats Monitor",
    ClientVoiceWebrtcConnectionChangesOperation = "WebRTC Connection Changes",
    ClientRebootOperation = "Reboot",
    ClientContextParsingOperation = "Context Parsing",
    ConnectOperation = "Connect"
}

local eventNameLabels = {
    ClientRetryJoin = "Client Retry Join",
    ClientRetryJoinWithConfig = "Client Retry Join With Config",
    VoiceChatplayerMuteStatusChangedEvent = "Player Mute Status Changed",
    SubscribeStateChange = "Subscribe State Change",
    PublishStateChange = "Publish State Change",
    JoinedVoice = "Joined Voice",
    JoinedVoiceV2 = "Joined Voice V2",
    PublishingHandshakeAcked = "Publishing Handshake Acked",
    PublishingHandshakeCompleted = "Publishing Handshake Completed",
    PublishingHandshakeInitiated = "Publishing Handshake Initiated",
    PublishingHandshakeInitiatedWithBothSdp = "Publishing Handshake Initiated (Both SDP)",
    PublishingHandshakeAckedWithBothSdp = "Publishing Handshake Acked (Both SDP)",
    PublishingHandshakeInitiatedWithCompressedSdp = "Publishing Handshake Initiated (Compressed SDP)",
    PublishingHandshakeAckedWithCompressedSdp = "Publishing Handshake Acked (Compressed SDP)",
    UpdateTurnAuthInfoRequest = "Update TURN Auth Info Request",
    ACSCleanup = "ACS Cleanup",
    ReJoinedVoice = "Rejoined Voice",
    ReJoinedVoiceV2 = "Rejoined Voice V2",
    UserTurnAuth = "User TURN Auth",
    UserTurnAuthV2 = "User TURN Auth V2",
    FetchUserTurnAuthOperationFailed = "Fetch User TURN Auth Failed",
    RelayCandidatesGathered = "Relay Candidates Gathered",
    VoiceChatClientVoiceCapability = "Client Voice Capability",
    VoiceChatClientVoiceCapabilityWithConfig = "Client Voice Capability (With Config)",
    VoiceChatPlayerMuteStateChangedClientToServer = "Player Mute State Changed (Client to Server)",
    VoiceChatPlayerMuteStateChangedServerToClient = "Player Mute State Changed (Server to Client)",
    VoiceChatSampleTaggedEventClientToServer = "Sample Tagged Event (Client to Server)",
    VoiceChatSampleTaggedEventServerToClient = "Sample Tagged Event (Server to Client)",
    VoiceSetupFailed = "Voice Setup Failed",
    SubscriptionReset = "Subscription Reset",
    SsrcUserIdMappingUpdate = "SSRC/User ID Mapping Update",
    ClientStreamSwitchAck = "Client Stream Switch Ack",
    SubscriptionHandshakeInitiated = "Subscription Handshake Initiated",
    SubscriptionHandshakeAcked = "Subscription Handshake Acked",
    SubscriptionHandshakeInitiatedWithBothSdp = "Subscription Handshake Initiated (Both SDP)",
    SubscriptionHandshakeAckedWithBothSdp = "Subscription Handshake Acked (Both SDP)",
    SubscriptionHandshakeInitiatedWithCompressedSdp = "Subscription Handshake Initiated (Compressed SDP)",
    SubscriptionHandshakeAckedWithCompressedSdp = "Subscription Handshake Acked (Compressed SDP)",
    SubscriptionHandshakeCompleted = "Subscription Handshake Completed",
    VoiceChatSubscriptionInitialBatchEmpty = "Subscription Initial Batch Empty",
    SubscriptionFeedStarted = "Subscription Feed Started",
    VoiceMigration = "Voice Migration",
    SubscriberAudioQualitySample = "Subscriber Audio Quality Sample"
}

return {
    operationTypeLabels = operationTypeLabels,
    eventNameLabels = eventNameLabels,
    humanizeName = humanizeName,
    labelForOperationType = function(str1: string)
        return operationTypeLabels[str1] or humanizeName(str1)
    end,
    labelForEventName = function(str1: string)
        return eventNameLabels[str1] or humanizeName(str1)
    end
}
