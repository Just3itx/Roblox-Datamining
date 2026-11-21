-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent

local React = require(EditProfileParent.React)

local Foundation = require(EditProfileParent.Foundation)
local BadgeShape = Foundation.Enums.BadgeShape
local BadgeVariant = Foundation.Enums.BadgeVariant
local Badge = Foundation.Badge
local List = Foundation.List
local View = Foundation.View

local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization
local AvatarExperienceProfilePictureEditor = require(EditProfileParent.AvatarExperienceProfilePictureEditor)
local ProfileFramePreviewThumbnail = AvatarExperienceProfilePictureEditor.ProfileFramePreviewThumbnail
local useUserAvatarConfigurations = AvatarExperienceProfilePictureEditor.useUserAvatarConfigurations

local useProfileFramesNewLabel = require(EditProfile.Hooks.useProfileFramesNewLabel)
local TextKeys = require(EditProfile.Common.TextKeys)
local FFlagProfileFramesNewLabelEnabled = require(EditProfile.Flags.FFlagProfileFramesNewLabelEnabled)

local tbl1 = {
    isContained = true,
    hasDivider = { hasDivider = true, isInset = false }
}

local function EditProfileProfileFramesSection(tbl2)
    local var1 = useLocalization({ ProfileFrameLabel = TextKeys.ProfileFrame, NewLabel = TextKeys.New })

    local _, frameAssetId, var3 = useUserAvatarConfigurations(tbl2.userId)
    local var4, var5 = useProfileFramesNewLabel()

    local function onActivated()
        if FFlagProfileFramesNewLabelEnabled then
            var5()
        end
        tbl2.onActivated()
    end

    local createElement = React.createElement
    local root = List.Root
    local tbl3 = {
        testId = "ProfileFramesList",
        LayoutOrder = tbl2.layoutOrder,
        isContained = tbl1.isContained,
        hasDivider = tbl1.hasDivider
    }
    local tbl4 = { ProfileFramesRow = 0 }
    local createElement2 = React.createElement
    local item = List.Item
    local tbl5 = {
        testId = "ProfileFramesRow",
        title = var1.ProfileFrameLabel,
        trailing = React.createElement(View, { tag = "row align-y-center gap-small auto-xy" }, {
            NewLabel = if FFlagProfileFramesNewLabelEnabled and var4 then React.createElement(Badge, { text = var1.NewLabel, variant = BadgeVariant.Contrast, shape = BadgeShape.Box }) else nil,
            ProfileFramePreview = if FFlagProfileFramesNewLabelEnabled and var4 then nil else React.createElement(ProfileFramePreviewThumbnail, { frameAssetId = frameAssetId, isLoading = var3 == true })
        }),
        onActivated = not var3 and { onActivated = onActivated } or nil,
        LayoutOrder = 1
    }
    tbl4.ProfileFramesRow = createElement2(item, tbl5)
    return createElement(root, tbl3, tbl4)
end

return EditProfileProfileFramesSection
