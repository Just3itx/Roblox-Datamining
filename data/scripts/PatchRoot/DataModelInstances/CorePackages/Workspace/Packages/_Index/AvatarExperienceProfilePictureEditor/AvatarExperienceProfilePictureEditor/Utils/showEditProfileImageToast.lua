-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local ToastRodux = require(AvatarExperienceProfilePictureEditorParent.ToastRodux)
local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)

local ToastType = ToastRodux.Enums.ToastType
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage

local tbl1 = {
    toastMessage = "Feature.Profile.Heading.ProfilePictureSaved",
    isLocalized = false,
    toastType = ToastType.SuccessConfirmation
}

local tbl2 = {
    toastMessage = TextKeys.SaveFailed,
    isLocalized = false,
    toastType = ToastType.NetworkingError
}

return {
    showSaveSuccessToast = function(callback: (...any) -> (...any))
        callback(SetCurrentToastMessage(tbl1))
    end,
    showSaveFailureToast = function(callback: (...any) -> (...any))
        callback(SetCurrentToastMessage(tbl2))
    end
}
