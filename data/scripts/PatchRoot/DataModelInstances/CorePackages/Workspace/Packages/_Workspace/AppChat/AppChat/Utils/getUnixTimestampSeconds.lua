-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _AppChatParent = script:FindFirstAncestor("AppChat").Parent

local function getUnixTimestampSeconds(arg1)
    if typeof(arg1) == "DateTime" then
        return arg1.UnixTimestamp
    elseif type(arg1) == "table" and arg1.GetUnixTimestamp ~= nil then
        return arg1:GetUnixTimestamp()
    end
    return nil
end

return getUnixTimestampSeconds
