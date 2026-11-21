-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignup = script:FindFirstAncestor("AuthSignup")
local AuthSignupParent = AuthSignup.Parent

local Cryo = require(AuthSignupParent.Cryo)
local React = require(AuthSignupParent.React)
local Foundation = require(AuthSignupParent.Foundation)
local AuthAnalytics = require(AuthSignupParent.AuthAnalytics)
local AuthCommon = require(AuthSignupParent.AuthCommon)
local Time = require(AuthSignupParent.Time)

local authFormInteraction = AuthAnalytics.Events.authFormInteraction
local EventStreamConstants = AuthAnalytics.EventStreamConstants

local useLocalization = require(AuthSignupParent.Localization).Hooks.useLocalization
local validateBirthday = require(AuthSignup.Util.validateBirthday)
local Birthday = AuthCommon.Models.Birthday
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local View = Foundation.View
local useEffect = React.useEffect
local useState = React.useState
local TimeUnit = Time.TimeUnit
local DateHelper = Time.DateHelper

local DropdownWithPopover = AuthCommon.Components.DropdownWithPopover

local function func1(arg1)
    local result = {}
    for value = 1, 12 do
        table.insert(result, { text = arg1[value], value = value })
    end

    return result
end

local tbl1 = { minAgeAllowed = 0, maxAgeAllowed = 99 }

return React.memo(function(tbl2) -- name: BirthdayDropdown
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = useTokens()
    local var3 = useLocalization({
        errorText = "Authentication.SignUp.Response.InvalidBirthday",
        monthLabel = "Authentication.SignUp.Label.Month",
        dayLabel = "Authentication.SignUp.Label.Day",
        yearLabel = "Authentication.SignUp.Label.Year"
    })

    local var4 = useLocalization(DateHelper.MonthsLocalizationKeys)
    local var5, onChange = useState(nil)
    local var7, var6 = useState(nil)
    local var9, var8 = useState(nil)
    local errorState, var12 = useState(false)

    local var13 = DateHelper:getCurrentDate()[TimeUnit.Years]
    local minAgeAllowed = var1.minAgeAllowed
    local var14 = var13 - var1.maxAgeAllowed
    local var15 = var13 - minAgeAllowed

    local var16 = DateHelper.DateTypeOrder[var1.localeId]
    local layoutOrder = var16[TimeUnit.Months]
    local var10 = var16[TimeUnit.Days]
    local var11 = var16[TimeUnit.Years]

    local cellDatas = React.useMemo(function()
        return DateHelper:generateYearCellDatas(var14, var15)
    end, { var14, var15 })
    local var17 = React.useMemo(function()
        return (func1(var4))
    end, { var4 })
    local var18 = React.useMemo(function()
        return DateHelper:generateDayCellDatas()
    end, {})

    local focusOnMount = var1.focusOnMount

    useEffect(function()
        if var7 == nil or var5 == nil or var9 == nil then
            return
        end

        local birthday = Birthday.new({ Month = var7, Day = var5, Year = var9 })

        if validateBirthday(var7, var5, var9, minAgeAllowed) then
            var1.onBirthdaySelected(birthday, birthday:GetAgeInYears(), true)
            var12(false)

            local var23 = EventStreamConstants.State.BirthdayDropdownBirthdaySelected .. "," .. birthday:ToString(",")
            authFormInteraction(var1.analyticsEventContext, EventStreamConstants.Field.BirthdayDropdown, var23)
            return
        end

        var1.onBirthdaySelected(birthday, birthday:GetAgeInYears(), false)

        var12(true)
        authFormInteraction(
            var1.analyticsEventContext,
            EventStreamConstants.Field.BirthdayDropdown,
            EventStreamConstants.State.BirthdayDropdownInvalidBirthdayError
        )
    end, { var7, var5, var9 })

    return React.createElement(View, { tag = "col size-full-0 auto-y gap-small align-x-start" }, {
        DropdownContainer = React.createElement(View, {
            tag = "row size-full-0 flex-x-fill auto-y gap-medium"
        }, {
            MonthDropdown = React.createElement(DropdownWithPopover, {
                placeholder = var3.monthLabel,
                value = var7,
                cellDatas = var17,
                layoutOrder = layoutOrder,
                onChange = var6,
                errorState = errorState,
                focusOnMount = focusOnMount and layoutOrder == 1,
                backgroundColorToken = var2.Color.Common.Shadow,
                dropdownHeight = 40,
                onDropdownOpened = var1.onDropdownOpened,
                fixSizeToParent = true
            }),
            DayDropdown = React.createElement(DropdownWithPopover, {
                placeholder = var3.dayLabel,
                value = var5,
                cellDatas = var18,
                layoutOrder = var10,
                onChange = onChange,
                errorState = errorState,
                focusOnMount = focusOnMount and var10 == 1,
                backgroundColorToken = var2.Color.Common.Shadow,
                dropdownHeight = 40,
                onDropdownOpened = var1.onDropdownOpened,
                fixSizeToParent = true
            }),
            YearDropdown = React.createElement(DropdownWithPopover, {
                placeholder = var3.yearLabel,
                value = var9,
                cellDatas = cellDatas,
                layoutOrder = var11,
                onChange = var8,
                errorState = errorState,
                focusOnMount = focusOnMount and var11 == 1,
                backgroundColorToken = var2.Color.Common.Shadow,
                dropdownHeight = 40,
                onDropdownOpened = var1.onDropdownOpened,
                fixSizeToParent = true
            })
        }),
        ErrorText = errorState
            and React.createElement(FoundationText, {
                Text = var3.errorText,
                tag = "auto-xy text-body-small",
                padding = {
                    bottom = UDim.new(0, 0)
                },
                textStyle = var2.Color.System.Alert
            })
    })
end)
