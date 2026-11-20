-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _VoiceChatServiceManager = require(script.Parent.VoiceChatServiceManager)

local MethodsOfAbuse = { voice = "voice", text = "text", other = "other" }

function GetDefaultMethodOfAbuse(tbl2, arg1)
    if not tbl2 then
        return if arg1:GetMutedAnyone() then MethodsOfAbuse.voice else MethodsOfAbuse.text
    end

    return if arg1:getRecentUsersInteractionData()[tostring(tbl2.UserId)] then MethodsOfAbuse.voice else MethodsOfAbuse.text
end

return {
    MethodsOfAbuse = MethodsOfAbuse,
    GetDefaultMethodOfAbuse = GetDefaultMethodOfAbuse
}
