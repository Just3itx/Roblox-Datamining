-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local FFlagEditProfileFramesEnabled = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagEditProfileFramesEnabled

local editProfileImageHelpers = require(AvatarExperienceProfilePictureEditor.Utils.editProfileImageHelpers)
local saveEditProfileImage = require(AvatarExperienceProfilePictureEditor.Utils.saveEditProfileImage)
local showEditProfileImageToast = require(AvatarExperienceProfilePictureEditor.Utils.showEditProfileImageToast)
local EditProfileImageAnalytics = require(AvatarExperienceProfilePictureEditor.Analytics.EditProfileImageAnalytics)
local _Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)

local function useEditProfileImageSave(tbl1)
    local isSaving, var2 = React.useState(false)

    local resetTransientState = React.useCallback(function()
        var2(false)
    end, {})

    return {
        isSaving = isSaving,
        onSave = React.useCallback(function()
            if isSaving then
                return
            end
            var2(true)

            local savePayloadForActiveView = editProfileImageHelpers.buildSavePayloadForActiveView(tbl1.activeView, {
                selectedEmoteId = tbl1.selectedEmoteId,
                savedEmoteAssetId = tbl1.savedEmoteAssetId,
                selectedFrameId = if tbl1.showFrames then tbl1.selectedFrameId else nil,
                showFrames = tbl1.showFrames
            })
            local tbl2 = {
                emoteAssetId = savePayloadForActiveView.emoteAssetId,
                profileFrameAssetId = savePayloadForActiveView.profileFrameAssetId,
                cameraDistanceScale = tbl1.distanceScale,
                cameraYRotDeg = tbl1.yRotDeg,
                fieldOfViewDeg = tbl1.cutoutFieldOfViewDeg,
                localUserId = tbl1.localUserId
            }
            local onClose = tbl1.onClose
            local onSaveSuccess = tbl1.onSaveSuccess
            local titleBackAvailable = tbl1.titleBackAvailable

            task.spawn(function()
                local var4 = saveEditProfileImage(tbl2)
                var2(false)

                if not var4 then
                    EditProfileImageAnalytics.logSave({
                        mode = tbl1.mode,
                        emoteAssetId = savePayloadForActiveView.emoteAssetId,
                        frameAssetId = savePayloadForActiveView.profileFrameAssetId,
                        isPlusSubscriber = tbl1.isPlusSubscriber,
                        result = "failure"
                    })

                    showEditProfileImageToast.showSaveFailureToast(tbl1.dispatch)
                    return
                end

                EditProfileImageAnalytics.logSave({
                    mode = tbl1.mode,
                    emoteAssetId = savePayloadForActiveView.emoteAssetId,
                    frameAssetId = savePayloadForActiveView.profileFrameAssetId,
                    isPlusSubscriber = tbl1.isPlusSubscriber,
                    result = "success"
                })

                local var5 = editProfileImageHelpers.resolvePostSaveAction({
                    framesFeatureEnabled = FFlagEditProfileFramesEnabled,
                    hasOnTitleBack = titleBackAvailable,
                    hasOnSaveSuccess = onSaveSuccess ~= nil
                })
                if var5 == "returnToCombined" then
                    tbl1.onReturnToCombined()
                elseif var5 == "exitWithSuccessCallback" and onSaveSuccess then
                    onSaveSuccess()
                else
                    onClose()
                end
            end)
        end, {
            isSaving,
            tbl1.mode,
            tbl1.activeView,
            tbl1.titleBackAvailable,
            tbl1.selectedEmoteId,
            tbl1.savedEmoteAssetId,
            tbl1.selectedFrameId,
            tbl1.showFrames,
            tbl1.distanceScale,
            tbl1.yRotDeg,
            tbl1.cutoutFieldOfViewDeg,
            tbl1.localUserId,
            tbl1.isPlusSubscriber,
            tbl1.dispatch,
            tbl1.onReturnToCombined,
            tbl1.onClose,
            tbl1.onSaveSuccess
        }),
        resetTransientState = resetTransientState
    }
end

return useEditProfileImageSave
