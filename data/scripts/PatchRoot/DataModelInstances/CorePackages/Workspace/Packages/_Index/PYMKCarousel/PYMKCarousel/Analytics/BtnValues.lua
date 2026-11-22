-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local enumerate = dependencies.enumerate
local getFFlagPYMKAddFriendsEntry = dependencies.getFFlagPYMKAddFriendsEntry

return enumerate(script.Name, {
    RequestFriendship = "requestFriendship",
    OpenPeopleList = "openPeopleList",
    AcceptFriendship = "acceptFriendship",
    FindFriends = if getFFlagPYMKAddFriendsEntry() then "findFriends" else "",
    SeeAll = if getFFlagPYMKAddFriendsEntry() then "seeAll" else ""
})
