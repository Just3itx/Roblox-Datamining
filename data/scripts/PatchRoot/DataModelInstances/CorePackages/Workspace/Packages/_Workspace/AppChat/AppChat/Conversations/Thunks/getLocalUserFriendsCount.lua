-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local AppChat = script:FindFirstAncestor("AppChat")

local NetworkingFriends = require(AppChat.Http.NetworkingFriends)

return function()
    return function(arg1)
        if Players.LocalPlayer then
            return arg1:dispatch(NetworkingFriends.GetFriendsCountFromUserId.API(Players.LocalPlayer.UserId))
        end
    end
end
