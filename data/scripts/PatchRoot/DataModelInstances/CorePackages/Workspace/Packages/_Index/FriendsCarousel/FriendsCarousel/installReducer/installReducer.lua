-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCarousel = script:FindFirstAncestor("FriendsCarousel")
local dependencies = require(FriendsCarousel.dependencies)

local Rodux = dependencies.Rodux
local RoduxNetworking = dependencies.RoduxNetworking

local Friends = require(script.Parent.Friends)

return function()
    return Rodux.combineReducers({ Friends = Friends, NetworkStatus = RoduxNetworking.installReducer() })
end
