-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local Otter = require(AccountUpgradeParent.Otter)
local Foundation = require(AccountUpgradeParent.Foundation)
local useLocalization = require(AccountUpgradeParent.Localization).Hooks.useLocalization
local AuthSignup = require(AccountUpgradeParent.AuthSignup)
local SharedFlags = require(AccountUpgradeParent.SharedFlags)

local useRequireManualSelection = require(AccountUpgrade.Hooks.useRequireManualSelection)
local _BirthdaySheetView = require(script.Parent.BirthdaySheetView)

local DateHelper = require(AccountUpgradeParent.Time).DateHelper

local useValidatedBirthday = AuthSignup.Hooks.useValidatedBirthday

local FIntSinglePageSignupMinimumAge = SharedFlags.FIntSinglePageSignupMinimumAge

local tbl1 = { frequency = 3 }

local function useSlide(current: (...any) -> (...any))
    local reducedMotion = Foundation.Hooks.usePreferences().reducedMotion
    local var1, var2 = React.useBinding(if reducedMotion then 1 else 0)
    local var3 = React.useMemo(function()
        return Otter.createSingleMotor(if reducedMotion then 1 else 0)
    end, { reducedMotion })
    local var4 = React.useRef(false)
    local var5 = React.useRef(current)
    var5.current = current

    React.useEffect(function()
        local var6 = var3:onStep(function(num1: number)
            var2(num1)
            if var4.current and num1 <= 0.1 then
                var4.current = false
                var3:stop()
                var5.current()
            end
        end)
        if not reducedMotion then
            var3:setGoal(Otter.spring(1, tbl1))
        end
        return function()
            var6()
            var3:destroy()
        end
    end, { var3, reducedMotion })

    return var1, (React.useCallback(function()
        if reducedMotion then
            var5.current()
        elseif not var4.current then
            var4.current = true
            var3:setGoal(Otter.spring(0, tbl1))
        end
    end, { var3, reducedMotion }))
end

local function useBirthdaySheetViewModel(tbl2)
    local slideProgress, onDismiss = useSlide(tbl2.onClose)

    local var3, var4 = useValidatedBirthday(FIntSinglePageSignupMinimumAge)

    local requireManualSelection = useRequireManualSelection()

    local onConfirm = tbl2.onConfirm
    local onConfirmActivated = React.useCallback(function()
        if var3 ~= nil then
            onConfirm(var3)
        end
    end, { var3, onConfirm })

    local onAllPicked = tbl2.onAllPicked
    local var7 = React.useRef(false)
    local updateBirthday = React.useCallback(function(num1: number?, num2: number?, num3: number?)
        var4(num1, num2, num3)
        if onAllPicked and not var7.current and num1 and num2 and num3 then
            var7.current = true
            onAllPicked()
        end
    end, { var4, onAllPicked })

    local var9 = if tbl2.showsAgeSummary then var3 else nil
    local ageInYears = if var9 then var9:GetAgeInYears() else nil
    local onAgeSummaryShown = tbl2.onAgeSummaryShown
    local var10 = React.useRef(false)
    React.useEffect(function()
        if ageInYears ~= nil and onAgeSummaryShown and not var10.current then
            var10.current = true
            onAgeSummaryShown(ageInYears)
        end
    end, { ageInYears, onAgeSummaryShown })

    local var11 = useLocalization({
        titleText = "Authentication.SignUp.Label.SelectBirthdaySentenceCase",
        confirmText = "Authentication.SignUp.Button.OKCaptialized",
        monthText = if var9 then DateHelper.MonthsLocalizationKeys[var9.Month] else nil,
        dayAffix = DateHelper.DayAffixLocalizationKey,
        yearAffix = DateHelper.YearAffixLocalizationKey
    })
    local date = if var9 and var11.monthText then DateHelper:GetFormattedFullString(
        var11.monthText,
        var9.Day,
        var11.dayAffix,
        var9.Year,
        var11.yearAffix,
        " ",
        LocalizationService.RobloxLocaleId
    ) else nil
    local var12 = useLocalization({
        ageSummaryText = date and {
            "Authentication.SignUp.Label.BirthdayPickerWithDateAndAge",
            date = date,
            yearsOld = tostring(ageInYears)
        }
            or nil
    })

    local birthday = tbl2.birthday

    return {
        titleText = var11.titleText,
        confirmText = var11.confirmText,
        ageSummaryText = var12.ageSummaryText,
        isCentered = tbl2.isCentered == true,
        slideProgress = slideProgress,
        minAgeAllowed = FIntSinglePageSignupMinimumAge,
        requireManualSelection = requireManualSelection,
        updateBirthday = updateBirthday,
        initialMonth = if birthday then birthday.Month else nil,
        initialDay = if birthday then birthday.Day else nil,
        initialYear = if birthday then birthday.Year else nil,
        isConfirmEnabled = var3 ~= nil,
        onDismiss = onDismiss,
        onConfirmActivated = onConfirmActivated
    }
end

return useBirthdaySheetViewModel
