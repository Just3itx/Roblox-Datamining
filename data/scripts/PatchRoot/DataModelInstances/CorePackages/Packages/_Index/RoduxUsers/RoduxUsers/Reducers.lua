-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxUsersParent = script:FindFirstAncestor("RoduxUsers").Parent
local Rodux = require(RoduxUsersParent.Rodux)

local byUserId = require(script.Users.byUserId)
local byUsername = require(script.Users.byUsername)

return function(arg1)
    return Rodux.combineReducers({ byUserId = byUserId(arg1), byUsername = byUsername(arg1) })
end
