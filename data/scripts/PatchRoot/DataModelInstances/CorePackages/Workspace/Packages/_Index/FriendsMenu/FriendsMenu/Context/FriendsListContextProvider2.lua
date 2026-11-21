-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local utils = scriptParentParent.utils
local FriendsMenuDependencies = require(scriptParentParent.FriendsMenuDependencies)

local React = require(scriptParentParentParent.React)
local UserLib = require(scriptParentParentParent.UserLib)
local RoactUtils = require(scriptParentParentParent.RoactUtils)
local UserProfiles = require(scriptParentParentParent.UserProfiles)
local FriendsCommon = require(scriptParentParentParent.FriendsCommon)
local Cryo = require(scriptParentParentParent.Cryo)
local GraphQLServer = require(scriptParentParentParent.GraphQLServer)

local Constants = UserLib.Utils.Constants
local ThumbnailRequest = UserLib.Utils.ThumbnailRequest
local PreloadUsersThumbnail = UserLib.Thunks.PreloadUsersThumbnail

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local sortFriendsByCorrectedPresenceAndRank = FriendsMenuDependencies.sortFriendsByCorrectedPresenceAndRank
local networkImpl = FriendsMenuDependencies.networkImpl
local PresenceType = GraphQLServer.types.PresenceType
local GetFriendsSearch = require(scriptParentParent.Requests.GetFriendsSearch)
local Constants2 = require(scriptParentParent.Constants)
local SortInvitesByScoreIXP = require(scriptParentParent.Experiments.SortInvitesByScoreIXP)

local FriendsListContext = require(scriptParent.FriendsListContext)
local useFriendsListOrderedByPresence = FriendsCommon.Hooks.useFriendsListOrderedByPresence
local generateDummyFriends = require(utils.generateDummyFriends)

local FFlagFilterOutDeletedAccountsGameInvites = require(scriptParentParent.Flags.FFlagFilterOutDeletedAccountsGameInvites)

local FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt = require(scriptParentParentParent.SharedFlags).FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt

local UserModel = UserLib.Models.UserModel
local tbl1 = {
    InviteAvatarThumbnailType = Constants.RbxAvatarThumbnailTypesFromEnum.HeadShot,
    InviteAvatarThumbnailSize = Constants.RbxThumbnailSizes.Size150x150,
    InviteAvatarRbxthumbType = Constants.RbxthumbTypes.AvatarHeadShot
}
tbl1.ThumbnailRequest = {
    InviteToGame = { ThumbnailRequest.fromData(tbl1.InviteAvatarThumbnailType, tbl1.InviteAvatarThumbnailSize) }
}

return function(tbl2)
    local var1 = if SortInvitesByScoreIXP.FFlagEnableSortInvitesByScoreExperiment then SortInvitesByScoreIXP.useSortInvitesByScoreExperiment() else nil
    local var2 = if tbl2.networkImplOverride then tbl2.networkImplOverride else networkImpl
    local var3 = if Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else "0"
    local var4 = useDispatch()
    local searchFriendsString, searchFriends = React.useState("")
    local var7, var8 = React.useState(true)
    local tbl3 = {}
    local friends, var10 = React.useState((generateDummyFriends(10)))

    local var11 = useFriendsListOrderedByPresence({ userId = var3, pageSize = 50, shouldListenToPresenceUpdates = false })
    local var12 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = {},
            query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
        }
    )
    local function func1(userIds, arg1: {[any]: any}?)
        var4(PreloadUsersThumbnail(userIds, tbl1.ThumbnailRequest.InviteToGame, nil))
        var12:fetchMore({ variables = { userIds = userIds } }):andThen(function(arg2)
            local tbl4 = {}
            for _, id in userIds do
                if tbl2.excludedFriendsSet and tbl2.excludedFriendsSet[id] then
                    continue
                end

                local offline = UserModel.PresenceType.OFFLINE
                local lastLocation = nil
                for _, onlineFriend in var11.onlineFriends do
                    if id ~= onlineFriend.id then
                        continue
                    end

                    if onlineFriend.presence then
                        local userPresenceType = onlineFriend.presence.userPresenceType
                        if userPresenceType == PresenceType.InGame then
                            offline = UserModel.PresenceType.IN_GAME
                        elseif userPresenceType == PresenceType.Online then
                            offline = UserModel.PresenceType.ONLINE
                        elseif userPresenceType == PresenceType.InStudio then
                            offline = UserModel.PresenceType.IN_STUDIO
                        end
                        lastLocation = onlineFriend.presence.lastLocation
                    end

                    break
                end

                for _, value in arg2.data.userProfiles do
                    if FFlagFilterOutDeletedAccountsGameInvites and value.names.username == Constants2.NameAccountDeleted or value.id ~= id then
                        continue
                    end

                    table.insert(tbl4, {
                        id = id,
                        presence = offline,
                        lastLocation = lastLocation,
                        displayName = value.names.combinedName,
                        name = value.names.username,
                        friendRank = if var1 or SortInvitesByScoreIXP.FFlagSortInvitesByScoreEnabledForAll then arg1 and arg1[id] else nil
                    })
                    break
                end
            end

            table.sort(tbl4, sortFriendsByCorrectedPresenceAndRank)
            var10(tbl4)
            var8(false)
        end):catch(function(arg2)
            print("error", arg2)
            var8(false)
        end)

        if tbl3 then
            return (Cryo.List.join(tbl3, userIds))
        end

        return userIds
    end

    local useMemo = React.useMemo

    local function func2()
        if searchFriendsString ~= "" then
            GetFriendsSearch(var2, var3, searchFriendsString, 20):andThen(function(arg1)
                local var13 = (var1 or SortInvitesByScoreIXP.FFlagSortInvitesByScoreEnabledForAll) and {} or nil

                local userIds = Cryo.List.map(arg1.responseBody.PageItems, function(arg2, arg3): string
                    if var1 or SortInvitesByScoreIXP.FFlagSortInvitesByScoreEnabledForAll then
                        var13[arg2.id] = arg3
                    end
                    return tostring(arg2.id)
                end)
                return (func1(userIds, var13))
            end):catch(function(arg1)
                print("error", arg1)
            end)
        elseif var11.onlineFriends and var11.offlineFriends then
            local tbl4 = {}
            local var13 = (var1 or SortInvitesByScoreIXP.FFlagSortInvitesByScoreEnabledForAll) and {} or nil

            for value, value2 in (Cryo.List.join(var11.offlineFriends, var11.onlineFriends)) do
                if Cryo.List.find(tbl3, value2.id) ~= nil then
                    continue
                end

                table.insert(tbl4, value2.id)
                if var1 or SortInvitesByScoreIXP.FFlagSortInvitesByScoreEnabledForAll then
                    var13[value2.id] = value
                end
            end

            if not FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt or #tbl4 ~= 0 then
                return (func1(tbl4, var13))
            end

            if var11.isLoading then
                return {}
            end
            var10({})
            var8(false)
            return {}
        end
        return {}
    end
    local onlineFriends = var11.onlineFriends
    local offlineFriends = var11.offlineFriends
    local isLoading = if FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt then var11.isLoading else nil
    tbl3 = useMemo(func2, { onlineFriends, offlineFriends, searchFriendsString, isLoading })

    return React.createElement(FriendsListContext.Provider, {
        value = {
            friends = friends,
            hasFriends = not (Cryo.isEmpty(var11.onlineFriends) and Cryo.isEmpty(var11.offlineFriends)),
            isFetchingFriends = var12.loading
                or tbl2.isLoadingCustomParams
                or var7
                or FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt and var11.isLoading,
            isFriendsListFetchFailed = false,
            friendsNames = {
                loading = var12 and var12.loading
            },
            fetchMoreFriends = var11.fetchMoreFriends,
            searchFriends = searchFriends,
            searchFriendsString = searchFriendsString
        }
    }, tbl2.children)
end
