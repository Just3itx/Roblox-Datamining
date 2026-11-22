-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local Localization = require(MomentsCreationParent.Localization)
local React = require(MomentsCreationParent.React)
local FFlagMomentsCreateAvatarPosts = require(MomentsCreationParent.SharedFlags).FFlagMomentsCreateAvatarPosts

local Dialog = Foundation.Dialog
local useLocalization = Localization.Hooks.useLocalization

local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)
local creationFlowStrings = require(MomentsCreation.creationFlowStrings)

return function(tbl1)
    local var1 = useCreationFlowStrings()
    local var2 = if FFlagMomentsCreateAvatarPosts then useLocalization({ body = tbl1.bodyLocalizationKey or creationFlowStrings.LeaveMomentCreationBody }) else nil
    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        disablePortal = false,
        size = Foundation.Enums.DialogSize.Medium,
        hasBackdrop = true
    }
    local tbl3 = {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.LeaveMomentCreationTitle, LayoutOrder = 1 }),
        DialogContent = 0,
        DialogActions = 0
    }

    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl4 = { LayoutOrder = 2 }

    local tbl5 = {
        DialogText = React.createElement(
            Dialog.Text,
            {
                Text = if FFlagMomentsCreateAvatarPosts then var2.body else var1.LeaveMomentCreationBody
            }
        )
    }
    tbl3.DialogContent = createElement2(content, tbl4, tbl5)

    tbl3.DialogActions = React.createElement(Dialog.Actions, {
        LayoutOrder = 3,
        actions = {
            {
                text = var1.GeneralCtaLeave,
                variant = Foundation.Enums.ButtonVariant.Emphasis,
                onActivated = tbl1.onConfirm
            },
            {
                text = var1.GeneralCtaCancel,
                variant = Foundation.Enums.ButtonVariant.Standard,
                onActivated = tbl1.onCancel
            }
        }
    })
    return createElement(root, tbl2, tbl3)
end
