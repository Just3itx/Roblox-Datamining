-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent

local React = require(SocialCarouselParent.React)
local RoactAppExperiment = require(SocialCarouselParent.RoactAppExperiment)
local useSignalState = require(SocialCarouselParent.SignalsReact).useSignalState
local FriendsRequests = require(SocialCarouselParent.DataHydration.FriendsRequests)
local FriendsRequestsStore = FriendsRequests.FriendsRequestsStore
local UnseenRequestsStore = FriendsRequests.UnseenRequestsStore
local FStringNewFriendRequestsBadgeLayer = require(SocialCarouselParent.SharedFlags).FStringNewFriendRequestsBadgeLayer

local FFlagAddFriendsPageHighlightUnseenTrustedRequests = require(SocialCarouselParent.SharedFlags).FFlagAddFriendsPageHighlightUnseenTrustedRequests

local FFlagSocialCarouselEnableNewFriendRequestsBadgeForAll = require(SocialCarousel.Flags.FFlagSocialCarouselEnableNewFriendRequestsBadgeForAll)

return function(): string?
    local var1 = if FFlagSocialCarouselEnableNewFriendRequestsBadgeForAll then true else RoactAppExperiment.useUserExperiment({ FStringNewFriendRequestsBadgeLayer }, function(arg1)
        return (arg1[FStringNewFriendRequestsBadgeLayer] or {}).showNewFriendRequestsBadge
    end)

    local var2 = React.useMemo(function()
        if FFlagAddFriendsPageHighlightUnseenTrustedRequests then
            return UnseenRequestsStore.get().getUnseenRequestCount()
        end
        return FriendsRequestsStore.get().getNewFriendsRequestCount()
    end, {})

    local var3 = useSignalState(var2.data) or 0

    local bool1 = var3 > 0

    local str1 = tostring(var3)

    return if var1 and bool1 then str1 else nil
end
