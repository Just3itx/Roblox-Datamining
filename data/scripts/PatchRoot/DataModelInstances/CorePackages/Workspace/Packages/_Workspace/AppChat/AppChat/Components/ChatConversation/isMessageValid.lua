-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local isOverLength = require(AppChat.Utils.isOverLength)
local FFlagAppChatUseGraphemeMessageLength = require(AppChat.Flags.FFlagAppChatUseGraphemeMessageLength)

return function(arg1, arg2)
    if FFlagAppChatUseGraphemeMessageLength then
        if isOverLength(arg1, arg2, 300) then
            return false
        end
    elseif arg2 < #arg1 then
        return false
    end

    return not arg1:match("^%s*$")
end
