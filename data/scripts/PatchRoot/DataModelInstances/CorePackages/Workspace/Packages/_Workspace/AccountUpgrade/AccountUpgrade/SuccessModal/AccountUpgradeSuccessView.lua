-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local React = require(AccountUpgradeParent.React)
local Foundation = require(AccountUpgradeParent.Foundation)
local Localization = require(AccountUpgradeParent.Localization)

local AccountUpgradeDialog = require(script.Parent.AccountUpgradeDialog)
local AccountUpgradeIdentityHeader = require(script.Parent.AccountUpgradeIdentityHeader)
local AccountUpgradeDialogActions = require(script.Parent.AccountUpgradeDialogActions)

local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local useLocalization = Localization.Hooks.useLocalization

local function AccountUpgradeSuccessView(tbl1)
    local var1 = useLocalization({
        usernameChangedBody = {
            "Authentication.SignUp.Description.UsernameChanged",
            platform = tbl1.linkedAccountType
        },
        usernameUnchangedBody = {
            "Authentication.SignUp.Description.UsernameUnchanged",
            platform = tbl1.linkedAccountType
        },
        respawnNowText = "Authentication.SignUp.Action.RespawnNow",
        applyLaterText = "Authentication.SignUp.Action.ApplyOnNextRespawn",
        confirmText = "CommonUI.Controls.Action.OK"
    })

    local var2 = tbl1.didUsernameChange and tbl1.canRespawn ~= false
    local var3 = if var2 then var1.usernameChangedBody else var1.usernameUnchangedBody
    local buttons = var2
        and {
            {
                text = var1.respawnNowText,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl1.onRespawnNow
            },
            {
                text = var1.applyLaterText,
                variant = ButtonVariant.Standard,
                onActivated = tbl1.onApplyLater
            }
        }
        or {{
            text = var1.confirmText,
            variant = ButtonVariant.Emphasis,
            onActivated = tbl1.onConfirm
        }}

    local content = React.createElement(View, {
        tag = "col align-x-center gap-xxlarge size-full-0 auto-y"
    }, {
        IdentityHeader = React.createElement(
            AccountUpgradeIdentityHeader,
            {
                userId = tbl1.userId,
                displayName = tbl1.displayName,
                username = tbl1.username,
                LayoutOrder = 1
            }
        ),
        BodyAndActions = React.createElement(
            View,
            { tag = "col align-x-center gap-xlarge size-full-0 auto-y", LayoutOrder = 2 },
            {
                Body = React.createElement(FoundationText, {
                    tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left content-default",
                    Text = var3,
                    LayoutOrder = 1,
                    testId = "account-upgrade-success-body"
                }),
                Actions = React.createElement(AccountUpgradeDialogActions, { LayoutOrder = 2, buttons = buttons })
            }
        )
    })

    return React.createElement(
        AccountUpgradeDialog,
        {
            hasBackdrop = tbl1.hasBackdrop,
            testId = "account-upgrade-success-dialog",
            children = { Content = content }
        }
    )
end

return AccountUpgradeSuccessView
