-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local Foundation = require(AccountUpgradeParent.Foundation)
local useLocalization = require(AccountUpgradeParent.Localization).Hooks.useLocalization
local AuthSignup = require(AccountUpgradeParent.AuthSignup)
local SharedFlags = require(AccountUpgradeParent.SharedFlags)

local useRequireManualSelection = require(AccountUpgrade.Hooks.useRequireManualSelection)
local FFlagAccountUpgradeOAuthTelemetry = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthTelemetry)
local AccountUpgradeDialog = require(AccountUpgrade.SuccessModal.AccountUpgradeDialog)
local AccountUpgradeDialogActions = require(AccountUpgrade.SuccessModal.AccountUpgradeDialogActions)

local BirthdayPicker = AuthSignup.Components.BirthdayPicker
local useValidatedBirthday = AuthSignup.Hooks.useValidatedBirthday

local FIntSinglePageSignupMinimumAge = SharedFlags.FIntSinglePageSignupMinimumAge

local ButtonVariant = Foundation.Enums.ButtonVariant

local function BirthdayPickerDialog(tbl1)
    local var1, var2 = useValidatedBirthday(FIntSinglePageSignupMinimumAge)

    local requireManualSelection = useRequireManualSelection()

    local onAllPicked = tbl1.onAllPicked
    local var4 = if FFlagAccountUpgradeOAuthTelemetry then React.useRef(false) else nil

    local updateBirthday = if FFlagAccountUpgradeOAuthTelemetry then React.useCallback(function(num1: number?, num2: number?, num3: number?)
        var2(num1, num2, num3)
        if onAllPicked and var4 and not var4.current and num1 and num2 and num3 then
            var4.current = true
            onAllPicked()
        end
    end, { var2, onAllPicked, var4 }) else nil

    local onConfirm = tbl1.onConfirm
    local onActivated = React.useCallback(function()
        if var1 ~= nil then
            onConfirm(var1)
        end
    end, { var1, onConfirm })

    local onClose = tbl1.onClose
    local var3 = React.useCallback(function(_)
        onClose()
    end, { onClose })

    local var8 = useLocalization({
        titleText = "Authentication.SignUp.Label.SelectBirthdaySentenceCase",
        confirmText = "Authentication.SignUp.Button.OKCaptialized"
    })

    local birthday = tbl1.birthday
    local month = if birthday then birthday.Month else nil
    local day = if birthday then birthday.Day else nil
    local year = if birthday then birthday.Year else nil
    return React.createElement(AccountUpgradeDialog, {
        title = var8.titleText,
        onClose = var3,
        hasBackdrop = true,
        testId = "account-upgrade-birthday-dialog",
        children = {
            Picker = React.createElement(BirthdayPicker, {
                layoutOrder = 1,
                minAgeAllowed = FIntSinglePageSignupMinimumAge,
                requireManualSelection = requireManualSelection,
                updateBirthday = updateBirthday or var2,
                initialMonth = month,
                initialDay = day,
                initialYear = year
            })
        },
        actions = React.createElement(AccountUpgradeDialogActions, {
            LayoutOrder = 3,
            testId = "account-upgrade-birthday-dialog-actions",
            buttons = {{
                text = var8.confirmText,
                variant = ButtonVariant.Emphasis,
                onActivated = onActivated,
                isDisabled = var1 == nil
            }}
        })
    })
end

local function BirthdayPickerSheet(tbl1)
    if not tbl1.isOpen then
        return nil
    end

    return React.createElement(BirthdayPickerDialog, tbl1)
end

return BirthdayPickerSheet
