-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local Rodux = require(UserSearchParent.Rodux)
local Presence = require(UserSearch.Rodux.Presence)
local Friends = require(UserSearch.Rodux.Friends)
local myRoduxNetworking = require(UserSearch.Networking.myRoduxNetworking)

local FFlagUserSearchPresenceStoreMigration = require(UserSearch.Flags.FFlagUserSearchPresenceStoreMigration)

return function()
    return Rodux.combineReducers({
        Presence = if FFlagUserSearchPresenceStoreMigration then nil else Presence,
        NetworkStatus = myRoduxNetworking.installReducer(),
        Friends = Friends
    })
end
