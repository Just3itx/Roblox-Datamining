-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent

local _friendsMenuModalType = require(FriendsMenu.friendsMenuModalType)
local Constants = require(FriendsMenu.Constants)
local GetFFlagFriendsMenuDummyLoadingFriendsFix = require(FriendsMenuParent.SharedFlags).GetFFlagFriendsMenuDummyLoadingFriendsFix

local function func1(num1: number)
    return {
        displayName = "",
        friendFrequentRank = num1,
        friendRank = num1,
        hasVerifiedBadge = false,
        id = GetFFlagFriendsMenuDummyLoadingFriendsFix() and Constants.DummyFriendsPrefix .. tostring(num1) or tostring(num1),
        isFetching = true,
        isFriend = true,
        lastLocation = "",
        lastOnline = DateTime.now(),
        name = "",
        presence = "",
        isLoadingPlaceholder = true
    }
end

return function(num1: number)
    local result = ({})
    for i = 1, num1 do
        result[i] = func1(i)
    end
    return result
end
