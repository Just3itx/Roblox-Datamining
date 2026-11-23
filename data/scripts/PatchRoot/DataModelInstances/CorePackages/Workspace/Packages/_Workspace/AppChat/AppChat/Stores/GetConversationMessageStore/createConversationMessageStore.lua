-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local createProxy = require(AppChatParent.SignalsExperimental).createProxy

local _Types = require(AppChat.MessageData.Types)
local SignalsMigrationConfig = require(AppChat.Flags.SignalsMigrationConfig)
local FFlagAppChatParseMessageTimestampsOnce = require(AppChat.Flags.FFlagAppChatParseMessageTimestampsOnce)
local parseIsoDateUnixMillis = require(AppChat.Utils.parseIsoDateUnixMillis)

local function keepSendingMessageStableKey(arg1, arg2)
    if arg1 ~= nil
        and arg1.stableKey ~= nil
        and arg1.stableKey ~= arg1.id
        and (arg2.stableKey == nil or arg2.stableKey == arg2.id)
    then
        return Cryo.Dictionary.join(arg2, { stableKey = arg1.stableKey })
    end
    return arg2
end

local function getCreatedAtUnixMillis(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg2 ~= nil and arg2.created_at == arg1.created_at and arg2.createdAtUnixMillis ~= nil then
        return arg2.createdAtUnixMillis
    end
    return parseIsoDateUnixMillis(arg1.created_at)
end

local function withCreatedAtUnixMillis(arg1, arg2)
    local tbl1 = {}
    local createdAtUnixMillis = if arg2 ~= nil and arg2.created_at == arg1.created_at and arg2.createdAtUnixMillis ~= nil then arg2.createdAtUnixMillis else getCreatedAtUnixMillis(arg1, nil)

    if createdAtUnixMillis ~= arg1.createdAtUnixMillis then
        if createdAtUnixMillis == nil then
            createdAtUnixMillis = Cryo.None
        end

        tbl1.createdAtUnixMillis = createdAtUnixMillis
    end

    local repliesTo = arg1.replies_to
    if repliesTo ~= nil then
        local repliesTo2 = if arg2 == nil then nil else arg2.replies_to
        local createdAtUnixMillis2 = if repliesTo2 ~= nil and repliesTo2.created_at == repliesTo.created_at and repliesTo2.createdAtUnixMillis ~= nil then repliesTo2.createdAtUnixMillis else getCreatedAtUnixMillis(repliesTo, nil)

        if createdAtUnixMillis2 ~= repliesTo.createdAtUnixMillis then
            local join = Cryo.Dictionary.join
            local tbl2 = { createdAtUnixMillis = 0 }
            if createdAtUnixMillis2 == nil then
                createdAtUnixMillis2 = Cryo.None
            end

            tbl2.createdAtUnixMillis = createdAtUnixMillis2
            tbl1.replies_to = join(repliesTo, tbl2)
        end
    end

    if next(tbl1) == nil then
        return arg1
    end
    return Cryo.Dictionary.join(arg1, tbl1)
end

local function createConversationMessageStore()
    local messages = createProxy({})

    return {
        messages = messages,
        getMessage = function(str1: string, arg1)
            return messages(arg1)[str1]
        end,
        upsertMessages = function(tbl1)
            for value, value2 in tbl1 do
                if SignalsMigrationConfig.shouldUseViewRecyclerMessageList then
                    value2 = keepSendingMessageStableKey(messages[value], value2)
                end
                if FFlagAppChatParseMessageTimestampsOnce then
                    value2 = withCreatedAtUnixMillis(value2, messages[value])
                end
                messages[value] = value2
            end
        end,
        updateMessage = function(str1: string, tbl1)
            local var1 = messages[str1]
            if var1 == nil then
                return
            end

            local var2 = Cryo.Dictionary.join(var1, tbl1)
            if FFlagAppChatParseMessageTimestampsOnce then
                var2 = withCreatedAtUnixMillis(var2, var1)
            end
            messages[str1] = var2
        end,
        removeMessage = function(str1: string)
            messages[str1] = nil
        end,
        clear = function()
            for value in messages do
                messages[value] = nil
            end
        end
    }
end

return createConversationMessageStore
