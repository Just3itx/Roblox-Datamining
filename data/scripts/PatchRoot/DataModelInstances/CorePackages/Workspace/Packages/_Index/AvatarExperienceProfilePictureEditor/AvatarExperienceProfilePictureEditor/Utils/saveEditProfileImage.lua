-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local ProfileRefreshSignal = require(AvatarExperienceProfilePictureEditorParent.ProfilePlatformCommon).Signals.ProfileRefreshSignal
local userAvatarConfigurationsCache = require(AvatarExperienceProfilePictureEditor.Api.userAvatarConfigurationsCache)
local saveCloseupAndFullBody = require(AvatarExperienceProfilePictureEditor.Shared.savePPEConfig).saveCloseupAndFullBody

local function saveEditProfileImage(tbl1): boolean
    local success, result = pcall(function()
        return saveCloseupAndFullBody({
            emoteAssetId = tbl1.emoteAssetId,
            cameraDistanceScale = tbl1.cameraDistanceScale,
            cameraYRotDeg = tbl1.cameraYRotDeg,
            fieldOfViewDeg = tbl1.fieldOfViewDeg,
            profileFrameAssetId = tbl1.profileFrameAssetId
        })
    end)

    if not (success and result.ok) then
        return false
    end

    if tbl1.localUserId then
        userAvatarConfigurationsCache.invalidate(tbl1.localUserId)
    end
    ProfileRefreshSignal.notifyProfileRefresh()

    return true
end

return saveEditProfileImage
