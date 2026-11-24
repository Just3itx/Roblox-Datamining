-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local ChatMute = require(GenericAbuseReportingParent.ChatMute)

local ExpChatShared = require(GenericAbuseReportingParent.ExpChatShared)

local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)
local FFlagExpChatUseChatMuteStore = SharedFlags.FFlagExpChatUseChatMuteStore
local FFlagAbuseReportVoiceMute = SharedFlags.FFlagAbuseReportVoiceMute

local function voiceMutePlayer(userId: number, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not (FFlagAbuseReportVoiceMute and arg1) then
        return
    end
    local participants = arg1.participants
    if not participants then
        return
    end
    local participant = participants[tostring(userId)]
    if participant and not participant.isMutedLocally then
        arg1:ToggleMutePlayer(userId, "igm-report-v2")
    end
end

function muteUser(userId: number, arg1, arg2): boolean
    if not (userId and arg1) then
        return false
    end

    if userId == arg1.UserId then
        return false
    end

    if FFlagExpChatUseChatMuteStore then
        ChatMute.mutePlayer({ userId = tostring(userId) })
        if not FFlagAbuseReportVoiceMute then
            return true
        end

        voiceMutePlayer(userId, arg2)
        return true
    end

    local context = ExpChatShared.context
    if not context.store then
        return false
    end

    if not context.messagesStore then
        return false
    end

    context.messagesStore.muteUser(userId)
    if FFlagAbuseReportVoiceMute then
        voiceMutePlayer(userId, arg2)
    end

    return true
end

function isUserMuted(num1: number)
    if not num1 then
        return false
    end

    if FFlagExpChatUseChatMuteStore then
        return ChatMute.isUserIdMuted(tostring(num1))
    end

    local context = ExpChatShared.context
    return if context.store then if context.messagesStore then context.messagesStore.getMutedUserIds(false)[tostring(num1)] == true else false else false
end

return {
    isUserMuted = isUserMuted,
    muteUser = muteUser
}
