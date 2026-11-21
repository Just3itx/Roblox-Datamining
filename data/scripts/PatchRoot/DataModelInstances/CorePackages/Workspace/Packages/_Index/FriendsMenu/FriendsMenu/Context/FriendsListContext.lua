-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent
local React = require(FriendsMenuParent.React)

local _friendsMenuModalType = require(FriendsMenu.friendsMenuModalType)

return (React.createContext({
    friends = {},
    hasFriends = false,
    isFetchingFriends = false,
    isFriendsListFetchFailed = false,
    searchFriends = function()
        return {}
    end,
    fetchMoreFriends = function()
        return {}
    end,
    searchFriendsString = "",
    friendsNames = { loading = true }
}))
