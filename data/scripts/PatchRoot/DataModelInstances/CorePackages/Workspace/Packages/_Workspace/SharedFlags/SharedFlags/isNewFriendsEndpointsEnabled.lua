-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:11:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local SharedFlagsParent = script:FindFirstAncestor("SharedFlags").Parent

local Players = game:GetService("Players")
local ThrottleUserId = require(SharedFlagsParent.AppCommonLib).ThrottleUserId

return function()
    return ThrottleUserId(game:DefineFastInt("LuaChatUseNewFriendsEndpointsV2", 0), Players.LocalPlayer.UserId)
end
