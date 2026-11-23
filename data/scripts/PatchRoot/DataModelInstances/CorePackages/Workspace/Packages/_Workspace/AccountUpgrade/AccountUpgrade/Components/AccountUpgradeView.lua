-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local Foundation = require(AccountUpgradeParent.Foundation)
local RegisterAuditContent = require(AccountUpgradeParent.AuthCommon).Components.RegisterAuditContent
local LegalTextWithLinks = require(AccountUpgradeParent.AuthCommon).Components.LegalTextWithLinks
local AccountUpgradeFields = require(script.Parent.AccountUpgradeFields)
local AccountUpgradeFieldError = require(script.Parent.AccountUpgradeFieldError)
local BirthdayPickerSheet = require(script.Parent.BirthdayPickerSheet)
local CloseConfirmationDialog = require(script.Parent.CloseConfirmationDialog)
local MarketingConsentCheckbox = require(script.Parent.MarketingConsentCheckbox)
local AccountUpgradeDialog = require(AccountUpgrade.SuccessModal.AccountUpgradeDialog)
local AccountUpgradeDialogActions = require(AccountUpgrade.SuccessModal.AccountUpgradeDialogActions)
local AccountUpgradeField = require(AccountUpgrade.AccountUpgradeField)
local FFlagAccountUpgradeOAuthTelemetry = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthTelemetry)

local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function noop() end

local function createAuditContent(auditContent)
    local tbl1 = {}
    for _, value in auditContent do
        tbl1[value.translationKey] = React.createElement(RegisterAuditContent, value)
    end
    return React.createElement(React.Fragment, nil, tbl1)
end

local function AccountUpgradeView(form)
    local isDisabled = not (form.isSaveEnabled or form.isSubmitting)
    local bool2 = form.fieldStates[AccountUpgradeField.Birthday] ~= nil

    local onClose = form.onClose
    local var1 = React.useCallback(function(_)
        if onClose then
            onClose()
        end
    end, { onClose })
    local onSignOut = form.onSignOut

    local createElement = React.createElement
    local var2 = View
    local tbl1 = {
        tag = {
            ["col size-full-0 auto-y"] = true,
            ["padding-top-xsmall"] = form.subtitleText ~= nil
        },
        testId = "AccountUpgradeContent"
    }

    local tbl2 = { Body = 0, AuditContent = 0 }
    local createElement2 = React.createElement
    local var3 = View
    local tbl3 = {
        tag = "col gap-xlarge size-full-0 auto-y",
        LayoutOrder = 1,
        testId = "AccountUpgradeBody"
    }

    local tbl4 = {
        Fields = React.createElement(AccountUpgradeFields, { form = form, LayoutOrder = 1 }),
        Actions = 0
    }

    local createElement3 = React.createElement
    local var4 = View
    local tbl5 = { tag = "col gap-large size-full-0 auto-y", LayoutOrder = 2 }

    local tbl6 = { MarketingConsent = 0, Submit = 0 }
    local element

    if form.marketingConsentText == nil then
        element = nil
    else
        element = React.createElement(MarketingConsentCheckbox, {
            text = form.marketingConsentText,
            isChecked = form.isMarketingConsentChecked == true,
            isDisabled = form.isSubmitting or form.isMarketingConsentDisabled == true,
            onToggled = form.onMarketingConsentToggled or noop,
            size = InputSize.Small,
            LayoutOrder = 1
        })
    end

    tbl6.MarketingConsent = element

    local createElement4 = React.createElement
    local var5 = View
    local tbl7 = { tag = "col gap-small size-full-0 auto-y", LayoutOrder = 2 }

    local tbl8 = { Buttons = 0, Error = 0, LegalText = 0 }
    local createElement5 = React.createElement
    local var6 = AccountUpgradeDialogActions
    local tbl9 = {
        LayoutOrder = 1,
        buttons = {{
            text = form.saveText,
            variant = if isDisabled then ButtonVariant.Standard else ButtonVariant.Emphasis,
            onActivated = form.onSaveActivated,
            isDisabled = isDisabled,
            isLoading = form.isSubmitting
        }}
    }
    tbl8.Buttons = createElement5(var6, tbl9)

    tbl8.Error = React.createElement(
        AccountUpgradeFieldError,
        {
            text = form.submitError,
            LayoutOrder = 2,
            testId = "AccountUpgradeSubmitError"
        }
    )

    tbl8.LegalText = if form.legalText then React.createElement(LegalTextWithLinks, {
        text = form.legalText,
        onLinkActivated = form.onLegalLinkActivated,
        LayoutOrder = 3,
        testId = "AccountUpgradeLegalText"
    }) else nil
    tbl6.Submit = createElement4(var5, tbl7, tbl8)
    tbl4.Actions = createElement3(var4, tbl5, tbl6)
    tbl2.Body = createElement2(var3, tbl3, tbl4)

    tbl2.AuditContent = if form.auditContent then createAuditContent(form.auditContent) else nil
    local content = createElement(var2, tbl1, tbl2)

    local createElement6 = React.createElement
    local var7 = AccountUpgradeDialog
    local tbl10 = {
        title = form.titleText,
        subtitle = form.subtitleText,
        onClose = 0,
        onCloseActivated = 0,
        hasBackdrop = 0,
        fitsContent = 0,
        isFocusable = 0,
        children = 0
    }

    if not onClose or form.confirmsClose then
        var1 = nil
    end

    tbl10.onClose = var1
    tbl10.onCloseActivated = if form.confirmsClose then onClose else nil
    tbl10.hasBackdrop = form.hasBackdrop
    tbl10.fitsContent = form.fitsDialogToContent
    tbl10.isFocusable = not (form.isBirthdayPickerOpen or form.isCloseConfirmationOpen)
    local children = {
        Content = content,
        BirthdayPicker = if bool2 then React.createElement(BirthdayPickerSheet, {
            isOpen = form.isBirthdayPickerOpen,
            birthday = form.birthday,
            onClose = form.onBirthdayPickerClosed,
            onConfirm = form.onBirthdayConfirmed,
            onAllPicked = if FFlagAccountUpgradeOAuthTelemetry then form.onBirthdayPickerAllPicked else nil
        }) else nil,
        CloseConfirmation = if form.isCloseConfirmationOpen and onSignOut then React.createElement(CloseConfirmationDialog, { onBack = form.onCloseConfirmationBack, onSignOut = onSignOut }) else nil
    }
    tbl10.children = children
    return createElement6(var7, tbl10)
end

return AccountUpgradeView
