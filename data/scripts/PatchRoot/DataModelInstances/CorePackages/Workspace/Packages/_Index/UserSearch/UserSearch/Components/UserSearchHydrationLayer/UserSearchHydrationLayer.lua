-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local React = require(UserSearchParent.React)
local Cryo = require(UserSearchParent.Cryo)

local useMatchSearchPagination = require(UserSearch.Utils.useMatchSearchPagination)

local usePaginatedProfileInsightsFetch = require(script.Parent.Parent.ProfileInsightsContextFetchWrapper.usePaginatedProfileInsightsFetch)
local useDispatch = require(UserSearchParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NetworkingPresence = require(UserSearch.Networking.NetworkingPresence)
local _LocalTypes = require(UserSearch.Common.LocalTypes)
local HydrateFriendStatuses = require(UserSearch.Thunks.HydrateFriendStatuses)
local HydrateFollowingStatuses = require(UserSearch.Thunks.HydrateFollowingStatuses)

local FFlagPlayerSearchEnableOnlineFrequents = require(UserSearchParent.SharedFlags).FFlagPlayerSearchEnableOnlineFrequents

local FFlagPlayerSearchEnableOnlineFrequentsForAll = require(UserSearchParent.SharedFlags).FFlagPlayerSearchEnableOnlineFrequentsForAll
local FFlagUserSearchClassmatesInsight = require(UserSearchParent.SharedFlags).FFlagUserSearchClassmatesInsight
local FFlagUserSearchPresenceStoreMigration = require(UserSearch.Flags.FFlagUserSearchPresenceStoreMigration)
local FFlagMigrateFriendshipStatusesUserSearch = require(UserSearch.Flags.FFlagMigrateFriendshipStatusesUserSearch)
local FFlagSduiUserSearchTile = require(UserSearchParent.SharedFlags).FFlagSduiUserSearchTile
local var1 = if FFlagMigrateFriendshipStatusesUserSearch or FFlagSduiUserSearchTile then require(UserSearchParent.DataHydration).Friends.FriendsStore.get() else nil
local var2 = if FFlagSduiUserSearchTile then require(UserSearchParent.DataHydration.Following).FollowingStore.get() else nil
local var3 = if FFlagSduiUserSearchTile then require(UserSearchParent.DataHydration.ProfileInsights).ProfileInsightsStore.get() else nil
local _GraphQLServer = require(UserSearchParent.GraphQLServer)

return function(tbl1)
    local var4 = useDispatch()
    local var5 = useMatchSearchPagination({ users = tbl1.users })

    local mappedProfilesInsights = FFlagSduiUserSearchTile and {}
        or usePaginatedProfileInsightsFetch({
            users = tbl1.users or {},
            searchKeyword = tbl1.searchParameters.searchKeyword,
            rankingStrategy = if FFlagPlayerSearchEnableOnlineFrequents and tbl1.enableOnlineFrequents or FFlagPlayerSearchEnableOnlineFrequentsForAll then "profile_info_boost" else nil
        })
        or {}

    local var7 = React.useMemo(function()
        return Cryo.List.map(var5, function(arg1)
            return arg1.id
        end)
    end, { tbl1.users })

    React.useEffect(function()
        if not FFlagUserSearchPresenceStoreMigration then
            var4(NetworkingPresence.GetPresencesFromUserIds.API(var7))
        end
        if FFlagSduiUserSearchTile then
            local rankingStrategy = if FFlagPlayerSearchEnableOnlineFrequentsForAll then "profile_info_boost" else nil
            local tbl2 = {
                rankingStrategy = rankingStrategy,
                count = if FFlagUserSearchClassmatesInsight and rankingStrategy then 3 else nil
            }
            for _, value in var7 do
                var2.GetIsFollowing(value)
                var3.GetProfileInsight(value, tbl2)
            end
        else
            var4(HydrateFollowingStatuses(var7))
        end
        if FFlagMigrateFriendshipStatusesUserSearch or FFlagSduiUserSearchTile then
            for _, value in var7 do
                var1.GetFriendshipStatus(value)
            end

            return
        end

        var4(HydrateFriendStatuses(var7))
    end, { var7 })

    return tbl1.renderComponent({ mappedProfilesInsights = mappedProfilesInsights })
end
