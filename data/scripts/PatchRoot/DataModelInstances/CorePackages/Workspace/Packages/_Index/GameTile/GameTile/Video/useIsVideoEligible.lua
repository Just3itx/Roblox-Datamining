-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local Cryo = require(GameTileParent.Cryo)
local FetchGamePlayabilityAndProductInfo = require(GameTileParent.GameDetailRodux).FetchGamePlayabilityAndProductInfo
local RetrievalStatus = require(GameTileParent.Http).Enum.RetrievalStatus

local PlayabilityStatusEnum = require(GameTileParent.DiscoveryTypes).PlayabilityStatusEnum
local isVideoEligibleForPlayability = require(GameTileParent.VideoUtils).isVideoEligibleForPlayability

local useSelector = require(GameTileParent.RoactUtils).Hooks.RoactRodux.useSelector

local FFlagLuaAppUsePrevalidatedVideoGamePlayability = require(GameTileParent.SharedFlags).FFlagLuaAppUsePrevalidatedVideoGamePlayability
local FFlagLuaAppSduiVideoThumbnail = require(GameTileParent.SharedFlags).FFlagLuaAppSduiVideoThumbnail

local var1 = nil
var1 = not FFlagLuaAppSduiVideoThumbnail
    and {
        PlayabilityStatusEnum.UnderReview,
        PlayabilityStatusEnum.UniverseRootPlaceIsPrivate,
        PlayabilityStatusEnum.InsufficientPermissionFriendsOnly,
        PlayabilityStatusEnum.InsufficientPermissionGroupOnly,
        PlayabilityStatusEnum.GameUnapproved,
        PlayabilityStatusEnum.AccountRestricted,
        PlayabilityStatusEnum.ComplianceBlocked,
        PlayabilityStatusEnum.ContextualPlayabilityRegionalCompliance,
        PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls,
        PlayabilityStatusEnum.ContextualPlayabilityAgeGated,
        PlayabilityStatusEnum.ContextualPlayabilityUnrated,
        PlayabilityStatusEnum.ContextualPlayabilityAgeGatedByDescriptor,
        PlayabilityStatusEnum.ContextualPlayabilityExperienceBlockedParentalControls,
        PlayabilityStatusEnum.ContextualPlayabilityRequireParentApproval,
        PlayabilityStatusEnum.ContextualPlayabilityAgeCheckRequired,
        PlayabilityStatusEnum.ContextualPlayabilityCoreGated,
        PlayabilityStatusEnum.ContextualPlayabilityUnverifiedSeventeenPlusUser
    }
    or var1

local function useIsVideoEligible(arg1, bool1: boolean?)
    local var2 = useSelector(function(arg2)
        return FetchGamePlayabilityAndProductInfo.GetFetchingStatus(arg2, arg1)
    end)

    local var3 = useSelector(function(arg2)
        return arg2.PlayabilityStatus and arg2.PlayabilityStatus[arg1] or nil
    end)

    if FFlagLuaAppSduiVideoThumbnail then
        return isVideoEligibleForPlayability(var2 == RetrievalStatus.Done, var3, bool1)
    end

    return if FFlagLuaAppUsePrevalidatedVideoGamePlayability and bool1 then true else var2 == RetrievalStatus.Done
        and var3 ~= nil
        and (var3.isPlayable == true or Cryo.List.find(var1, var3.playabilityStatus) == nil)
end

return useIsVideoEligible
