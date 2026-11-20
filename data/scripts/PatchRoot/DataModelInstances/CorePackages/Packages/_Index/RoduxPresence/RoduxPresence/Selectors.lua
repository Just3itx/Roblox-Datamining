-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getUserPresenceByUserId = require(script.getUserPresenceByUserId)

return function(arg1)
    return {
        getUserPresenceByUserId = getUserPresenceByUserId(arg1)
    }
end
