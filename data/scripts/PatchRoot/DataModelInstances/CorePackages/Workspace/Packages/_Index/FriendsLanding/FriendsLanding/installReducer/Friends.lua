-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local RoduxFriends = require(FriendsLanding.dependencies).RoduxFriends
local convertActions = require(script.Parent.convertActions)
local friendsActionAdaptor = require(script.Parent.friendsActionAdaptor)

local tbl1 = {
    countsByUserId = {},
    byUserId = {},
    requests = { receivedCount = 0 }
}

return function(arg1)
    return convertActions(RoduxFriends.installReducer(), friendsActionAdaptor(arg1), tbl1)
end
