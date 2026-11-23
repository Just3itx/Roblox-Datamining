-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)

local FocusNavigationUtils = require(AccountUpgradeParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local Foundation = require(AccountUpgradeParent.Foundation)
local Dialog = Foundation.Dialog
local View = Foundation.View
local FoundationText = Foundation.Text
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation

local useLocalization = require(AccountUpgradeParent.Localization).Hooks.useLocalization
local useMobilePage = require(AccountUpgrade.MobilePage.useMobilePage)

local function CloseConfirmationDialog(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = useMobilePage()
    local ref = useFocusRoot({ surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp, isAutoFocusRoot = true })

    local var4 = useLocalization({
        titleText = "Authentication.SignUp.Header.CancelAccountCreation",
        bodyText = "Authentication.SignUp.Subtitle.YoureAlmostThereClose",
        continueSetupText = "Authentication.SignUp.Action.ContinueSetup",
        cancelText = "Authentication.SignUp.Action.Cancel"
    })

    local var5, var6 = React.useState(false)
    local var7 = React.useRef(false)
    local onSignOut = tbl1.onSignOut
    local onActivated = React.useCallback(function()
        if var7.current then
            return
        end
        var7.current = true
        var6(true)
        onSignOut()
    end, { onSignOut })

    local onBack = tbl1.onBack
    local var3 = React.useCallback(function()
        if not var7.current then
            onBack()
        end
    end, { onBack })

    local actions = {
        {
            text = var4.continueSetupText,
            variant = ButtonVariant.Emphasis,
            onActivated = var3,
            isDisabled = var5
        },
        {
            text = var4.cancelText,
            variant = ButtonVariant.Standard,
            onActivated = onActivated,
            isLoading = var5
        }
    }

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl3 = {
        ref = ref,
        size = DialogSize.Small,
        disablePortal = false,
        hasBackdrop = true,
        testId = "account-upgrade-close-dialog"
    }

    local tbl4 = {
        Header = React.createElement(View, {
            tag = "col gap-xsmall size-full-0 auto-y",
            padding = {
                top = UDim.new(0, var1.Size.Size_450),
                bottom = UDim.new(0, var1.Padding.Large)
            },
            LayoutOrder = 1,
            testId = "account-upgrade-close-dialog--header"
        }, {
            Title = React.createElement(FoundationText, {
                Text = var4.titleText,
                tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-left content-emphasis",
                LayoutOrder = 1,
                testId = "account-upgrade-close-dialog--title"
            }),
            Body = React.createElement(Dialog.Text, { Text = var4.bodyText, LayoutOrder = 2 })
        }),
        Actions = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = actions,
            orientation = if var2 then EnumsOrientation.Vertical else EnumsOrientation.Horizontal
        })
    }
    return createElement(root, tbl3, tbl4)
end

return CloseConfirmationDialog
