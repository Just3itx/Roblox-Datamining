-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent

local RoactUtils = require(ProfileQRCodeParent.RoactUtils)

local configureRoduxFriends = require(ProfileQRCode.Networking.configureRoduxFriends)

local FFlagMigrateFriendshipStatusesRemainingActions = require(ProfileQRCodeParent.SharedFlags).FFlagMigrateFriendshipStatusesRemainingActions

local var1 = require(ProfileQRCodeParent.DataHydration).Friends.FriendsStore.get()

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

return function()
    local var2 = useDispatch()

    return function(currentUserId: string, targetUserId: string)
        if FFlagMigrateFriendshipStatusesRemainingActions then
            return var1.AcceptFriendRequest(targetUserId)
        end
        return var2(
            configureRoduxFriends.AcceptFriendRequestFromUserId.API({ currentUserId = currentUserId, targetUserId = targetUserId })
        )
    end
end
