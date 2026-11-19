-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:41:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local DateTimeCalendarViewUtilities = require(script.Parent.Utilities.DateTimeCalendarViewUtilities)
local DateTimeEqualityUtilities = require(script.Parent.Utilities.DateTimeEqualityUtilities)
local DateTimeParsingUtilities = require(script.Parent.Utilities.DateTimeParsingUtilities)
local _DateTimePickerProps = require(script.Parent.DateTimePickerProps)
local DateTimeRangeSelectionUtilities = require(script.Parent.Utilities.DateTimeRangeSelectionUtilities)
local DateTimeUtilities = require(script.Parent.DateTimeUtilities)

local DateTimePickerVariant = require(Foundation.Enums.DateTimePickerVariant)

local _Types = require(Foundation.Components.Types)
local GuiService = require(Foundation.Utility.Wrappers.Services).GuiService

local function useDateTimePickerState(arg1)
    local variant = arg1.variant or DateTimePickerVariant.Single
    local acceptsDateRange = variant == DateTimePickerVariant.Dual or variant == DateTimePickerVariant.DualWithPresets
    local bool2 = variant == DateTimePickerVariant.DualWithPresets
    local bool3 = variant == DateTimePickerVariant.SingleWithTime

    local isOpen, var3 = React.useState(false)
    local textInputRef = React.useRef(nil)

    local dates = React.useMemo(function()
        local defaultDates = arg1.defaultDates
        if defaultDates == nil then
            return nil
        end
        return DateTimeRangeSelectionUtilities.normalizeDates({ acceptsDateRange = acceptsDateRange, dates = defaultDates })
    end, { arg1.defaultDates, acceptsDateRange })

    local var6, var7 = React.useState(if dates then DateTimeParsingUtilities.formatInputText({ dates = dates, variant = variant }) else "")

    local var8 = React.useRef(var6)
    var8.current = var6

    local var9, var10 = React.useState(function()
        return dates
    end)

    local var11 = React.useRef(var9)
    var11.current = var9

    local viewAnchorDate, var13 = React.useState(nil)

    local var14, var15 = React.useState(function()
        return dates
    end)

    local closeDateTimePicker = React.useCallback(function()
        var3(false)
    end, {})

    local showDateTimePicker = React.useCallback(function()
        var3(true)
    end, {})

    local onFocusGained = React.useCallback(function()
        if GuiService.ViewportDisplaySize ~= Enum.DisplaySize.Small then
            showDateTimePicker()
        end
    end, { showDateTimePicker, GuiService.ViewportDisplaySize })

    local var19 = React.useCallback(function(current, tbl1)
        var10(current)
        var11.current = current
        if tbl1 and tbl1.asApplied then
            var15(current)
        end

        if tbl1 and tbl1.anchor then
            var13(tbl1.anchor)
        end
    end, {})

    local function resolvedViewAnchor(tbl1): DateTime -- Luacid: Inlined by compiler; 2 call sites recovered
        local var20 = DateTimeCalendarViewUtilities.resolveAnchorDate(tbl1, arg1.referenceDate)
        return DateTime.fromUnixTimestamp(var20.UnixTimestamp)
    end

    local var20 = React.useRef(nil)

    local updateInputText = React.useCallback(function(str1: string)
        var7(str1)

        if var20.current ~= nil then
            local current = var20.current
            var20.current = nil
            if str1 == current then
                return
            end
        end

        local function clearDraftToReference()
            var19({}, { anchor = resolvedViewAnchor(nil), asApplied = true })
        end

        if str1:match("^%s*$") then
            clearDraftToReference()
            arg1.onChanged(nil)
            return
        end

        if acceptsDateRange then
            local var21, var22 = DateTimeParsingUtilities.parseDualInputEndpoints(str1)
            arg1.onChanged(var21, var22)

            local var23 = DateTimeParsingUtilities.parseInputToDraftDates(str1, arg1.selectableDateRange)
            if var23 then
                var19(var23, { anchor = var23[1], asApplied = true })
                return
            end

            clearDraftToReference()
        else
            local anchor = DateTimeParsingUtilities.parseDateTimeFromText(DateTimeParsingUtilities.trimInputText(str1))
            if anchor and (arg1.selectableDateRange == nil or DateTimeUtilities.isDateWithinRange(anchor, arg1.selectableDateRange)) then
                var19({ anchor }, { anchor = anchor, asApplied = true })

                arg1.onChanged(anchor)
                return
            end
            clearDraftToReference()
            arg1.onChanged(anchor)
        end
    end, {
        arg1.onChanged,
        acceptsDateRange,
        bool3,
        arg1.referenceDate,
        arg1.selectableDateRange,
        var19
    })

    local onFocusLost = React.useCallback(function(_)
        if not acceptsDateRange then
            return
        end

        local current = var8.current
        local var1 = DateTimeParsingUtilities.parseInputToDraftDates(current, arg1.selectableDateRange)
        if not var1 then
            return
        end

        local var2 = DateTimeParsingUtilities.formatInputText({ dates = var1, variant = variant })

        if var2 == current then
            return
        end

        local current2 = var11.current
        if not (current2
            and current2[1]
            and current2[2]
            and DateTimeEqualityUtilities.isSameDay(current2[1], var1[1])
            and DateTimeEqualityUtilities.isSameDay(current2[2], var1[2])) then
            return
        end

        var20.current = var2
        var7(var2)
        arg1.onChanged(var1[1], var1[2])
    end, {
        acceptsDateRange,
        arg1.onChanged,
        arg1.selectableDateRange,
        variant
    })

    local onDayActivated = React.useCallback(function(arg2)
        local var23 = DateTimeRangeSelectionUtilities.selectRangeEndpoint(var11.current, arg2)
        var19(var23)
    end, { var19 })

    local onPresetSelected = React.useCallback(function(arg2)
        if arg1.selectableDateRange and not DateTimeEqualityUtilities.isRangeWithinSelectableRange(arg2, arg1.selectableDateRange) then
            return
        end

        var19({ arg2.startDate, arg2.endDate }, { anchor = arg2.startDate })
    end, { arg1.selectableDateRange, var19 })

    local onSelectedDatesChanged = React.useCallback(function(tbl1)
        local current = var11.current
        local var25 = if current then current[1] else nil
        local var26 = if current then current[2] else nil
        local var27 = tbl1[1]
        local var28 = tbl1[2]

        if current
            and var27
            and var25
            and var25.UnixTimestamp == var27.UnixTimestamp
            and not var26 == not var28
            and (not var26 or not var28 or var26.UnixTimestamp == var28.UnixTimestamp)
        then
            return
        end

        var19(tbl1)
    end, { var19 })

    local var26 = React.useCallback(function()
        var19(var14, { anchor = resolvedViewAnchor(var14) })
    end, { var14, arg1.referenceDate, var19 })

    local onCancel = React.useCallback(function()
        var26()
        closeDateTimePicker()
    end, { var26, closeDateTimePicker })

    local onReset = React.useCallback(function()
        var26()
    end, { var26 })

    local var29 = React.useCallback(function(tbl1)
        local anchor = tbl1[1]
        if not anchor then
            return
        end

        var19(tbl1, { anchor = anchor })

        if acceptsDateRange then
            local var30 = tbl1[2]
            local current = DateTimeUtilities.formatLocalTime(anchor) .. " - " .. (if var30 then DateTimeUtilities.formatLocalTime(var30) else "")
            var20.current = current
            var7(current)
            arg1.onChanged(anchor, var30)
            return
        end
        local current = DateTimeUtilities.formatLocalTime(anchor, bool3)
        var20.current = current
        var7(current)
        arg1.onChanged(anchor)
    end, {
        arg1.onChanged,
        acceptsDateRange,
        bool3,
        var19
    })
    local onApply = React.useCallback(function()
        local current = var11.current
        if current then
            if bool2 and not (current[1] and current[2]) then
                closeDateTimePicker()
                return
            end
            var15(current)
            var29(current)
        end
        closeDateTimePicker()
    end, { closeDateTimePicker, var29, bool2 })

    local bool4 = false
    if var9 then
        local var31 = var9[1]
        local var32 = var9[2]
        if bool2 or acceptsDateRange then
            bool4 = var31 == nil or var32 == nil or var31.UnixTimestamp > var32.UnixTimestamp
        elseif variant == DateTimePickerVariant.Single or bool3 then
            bool4 = var31 == nil
        end
    elseif bool2 then
        bool4 = true
    end

    return {
        closeDateTimePicker = closeDateTimePicker,
        isOpen = isOpen,
        onFocusGained = onFocusGained,
        onFocusLost = onFocusLost,
        showDateTimePicker = showDateTimePicker,
        textInputRef = textInputRef,
        selectedDates = var9,
        inputText = var6,
        updateInputText = updateInputText,
        viewAnchorDate = viewAnchorDate,
        onDayActivated = onDayActivated,
        onPresetSelected = onPresetSelected,
        onSelectedDatesChanged = onSelectedDatesChanged,
        onApply = onApply,
        onCancel = onCancel,
        onReset = onReset,
        isApplyButtonDisabled = bool4,
        isResetButtonDisabled = not (bool2 or bool3) or DateTimeEqualityUtilities.areDatesEqual(var9, var14)
    }
end

return useDateTimePickerState
