-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local Foundation = require(BuildExperienceParent.Foundation)
local NumberLocalization = require(BuildExperienceParent.Localization).NumberLocalization
local React = require(BuildExperienceParent.React)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local GetFFlagLuaAppEnableOpenTypeSupport = SharedFlags.GetFFlagLuaAppEnableOpenTypeSupport

local Button = Foundation.Button
local Chip = Foundation.Chip
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View
local Sheet = Foundation.Sheet

local ButtonVariant = Foundation.Enums.ButtonVariant
local ChipSize = Foundation.Enums.ChipSize
local ChipVariant = Foundation.Enums.ChipVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize

local tbl1 = { 2000, 5000 }

local function formatNumber(num1: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    return NumberLocalization.localize(string.format("%.0f", math.floor(num1)), LocalizationService.RobloxLocaleId)
end

local function DailyLimitBottomSheetContent(tbl2)
    local additionalUsed = tbl2.additionalUsed or 0
    local var1 = useLocalization({
        belowSpend = {
            LocalizationStrings.CREATOR_CREDIT_LIMIT_BELOW_SPEND,
            ALREADY_SPENT = formatNumber(additionalUsed)
        },
        confirm = LocalizationStrings.CREATOR_CREDIT_LIMIT_SHEET_CONFIRM,
        noLimit = LocalizationStrings.CREATOR_CREDIT_LIMIT_SHEET_NO_LIMIT,
        saveError = LocalizationStrings.CREATOR_CREDIT_SETTINGS_SAVE_ERROR,
        title = LocalizationStrings.CREATOR_CREDIT_LIMIT_SHEET_TITLE
    })
    local belowSpend = var1.belowSpend
    local confirm = var1.confirm
    local noLimit = var1.noLimit
    local saveError = var1.saveError
    local title = var1.title
    local testId = tbl2.testId or "creator-credit-limit-sheet"

    local num1 = math.max(tbl2.initialValue or 500, 100)
    local isDisabled = tbl2.isSaving == true

    local var2, var3 = React.useState(num1)
    local var4, var5 = React.useState(tbl2.initialIsNoLimit == true)

    local onActivated = React.useCallback(function()
        var5(false)
        var3(function(arg1): number
            return math.max(arg1 - 500, 100)
        end)
    end, {})

    local var6 = React.useCallback(function()
        var5(false)
        var3(function(arg1): number
            return arg1 + 500
        end)
    end, {})

    local var8 = React.useCallback(function(num2: number)
        var5(false)
        var3(math.max(num2, 100))
    end, {})

    local var7 = React.useCallback(function()
        var5(true)
    end, {})

    local bool2 = not var4 and var2 < additionalUsed
    if bool2 then
        saveError = belowSpend
    elseif not tbl2.saveError then
        saveError = nil
    end
    local var9 = React.useCallback(function()
        if var4 then
            tbl2.onConfirm(nil)
        elseif not (var2 < additionalUsed) then
            tbl2.onConfirm(var2)
        end
    end, {
        var2,
        additionalUsed,
        var4,
        tbl2.onConfirm
    })

    local tbl3 = {
        NoLimit = React.createElement(Chip, {
            LayoutOrder = 1,
            text = noLimit,
            leading = IconName.CircleX,
            variant = ChipVariant.Standard,
            size = ChipSize.Medium,
            onActivated = var7,
            isDisabled = isDisabled,
            testId = `{testId}-preset-no-limit`
        })
    }

    for value, value2 in tbl1 do
        local str1 = `Preset{value2}`
        local createElement = React.createElement
        local var11 = Chip
        local tbl4 = {
            LayoutOrder = 1 + value,
            text = formatNumber(value2),
            leading = IconName.Robux,
            variant = ChipVariant.Standard,
            size = ChipSize.Medium,
            onActivated = 0,
            isDisabled = 0,
            testId = 0
        }

        function tbl4.onActivated()
            var8(value2)
        end
        tbl4.isDisabled = isDisabled
        tbl4.testId = `{testId}-preset-{value2}`
        tbl3[str1] = createElement(var11, tbl4)
    end

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl4 = {
        isOpen = true,
        preferCenterSheet = true,
        onClose = tbl2.onCancel
    }
    local tbl5 = {
        Header = React.createElement(
            Sheet.Header,
            { hasCloseAffordance = true },
            {
                Title = React.createElement(FoundationText, { Text = title, tag = "auto-xy text-heading-small content-emphasis" })
            }
        ),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local var11 = nil
    local tbl6 = { Body = 0 }
    local createElement3 = React.createElement
    local var12 = View
    local tbl7 = { tag = "col gap-large size-full-0 auto-y" }

    local tbl8 = { Stepper = 0, Chips = 0, Error = 0 }
    local createElement4 = React.createElement
    local var13 = View
    local tbl9 = {
        LayoutOrder = 1,
        tag = "row align-x-center align-y-center gap-large size-full-0 auto-y padding-y-medium"
    }

    local tbl10 = {
        Minus = React.createElement(IconButton, {
            LayoutOrder = 1,
            icon = IconName.MinusSmall,
            isCircular = true,
            variant = ButtonVariant.Utility,
            size = InputSize.Medium,
            onActivated = onActivated,
            isDisabled = isDisabled or var4 or var2 <= 100,
            testId = `{testId}-decrement`
        }),
        ValueDisplay = 0,
        Plus = 0
    }
    local createElement5 = React.createElement
    local var14 = View
    local tbl11 = { LayoutOrder = 2, tag = "row align-y-center gap-small auto-xy" }

    local tbl12 = {
        IconEl = React.createElement(Icon, {
            LayoutOrder = 1,
            name = if var4 then IconName.CircleX else IconName.Robux,
            size = IconSize.Large,
            tag = "auto-xy content-emphasis"
        }),
        Amount = 0
    }

    local createElement6 = React.createElement
    local var15 = FoundationText
    local tbl13 = {
        LayoutOrder = 2,
        Text = 0,
        tag = "auto-xy text-heading-medium content-emphasis",
        OpenTypeFeatures = 0,
        testId = 0
    }
    if not var4 then
        noLimit = formatNumber(var2)
    end

    tbl13.Text = noLimit

    tbl13.OpenTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() then "tnum" else nil
    tbl13.testId = `{testId}-value`
    tbl12.Amount = createElement6(var15, tbl13)
    tbl10.ValueDisplay = createElement5(var14, tbl11, tbl12)

    tbl10.Plus = React.createElement(IconButton, {
        LayoutOrder = 3,
        icon = IconName.PlusSmall,
        isCircular = true,
        variant = ButtonVariant.Utility,
        size = InputSize.Medium,
        onActivated = var6,
        isDisabled = isDisabled or var4,
        testId = `{testId}-increment`
    })
    tbl8.Stepper = createElement4(var13, tbl9, tbl10)

    tbl8.Chips = React.createElement(
        View,
        { LayoutOrder = 2, tag = "row align-x-center align-y-center gap-small size-full-0 auto-y" },
        tbl3
    )
    local element = if saveError then React.createElement(FoundationText, {
        LayoutOrder = 3,
        Text = saveError,
        tag = "size-full-0 auto-y text-caption-medium text-wrap text-align-x-center content-system-alert",
        testId = if bool2 then `{testId}-below-spend-error` else `{testId}-save-error`
    }) else nil
    tbl8.Error = element
    tbl6.Body = createElement3(var12, tbl7, tbl8)
    tbl5.Content = createElement2(content, var11, tbl6)

    tbl5.Actions = React.createElement(Sheet.Actions, nil, {
        Confirm = React.createElement(Button, {
            text = confirm,
            size = InputSize.Large,
            variant = ButtonVariant.Emphasis,
            fillBehavior = FillBehavior.Fill,
            onActivated = var9,
            isDisabled = isDisabled or bool2,
            testId = `{testId}-confirm`
        })
    })
    return createElement(root, tbl4, tbl5)
end

local function DailyLimitBottomSheet(tbl2)
    if not tbl2.isOpen then
        return nil
    end

    return React.createElement(DailyLimitBottomSheetContent, tbl2)
end

return DailyLimitBottomSheet
