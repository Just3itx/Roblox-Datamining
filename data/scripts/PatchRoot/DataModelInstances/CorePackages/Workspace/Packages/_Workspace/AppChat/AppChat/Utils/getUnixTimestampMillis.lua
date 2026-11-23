-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local _AppChatParent = AppChat.Parent

local parseIsoDateUnixMillis = require(AppChat.Utils.parseIsoDateUnixMillis)

local function getUnixTimestampMillis(arg1)
    if typeof(arg1) == "DateTime" then
        return arg1.UnixTimestampMillis
    end
    if type(arg1) == "string" then
        return parseIsoDateUnixMillis(arg1)
    end
    if type(arg1) ~= "table" or arg1.GetUnixTimestamp == nil then
        return nil
    end

    return math.round(arg1:GetUnixTimestamp() * 1000)
end

return getUnixTimestampMillis
