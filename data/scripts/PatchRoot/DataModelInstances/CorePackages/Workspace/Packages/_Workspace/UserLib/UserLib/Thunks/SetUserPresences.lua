-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local receiveUsersPresence = require(UserLib.Utils.receiveUsersPresence)

return function(arg1)
    return function(arg2)
        receiveUsersPresence(arg1, arg2)
    end
end
