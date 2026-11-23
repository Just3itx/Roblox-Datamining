-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local Foundation = require(BuildExperienceParent.Foundation)
local NumberLocalization = require(BuildExperienceParent.Localization).NumberLocalization
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FFlagBuildExperienceFreeTrialResetPeriod = require(BuildExperience.Flags.FFlagBuildExperienceFreeTrialResetPeriod)

local Button = Foundation.Button
local Icon = Foundation.Icon
local Progress = Foundation.Progress
local FoundationText = Foundation.Text
local Toggle = Foundation.Toggle
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local ProgressShape = Foundation.Enums.ProgressShape
local ProgressSize = Foundation.Enums.ProgressSize

local function noop() end

local function clampPct(pctUsed: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if pctUsed < 0 then 0 elseif pctUsed > 100 then 100 else pctUsed
end

local function formatNumber(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return NumberLocalization.localize(string.format("%.0f", math.floor(num1)), LocalizationService.RobloxLocaleId)
end

local function FreeUsageCard(tbl1)
    local value = clampPct(tbl1.pctUsed)
    local var1 = useLocalization({
        caption = LocalizationStrings.CREATOR_CREDIT_FREE_USAGE_CAPTION,
        captionWeekly = LocalizationStrings.CREATOR_CREDIT_FREE_USAGE_CAPTION_WEEKLY,
        captionMonthly = LocalizationStrings.CREATOR_CREDIT_FREE_USAGE_CAPTION_MONTHLY,
        label = LocalizationStrings.CREATOR_CREDIT_FREE_USAGE_LABEL,
        percentUsed = {
            LocalizationStrings.CREATOR_CREDIT_PERCENT_USED,
            PERCENT = math.floor(value + 0.5)
        },
        resetHours = if tbl1.resetHours == 1 then LocalizationStrings.CREATOR_CREDIT_RESET_ONE_HOUR else tbl1.resetHours ~= nil and {
            LocalizationStrings.CREATOR_CREDIT_RESET_HOURS,
            HOURS = tbl1.resetHours
        } or nil
    })

    local label = var1.label
    local percentUsed = var1.percentUsed
    local var2

    if FFlagBuildExperienceFreeTrialResetPeriod then
        if tbl1.resetPeriod == "Weekly" then
            var2 = var1.captionWeekly
        elseif tbl1.resetPeriod == "Monthly" then
            var2 = var1.captionMonthly
        else
            var2 = var1.caption
        end

        if (tbl1.resetPeriod == nil or tbl1.resetPeriod == "Daily") and math.floor(value + 0.5) > 0 and tbl1.resetHours ~= nil then
            var2 = var1.resetHours
        end
    else
        var2 = var1.caption
        if math.floor(value + 0.5) > 0 and tbl1.resetHours ~= nil then
            var2 = var1.resetHours
        end
    end
    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col gap-small size-full-0 auto-y padding-large radius-large bg-shift-100",
        testId = "creator-credit-page-free-usage-card"
    }, {
        Label = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = label,
            tag = "size-full-0 auto-y text-title-medium text-align-x-left content-emphasis",
            testId = "creator-credit-page-free-usage-label"
        }),
        Value = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = percentUsed,
            tag = "size-full-0 auto-y text-heading-small text-align-x-left content-emphasis",
            testId = "creator-credit-page-free-usage-value"
        }),
        Bar = React.createElement(Progress, {
            LayoutOrder = 3,
            shape = ProgressShape.Bar,
            size = ProgressSize.Medium,
            value = value,
            width = UDim.new(1, 0),
            testId = "creator-credit-page-daily-progress"
        }),
        Caption = React.createElement(FoundationText, {
            LayoutOrder = 4,
            Text = var2,
            tag = "size-full-0 auto-y padding-top-medium text-body-small text-align-x-left content-muted",
            testId = "creator-credit-page-free-usage-reset"
        })
    })
end

local function RobuxLine(tbl1)
    local var1 = formatNumber(tbl1.amount)
    local usedOf = tbl1.usedOf
    if tbl1.kind == "used" then
        assert(usedOf ~= nil, "usedOf required when kind == 'used'")
    end

    local limit = if usedOf == nil then "" else formatNumber(usedOf)
    local var3 = useLocalization({
        available = tbl1.kind == "available" and {
            LocalizationStrings.CREATOR_CREDIT_AMOUNT_AVAILABLE,
            AMOUNT = var1
        } or nil,
        used = tbl1.kind == "used" and {
            LocalizationStrings.CREATOR_CREDIT_ADDITIONAL_USED,
            USED = var1,
            LIMIT = limit
        }
            or tbl1.kind == "usedNoLimit" and {
                LocalizationStrings.CREATOR_CREDIT_UNLIMITED_USED,
                USED = var1
            }
            or nil
    })
    local var4 = if tbl1.kind == "available" then var3.available else var3.used
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "row align-y-center gap-xsmall size-full-0 auto-y padding-bottom-medium"
        },
        {
            IconEl = React.createElement(Icon, {
                LayoutOrder = 1,
                name = IconName.Robux,
                size = IconSize.Medium,
                tag = {
                    ["auto-xy"] = true,
                    ["content-muted"] = not tbl1.isEnabled,
                    ["content-emphasis"] = tbl1.isEnabled
                }
            }),
            Amount = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = var4,
                tag = {
                    ["auto-xy text-heading-small"] = true,
                    ["content-muted"] = not tbl1.isEnabled,
                    ["content-emphasis"] = tbl1.isEnabled
                },
                testId = "creator-credit-page-robux-line"
            })
        }
    )
end

local function AdditionalUsageCard(tbl1)
    local var1 = useLocalization({
        additionalDailyUsage = LocalizationStrings.CREATOR_CREDIT_ADDITIONAL_DAILY_USAGE_LABEL,
        additionalUsage = LocalizationStrings.CREATOR_CREDIT_ADDITIONAL_USAGE_LABEL,
        description = LocalizationStrings.CREATOR_CREDIT_ADDITIONAL_USAGE_DESCRIPTION,
        setDailyLimit = LocalizationStrings.CREATOR_CREDIT_SET_DAILY_LIMIT,
        manageLimit = LocalizationStrings.CREATOR_CREDIT_MANAGE_LIMIT,
        settingsSaveError = LocalizationStrings.CREATOR_CREDIT_SETTINGS_SAVE_ERROR,
        buyRobux = LocalizationStrings.CREATOR_CREDIT_BUY_ROBUX_BUTTON
    })
    local additionalDailyUsage = var1.additionalDailyUsage
    local additionalUsage = var1.additionalUsage
    local description = var1.description
    local setDailyLimit = var1.setDailyLimit
    local manageLimit = var1.manageLimit
    local settingsSaveError = var1.settingsSaveError
    local buyRobux = var1.buyRobux
    local var2 = tbl1.additionalEnabled and tbl1.dailyLimit ~= nil
    local var3 = var2 or tbl1.additionalEnabled and tbl1.hasLimitConfigured == true
    local var4 = var3 and not var2
    if tbl1.additionalEnabled then
        additionalUsage = additionalDailyUsage
    end
    local tbl2 = {
        Header = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row align-y-center size-full-0 auto-y"
        }, {
            Label = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = additionalUsage,
                tag = {
                    ["fill auto-y text-title-medium text-align-x-left"] = true,
                    ["content-default"] = not tbl1.additionalEnabled,
                    ["content-emphasis"] = tbl1.additionalEnabled
                },
                testId = "creator-credit-page-additional-usage-label"
            }),
            ToggleSwitch = React.createElement(Toggle, {
                LayoutOrder = 2,
                size = InputSize.Medium,
                label = "",
                isChecked = tbl1.additionalEnabled,
                isDisabled = tbl1.settingsDisabled == true,
                onActivated = function(bool1: boolean)
                    if not tbl1.settingsDisabled then
                        tbl1.onToggleAdditional(bool1)
                    end
                end,
                testId = "creator-credit-page-additional-toggle"
            })
        })
    }

    if var2 then
        assert(tbl1.dailyLimit ~= nil, "dailyLimit must be provided when a numeric limit is configured")
        tbl2.UsageLine = React.createElement(RobuxLine, {
            LayoutOrder = 2,
            amount = tbl1.additionalUsed,
            kind = "used",
            usedOf = tbl1.dailyLimit,
            isEnabled = tbl1.additionalEnabled
        })
    elseif var4 then
        tbl2.UsageLine = React.createElement(
            RobuxLine,
            {
                LayoutOrder = 2,
                amount = tbl1.additionalUsed,
                kind = "usedNoLimit",
                isEnabled = tbl1.additionalEnabled
            }
        )
    else
        tbl2.AvailableLine = React.createElement(
            RobuxLine,
            {
                LayoutOrder = 2,
                amount = tbl1.robuxAvailable,
                kind = "available",
                isEnabled = tbl1.additionalEnabled
            }
        )
    end
    if not tbl1.additionalEnabled then
        tbl2.Description = React.createElement(FoundationText, {
            LayoutOrder = 3,
            Text = description,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-muted"
        })
    else
        if var3 then
            setDailyLimit = manageLimit
        end

        local testId = if var3 then "creator-credit-page-manage-limit" else "creator-credit-page-set-daily-limit"

        tbl2.ActionsRow = React.createElement(
            View,
            {
                LayoutOrder = 3,
                tag = "row align-x-left align-y-center gap-small size-full-0 auto-y"
            },
            {
                BuyRobuxButton = if tbl1.showBuyRobux then React.createElement(Button, {
                    LayoutOrder = 1,
                    text = buyRobux,
                    variant = ButtonVariant.Emphasis,
                    size = InputSize.Medium,
                    onActivated = tbl1.onOpenBuyRobux or noop,
                    isDisabled = tbl1.onOpenBuyRobux == nil,
                    testId = "creator-credit-page-buy-robux"
                }) else nil,
                LimitButton = React.createElement(Button, {
                    LayoutOrder = 2,
                    text = setDailyLimit,
                    variant = ButtonVariant.Standard,
                    size = InputSize.Medium,
                    onActivated = tbl1.onOpenLimitSheet or noop,
                    isDisabled = tbl1.settingsDisabled == true or tbl1.onOpenLimitSheet == nil,
                    testId = testId
                })
            }
        )
    end
    if tbl1.settingsError then
        tbl2.SettingsError = React.createElement(FoundationText, {
            LayoutOrder = 4,
            Text = settingsSaveError,
            tag = "size-full-0 auto-y text-caption-medium text-wrap text-align-x-left content-system-alert",
            testId = "creator-credit-page-settings-error"
        })
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = {
            ["col gap-small size-full-0 auto-y padding-large radius-large"] = true,
            ["bg-shift-100"] = tbl1.additionalEnabled,
            ["stroke-standard stroke-default"] = not tbl1.additionalEnabled
        },
        testId = "creator-credit-page-additional-usage-card"
    }, tbl2)
end

local function CreatorCreditPageView(tbl1)
    return React.createElement(
        View,
        {
            tag = "col gap-medium size-full-0 auto-y padding-y-xlarge",
            testId = tbl1.testId or "creator-credit-page"
        },
        {
            FreeUsage = React.createElement(
                FreeUsageCard,
                {
                    LayoutOrder = 1,
                    pctUsed = tbl1.dailyPctUsed,
                    resetHours = tbl1.resetHours,
                    resetPeriod = tbl1.resetPeriod
                }
            ),
            AdditionalUsage = React.createElement(AdditionalUsageCard, {
                LayoutOrder = 2,
                additionalEnabled = tbl1.additionalEnabled,
                dailyLimit = tbl1.dailyLimit,
                hasLimitConfigured = tbl1.hasLimitConfigured,
                additionalUsed = tbl1.additionalUsed,
                robuxAvailable = tbl1.robuxAvailable,
                settingsDisabled = tbl1.settingsDisabled,
                settingsError = tbl1.settingsError,
                showBuyRobux = tbl1.showBuyRobux,
                onToggleAdditional = tbl1.onToggleAdditional,
                onOpenLimitSheet = tbl1.onOpenLimitSheet,
                onOpenBuyRobux = tbl1.onOpenBuyRobux
            })
        }
    )
end
return CreatorCreditPageView
