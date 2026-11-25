-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local SetLocalUserId = require(UserLib.Actions.SetLocalUserId)

return function(str1: string?, arg1)
    return if arg1.type == SetLocalUserId.name then arg1.userId else str1 or ""
end
