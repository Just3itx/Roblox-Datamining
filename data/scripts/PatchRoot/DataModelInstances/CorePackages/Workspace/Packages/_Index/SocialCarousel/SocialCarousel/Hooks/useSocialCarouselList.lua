-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")
local SocialCarouselParent = SocialCarousel.Parent
local FriendsCommon = require(SocialCarouselParent.FriendsCommon)
local GameJoinCard = require(SocialCarouselParent.GameJoinCard)
local useLocalUserId = require(SocialCarouselParent.RobloxAppHooks).useLocalUserId
local Cryo = require(SocialCarouselParent.Cryo)
local React = require(SocialCarouselParent.React)
local RoactUtils = require(SocialCarouselParent.RoactUtils)
local Responsive = require(SocialCarouselParent.Responsive)
local tutils = require(SocialCarouselParent.tutils)

local useFriendsListOrderedByPresence = FriendsCommon.Hooks.useFriendsListOrderedByPresence
local usePrefetchInGameFriendsMedia = GameJoinCard.usePrefetchInGameFriendsMedia
local useGetFriendRequests = require(SocialCarousel.Hooks.useGetFriendRequests)
local useGetRecommendations = require(SocialCarousel.Hooks.useGetRecommendations)
local getDeepValue = require(SocialCarousel.Utils.getDeepValue)
local Enums = require(SocialCarousel.Common.Enums)
local Constants = require(SocialCarousel.Common.Constants)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local usePreferredInput = Responsive.usePreferredInput
local useIsSpatial = Responsive.useIsSpatial

local useGetFriendsCountByUserId = require(SocialCarouselParent.FriendsHydrationReact).useGetFriendsCountByUserId

local FIntSocialCarouselShowRecsLimit = require(SocialCarousel.Flags).FIntSocialCarouselShowRecsLimit
local FFlagSocialCarouselShowLoadingSkeleton = require(SocialCarousel.Flags.FFlagSocialCarouselShowLoadingSkeleton)
local SharedFlags = require(SocialCarouselParent.SharedFlags)
local FFlagShowRequestsInCarouselForAllUsers = SharedFlags.FFlagShowRequestsInCarouselForAllUsers
local FFlagSocialCarouselShareQREnabled = SharedFlags.FFlagSocialCarouselShareQREnabled
local FIntFriendsCarouselInitialFetchSize = SharedFlags.FIntFriendsCarouselInitialFetchSize

local FFlagEnableRecommendationsForPCGDK = require(SocialCarouselParent.SharedFlags).FFlagEnableRecommendationsForPCGDK
local FFlagFixIsConsoleCheckForSocialCarousel = require(SocialCarouselParent.SharedFlags).FFlagFixIsConsoleCheckForSocialCarousel
local bool1 = game:DefineFastFlag("PrefetchFriendGameMedia", false)
local FFlagSocialCarouselStableSelectors = require(SocialCarousel.Flags.FFlagSocialCarouselStableSelectors)

local Tile = Enums.Tile
local TileGroup = Enums.TileGroup

local tbl1 = {
    {
        tileGroup = TileGroup.AddFriends
    },
    {
        tileGroup = TileGroup.FriendsListWithRecommendations
    }
}

if FFlagShowRequestsInCarouselForAllUsers then
    table.insert(tbl1, { tileGroup = TileGroup.FriendRequests })
end

local tbl2 = { skipFetch = true }

return function(str1: string?, arg1)
    local var1 = arg1 or tbl1
    local userId = useLocalUserId()
    local tiles = useGetRecommendations(userId)

    local var4 = useFriendsListOrderedByPresence({ userId = userId, pageSize = FIntFriendsCarouselInitialFetchSize })

    if bool1 then
        usePrefetchInGameFriendsMedia(var4.onlineFriends)
    end

    local bool2 = if FFlagFixIsConsoleCheckForSocialCarousel then usePreferredInput() == Responsive.Input.Directional elseif FFlagEnableRecommendationsForPCGDK and ThirdPartyUserService then ThirdPartyUserService:HaveActiveUser() else usePreferredInput() == Responsive.Input.Directional
    local var5 = if FFlagSocialCarouselShareQREnabled then useIsSpatial() else false

    local var6 = useSelector(function(arg2)
        return {
            friendRequestCount = getDeepValue(arg2, string.format("%s.Friends.requests.receivedCount", str1 or Constants.RODUX_KEY)) or 0
        }
    end, if FFlagSocialCarouselStableSelectors then tutils.shallowEqual else nil)

    local str2 = tostring(userId or "")
    local friendCount = useGetFriendsCountByUserId(str2, tbl2) or 0

    local var8 = if FFlagShowRequestsInCarouselForAllUsers then React.useMemo(function()
        for _, value in var1 do
            if value.tileGroup == TileGroup.FriendRequests then
                return true
            end
        end
        return false
    end, { var1 }) else false

    local var9 = if FFlagShowRequestsInCarouselForAllUsers then useGetFriendRequests(var8 and friendCount < FIntFriendsCarouselInitialFetchSize) else nil
    local bool3 = bool2 and friendCount <= FIntSocialCarouselShowRecsLimit
    local var10 = var9

    if FFlagShowRequestsInCarouselForAllUsers then
        var10 = React.useMemo(function()
            if #var9 == 0 then
                return var9
            end

            local tbl3 = {}
            for _, onlineFriend in var4.onlineFriends do
                local id = onlineFriend.id
                tbl3[tostring(id)] = true
            end
            for _, offlineFriend in var4.offlineFriends do
                local id = offlineFriend.id
                tbl3[tostring(id)] = true
            end
            if bool3 then
                for _, value in tiles do
                    local id = value.id
                    tbl3[tostring(id)] = true
                end
            end

            local result = {}
            for _, value in var9 do
                if not tbl3[tostring(value.id)] then
                    table.insert(result, value)
                end
            end

            return result
        end, {
            var4.onlineFriends,
            var4.offlineFriends,
            tiles,
            var9,
            bool3
        })
    end

    local bool4 = friendCount == 0 and not bool2
    local bool5 = FFlagSocialCarouselShareQREnabled

    if bool5 then
        bool5 = false

        if friendCount == 0 then
            bool5 = not bool2
            bool5 = bool5 and not var5
        end
    end

    local bool6 = false
    if FFlagShowRequestsInCarouselForAllUsers then
        bool6 = friendCount < FIntFriendsCarouselInitialFetchSize and #var10 > 0
        bool4 = bool4 and not bool6
        bool5 = bool5 and not bool6
    end

    local useMemo = React.useMemo
    local function func1()
        local tbl3 = {
            [TileGroup.FriendsList] = {
                {
                    tiles = var4.onlineFriends,
                    tileType = Tile.Friend
                },
                {
                    tiles = var4.offlineFriends,
                    tileType = Tile.Friend
                }
            },
            [TileGroup.FriendsListWithRecommendations] = {
                {
                    tiles = var4.onlineFriends,
                    tileType = Tile.Friend
                },
                bool3 and {
                    tiles = tiles,
                    tileType = Tile.Recommendation
                } or nil,
                {
                    tiles = var4.offlineFriends,
                    tileType = Tile.Friend
                }
            },
            [TileGroup.AddFriends] = {
                {
                    tileType = Tile.AddFriends
                },
                bool5 and {
                    tileType = Tile.ShareQR
                } or nil,
                bool4 and {
                    tileType = Tile.FriendsHint
                } or nil
            },
            [TileGroup.StartSquad] = {{
                tileType = Tile.StartSquad
            }}
        }

        if FFlagShowRequestsInCarouselForAllUsers then
            tbl3[TileGroup.FriendRequests] = { bool6 and {
                    tiles = var10,
                    tileType = Tile.FriendRequest
                } or nil }
        end

        return tbl3
    end

    local onlineFriends = var4.onlineFriends
    local offlineFriends = var4.offlineFriends
    local var11 = if FFlagShowRequestsInCarouselForAllUsers then var10 else nil
    local bool7 = if FFlagShowRequestsInCarouselForAllUsers then bool6 else nil
    local bool8 = bool4
    local var12 = if FFlagSocialCarouselShareQREnabled then bool5 else nil
    local var13 = useMemo(func1, { onlineFriends, offlineFriends, tiles, var11, bool7, bool3, bool8, var12 })

    return {
        tiles = React.useMemo(function()
            local result = {}
            for _, value in var1 do
                for _, value2 in var13[value.tileGroup] do
                    if not value2 then
                        continue
                    end

                    if value2.tiles then
                        for _, value3 in value2.tiles do
                            table.insert(result, Cryo.Dictionary.join(value3, { tileType = value2.tileType, onActivated = value.onActivated }))
                        end
                    else
                        table.insert(result, { tileType = value2.tileType, onActivated = value.onActivated })
                    end
                end
            end

            return result
        end, { var13, var1 }),
        friendCount = friendCount,
        friendRequestCount = var6.friendRequestCount,
        recommendationCount = #tiles,
        refreshFriendsList = var4.refreshFriendsData,
        isLoading = FFlagSocialCarouselShowLoadingSkeleton and var4.isLoading
    }
end
