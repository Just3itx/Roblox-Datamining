-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)

local Rodux = dependencies.Rodux
local RoduxNetworking = dependencies.RoduxNetworking

return function()
    return Rodux.combineReducers({ Friends = require(script.Friends)(), NetworkStatus = RoduxNetworking.installReducer() })
end
