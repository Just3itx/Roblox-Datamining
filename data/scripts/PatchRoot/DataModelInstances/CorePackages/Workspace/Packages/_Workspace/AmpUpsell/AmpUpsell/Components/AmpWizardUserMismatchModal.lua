-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent

local React = require(AmpUpsellParent.React)

local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization

local Foundation = require(AmpUpsellParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local authModalShown = require(AmpUpsellParent.AuthAnalytics).Events.authModalShown
local GetFFlagEnableAmpUserMismatchTelemetry = require(AmpUpsell.Flags.GetFFlagEnableAmpUserMismatchTelemetry)

local function AmpWizardUserMismatchModal(tbl1)
    local navigation = tbl1.navigation
    local entryPointEventCtx = tbl1.entryPointEventCtx

    local var1 = useLocalization({
        title = "Amp.ErrorScreen.UserMismatchTitle",
        description = "Amp.ErrorScreen.UserMismatchBody",
        ok = "CommonUI.Controls.Action.OK"
    })

    React.useEffect(function()
        if GetFFlagEnableAmpUserMismatchTelemetry() then
            authModalShown(entryPointEventCtx or "", nil, "userMismatch")
        end
    end, { entryPointEventCtx })

    local onActivated = React.useCallback(function()
        navigation.goBack()
    end, { navigation })

    return React.createElement(Dialog.Root, {
        size = DialogSize.Medium
    }, {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var1.title }),
        BodyText = React.createElement(Dialog.Text, { LayoutOrder = 2, Text = var1.description }),
        DialogActions = React.createElement(
            Dialog.Actions,
            {
                LayoutOrder = 3,
                actions = {{
                    text = var1.ok,
                    variant = ButtonVariant.Emphasis,
                    onActivated = onActivated
                }}
            }
        )
    })
end

return AmpWizardUserMismatchModal
