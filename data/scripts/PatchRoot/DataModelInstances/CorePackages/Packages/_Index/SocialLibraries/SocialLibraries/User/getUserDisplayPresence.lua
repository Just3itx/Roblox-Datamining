-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getPresenceTextFromUser = require(script.Parent.getPresenceTextFromUser)
local presenceImageByPresence = require(script.Parent.presenceImageByPresence)

return function(arg1)
    return {
        text = getPresenceTextFromUser(arg1),
        image = presenceImageByPresence[arg1.presence]
    }
end
