-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Foundation = require(ProfilePlatformParent.Foundation)
local SocialUpsell = require(ProfilePlatformParent.SocialUpsell)

local ButtonVariant = Foundation.Enums.ButtonVariant
local startFacialAgeEstimation = SocialUpsell.Thunks.startFacialAgeEstimation
local SocialUpsellType = SocialUpsell.Enums.SocialUpsellType
local UpsellEntrySurfaceType = SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local module = {}
module[Enums.ProfileActions.UnlockChat] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Emphasis,
        text = arg1.localized[Enums.ProfileActions.UnlockChat],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonUnlockChat, { buttonSurface = arg1.buttonSurface })

        arg1.dispatch(
            startFacialAgeEstimation(
                SocialUpsellType.FacialAgeEstimation .. UpsellEntrySurfaceType.ProfileActionBar,
                nil,
                nil,
                UpsellEntrySurfaceType.ProfileActionBar,
                false
            )
        )
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
