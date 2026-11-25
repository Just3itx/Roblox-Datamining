-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Enums = require(ProfilePlatform.Common.Enums)

local tbl1 = {
    [Enums.DisabledReasons.BannedFromCommunity] = TextKeys.BannedFromGroup,
    [Enums.DisabledReasons.CommunityIsClosed] = TextKeys.GroupClosed,
    [Enums.DisabledReasons.MaxCommunitiesJoined] = TextKeys.PremiumMaxGroups,
    [Enums.DisabledReasons.AccountCreatedLessThanOneDay] = TextKeys.RequiresAccountTenureTooltipOneDay,
    [Enums.DisabledReasons.AccountCreatedLessThanThreeDays] = TextKeys.RequiresAccountTenureTooltipThreeDays,
    [Enums.DisabledReasons.AccountCreatedLessThanOneWeek] = TextKeys.RequiresAccountTenureTooltipOneWeek,
    [Enums.DisabledReasons.AccountCreatedLessThanOneMonth] = TextKeys.RequiresAccountTenureTooltipOneMonth,
    [Enums.DisabledReasons.AccountCreatedLessThanThreeMonths] = TextKeys.RequiresAccountTenureTooltipThreeMonths,
    [Enums.DisabledReasons.InsufficientVerificationLevelHigh] = nil,
    [Enums.DisabledReasons.InsufficientVerificationLevelMedium] = nil,
    [Enums.DisabledReasons.InsufficientVerificationLevelLow] = nil
}

return function(arg1)
    local disabledReasonText = if arg1 then tbl1[arg1] else nil
    return useLocalization({ disabledReasonText = disabledReasonText }).disabledReasonText
end
