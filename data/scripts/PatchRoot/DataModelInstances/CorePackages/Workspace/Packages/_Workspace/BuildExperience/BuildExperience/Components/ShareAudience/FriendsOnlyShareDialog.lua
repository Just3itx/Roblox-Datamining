-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Dialog = Foundation.Dialog

local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize

local function FriendsOnlyShareDialog(tbl1)
    local var1 = useLocalization({
        cancel = LocalizationStrings.SHARE_AUDIENCE_CANCEL,
        description = LocalizationStrings.SHARE_AUDIENCE_FRIENDS_ONLY_DESCRIPTION,
        share = LocalizationStrings.SHARE_AUDIENCE_SHARE,
        title = LocalizationStrings.SHARE_AUDIENCE_FRIENDS_ONLY_TITLE
    })
    local cancel = var1.cancel
    local description = var1.description
    local share = var1.share
    local title = var1.title
    local tbl2 = {
        LayoutOrder = 3,
        actions = {
            {
                text = share,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl1.onShare
            },
            {
                text = cancel,
                variant = ButtonVariant.Standard,
                onActivated = tbl1.onCancel
            }
        }
    }

    return React.createElement(Dialog.Root, {
        disablePortal = tbl1.disablePortal == true,
        hasBackdrop = tbl1.hasBackdrop == nil or tbl1.hasBackdrop,
        onClose = tbl1.onCancel,
        size = DialogSize.Small,
        testId = "build-friends-only-share-dialog"
    }, {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = title }),
        Content = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                Description = React.createElement(Dialog.Text, { Text = description })
            }
        ),
        Actions = React.createElement(Dialog.Actions, tbl2)
    })
end

return FriendsOnlyShareDialog
