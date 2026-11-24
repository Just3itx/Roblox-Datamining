-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCallingService = game:GetService("FriendsCallingService")

local FriendsCallingParent = script:FindFirstAncestor("FriendsCalling").Parent

local Signals = require(FriendsCallingParent.Signals)

local createFriendsCallingStore = require(script.createFriendsCallingStore)

return Signals.createComputed(function()
    return createFriendsCallingStore(FriendsCallingService)
end)
