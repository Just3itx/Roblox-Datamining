-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, bool1: boolean?)
    if bool1 then
        return Enum.FriendStatus.FriendRequestReceived
    end

    return arg1 or Enum.FriendStatus.NotFriend
end
