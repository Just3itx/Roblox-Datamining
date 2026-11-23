-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedParentalConsentDialog = script:FindFirstAncestor("VerifiedParentalConsentDialog")
local VerifiedParentalConsentDialogParent = VerifiedParentalConsentDialog.Parent
local React = require(VerifiedParentalConsentDialogParent.React)

local Images = require(VerifiedParentalConsentDialogParent.UIBlox).App.ImageSet.Images
local useLocalization = require(VerifiedParentalConsentDialogParent.Localization).Hooks.useLocalization

local AlertPrompt = require(VerifiedParentalConsentDialog.Components.AlertPrompt)
local _VPCModalType = require(VerifiedParentalConsentDialog.VPCModalType)

local function VPCModalPrompt(tbl1)
    local tbl2 = {
        EnablePurchase = { if tbl1.isActionable then "Common.VerifiedParentalConsent.Description.SpendingRestrictionWithSettings" else "Common.VerifiedParentalConsent.Description.SpendingRestrictionWithoutSettings" }
    }

    local var1 = useLocalization({ title = "Common.VerifiedParentalConsent.Label.AskParent", message = tbl2[tbl1.modalType] })

    return React.createElement(AlertPrompt, {
        title = var1.title,
        titleIcon = Images["icons/graphic/lock_xxlarge"],
        bodyText = var1.message,
        onDismiss = tbl1.onDismiss,
        isActionable = tbl1.isActionable,
        screenSize = tbl1.screenSize,
        onAction = tbl1.onAction
    })
end

return VPCModalPrompt
