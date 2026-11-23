-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local React = require(AmpUpsellParent.React)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local useSelector = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector
local UIBlox = require(AmpUpsellParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Cryo = require(AmpUpsellParent.Cryo)

local GetFFlagEnableVPCUpsellFoundationDialogHardening = require(AmpUpsell.Flags.GetFFlagEnableVPCUpsellFoundationDialogHardening)
local GetShouldUseFoundationUIVPCUpsell = require(AmpUpsell.Flags.GetShouldUseFoundationUIVPCUpsell)

local Foundation = require(AmpUpsellParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function VPCConfirmationScreen(tbl1)
    local onAck = tbl1.onAck
    local screenSize = useSelector(selectScreenSize)
    local messageStrings = tbl1.messageStrings
    local parentEmails = tbl1.parentEmails
    local disablePortal = if tbl1.disablePortal then tbl1.disablePortal else false
    local isInExperienceEntry = if tbl1.isInExperienceEntry then tbl1.isInExperienceEntry else false
    local shouldUseFoundationUivpcUpsell = GetShouldUseFoundationUIVPCUpsell(isInExperienceEntry)
    local var2 = if #parentEmails == 1 then useLocalization(
        Cryo.Dictionary.join(messageStrings, { bodyText = { messageStrings.oneParentBody, parentEmail = parentEmails[1] } })
    ) else useLocalization(Cryo.Dictionary.join(messageStrings, { bodyText = messageStrings.multipleParentsBody }))

    if not shouldUseFoundationUivpcUpsell then
        return React.createElement(InteractiveAlert, {
            anchorPoint = Vector2.new(0.5, 0.5),
            position = UDim2.new(0.5, 0, 0.5, 0),
            screenSize = screenSize,
            title = var2.title,
            bodyText = var2.bodyText,
            buttonStackInfo = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onAck,
                        text = var2.buttonText
                    }
                }}
            }
        })
    end

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small,
        onClose = tbl1.onClose or onAck,
        disablePortal = disablePortal,
        hasBackdrop = not not GetFFlagEnableVPCUpsellFoundationDialogHardening()
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var2.title }),
        DialogContent = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                DialogText = React.createElement(Dialog.Text, { Text = var2.bodyText })
            }
        ),
        DialogActions = React.createElement(
            Dialog.Actions,
            {
                LayoutOrder = 3,
                actions = {{
                    text = var2.buttonText,
                    variant = ButtonVariant.Standard,
                    onActivated = onAck
                }}
            }
        )
    })
end

return VPCConfirmationScreen
