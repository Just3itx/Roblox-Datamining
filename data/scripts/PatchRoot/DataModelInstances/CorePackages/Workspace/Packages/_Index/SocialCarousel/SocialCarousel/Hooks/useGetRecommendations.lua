-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local SocialCommon = require(SocialCarouselParent.SocialCommon)
local React = require(SocialCarouselParent.React)
local Cryo = require(SocialCarouselParent.Cryo)
local RoactUtils = require(SocialCarouselParent.RoactUtils)
local DataHydration = require(SocialCarouselParent.DataHydration)
local Signals = require(SocialCarouselParent.Signals)
local SignalsReact = require(SocialCarouselParent.SignalsReact)
local tutils = require(SocialCarouselParent.tutils)
local getDeepValue = require(SocialCarousel.Utils.getDeepValue)
local Constants = require(SocialCarousel.Common.Constants)
local RecommendationSourceEnum = SocialCommon.Enums.RecommendationSourceEnum
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local FriendsRecommendations = require(SocialCarouselParent.DataHydration.FriendsRecommendations)
local FriendsRecommendationsStore = FriendsRecommendations.FriendsRecommendationsStore
local DataSource = FriendsRecommendations.Enums.DataSource

local FFlagMigrateFriendshipStatusesSocialCarousel = require(SocialCarousel.Flags.FFlagMigrateFriendshipStatusesSocialCarousel)

local FFlagSocialCarouselMigrateRecommendations = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselMigrateRecommendations
local FFlagSocialCarouselStableSelectors = require(SocialCarousel.Flags.FFlagSocialCarouselStableSelectors)
local var1 = if FFlagMigrateFriendshipStatusesSocialCarousel then DataHydration.Friends.FriendsStore.get() else nil
local tbl1 = { skipFetch = true }

local var2 = table.freeze({})

local function func1(tbl2, tbl3): boolean
    return tbl2.rank < tbl3.rank
end

return function(str1: string)
    local var3 = useSelector(function(arg1)
        return {
            recommendationsDict = if FFlagSocialCarouselMigrateRecommendations then nil else getDeepValue(arg1, string.format("%s.Friends.recommendations.byUserId.%s", Constants.RODUX_KEY, str1 or ""))
                or not FFlagSocialCarouselStableSelectors and {}
                or var2,
            friendshipStatus = if FFlagMigrateFriendshipStatusesSocialCarousel then nil else getDeepValue(arg1, string.format("%s.Friends.friendshipStatus", Constants.RODUX_KEY))
                or not FFlagSocialCarouselStableSelectors and {}
                or var2,
            friendsCarouselRecommendationIds = if FFlagSocialCarouselMigrateRecommendations then nil else getDeepValue(
                arg1,
                string.format(
                    "%s.Friends.recommendations.bySource.%s",
                    Constants.RODUX_KEY,
                    RecommendationSourceEnum.HomepageFriendsCarousel
                )
            )
                or not FFlagSocialCarouselStableSelectors and {}
                or var2,
            hasIncomingFriendRequest = if FFlagSocialCarouselMigrateRecommendations then nil else getDeepValue(arg1, string.format("%s.Friends.recommendations.hasIncomingFriendRequest", Constants.RODUX_KEY))
        }
    end, if FFlagSocialCarouselStableSelectors then tutils.shallowEqual else nil)

    local var4 = if FFlagSocialCarouselMigrateRecommendations then nil else React.useMemo(function()
        return Cryo.List.filter(Cryo.Dictionary.keys(var3.recommendationsDict), function(arg1)
            return var3.friendsCarouselRecommendationIds[arg1]
        end)
    end, { var3.recommendationsDict, var3.friendsCarouselRecommendationIds })

    local var5 = if FFlagMigrateFriendshipStatusesSocialCarousel and not FFlagSocialCarouselMigrateRecommendations then React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local result = ({})

            for _, value in var4 do
                local friendshipStatus = var1.GetFriendshipStatus(value, tbl1)
                local var5 = if friendshipStatus then friendshipStatus.data(arg1) else nil
                result[value] = var5
            end

            return result
        end)
    end, { table.concat(var4, ",") }) else nil

    local var6 = if FFlagMigrateFriendshipStatusesSocialCarousel and not FFlagSocialCarouselMigrateRecommendations then SignalsReact.useSignalState(var5) else nil

    local var7 = if FFlagSocialCarouselMigrateRecommendations then nil else React.useCallback(function(str2: string)
        local var8 = var3.recommendationsDict[str2]
        local var9 = if FFlagMigrateFriendshipStatusesSocialCarousel then var6 and var6[str2] else var3.friendshipStatus[str2]
        return Cryo.Dictionary.join({}, var8, {
            isFriendWithUser = if var9 then var9 == Enum.FriendStatus.Friend else false,
            hasPendingFriendRequest = if var9 then var9 == Enum.FriendStatus.FriendRequestSent else false,
            canSendFriendRequest = not var9 or var9 == Enum.FriendStatus.NotFriend,
            hasIncomingFriendRequest = var3.hasIncomingFriendRequest[str2]
        })
    end, { var3.recommendationsDict, if FFlagMigrateFriendshipStatusesSocialCarousel then var6 else var3.friendshipStatus, var3.hasIncomingFriendRequest })

    local var8

    if FFlagSocialCarouselMigrateRecommendations then
        local var9 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                local var9 = FriendsRecommendationsStore.get().getFriendsRecommendations(DataSource.HomepageFriendsCarousel, tbl1).data(arg1)
                local data = var9 and var9.data or {}

                return Cryo.List.map(data, function(arg2)
                    local id = arg2.id
                    local var10

                    if FFlagMigrateFriendshipStatusesSocialCarousel then
                        local friendshipStatus = var1.GetFriendshipStatus(id, tbl1)
                        if friendshipStatus then
                            var10 = friendshipStatus.data(arg1)
                        else
                            var10 = nil
                        end
                    else
                        var10 = var3.friendshipStatus[id]
                    end

                    return {
                        id = id,
                        mutualFriendsCount = arg2.contextProps.mutualFriendsCount,
                        contextType = arg2.contextProps.contextType,
                        rank = arg2.rank,
                        hasIncomingFriendRequest = arg2.hasIncomingFriendRequest,
                        isFriendWithUser = if var10 then var10 == Enum.FriendStatus.Friend else false,
                        hasPendingFriendRequest = if var10 then var10 == Enum.FriendStatus.FriendRequestSent else false,
                        canSendFriendRequest = not var10 or var10 == Enum.FriendStatus.NotFriend
                    }
                end)
            end)
        end, FFlagMigrateFriendshipStatusesSocialCarousel and {} or { var3.friendshipStatus })

        var8 = SignalsReact.useSignalState(var9)
    else
        var8 = nil
    end

    local var9 = if FFlagSocialCarouselMigrateRecommendations then nil else React.useMemo(function()
        return Cryo.List.sort(Cryo.List.map(var4, var7), func1)
    end, { var4, var7 })

    if FFlagSocialCarouselMigrateRecommendations then
        var9 = var8
    end

    return var9
end
