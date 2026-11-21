-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local Localization = require(AvatarExperienceProfilePictureEditorParent.Localization)
local UIBlox = require(AvatarExperienceProfilePictureEditorParent.UIBlox)

local View = Foundation.View
local useLocalization = Localization.Hooks.useLocalization
local EmptyState = UIBlox.App.Indicator.EmptyState

local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)

local function AssetPickerErrorBody(tbl1)
    local var1 = useLocalization({ failedMessage = TextKeys.SomethingWentWrong })

    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-y padding-bottom-xxlarge",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            EmptyState = React.createElement(EmptyState, {
                text = var1.failedMessage,
                onActivated = tbl1.onRetry,
                size = UDim2.new(1, 0, 0, 187),
                position = UDim2.fromOffset(0, 0),
                anchorPoint = Vector2.new(0, 0)
            })
        }
    )
end
return AssetPickerErrorBody
