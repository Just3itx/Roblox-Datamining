-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function isOneToOneChatToast(tbl1): boolean
    local content = tbl1.content
    if content == nil or content.currentState == nil or content.states == nil then
        return false
    end

    local var1 = content.states[content.currentState]
    if var1 == nil or var1.visualItems == nil then
        return false
    end

    local num1 = 0
    for _, visualItem in var1.visualItems do
        if visualItem.thumbnail ~= nil then
            num1 += 1
        end
    end
    return num1 == 1
end

local function shouldHideFriendsChatToast(tbl1, conversationId: string?)
    if tbl1 == nil or conversationId == nil then
        return false
    end

    local content = tbl1.content
    local clientEventsPayload = if content then content.clientEventsPayload else tbl1.clientEventsPayload
    local var1 = clientEventsPayload and (clientEventsPayload.sender_id or clientEventsPayload.sender_userid)
    if var1 ~= nil and isOneToOneChatToast(tbl1) and conversationId == `friends:{tostring(var1)}` then
        return true
    end

    local conversationId2 = clientEventsPayload and clientEventsPayload.conversation_id
    if conversationId2 == conversationId then
        return true
    end
    if type(conversationId2) ~= "string" then
        return false
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(conversationId2)
    end)

    return success and type(result) == "table" and result.conversationId == conversationId
end

return shouldHideFriendsChatToast
