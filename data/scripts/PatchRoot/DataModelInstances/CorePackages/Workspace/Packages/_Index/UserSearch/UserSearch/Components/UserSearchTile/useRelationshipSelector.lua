-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local React = require(UserSearchParent.React)
local useSelector = require(UserSearchParent.RoactUtils).Hooks.RoactRodux.useSelector
local SignalsReact = require(UserSearchParent.SignalsReact)
local RODUX_KEY = require(UserSearch.Common.Constants).RODUX_KEY
local getDeepValue = require(UserSearchParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue
local FFlagMigrateFriendshipStatusesUserSearch = require(UserSearch.Flags.FFlagMigrateFriendshipStatusesUserSearch)
local FFlagSduiUserSearchTile = require(UserSearchParent.SharedFlags).FFlagSduiUserSearchTile

local FFlagUserSearchRefreshPendingFriendshipStatus = require(UserSearch.Flags.FFlagUserSearchRefreshPendingFriendshipStatus)
local useGetFriendshipStatus = require(UserSearchParent.FriendsHydrationReact).useGetFriendshipStatus
local FollowingStore = require(UserSearchParent.DataHydration.Following).FollowingStore
local LocalUserIdStore = require(UserSearchParent.LocalUserIdStore).LocalUserIdStore
local var1 = require(UserSearchParent.DataHydration).Friends.FriendsStore.get()

local tbl1 = { skipFetch = true }

local function useRefetchPendingFriendshipStatus(localUserId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    React.useEffect(function()
        local friendshipStatus = var1.GetFriendshipStatus(localUserId, tbl1)
        if friendshipStatus and friendshipStatus.data(false) == Enum.FriendStatus.FriendRequestSent then
            var1.RefetchFriendshipStatus(localUserId)
        end
    end, { localUserId })
end

return function(localUserId: string)
    if FFlagSduiUserSearchTile then
        local status = useGetFriendshipStatus(localUserId)
        if FFlagUserSearchRefreshPendingFriendshipStatus then
            useRefetchPendingFriendshipStatus(localUserId)
        end

        local var3 = React.useMemo(function()
            return FollowingStore.get().GetIsFollowing(localUserId)
        end, { localUserId })
        return {
            status = status,
            following = SignalsReact.useSignalState(var3.data) == true,
            isMyself = SignalsReact.useSignalState(LocalUserIdStore.getCurrentUserId) == localUserId
        }
    end

    local var2 = nil
    if FFlagMigrateFriendshipStatusesUserSearch then
        var2 = useGetFriendshipStatus(localUserId, tbl1)
        if FFlagUserSearchRefreshPendingFriendshipStatus then
            useRefetchPendingFriendshipStatus(localUserId)
        end
    end

    return useSelector(function(arg1)
        local deepValue = getDeepValue(arg1, string.format("%s.Friends.followings.followingStatuses.%s", RODUX_KEY, localUserId)) or {}

        return {
            status = if FFlagMigrateFriendshipStatusesUserSearch then var2 else getDeepValue(arg1, string.format("%s.Friends.friendshipStatus.%s", RODUX_KEY, localUserId)),
            following = deepValue.isFollowing or false,
            isMyself = arg1.LocalUserId == localUserId
        }
    end)
end
