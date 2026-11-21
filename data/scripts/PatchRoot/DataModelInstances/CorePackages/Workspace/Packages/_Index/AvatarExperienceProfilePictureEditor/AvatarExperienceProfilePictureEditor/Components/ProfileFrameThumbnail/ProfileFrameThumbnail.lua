-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)

local View = Foundation.View
local Icon = Foundation.Icon
local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local mapWidgetContentToFrameItems = require(AvatarExperienceProfilePictureEditor.Utils.mapWidgetContentToFrameItems)

local function ProfileFramePreviewThumbnail(tbl1)
    local var1 = useTokens()
    local var2 = tbl1.previewSize or var1.Size.Size_800
    local element

    if tbl1.isLoading then
        element = React.createElement(Skeleton, { Size = UDim2.fromOffset(var2, var2), radius = Radius.Medium })
    elseif tbl1.frameAssetId == nil then
        element = React.createElement(
            View,
            { testId = "none-frame-icon", tag = "auto-xy" },
            {
                Icon = React.createElement(Icon, { name = IconName.CircleSlash, size = IconSize.Medium })
            }
        )
    else
        local image = mapWidgetContentToFrameItems.getProfileFramePickerImage(tbl1.frameAssetId)
        element = React.createElement(
            View,
            { testId = "frame-preview-image", tag = "size-full-full padding-xsmall" },
            {
                Image = React.createElement(Image, { tag = "size-full-full", Image = image })
            }
        )
    end

    return React.createElement(View, {
        testId = "profile-frame-preview-thumbnail",
        tag = "align-x-center align-y-center radius-medium bg-surface-100",
        Size = UDim2.fromOffset(var2, var2)
    }, { Content = element })
end

return ProfileFramePreviewThumbnail
