-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local Conversation = require(AppChat.Models.Conversation)

local function set(tbl1, arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if tbl1[arg1] == arg2 then
        return tbl1
    end
    local var1 = table.clone(tbl1)
    var1[arg1] = arg2
    return var1
end

local function updateConversationMessages(arg1, arg2, str1: string)
    local tbl1 = {}
    for value, value2 in arg1[str1]:CreateIterator() do
        if not arg2[str1]:Get(value) then
            table.insert(tbl1, value2)
        end
    end
    if #tbl1 > 0 then
        arg2[str1] = arg2[str1]:Insert(table.unpack(tbl1))
    end
end

local function updateConversationField(arg1, arg2, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg2[str1] == nil then
        arg2[str1] = arg1[str1]
    end
end

local function updateConversationToState(tbl1, arg1)
    if arg1.conversationType == Conversation.Type.ONE_TO_ONE_CONVERSATION then
        local var1 = Conversation.IdForFakeOneOnOne(arg1.participants)

        if tbl1[var1] ~= nil and tbl1[var1] ~= arg1 then
            tbl1 = set(tbl1, var1, nil)
        end
    end

    local var1 = set(tbl1, arg1.id, arg1)
    local var2 = tbl1[arg1.id]
    local var3 = var1[arg1.id]
    if var3 and var2 then
        updateConversationMessages(var2, var3, "messages")
        updateConversationMessages(var2, var3, "sendingMessages")
        updateConversationField(var2, var3, "previousCursor")
        updateConversationField(var2, var3, "nextCursor")
        updateConversationField(var2, var3, "fetchedOldestMessage")
    end

    return var1
end

return updateConversationToState
