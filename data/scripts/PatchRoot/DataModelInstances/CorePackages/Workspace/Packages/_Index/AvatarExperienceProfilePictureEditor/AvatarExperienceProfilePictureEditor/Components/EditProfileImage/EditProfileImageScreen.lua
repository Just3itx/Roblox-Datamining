-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local React = require(AvatarExperienceProfilePictureEditorParent.React)
local RoactNavigation = require(AvatarExperienceProfilePictureEditorParent.RoactNavigation)
local RoactUtils = require(AvatarExperienceProfilePictureEditorParent.RoactUtils)
local EditProfileImage = require(script.Parent.EditProfileImage)
local Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)
local FFlagNavigationCallbackParam = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagNavigationCallbackParam
local closeProfilePictureEditor = require(AvatarExperienceProfilePictureEditor.Utils.closeProfilePictureEditor)
local leaveEditProfileImage = require(AvatarExperienceProfilePictureEditor.Utils.leaveEditProfileImage)
local showEditProfileImageToast = require(AvatarExperienceProfilePictureEditor.Utils.showEditProfileImageToast)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

return RoactNavigation.withNavigationFocus(function(tbl1) -- name: EditProfileImageScreen
    local var1 = useDispatch()

    local onClose = React.useCallback(function()
        if FFlagNavigationCallbackParam then
            leaveEditProfileImage(tbl1.navigation, tbl1.onReturn)
            return
        end
        closeProfilePictureEditor(tbl1.navigation)
    end, { tbl1.navigation, tbl1.onReturn })

    local onSaveSuccess = React.useCallback(function()
        showEditProfileImageToast.showSaveSuccessToast(var1)
        if FFlagNavigationCallbackParam then
            leaveEditProfileImage(tbl1.navigation, tbl1.onReturn)
            return
        end
        closeProfilePictureEditor(tbl1.navigation)
    end, { var1, tbl1.navigation, tbl1.onReturn })

    local mode = if tbl1.navigation.getParam then tbl1.navigation.getParam("mode", Enums.EditProfileImageMode.Default) else Enums.EditProfileImageMode.Default
    return React.createElement(EditProfileImage, {
        mode = mode,
        initialFrameAssetId = tbl1.initialFrameAssetId,
        initialFrameSelectionRequestId = tbl1.initialFrameSelectionRequestId,
        showCloseButton = tbl1.isFocused ~= false,
        onClose = onClose,
        onSaveSuccess = onSaveSuccess,
        onOpenEmoteDetails = tbl1.onOpenEmoteDetails,
        onPrepareRecommendedEmotePurchase = tbl1.onPrepareRecommendedEmotePurchase,
        onShopForMoreEmotes = tbl1.onShopForMoreEmotes,
        onPromptR15Upgrade = tbl1.onPromptR15Upgrade,
        accountRigType = tbl1.accountRigType,
        renderRecommendedEmotePurchaseFooter = tbl1.renderRecommendedEmotePurchaseFooter
    })
end)
