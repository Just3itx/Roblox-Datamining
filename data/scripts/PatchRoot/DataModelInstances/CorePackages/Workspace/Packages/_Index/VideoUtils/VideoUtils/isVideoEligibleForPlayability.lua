-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtilsParent = script:FindFirstAncestor("VideoUtils").Parent

local Cryo = require(VideoUtilsParent.Cryo)
local PlayabilityStatusEnum = require(VideoUtilsParent.DiscoveryTypes).PlayabilityStatusEnum

local FFlagLuaAppUsePrevalidatedVideoGamePlayability = require(VideoUtilsParent.SharedFlags).FFlagLuaAppUsePrevalidatedVideoGamePlayability

local tbl1 = {
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

local function isVideoEligibleForPlayability(bool1: boolean, tbl2, bool2: boolean?): boolean
    return if FFlagLuaAppUsePrevalidatedVideoGamePlayability and bool2 then true elseif bool1 and tbl2 ~= nil then tbl2.isPlayable == true or Cryo.List.find(tbl1, tbl2.playabilityStatus) == nil else false
end

return isVideoEligibleForPlayability
