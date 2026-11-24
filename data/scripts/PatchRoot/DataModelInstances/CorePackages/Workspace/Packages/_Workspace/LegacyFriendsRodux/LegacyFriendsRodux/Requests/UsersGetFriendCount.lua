-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LegacyFriendsRoduxParent = script:FindFirstAncestor("LegacyFriendsRodux").Parent
local Players = game:GetService("Players")

local Url = require(LegacyFriendsRoduxParent.Http).Url

local isNewFriendsEndpointsEnabled = require(LegacyFriendsRoduxParent.SharedFlags).isNewFriendsEndpointsEnabled

return function(arg1)
    local var1 = string.format("%s/user/get-friendship-count?%s", Url.API_URL, tostring(Players.LocalPlayer.UserId))

    if isNewFriendsEndpointsEnabled() then
        var1 = string.format("%s/my/friends/count", Url.FRIEND_URL)
    end

    return arg1(var1, "GET")
end
