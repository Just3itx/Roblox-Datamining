-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local Signals = require(FriendsChatParent.Signals)
local _MessageEnvelopeModel = require(FriendsChatParent.ChatUIPrimitives.MessageEnvelopeModel)
local GetConversationMessageStore = require(FriendsChatParent.AppChat.GetConversationMessageStore)

local _NameInfo = require(script.Parent.Parent.MessageDisplayStore.NameInfo)
local createFrozenSortTimes = require(script.Parent.Parent.MessageDisplayStore.createFrozenSortTimes)
local resolveNameInfos = require(script.Parent.Parent.MessageDisplayStore.resolveNameInfos)
local getLocalUserId = require(script.Parent.Parent.Parent.Utils.getLocalUserId)
local _useLocalize = require(script.Parent.Parent.Parent.Utils.useLocalize)
local buildMessageEnvelopes = require(script.Parent.buildMessageEnvelopes)
local getReplyQuote = require(script.Parent.getReplyQuote)

local var1 = table.freeze({})

local function currentUnixMilliseconds(): number
    return DateTime.now().UnixTimestampMillis
end

local function isSameNameInfo(arg1, arg2): boolean
    return arg1.name == arg2.name and arg1.username == arg2.username
end

return {
    create = function(arg1, tbl1) -- name: createConversationEnvelopes
        local tbl2 = ({})
        local frozenSortTimes = createFrozenSortTimes({ now = tbl1.now or currentUnixMilliseconds })

        local tbl3 = ({})
        local function getNameInfo(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
            local var2 = tbl3[num1]
            if var2 ~= nil then
                return var2
            end
            local computed = Signals.createComputed(function(arg2)
                return resolveNameInfos({ num1 }, arg2)[num1] or { name = nil, username = nil }
            end, isSameNameInfo)
            tbl3[num1] = computed
            return computed
        end

        local function getMessageEnvelopes(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
            local var2 = tbl2[str1]
            if var2 ~= nil then
                return var2
            end
            local computed = Signals.createComputed(function(arg2)
                local conversationMessageStore = GetConversationMessageStore(arg2)
                local message = conversationMessageStore.getMessage(str1, arg2)
                if message == nil then
                    return var1
                end

                local tbl4 = {}
                if message.sender_user_id ~= nil then
                    table.insert(tbl4, message.sender_user_id)
                end
                local repliesTo = message.replies_to
                local replyQuote

                if repliesTo == nil then
                    replyQuote = nil
                else
                    if repliesTo.sender_user_id ~= nil then
                        table.insert(tbl4, repliesTo.sender_user_id)
                    end

                    local message2 = if repliesTo.id then conversationMessageStore.getMessage(repliesTo.id, arg2) else nil
                    replyQuote = getReplyQuote(repliesTo, message2)
                end

                local namesByUserId = ({})
                for _, value in tbl4 do
                    namesByUserId[value] = getNameInfo(value)(arg2)
                end
                return buildMessageEnvelopes(message, {
                    localUserId = getLocalUserId(),
                    namesByUserId = namesByUserId,
                    sentAtUnixMilliseconds = frozenSortTimes(str1, arg2),
                    replyQuote = replyQuote,
                    isGroup = tbl1.getIsGroup(arg2),
                    localize = tbl1.localize
                })
            end)
            tbl2[str1] = computed
            return computed
        end

        return {
            getEnvelopes = Signals.createComputed(function(arg2)
                local result = {}
                local num1 = 0
                for _, value in arg1(arg2) do
                    if tbl1.maxMessages > 0 and tbl1.maxMessages <= num1 then
                        break
                    end

                    local var2 = getMessageEnvelopes(value)(arg2)
                    if not (#var2 > 0) then
                        continue
                    end

                    num1 += 1
                    for _, value2 in var2 do
                        table.insert(result, value2)
                    end
                end

                return result
            end)
        }
    end
}
