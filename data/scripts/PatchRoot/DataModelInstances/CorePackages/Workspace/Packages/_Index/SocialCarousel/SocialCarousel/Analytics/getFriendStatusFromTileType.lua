-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent

local SharedFlags = require(SocialCarouselParent.SharedFlags)
local Tile = require(SocialCarousel.Common.Enums).Tile

local FFlagShowRequestsInCarouselForAllUsers = SharedFlags.FFlagShowRequestsInCarouselForAllUsers

local function getFriendStatusFromTileType(str1: string?)
    if FFlagShowRequestsInCarouselForAllUsers and str1 == Tile.FriendRequest then
        return Enum.FriendStatus.FriendRequestReceived
    end

    if str1 == Tile.Friend then
        return Enum.FriendStatus.Friend
    end

    return Enum.FriendStatus.NotFriend
end

return getFriendStatusFromTileType
