-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local React = require(AmpUpsellParent.React)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local vpcErrorScreenStrings = require(AmpUpsell.Common.LocalizationStrings).vpcErrorScreenStrings

local getRetryBehaviorFromErrorCodeAndRetryNum = require(AmpUpsell.Common.VPCErrorUtils).getRetryBehaviorFromErrorCodeAndRetryNum
local getStringsFromErrorCodeAndRetryNum = require(AmpUpsell.Common.VPCErrorUtils).getStringsFromErrorCodeAndRetryNum
local useSelector = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector
local UIBlox = require(AmpUpsellParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Cryo = require(AmpUpsellParent.Cryo)
local VPCRetryBehaviorEnum = require(AmpUpsell.Common.Enums).VPCRetryBehaviorEnum

local GetFFlagEnableVPCUpsellFoundationDialogHardening = require(AmpUpsell.Flags.GetFFlagEnableVPCUpsellFoundationDialogHardening)
local GetShouldUseFoundationUIVPCUpsell = require(AmpUpsell.Flags.GetShouldUseFoundationUIVPCUpsell)

local Foundation = require(AmpUpsellParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function VPCErrorScreen(tbl1)
    local errorCode = tbl1.errorCode
    local onRetryAmp = tbl1.onRetryAmp
    local onRetryVpc = tbl1.onRetryVPC
    local onCancel = tbl1.onCancel
    local onSuccess = tbl1.onSuccess
    local retryNum = tbl1.retryNum
    local screenSize = useSelector(selectScreenSize)
    local disablePortal = if tbl1.disablePortal then tbl1.disablePortal else false
    local isInExperienceEntry = if tbl1.isInExperienceEntry then tbl1.isInExperienceEntry else false
    local shouldUseFoundationUivpcUpsell = GetShouldUseFoundationUIVPCUpsell(isInExperienceEntry)

    local retryBehaviorFromErrorCodeAndRetryNum = getRetryBehaviorFromErrorCodeAndRetryNum(errorCode, retryNum)
    local stringsFromErrorCodeAndRetryNum = getStringsFromErrorCodeAndRetryNum(errorCode, retryNum)

    local var2 = useLocalization(
        Cryo.Dictionary.join(
            vpcErrorScreenStrings,
            {
                titleText = stringsFromErrorCodeAndRetryNum.title,
                bodyText = stringsFromErrorCodeAndRetryNum.body
            }
        )
    )
    local tbl2 = {}
    local tbl3 = {}
    if retryBehaviorFromErrorCodeAndRetryNum == VPCRetryBehaviorEnum.RetryVPC
        or retryBehaviorFromErrorCodeAndRetryNum == VPCRetryBehaviorEnum.RetryAMP
    then
        if retryBehaviorFromErrorCodeAndRetryNum == VPCRetryBehaviorEnum.RetryVPC then
            onRetryAmp = onRetryVpc
        end

        if shouldUseFoundationUivpcUpsell then
            tbl3 = {
                {
                    text = var2.cancelButton,
                    variant = ButtonVariant.Standard,
                    onActivated = onCancel
                },
                {
                    text = var2.retryButton,
                    variant = ButtonVariant.Emphasis,
                    onActivated = onRetryAmp
                }
            }
        else
            tbl2 = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = onCancel,
                        text = var2.cancelButton
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onRetryAmp,
                        text = var2.retryButton
                    }
                }
            }
        end
    elseif retryBehaviorFromErrorCodeAndRetryNum == VPCRetryBehaviorEnum.Success then
        if shouldUseFoundationUivpcUpsell then
            tbl3 = {{
                text = var2.okButton,
                variant = ButtonVariant.Standard,
                onActivated = onSuccess
            }}
        else
            tbl2 = {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = onSuccess,
                    text = var2.okButton
                }
            }}
        end
    elseif shouldUseFoundationUivpcUpsell then
        tbl3 = {{
            text = var2.okButton,
            variant = ButtonVariant.Standard,
            onActivated = onCancel
        }}
    else
        tbl2 = {{
            buttonType = ButtonType.PrimarySystem,
            props = {
                onActivated = onCancel,
                text = var2.okButton
            }
        }}
    end

    if not shouldUseFoundationUivpcUpsell then
        return React.createElement(InteractiveAlert, {
            anchorPoint = Vector2.new(0.5, 0.5),
            position = UDim2.new(0.5, 0, 0.5, 0),
            screenSize = screenSize,
            title = var2.titleText,
            bodyText = var2.bodyText,
            buttonStackInfo = { buttons = tbl2 }
        })
    end

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small,
        onClose = tbl1.onClose or onCancel,
        disablePortal = disablePortal,
        hasBackdrop = not not GetFFlagEnableVPCUpsellFoundationDialogHardening()
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var2.titleText }),
        DialogContent = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                DialogText = React.createElement(Dialog.Text, { Text = var2.bodyText })
            }
        ),
        DialogActions = React.createElement(Dialog.Actions, { LayoutOrder = 3, actions = tbl3 })
    })
end

return VPCErrorScreen
