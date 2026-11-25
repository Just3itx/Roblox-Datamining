-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local _Types = require(ProfilePlatform.Common.Types)
local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)
local Enums = require(ProfilePlatform.Common.Enums)
local FriendStatus = require(ProfilePlatform.Analytics.FriendStatus)

local tbl1 = {
    Friends = FriendStatus.Friends,
    Self = FriendStatus.Self,
    RequestSent = FriendStatus.RequestSent,
    RequestReceived = FriendStatus.RequestReceived,
    None = FriendStatus.NotFriends,
    Invalid = FriendStatus.Unknown,
    Ineligible = FriendStatus.Ineligible,
    _ = FriendStatus.Unknown
}

local function getTrustedFriendStatusString(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 then arg1.trustedFriendStatus or nil else nil
end

local function mapFriendshipStatusToAnalyticsFriendStatus(friendshipStatus: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[friendshipStatus]
end

return {
    getViewerRelationshipFromProfileResponse = function(arg1)
        return getDeepValue(arg1, `responseBody.components.{Enums.Components.UserProfileHeader}.viewerRelationship`)
    end,
    getContextualInformationFromProfileResponse = function(arg1)
        return getDeepValue(arg1, `responseBody.components.{Enums.Components.UserProfileHeader}.contextualInformation`)
    end,
    mapViewerRelationshipAndContextToAnalyticsFriendStatus = function(arg1, arg2)
        local friendshipStatus = arg1 and arg1.friendshipStatus or "Invalid"
        if arg2 and arg2.context == Enums.ContextualTypes.AccountDeleted and friendshipStatus == "Friends" then
            return FriendStatus.Ineligible
        end

        return (mapFriendshipStatusToAnalyticsFriendStatus(friendshipStatus))
    end,
    isViewerTrustedFriendsFromViewerRelationship = function(arg1): boolean
        return getTrustedFriendStatusString(arg1) == "TrustedFriends"
    end
}
