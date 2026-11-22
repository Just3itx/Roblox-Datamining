-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local TextKeys = require(scriptParentParentParent.Common.TextKeys)
local FriendshipOriginSourceType = dependencies.NetworkingFriendsEnums.FriendshipOriginSourceType
local SocialCommon = require(scriptParentParentParentParent.SocialCommon)

local Images = dependencies.UIBlox.App.ImageSet.Images
local React = dependencies.React

local useDispatch = dependencies.Hooks.useDispatch
local useSelector = dependencies.Hooks.useSelector

local NetworkingFriends = dependencies.NetworkingFriends
local NetworkStatus = dependencies.RoduxNetworking.Enum.NetworkStatus

local RoduxFriends = dependencies.RoduxFriends
local _RecommendationContextType = RoduxFriends.Enums.RecommendationContextType
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue
local EventNames = require(scriptParentParentParent.Analytics).EventNames
local ContextualInfoTypes = SocialCommon.Enums.ContextualInfoTypes
local _DirectRecommendationTypes = require(scriptParentParentParent.Common.DirectRecommendationTypes)

local getFFlagPYMKDisableButtonsOnFetch = require(scriptParentParentParent.Flags.getFFlagPYMKDisableButtonsOnFetch)
local FFlagMigrateFriendshipStatusesPYMK = require(scriptParentParentParent.Flags.FFlagMigrateFriendshipStatusesPYMK)
local FFlagLuaAppEnableSduiHomePage = require(scriptParentParentParentParent.SharedFlags).FFlagLuaAppEnableSduiHomePage
local FFlagPymkCarouselExtendProps = require(scriptParentParentParentParent.SharedFlags).FFlagPymkCarouselExtendProps
local useGetFriendshipStatus = require(scriptParentParentParentParent.FriendsHydrationReact).useGetFriendshipStatus
local friendsStoreChallengeNetwork = require(scriptParentParentParent.friendsStoreChallengeNetwork)

local FFlagEnableFriendsStoreChallengeInterceptor = require(scriptParentParentParentParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor
local var1 = require(scriptParentParentParentParent.DataHydration).Friends.FriendsStore.get()
local FocusNavigationEventNameEnum = require(scriptParentParentParentParent.FocusNavigationUtils).FocusNavigationEventNameEnum

local _UserList = require(scriptParentParentParentParent.UserList)

local tbl1 = { skipFetch = true }
local tbl2 = { isContact = true }

local function func1(arg1, arg2, str1: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg2.getStatus(arg1, str1) == NetworkStatus.Fetching
end

local function usePYMKCarouselUserButtons(tbl3)
    local str1 = tostring(tbl3.userId)
    local var2 = useDispatch()

    local currentUserId = useSelector(function(arg1): string
        return tostring(arg1.LocalUserId)
    end)

    local var4 = if FFlagMigrateFriendshipStatusesPYMK then useGetFriendshipStatus(str1, tbl1) else useSelector(function(arg1)
        return RoduxFriends.Selectors.selectFriendshipStatusesByUserIds(arg1)({ str1 })[str1] or nil
    end)

    local var5, bool1

    if FFlagLuaAppEnableSduiHomePage then
        var5 = tbl3.recommendation or {}

        bool1 = tbl3.recommendation and tbl3.recommendation.hasIncomingFriendRequest == true
    elseif FFlagPymkCarouselExtendProps then
        var5 = useSelector(function(arg1)
            return RoduxFriends.Selectors.selectRecommendationsForUserId(arg1)(currentUserId)[str1] or {}
        end)

        bool1 = useSelector(function(arg1)
            return getDeepValue(arg1, string.format("PYMKCarousel.Friends.recommendations.hasIncomingFriendRequest.%s", str1)) or false
        end)

        if tbl3.recommendation then
            var5 = tbl3.recommendation
            bool1 = tbl3.recommendation.hasIncomingFriendRequest == true
        end
    else
        var5 = useSelector(function(arg1)
            return RoduxFriends.Selectors.selectRecommendationsForUserId(arg1)(currentUserId)[str1] or {}
        end)

        bool1 = useSelector(function(arg1)
            return getDeepValue(arg1, string.format("PYMKCarousel.Friends.recommendations.hasIncomingFriendRequest.%s", str1)) or false
        end)
    end

    local var6 = if getFFlagPYMKDisableButtonsOnFetch() then useSelector(function(arg1)
        return {
            RequestFriendshipFromUserId = not not func1(arg1, NetworkingFriends.RequestFriendshipFromUserId, str1),
            AcceptFriendRequestFromUserId = not not func1(arg1, NetworkingFriends.AcceptFriendRequestFromUserId, str1)
        }
    end) else nil

    local var7 = React.useMemo(function()
        if var4 == Enum.FriendStatus.FriendRequestSent then
            return {{
                icon = Images["icons/actions/friends/friendpending"],
                isSecondary = true,
                isDisabled = true,
                onActivated = function() end,
                isLoading = false,
                buttonType = "Pending",
                focusEvent = nil
            }}
        end

        if bool1 or FFlagMigrateFriendshipStatusesPYMK and var4 == Enum.FriendStatus.FriendRequestReceived then
            local tbl4 = {
                icon = Images["icons/actions/friends/friendAdd"],
                isSecondary = false,
                isDisabled = if getFFlagPYMKDisableButtonsOnFetch() and var6 then var6.AcceptFriendRequestFromUserId else false,
                onActivated = 0,
                isLoading = 0,
                buttonType = "Accept",
                focusEvent = 0
            }

            function tbl4.onActivated()
                tbl3.fireAnalyticsEvent(EventNames.AcceptFriendship, {
                    recommendationContextType = var5.contextType,
                    requestedId = str1,
                    recommendationRank = var5.rank,
                    absolutePosition = tbl3.absolutePosition,
                    presence = tbl3.userPresenceType
                })
                local var7 = if FFlagMigrateFriendshipStatusesPYMK then var1.AcceptFriendRequest(str1) else var2(NetworkingFriends.AcceptFriendRequestFromUserId.API({ currentUserId = currentUserId, targetUserId = str1 }))

                var7:andThen(function()
                    tbl3.showToast(TextKeys.ConnectionAddedToast)
                end):catch(function()
                    tbl3.showToast(TextKeys.SomethingIsWrongToast)
                end)
            end
            tbl4.isLoading = if var6 then var6.AcceptFriendRequestFromUserId else false

            tbl4.focusEvent = FocusNavigationEventNameEnum.HoldToAcceptFriendRequest
            return { tbl4 }
        end

        if var4 and var4 ~= Enum.FriendStatus.NotFriend then
            return {}
        end

        local tbl4 = {
            icon = Images["icons/actions/friends/friendAdd"],
            isSecondary = false,
            isDisabled = if getFFlagPYMKDisableButtonsOnFetch() and var6 then var6.RequestFriendshipFromUserId else false,
            onActivated = 0,
            isLoading = 0,
            buttonType = "Add",
            focusEvent = 0
        }

        function tbl4.onActivated()
            tbl3.fireAnalyticsEvent(EventNames.RequestFriendship, {
                recommendationContextType = var5.contextType,
                requestedId = str1,
                contactId = tbl3.contactId,
                recommendationRank = var5.rank,
                absolutePosition = tbl3.absolutePosition,
                positionInRow = tbl3.absolutePosition,
                presence = tbl3.userPresenceType,
                interactionUuid = HttpService:GenerateGUID(false)
            })
            local var7

            if FFlagMigrateFriendshipStatusesPYMK then
                var7 = nil
            elseif tbl3.contactId then
                var7 = NetworkingFriends.RequestFriendshipFromContactId.API({
                    currentUserId = currentUserId,
                    targetUserId = str1,
                    contactId = tbl3.contactId,
                    contextType = ContextualInfoTypes.Contacts,
                    friendshipOriginSourceType = FriendshipOriginSourceType.FriendRecommendations.rawValue()
                })
            else
                var7 = NetworkingFriends.RequestFriendshipFromUserId.API({
                    currentUserId = currentUserId,
                    targetUserId = str1,
                    friendshipOriginSourceType = FriendshipOriginSourceType.FriendRecommendations.rawValue()
                })
            end

            local var8 = if FFlagMigrateFriendshipStatusesPYMK then if tbl3.contactId then var1.RequestFriendship(
                tbl3.contactId,
                FriendshipOriginSourceType.FriendRecommendations.rawValue(),
                tbl2,
                if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil
            ) else var1.RequestFriendship(
                str1,
                FriendshipOriginSourceType.FriendRecommendations.rawValue(),
                nil,
                if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil
            ) else var2(var7)

            var8:andThen(function()
                tbl3.showToast(TextKeys.ConnectionRequestSentToast)
            end):catch(function()
                tbl3.showToast(TextKeys.SomethingIsWrongToast)
            end)
        end
        tbl4.isLoading = if var6 then var6.RequestFriendshipFromUserId else false

        tbl4.focusEvent = FocusNavigationEventNameEnum.HoldToAddFriend
        return { tbl4 }
    end, {
        var4,
        str1,
        bool1,
        var5,
        currentUserId,
        var2,
        tbl3.userPresenceType
    })

    return React.useCallback(function()
        return var7
    end, { var7 })
end

return usePYMKCarouselUserButtons
