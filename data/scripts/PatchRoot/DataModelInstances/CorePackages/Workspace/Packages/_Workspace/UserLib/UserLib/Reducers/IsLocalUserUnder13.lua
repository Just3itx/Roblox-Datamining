-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local SetLocalUserUnder13 = require(UserLib.Actions.SetLocalUserUnder13)

return function(arg1, arg2)
    return if arg2.type == SetLocalUserUnder13.name then arg2.isUnder13 else arg1 == true
end
