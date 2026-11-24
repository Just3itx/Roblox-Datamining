-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function mapFriendshipStatusToEnum(str1: string?)
    if str1 == "NotFriends" then
        return Enum.FriendStatus.NotFriend
    elseif str1 == "Friends" then
        return Enum.FriendStatus.Friend
    elseif str1 == "RequestSent" then
        return Enum.FriendStatus.FriendRequestSent
    elseif str1 == "RequestReceived" then
        return Enum.FriendStatus.FriendRequestReceived
    end

    return Enum.FriendStatus.Unknown
end

return mapFriendshipStatusToEnum
