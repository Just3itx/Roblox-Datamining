-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local AmpApiProvider = require(AvatarExperienceProfilePictureEditorParent.AmpUpsell).AmpApiProvider
local AccessResponseEnum = require(AvatarExperienceProfilePictureEditorParent.AmpUpsell).AmpEnums.AccessResponseEnum
local ProfileFrameAmpConstants = require(AvatarExperienceProfilePictureEditor.Common.ProfileFrameAmpConstants)

local function getProfileFrameAmpAccess()
    local access = AmpApiProvider.upsellFeatureAccess(ProfileFrameAmpConstants.FEATURE_NAME, {}, ProfileFrameAmpConstants.NAME_SPACE).access

    if access == AccessResponseEnum.Error then
        return {
            access = { granted = false, canUpsell = false },
            hasError = true
        }
    end

    if access == AccessResponseEnum.Pending then
        return {
            access = { granted = false, canUpsell = false },
            hasError = false
        }
    end

    return {
        access = {
            granted = access == AccessResponseEnum.Granted,
            canUpsell = access == AccessResponseEnum.Actionable
        },
        hasError = false
    }
end

return getProfileFrameAmpAccess
