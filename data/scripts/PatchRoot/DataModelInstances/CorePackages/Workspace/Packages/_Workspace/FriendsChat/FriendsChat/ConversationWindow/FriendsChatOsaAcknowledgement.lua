-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)
local SignalsReact = require(FriendsChatParent.SignalsReact)
local AppChatNetworking = require(FriendsChatParent.AppChatNetworking)

local GetConversationStore = require(FriendsChatParent.AppChat.GetConversationStore)
local fetchConversationDetailsToSignals = require(FriendsChatParent.AppChat.fetchConversationDetailsToSignals)
local useIsGuiInChatVisible = require(FriendsChatParent.AppChat.useIsGuiInChatVisible)

local var1 = require(FriendsChatParent.ExpChatShared).Logger:new(script.Name)
local tbl1 = ({})
local tbl2 = ({})
local tbl3 = ({})
local tbl4 = ({})

local function getSubmissionKey(conversationId: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer
    return `{if localPlayer then localPlayer.UserId else 0}:{conversationId}`
end

local function isRetryable(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) ~= "table" then
        return true
    end
    local var2 = arg1.StatusCode or arg1.statusCode or arg1.responseCode
    return var2 == nil or var2 <= 0 or var2 == 408 or var2 == 429 or var2 >= 500
end

local function markAcknowledged(conversationId: string)
    local conversationStore = GetConversationStore(false)
    local conversation = conversationStore.getConversation(conversationId, false)
    if conversation
        and conversation.osaAcknowledgementStatus ~= AppChatNetworking.Constants.OsaAcknowledgementStatusResponse.Acknowledged
    then
        local var2 = table.clone(conversation)
        var2.osaAcknowledgementStatus = AppChatNetworking.Constants.OsaAcknowledgementStatusResponse.Acknowledged
        conversationStore.upsertConversation(var2)
    end
end

return {
    useAcknowledgement = function(tbl5) -- name: useFriendsChatOsaAcknowledgement
        local var2 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                return GetConversationStore(arg1).getConversation(tbl5.conversationId, arg1)
            end)
        end, { tbl5.conversationId })
        local var3 = SignalsReact.useSignalState(var2)
        local bool1 = not (var3 == nil)
            and var3.osaAcknowledgementStatus == AppChatNetworking.Constants.OsaAcknowledgementStatusResponse.Unacknowledged
        local source = if var3 then var3.source else nil
        local var4 = useIsGuiInChatVisible(tbl5.guiObjectRef, { tbl5.guiObjectRef.current })
        local var5, var6 = React.useState(0)

        React.useEffect(function()
            local conversationId = tbl5.conversationId
            local submissionKey = getSubmissionKey(conversationId)

            if conversationId == "" or not bool1 or not var4 or tbl1[submissionKey] or tbl4[submissionKey] then
                return
            end

            local bool2 = false
            local function scheduleRetry(arg1)
                local var7 = tbl3[submissionKey] or 0
                local bool3 = isRetryable(arg1)

                if not bool3 or var7 >= 4 then
                    tbl4[submissionKey] = true
                    return
                end
                local num1 = 2 ^ math.max(var7 - 1, 0) * 1
                task.delay(num1, function()
                    if not bool2 then
                        var6(function(arg2): number
                            return arg2 + 1
                        end)
                    end
                end)
            end
            local var7 = tbl2[submissionKey]
            if var7 then
                var7:catch(scheduleRetry)
                return function()
                    bool2 = true
                end
            end

            local bool3 = source == "friends"
            local var8 = AppChatNetworking.http.RecordModalSequenceResponse(nil, {
                actionType = "record_has_seen",
                modalSequence = "conversation_inline_top_modal",
                modalVariant = "OsaContextCard",
                conversationId = if bool3 then nil else conversationId,
                friendId = if bool3 then tbl5.userId else nil
            })
            tbl3[submissionKey] = (tbl3[submissionKey] or 0) + 1
            tbl2[submissionKey] = var8

            var8:andThen(function()
                tbl2[submissionKey] = nil
                tbl3[submissionKey] = nil
                tbl1[submissionKey] = true
                markAcknowledged(conversationId)
                if bool3 then
                    return
                end

                fetchConversationDetailsToSignals(conversationId):andThen(function()
                    markAcknowledged(conversationId)
                end):catch(function(arg1)
                    var1:warning(`Failed to refresh conversation after Friends Chat OSA acknowledgement: {tostring(arg1)}`)
                end)
            end):catch(function(arg1)
                tbl2[submissionKey] = nil
                var1:error(`Failed to record Friends Chat OSA acknowledgement: {tostring(arg1)}`)
                scheduleRetry(arg1)
            end)
            return function()
                bool2 = true
            end
        end, {
            tbl5.conversationId,
            tbl5.userId,
            bool1,
            var4,
            source,
            var5
        })
    end,
    hasSubmitted = function(str1: string): boolean
        local tbl5 = tbl1
        local localPlayer = Players.LocalPlayer
        return tbl5[`{if localPlayer then localPlayer.UserId else 0}:{str1}`] == true
    end
}
