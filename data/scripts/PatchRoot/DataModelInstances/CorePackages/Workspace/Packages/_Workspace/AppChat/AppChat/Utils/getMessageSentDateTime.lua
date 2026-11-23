-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local _AppChatParent = AppChat.Parent

local parseIsoDateUnixMillis = require(AppChat.Utils.parseIsoDateUnixMillis)

local function parseIsoDate(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(str1) ~= "string" then
        return nil
    end
    local unixTimestampMillis = parseIsoDateUnixMillis(str1)
    if unixTimestampMillis ~= nil then
        return DateTime.fromUnixTimestampMillis(unixTimestampMillis)
    end

    return nil
end

local function getMessageSentDateTime(tbl1)
    local sent = tbl1.sent
    if sent ~= nil then
        if type(sent) == "string" then
            return parseIsoDate(sent)
        end

        return sent
    end
    return parseIsoDate(tbl1.created_at or tbl1.createdAt)
end

return getMessageSentDateTime
