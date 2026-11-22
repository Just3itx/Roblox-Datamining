-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local Navigation = require(SocialCarouselParent.Navigation)
local RoactAppExperiment = require(SocialCarouselParent.RoactAppExperiment)
local useSignalState = require(SocialCarouselParent.SignalsReact).useSignalState
local FriendsRequests = require(SocialCarouselParent.DataHydration.FriendsRequests)
local FriendsRequestsStore = FriendsRequests.FriendsRequestsStore
local UnseenRequestsStore = FriendsRequests.UnseenRequestsStore

local useNavigationFocus = Navigation.useNavigationFocus
local useSocialCarouselAnalytics = require(SocialCarousel.Analytics.useSocialCarouselAnalytics)
local getBadgeAnalyticsFields = require(SocialCarousel.Analytics.getBadgeAnalyticsFields)
local FStringNewFriendRequestsBadgeLayer = require(SocialCarouselParent.SharedFlags).FStringNewFriendRequestsBadgeLayer

local FFlagAddFriendsPageHighlightUnseenTrustedRequests = require(SocialCarouselParent.SharedFlags).FFlagAddFriendsPageHighlightUnseenTrustedRequests

local FFlagSocialCarouselEnableNewFriendRequestsBadgeForAll = require(SocialCarousel.Flags.FFlagSocialCarouselEnableNewFriendRequestsBadgeForAll)

local function useAddFriendsTileSeenImpression(absolutePosition: number?)
    local addFriendsTileSeen = useSocialCarouselAnalytics().addFriendsTileSeen
    local var1 = useNavigationFocus()
    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)

    local var4 = if FFlagSocialCarouselEnableNewFriendRequestsBadgeForAll then true else RoactAppExperiment.useUserExperiment({ FStringNewFriendRequestsBadgeLayer }, function(arg1): boolean
        return (arg1[FStringNewFriendRequestsBadgeLayer] or {}).showNewFriendRequestsBadge == true
    end)

    local var5 = React.useMemo(function()
        if FFlagAddFriendsPageHighlightUnseenTrustedRequests then
            return UnseenRequestsStore.get().getUnseenRequestCount()
        end
        return FriendsRequestsStore.get().getNewFriendsRequestCount()
    end, {})

    local var6 = useSignalState(var5.data)
    local bool1 = useSignalState(var5.status) == "Ready"

    local current = var6 or 0

    React.useEffect(function()
        if not bool1 or absolutePosition == nil then
            return
        end

        local badgeAnalyticsFields = getBadgeAnalyticsFields(current, var4)
        local current2 = var2.current
        if current2 == current and var3.current == badgeAnalyticsFields.badgeShown or not var1 or not addFriendsTileSeen then
            return
        end

        addFriendsTileSeen({
            newRequestCount = badgeAnalyticsFields.newRequestCount,
            previousCount = current2,
            trigger = if current2 == nil then "initial" else "valueChanged",
            badgeEnabled = badgeAnalyticsFields.badgeEnabled,
            badgeShown = badgeAnalyticsFields.badgeShown,
            badgeCapped = badgeAnalyticsFields.badgeCapped,
            absolutePosition = absolutePosition
        })
        var2.current = current
        var3.current = badgeAnalyticsFields.badgeShown
    end, {
        absolutePosition,
        var1,
        current,
        var4,
        bool1,
        addFriendsTileSeen
    })
end

return useAddFriendsTileSeenImpression
