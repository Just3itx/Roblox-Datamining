-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local FFlagEditProfileFramesEnabled = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagEditProfileFramesEnabled
local Constants = require(AvatarExperienceProfilePictureEditor.Constants)
local Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)

local function toProfileFrameAssetId(profileFrameNoneId: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if profileFrameNoneId == nil then
        return nil
    elseif profileFrameNoneId == Constants.ProfileFrameNoneId then
        return 0
    end
    return tonumber(profileFrameNoneId)
end

return {
    buildSavePayloadForActiveView = function(str1: string, tbl1)
        if str1 == "frames" then
            return {
                emoteAssetId = tbl1.savedEmoteAssetId,
                profileFrameAssetId = toProfileFrameAssetId(tbl1.selectedFrameId)
            }
        elseif str1 == "emotes" then
            return {
                emoteAssetId = tbl1.selectedEmoteId,
                profileFrameAssetId = nil
            }
        end

        return {
            emoteAssetId = tbl1.selectedEmoteId,
            profileFrameAssetId = if tbl1.showFrames then toProfileFrameAssetId(tbl1.selectedFrameId) else nil
        }
    end,
    getInitialActiveView = function(framesOnly): string
        return if FFlagEditProfileFramesEnabled and framesOnly == Enums.EditProfileImageMode.FramesOnly then "frames" elseif FFlagEditProfileFramesEnabled then "combined" else "emotes"
    end,
    hasOnTitleBack = function(str1: string, framesOnly): boolean
        return not (str1 == "combined")
            and not (str1 == "frames" and framesOnly == Enums.EditProfileImageMode.FramesOnly)
            and not not FFlagEditProfileFramesEnabled
    end,
    resolvePostSaveAction = function(tbl1): string
        return if tbl1.framesFeatureEnabled and tbl1.hasOnTitleBack then "returnToCombined" elseif tbl1.hasOnSaveSuccess then "exitWithSuccessCallback" else "exit"
    end,
    resolveFooterCta = function(tbl1): string
        return if tbl1.isFramesOnlyEntry or not tbl1.isRecommendedEmoteSelected then if tbl1.isEquipRestrictedFrameSelected then "subscribePlus" else "save" else "purchaseEmote"
    end
}
