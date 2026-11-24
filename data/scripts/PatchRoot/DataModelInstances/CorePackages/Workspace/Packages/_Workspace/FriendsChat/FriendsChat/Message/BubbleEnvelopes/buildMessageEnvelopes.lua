-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local MessageEnvelopeModel = require(FriendsChatParent.ChatUIPrimitives.MessageEnvelopeModel)
local MessageDraftModel = require(FriendsChatParent.ChatUIPrimitives.MessageDraftModel)
local PlainTextContentModel = require(FriendsChatParent.ChatUIPrimitives.PlainTextContentModel)
local SystemContentModel = require(FriendsChatParent.ChatUIPrimitives.SystemContentModel)

local NameInfo = require(script.Parent.Parent.MessageDisplayStore.NameInfo)
local classifyMessage = require(script.Parent.Parent.MessageDisplayStore.classifyMessage)
local rowCopy = require(script.Parent.Parent.MessageDisplayStore.rowCopy)
local _useLocalize = require(script.Parent.Parent.Parent.Utils.useLocalize)

local function nameOf(tbl1, num1: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = tbl1[num1]
    return if var1 and var1.name then var1.name else ""
end

local function authorOf(tbl1, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        userId = tostring(num1),
        displayName = nameOf(tbl1, num1)
    }
end

local function systemEnvelope(id: string, sentAtUnixMilliseconds: number, str2: string, str3: string)
    return MessageEnvelopeModel.incoming({
        id = id,
        sentAtUnixMilliseconds = sentAtUnixMilliseconds,
        author = nil,
        contents = { SystemContentModel.fromSystem(str2, str3) }
    })
end

local function repliesToOf(arg1, tbl1)
    local repliesTo = arg1.replies_to
    local replyQuote = tbl1.replyQuote
    if type(repliesTo) ~= "table" or repliesTo.sender_user_id == nil or replyQuote == nil then
        return nil
    end
    local label = rowCopy.replyLabelText({
        senderUserId = arg1.sender_user_id,
        repliedToUserId = repliesTo.sender_user_id,
        localUserId = tbl1.localUserId,
        isGroup = tbl1.isGroup == true,
        namesByUserId = tbl1.namesByUserId,
        localize = tbl1.localize
    })

    return {{
        id = repliesTo.id or "",
        preview = { fallbackText = replyQuote },
        label = label
    }}
end

local function buildMessageEnvelopes(arg1, tbl1)
    local messageEnvelopes = {}
    local sentAtUnixMilliseconds = tbl1.sentAtUnixMilliseconds
    local namesByUserId = tbl1.namesByUserId

    for _, value in classifyMessage(arg1) do
        if value.kind == "userText" then
            local author = authorOf(namesByUserId, value.senderUserId)

            if arg1.status == "Pending" and value.senderUserId == tbl1.localUserId then
                table.insert(
                    messageEnvelopes,
                    MessageEnvelopeModel.sending(arg1.id, MessageDraftModel.fromPlainText(value.body), author, sentAtUnixMilliseconds)
                )
            else
                local var1 = if value.moderated then rowCopy.maskedBody(value) else value.body
                local repliesTo = repliesToOf(arg1, tbl1)
                local tbl3 = {
                    id = arg1.id,
                    sentAtUnixMilliseconds = sentAtUnixMilliseconds,
                    author = author,
                    contents = { PlainTextContentModel.fromText(var1) },
                    repliesTo = repliesTo
                }
                local stableKey = arg1.stableKey

                if type(stableKey) == "string" and stableKey ~= arg1.id then
                    local var3 = MessageEnvelopeModel.sending(stableKey, MessageDraftModel.fromPlainText(value.body), author, sentAtUnixMilliseconds)

                    table.insert(messageEnvelopes, MessageEnvelopeModel.acknowledged(var3, tbl3, sentAtUnixMilliseconds))
                else
                    table.insert(messageEnvelopes, MessageEnvelopeModel.incoming(tbl3))
                end
            end
        elseif value.kind == "hiddenUser" then
            if not NameInfo.isNameLoading(namesByUserId[value.senderUserId]) then
                local var1 = rowCopy.hiddenNoticeText(nameOf(namesByUserId, value.senderUserId), tbl1.localize)
                table.insert(messageEnvelopes, systemEnvelope(arg1.id, sentAtUnixMilliseconds, var1, rowCopy.HIDDEN_ICON))
            end
        elseif value.kind == "systemMessage" then
            table.insert(
                messageEnvelopes,
                systemEnvelope(arg1.id, sentAtUnixMilliseconds, value.body, rowCopy.systemIcon(value.variant))
            )
        elseif value.kind == "moderationNotice" then
            table.insert(
                messageEnvelopes,
                systemEnvelope(
                    arg1.id .. ":moderation",
                    sentAtUnixMilliseconds,
                    rowCopy.moderatedNoticeText(tbl1.localize),
                    rowCopy.MODERATED_ICON
                )
            )
        end
    end

    return messageEnvelopes
end

return buildMessageEnvelopes
