-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2WizardParent = script:FindFirstAncestor("AmpV2Wizard").Parent

local React = require(AmpV2WizardParent.React)
local useLocalization = require(AmpV2WizardParent.Localization).Hooks.useLocalization

local Foundation = require(AmpV2WizardParent.Foundation)
local Dialog = Foundation.Dialog
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation

local function GenericErrorModal(tbl1)
    local var1 = useLocalization(
        {
            title = "Feature.Parents.Title.SomethingWentWrong",
            close = "Common.VerifiedParentalConsent.Action.Close"
        }
    )

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small,
        onClose = tbl1.onClose
    }, {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var1.title }),
        Actions = React.createElement(Dialog.Actions, {
            LayoutOrder = 2,
            orientation = EnumsOrientation.Vertical,
            actions = {{
                text = var1.close,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl1.onClose
            }}
        })
    })
end

return GenericErrorModal
