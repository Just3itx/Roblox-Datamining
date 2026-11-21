-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent
local LocalizationService = game:GetService("LocalizationService")

local Cryo = require(AuthSignupParent.Cryo)
local Roact = require(AuthSignupParent.Roact)
local React = require(AuthSignupParent.React)
local FitChildren = require(AuthSignupParent.AuthCommon).Components.FitChildren
local ArgCheck = require(AuthSignupParent.ArgCheck)
local TimeUnit = require(AuthSignupParent.Time).TimeUnit
local DateTime = require(AuthSignupParent.Time).DateTime
local ReactFocusNavigation = require(AuthSignupParent.ReactFocusNavigation)

local FocusNavigationEventNameEnum = require(AuthSignupParent.FocusNavigationUtils).FocusNavigationEventNameEnum
local InputHandlers = require(AuthSignupParent.InputHandlers)

local withStyle = require(AuthSignupParent.UIBlox).Style.withStyle
local withLocalization = require(AuthSignupParent.Localization).withLocalization

local ScrollingPicker = require(AuthSignupParent.AuthCommon).Components.ScrollingPicker
local DateHelper = require(AuthSignupParent.Time).DateHelper

local GetFFlagSignUpBirthdayRefactorNestedDefinition = require(AuthSignupParent.SharedFlags).GetFFlagSignUpBirthdayRefactorNestedDefinition

local GetFFlagSignUpBirthdayPickerRequireManualSelection = require(AuthSignupParent.SharedFlags).GetFFlagSignUpBirthdayPickerRequireManualSelection

local tbl1 = {}
for i = 1, 31 do
    table.insert(tbl1, i)
end

local tbl2 = {
    [Enum.KeyCode.ButtonA] = FocusNavigationEventNameEnum.Confirm,
    [Enum.KeyCode.Return] = FocusNavigationEventNameEnum.Confirm
}

local ReasonDateInvalid = DateHelper.ReasonDateInvalid
local MonthsLocalizationKeys = DateHelper.MonthsLocalizationKeys
local DateTypeOrder = DateHelper.DateTypeOrder

local function renderWheelContainer(arg1, shouldExpandTapTarget, focusNavigationRef)
    return Roact.createElement("Frame", {
        LayoutOrder = 2,
        Size = UDim2.new(1, 0, 0, 200),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ClipsDescendants = not shouldExpandTapTarget,
        [Roact.Ref] = focusNavigationRef
    }, arg1)
end

local function buildEntries(tbl3, bool1: boolean, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    if bool1 then
        return Cryo.List.join({ str1 }, tbl3)
    end
    return tbl3
end

local var1 = Roact.PureComponent:extend("BirthdayPicker")

var1.defaultProps = {
    minAgeAllowed = 0,
    maxAgeAllowed = 99,
    NextSelectionUp = nil,
    NextSelectionDown = nil,
    skipUpdateOnMount = false,
    shouldExpandTapTarget = false,
    tapTargetExpansionSize = 0,
    requireManualSelection = false,
    placeholderTextMonth = "----",
    placeholderTextDay = "--",
    placeholderTextYear = "----"
}

local function useFocusNavigationBindings(arg1)
    local var2 = ReactFocusNavigation.useEventMap(tbl2, arg1)
    local var3 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.Confirm] = {
                handler = InputHandlers.onRelease(function() end)
            }
        }
    end, {})
    return ReactFocusNavigation.useEventHandlerMap(var3, var2)
end

function var1.init(arg1)
    arg1.isMounted = false

    local values = DateTime.now():GetValues()

    arg1.currentDate = {
        [TimeUnit.Months] = ArgCheck.isNonNegativeNumber(values.Month, "current month in BirthdayPicker"),
        [TimeUnit.Days] = ArgCheck.isNonNegativeNumber(values.Day, "current day in BirthdayPicker"),
        [TimeUnit.Years] = ArgCheck.isNonNegativeNumber(values.Year, "current year in BirthdayPicker")
    }

    local var2 = arg1.currentDate[TimeUnit.Years]
    local minAgeAllowed = arg1.props.minAgeAllowed
    local minYear = var2 - arg1.props.maxAgeAllowed
    local maxYear = var2 - minAgeAllowed

    local fFlagSignUpBirthdayPickerRequireManualSelection = arg1.props.requireManualSelection and GetFFlagSignUpBirthdayPickerRequireManualSelection()

    arg1.dummyYears = {}
    if fFlagSignUpBirthdayPickerRequireManualSelection then
        for i = maxYear, minYear, -1 do
            table.insert(arg1.dummyYears, i)
        end
    else
        for i = minYear, maxYear do
            table.insert(arg1.dummyYears, i)
        end
    end

    arg1.minYear = minYear
    arg1.maxYear = maxYear

    arg1.placeholderOffset = if fFlagSignUpBirthdayPickerRequireManualSelection then 1 else 0

    local initialMonth = arg1.props.initialMonth
    local initialDay = arg1.props.initialDay
    local initialYear = arg1.props.initialYear

    local bool1 = not fFlagSignUpBirthdayPickerRequireManualSelection
        or not (initialMonth == nil or initialDay == nil) and initialYear ~= nil

    local num1 = if fFlagSignUpBirthdayPickerRequireManualSelection then 2 else #arg1.dummyYears + -1

    local var5 = if bool1 then 1 + arg1.placeholderOffset else 1
    local var6 = if bool1 then 1 + arg1.placeholderOffset else 1
    local var7 = if bool1 then num1 + arg1.placeholderOffset else 1
    local selectedMonthIndex = if initialMonth then initialMonth + arg1.placeholderOffset else nil
    local selectedDayIndex = if initialDay then initialDay + arg1.placeholderOffset else nil
    local var10

    if initialYear then
        local num2 = math.clamp(initialYear, minYear, maxYear)

        var10 = (if fFlagSignUpBirthdayPickerRequireManualSelection then maxYear - num2 + 1 else num2 - minYear + 1) + arg1.placeholderOffset
    else
        var10 = nil
    end

    arg1.state = {
        selectedMonthIndex = selectedMonthIndex or var5,
        selectedDayIndex = selectedDayIndex or var6,
        selectedYearIndex = var10 or var7,
        continueButtonEnabled = bool1,
        hasUserPickedMonth = bool1,
        hasUserPickedDay = bool1,
        hasUserPickedYear = bool1
    }
    arg1.datePickerRef = Roact.createRef()
    arg1.defaultRef = Roact.createRef()

    arg1.shouldExpandTapTarget = arg1.props.shouldExpandTapTarget
    arg1.tapTargetExpansionSize = arg1.props.tapTargetExpansionSize

    function arg1.renderEntryTextfunction(arg2, arg3)
        return withStyle(function(arg4)
            local font = arg4.Font.Body.Font
            local var11 = arg4.Font.BaseSize * arg4.Font.Body.RelativeSize
            local textDefaultColor = arg4.Theme.TextDefault.Color
            local textDefaultTransparency = arg4.Theme.TextDefault.Transparency

            if arg3 == "Muted" then
                textDefaultColor = arg4.Theme.TextMuted.Color
                textDefaultTransparency = arg4.Theme.TextMuted.Transparency
            elseif arg3 == "Emphasized" then
                font = arg4.Font.Header1.Font
                var11 = arg4.Font.BaseSize * arg4.Font.Header1.RelativeSize
                textDefaultColor = arg4.Theme.TextEmphasis.Color
                textDefaultTransparency = arg4.Theme.TextEmphasis.Transparency
            end

            return Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Text = tostring(arg2),
                Font = font,
                TextSize = var11,
                TextColor3 = textDefaultColor,
                TextTransparency = textDefaultTransparency
            })
        end)
    end

    function arg1.renderWheelContainerFunction(arg2)
        return Roact.createElement("Frame", {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 200),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ClipsDescendants = not arg1.shouldExpandTapTarget,
            [Roact.Ref] = arg1.props.focusNavigationRef
        }, arg2)
    end

    if GetFFlagSignUpBirthdayRefactorNestedDefinition() then
        function arg1.renderWheelContainerFunction(arg2)
            return renderWheelContainer(arg2, arg1.shouldExpandTapTarget, arg1.props.focusNavigationRef)
        end
    end

    local function makeChangeHandler(str1: string, str2: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        return function(placeholderOffset, arg2)
            local bool2 = arg1.state[str1] ~= placeholderOffset
            local var11 = arg2 and not arg1.state[str2] and arg1.placeholderOffset < placeholderOffset

            if not (bool2 or var11) then
                return
            end

            spawn(function()
                if not arg1.isMounted then
                    return
                end
                local tbl3 = ({})
                if arg1.state[str1] ~= placeholderOffset then
                    tbl3[str1] = placeholderOffset
                end
                if arg2 and not arg1.state[str2] and placeholderOffset > arg1.placeholderOffset then
                    tbl3[str2] = true
                end
                if next(tbl3) ~= nil then
                    arg1:setState(tbl3)
                end
            end)
        end
    end

    arg1.onSelectedIndexChangedForMonth = makeChangeHandler("selectedMonthIndex", "hasUserPickedMonth")
    arg1.onSelectedIndexChangedForDay = makeChangeHandler("selectedDayIndex", "hasUserPickedDay")
    arg1.onSelectedIndexChangedForYear = makeChangeHandler("selectedYearIndex", "hasUserPickedYear")

    function arg1.onActivated(_)
        if arg1.props.focusedGuiObject and arg1.datePickerRef and arg1.defaultRef.current then
            arg1.props.focusGuiObject(arg1.defaultRef.current, true)
        end
    end

    function arg1.onEntryActivated()
        if arg1.props.focusedGuiObject and arg1.datePickerRef and arg1.datePickerRef.current then
            arg1.props.focusGuiObject(arg1.datePickerRef.current, true)
        end
    end
end

function var1.getActualIndex(tbl3, str1: string, str2: string, num1: number)
    if not tbl3.state[str1] then
        return nil
    end
    local var2 = tbl3.state[str2] - tbl3.placeholderOffset
    return if var2 < 1 or num1 < var2 then nil else var2
end

function var1.getActualMonth(arg1)
    return arg1:getActualIndex("hasUserPickedMonth", "selectedMonthIndex", #MonthsLocalizationKeys)
end

function var1.getActualDay(arg1)
    return arg1:getActualIndex("hasUserPickedDay", "selectedDayIndex", #tbl1)
end

function var1.getActualYear(arg1)
    local actualIndex = arg1:getActualIndex("hasUserPickedYear", "selectedYearIndex", #arg1.dummyYears)
    return if actualIndex then arg1.dummyYears[actualIndex] else nil
end

function var1.didMount(arg1)
    local updateBirthday = arg1.props.updateBirthday

    if updateBirthday and not arg1.props.skipUpdateOnMount then
        updateBirthday(arg1:getActualMonth(), arg1:getActualDay(), arg1:getActualYear())
    end

    if arg1.props.focusedGuiObject and arg1.datePickerRef and arg1.datePickerRef.current then
        arg1.props.focusGuiObject(arg1.datePickerRef.current, true)
    end

    arg1.isMounted = true
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

function var1.updatePickerState(arg1)
    local actualMonth = arg1:getActualMonth()
    local actualDay = arg1:getActualDay()
    local actualYear = arg1:getActualYear()
    local bool1 = not (actualMonth == nil or actualDay == nil) and actualYear ~= nil
    local bool2 = false
    local var2 = nil
    local bool3 = false

    if bool1 then
        local var3, var4 = DateHelper:isValidDate(actualMonth, actualDay, actualYear)
        bool3 = var3
        if not bool3 and var4 == ReasonDateInvalid.IsInvalidDayOfMonth then
            bool2 = true
            var2 = DateHelper:getLastDayOfTheMonthInYear(actualMonth, actualYear) + arg1.placeholderOffset
        end
    end

    spawn(function()
        if arg1.isMounted then
            arg1:setState({ selectedDayIndex = bool2 and var2 or nil, continueButtonEnabled = bool1 and bool3 })
        end
    end)
end

function var1.didUpdate(arg1)
    local updateBirthday = arg1.props.updateBirthday
    local actualMonth = arg1:getActualMonth()
    local actualDay = arg1:getActualDay()
    local actualYear = arg1:getActualYear()
    local continueButtonEnabled = arg1.state.continueButtonEnabled
    local bool1 = not (actualMonth == nil or actualDay == nil) and actualYear ~= nil
    local var2, var3

    if bool1 then
        var2, var3 = DateHelper:isValidDate(actualMonth, actualDay, actualYear)
    else
        var2 = false
        var3 = nil
    end

    local bool2 = not var2 and var3 == ReasonDateInvalid.IsInvalidDayOfMonth
    if var2 ~= continueButtonEnabled or bool2 then
        arg1:updatePickerState()
    end

    if updateBirthday then
        updateBirthday(actualMonth, actualDay, actualYear)
    end
end

function var1.render(arg1)
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local var2 = DateTypeOrder[robloxLocaleId]

    local bool1 = not arg1.shouldExpandTapTarget or arg1.tapTargetExpansionSize <= 0

    local layoutOrder = arg1.props.layoutOrder

    local fFlagSignUpBirthdayPickerRequireManualSelection = arg1.props.requireManualSelection and GetFFlagSignUpBirthdayPickerRequireManualSelection()
    local placeholderTextMonth = arg1.props.placeholderTextMonth
    local placeholderTextDay = arg1.props.placeholderTextDay
    local placeholderTextYear = arg1.props.placeholderTextYear

    local var3 = MonthsLocalizationKeys

    if fFlagSignUpBirthdayPickerRequireManualSelection then
        var3 = buildEntries(var3, true, placeholderTextMonth)
    end

    local tbl3 = tbl1

    if fFlagSignUpBirthdayPickerRequireManualSelection then
        tbl3 = buildEntries(tbl3, true, placeholderTextDay)
    end

    local dummyYears = arg1.dummyYears

    if fFlagSignUpBirthdayPickerRequireManualSelection then
        dummyYears = buildEntries(dummyYears, true, placeholderTextYear)
    end

    local selectedMonthIndex = arg1.state.selectedMonthIndex
    local selectedDayIndex = arg1.state.selectedDayIndex
    local selectedYearIndex = arg1.state.selectedYearIndex

    local minTargetIndex = fFlagSignUpBirthdayPickerRequireManualSelection and arg1.state.hasUserPickedMonth and 2 or 1
    local var4 = fFlagSignUpBirthdayPickerRequireManualSelection and arg1.state.hasUserPickedDay and 2 or 1
    local var5 = fFlagSignUpBirthdayPickerRequireManualSelection and arg1.state.hasUserPickedYear and 2 or 1

    local actualMonth = arg1:getActualMonth()
    local actualYear = arg1:getActualYear()
    local hasUserPickedMonth = arg1.state.hasUserPickedMonth
    local hasUserPickedDay = arg1.state.hasUserPickedDay
    local hasUserPickedYear = arg1.state.hasUserPickedYear

    return withStyle(function(_)
        return withLocalization({ continueText = "Authentication.SignUp.Label.Continue" })(function(_)
            local createElement = Roact.createElement
            local fitFrame = FitChildren.FitFrame
            local tbl4 = {
                LayoutOrder = layoutOrder,
                Size = UDim2.new(1, 0, 0, 0),
                fitAxis = FitChildren.FitAxis.Height,
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            }

            local tbl5 = {
                ListLayout = Roact.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 14)
                    }
                ),
                DatePickerWrap = 0
            }
            local createElement2 = Roact.createElement
            local fitFrame2 = FitChildren.FitFrame
            local tbl6 = {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, 0),
                fitAxis = FitChildren.FitAxis.Height,
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            }

            local tbl7 = {
                CenterFrame = Roact.createElement("ImageLabel", {
                    Size = UDim2.new(1, 0, 0, 50),
                    Image = "rbxasset://textures/ui/LuaApp/graphic/Auth/DatePickerDivider.png",
                    BackgroundTransparency = 1,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(2, 2, 4, 4),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    ZIndex = 2
                }),
                DatePicker = 0
            }

            local createElement3 = Roact.createElement
            local fitTextButton = FitChildren.FitTextButton
            local tbl8 = {
                Size = UDim2.new(1, 0, 0, 0),
                fitAxis = FitChildren.FitAxis.Height,
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Selectable = true,
                NextSelectionUp = arg1.props.NextSelectionUp,
                NextSelectionDown = arg1.props.NextSelectionDown,
                NextSelectionLeft = arg1.datePickerRef.current,
                NextSelectionRight = arg1.datePickerRef.current,
                Text = "",
                [Roact.Ref] = arg1.datePickerRef,
                [Roact.Event.Activated] = arg1.onActivated
            }
            local tbl9 = {
                ListLayout = Roact.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }
                ),
                WheelContainer = 0
            }
            local renderWheelContainerFunction = arg1.renderWheelContainerFunction

            local tbl10 = {
                ListLayout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = if bool1 then Enum.VerticalAlignment.Center else nil
                }),
                Padding = Roact.createElement("UIPadding", {
                    PaddingLeft = UDim.new(0, 5),
                    PaddingRight = UDim.new(0, 5),
                    PaddingTop = UDim.new(0, 5),
                    PaddingBottom = UDim.new(0, 5)
                }),
                MonthWheel = Roact.createElement(ScrollingPicker, {
                    layoutOrder = var2[TimeUnit.Months],
                    size = UDim2.new(0.45, 0, 0, 200),
                    renderEntry = function(monthText)
                        if monthText == placeholderTextMonth then
                            if hasUserPickedMonth then
                                return arg1.renderEntryTextfunction("", "Default")
                            end
                            return arg1.renderEntryTextfunction(placeholderTextMonth, "Muted")
                        end
                        return withStyle(function(_)
                            return withLocalization({ monthText = monthText })(function(arg2)
                                local var7 = var3[selectedMonthIndex]
                                local str1 = if monthText == var7 and hasUserPickedMonth then "Emphasized" else "Default"

                                return arg1.renderEntryTextfunction(arg2.monthText, str1)
                            end)
                        end)
                    end,
                    getEntryWrapperProps = function(arg2)
                        local var7 = var3[selectedMonthIndex]
                        return {
                            [Roact.Ref] = if arg2 == var7 then arg1.defaultRef else nil
                        }
                    end,
                    entries = var3,
                    entrySizeOnScrollingAxis = 50,
                    onSelectedIndexChanged = arg1.onSelectedIndexChangedForMonth,
                    parentSpecifiedTarget = selectedMonthIndex,
                    minTargetIndex = minTargetIndex,
                    onEntryActivated = arg1.onEntryActivated,
                    shouldExpandTapTarget = arg1.shouldExpandTapTarget,
                    tapTargetExpansionSize = arg1.tapTargetExpansionSize
                }),
                DayWheel = Roact.createElement(ScrollingPicker, {
                    layoutOrder = var2[TimeUnit.Days],
                    size = UDim2.new(0.2, 0, 0, 200),
                    renderEntry = function(arg2)
                        if type(arg2) ~= "number" then
                            if hasUserPickedDay then
                                return arg1.renderEntryTextfunction("", "Default")
                            end
                            return arg1.renderEntryTextfunction(placeholderTextDay, "Muted")
                        end
                        return withLocalization({ dayAffix = DateHelper.DayAffixLocalizationKey })(function(arg3)
                            local var7 = tbl3[selectedDayIndex]
                            local bool2 = arg2 == var7
                            local formattedDayString = DateHelper:GetFormattedDayString(arg2, arg3.dayAffix, robloxLocaleId)

                            local str1 = "Default"

                            if actualMonth and actualYear and DateHelper:isInvalidDayOfTheMonth(actualMonth, arg2, actualYear) then
                                str1 = "Muted"
                            elseif bool2 and hasUserPickedDay then
                                str1 = "Emphasized"
                            end

                            return arg1.renderEntryTextfunction(formattedDayString, str1)
                        end)
                    end,
                    entries = tbl3,
                    entrySizeOnScrollingAxis = 50,
                    onSelectedIndexChanged = arg1.onSelectedIndexChangedForDay,
                    parentSpecifiedTarget = selectedDayIndex,
                    minTargetIndex = var4,
                    onEntryActivated = arg1.onEntryActivated,
                    shouldExpandTapTarget = arg1.shouldExpandTapTarget,
                    tapTargetExpansionSize = arg1.tapTargetExpansionSize
                }),
                YearWheel = Roact.createElement(ScrollingPicker, {
                    layoutOrder = var2[TimeUnit.Years],
                    size = UDim2.new(0.35, 0, 0, 200),
                    renderEntry = function(arg2)
                        if type(arg2) ~= "number" then
                            if hasUserPickedYear then
                                return arg1.renderEntryTextfunction("", "Default")
                            end
                            return arg1.renderEntryTextfunction(placeholderTextYear, "Muted")
                        end
                        return withLocalization({ yearAffix = DateHelper.YearAffixLocalizationKey })(function(arg3)
                            local dummyYear = dummyYears[selectedYearIndex]
                            local bool2 = arg2 == dummyYear
                            local formattedYearString = DateHelper:GetFormattedYearString(arg2, arg3.yearAffix, robloxLocaleId)

                            return arg1.renderEntryTextfunction(formattedYearString, if bool2 and hasUserPickedYear then "Emphasized" else "Default")
                        end)
                    end,
                    entries = dummyYears,
                    entrySizeOnScrollingAxis = 50,
                    onSelectedIndexChanged = arg1.onSelectedIndexChangedForYear,
                    parentSpecifiedTarget = selectedYearIndex,
                    minTargetIndex = var5,
                    onEntryActivated = arg1.onEntryActivated,
                    shouldExpandTapTarget = arg1.shouldExpandTapTarget,
                    tapTargetExpansionSize = arg1.tapTargetExpansionSize
                })
            }

            tbl9.WheelContainer = renderWheelContainerFunction(tbl10)
            tbl7.DatePicker = createElement3(fitTextButton, tbl8, tbl9)
            tbl5.DatePickerWrap = createElement2(fitFrame2, tbl6, tbl7)
            return createElement(fitFrame, tbl4, tbl5)
        end)
    end)
end

return function(arg1)
    local focusedGuiObject = ReactFocusNavigation.useFocusedGuiObject()
    local focusGuiObject = ReactFocusNavigation.useFocusGuiObject()
    local focusNavigationRef = useFocusNavigationBindings(nil)
    return Roact.createElement(
        var1,
        Cryo.Dictionary.join(
            arg1,
            {
                focusedGuiObject = focusedGuiObject,
                focusGuiObject = focusGuiObject,
                focusNavigationRef = focusNavigationRef
            }
        )
    )
end
