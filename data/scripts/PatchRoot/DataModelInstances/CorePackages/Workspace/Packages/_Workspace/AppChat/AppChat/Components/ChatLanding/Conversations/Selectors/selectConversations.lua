-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local getDeepValue = require(AppChat.Utils.getDeepValue)
local populateConversationWithState = require(AppChat.Conversations.populateConversationWithState)

local function conversationSortPredicate(arg1, arg2): boolean
    if arg1.unixTime and arg2.unixTime then
        return arg1.unixTime > arg2.unixTime
    end

    if arg1.unixTime or arg2.unixTime then
        return (arg1.unixTime or arg2.unixTime) == arg1.unixTime
    end

    return string.lower(arg1.title) < string.lower(arg2.title)
end

local var1 = nil
local var2 = nil
return function(arg1)
    local deepValue = getDeepValue(arg1, "ChatAppReducer.Conversations")
    if not deepValue then
        return {}
    end

    if deepValue == var1 then
        return var2
    end
    local result = {}
    for _, value in pairs(deepValue) do
        table.insert(result, (populateConversationWithState(arg1, value)))
    end

    table.sort(result, conversationSortPredicate)

    var1 = deepValue
    var2 = result

    return result
end
