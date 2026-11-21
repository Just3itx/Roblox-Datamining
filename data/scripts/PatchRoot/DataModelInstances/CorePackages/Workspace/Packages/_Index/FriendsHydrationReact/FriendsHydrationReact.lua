-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local _DataHydration = require(scriptParent.DataHydration)

return {
    ["jest.config"] = script["jest.config"],
    useGetOnlineFriends = require(script.useGetOnlineFriends),
    useGetOnlineFriendsByUniverseId = require(script.useGetOnlineFriendsByUniverseId),
    useGetAllFriends = require(script.useGetAllFriends),
    useGetIsFriendWith = require(script.useGetIsFriendWith),
    useGetFriendshipStatus = require(script.useGetFriendshipStatus),
    useGetFriendsCountByUserId = require(script.useGetFriendsCountByUserId)
}
