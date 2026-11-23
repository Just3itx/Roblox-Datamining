-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent

local React = require(AmpUpsellParent.React)

local QRDeepLinkDialog = require(AmpUpsellParent.IdentityVerification).QRDeepLinkDialog
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization

local authButtonClick = require(AmpUpsellParent.AuthAnalytics).Events.authButtonClick

local function FAEWithQRCodeUpsell(tbl1)
    local appsFlyerLink = tbl1.appsFlyerLink
    local onCancel = tbl1.onCancel
    local sessionId = tbl1.sessionId
    local entryPointEventCtx = tbl1.entryPointEventCtx

    local var1 = useLocalization({
        title = "Amp.FAEUpsell.Modal.QRCode.Title",
        description = "Amp.FAEUpsell.Modal.QRCode.Description",
        footer = "Amp.FAEUpsell.Modal.QRCode.Footer"
    })

    local onClose = React.useCallback(function()
        authButtonClick(entryPointEventCtx, "closeFaeQR", sessionId)
        onCancel()
    end, { onCancel, sessionId, entryPointEventCtx })

    return React.createElement(QRDeepLinkDialog, {
        deeplink = appsFlyerLink,
        title = var1.title,
        description = var1.description,
        footer = var1.footer,
        onClose = onClose
    })
end

return FAEWithQRCodeUpsell
