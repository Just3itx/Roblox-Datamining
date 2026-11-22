-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeParent = script:FindFirstAncestor("Time").Parent

local ArgCheck = require(TimeParent.ArgCheck)
local TimeUnit = require(script.Parent.TimeUnit)
local DateTime = require(script.Parent.DateTime)

local GetFFlagSignUpBirthdayPickerRequireManualSelection = require(TimeParent.SharedFlags).GetFFlagSignUpBirthdayPickerRequireManualSelection

local module = {
    ReasonDateInvalid = {
        IsFutureDate = "IsFutureDate",
        IsInvalidDayOfMonth = "IsInvalidDayOfMonth",
        IsIncompleteDate = "IsIncompleteDate"
    },
    MonthsLocalizationKeys = {
        "CommonUI.Controls.Label.January",
        "CommonUI.Controls.Label.February",
        "CommonUI.Controls.Label.March",
        "CommonUI.Controls.Label.April",
        "CommonUI.Controls.Label.May",
        "CommonUI.Controls.Label.June",
        "CommonUI.Controls.Label.July",
        "CommonUI.Controls.Label.August",
        "CommonUI.Controls.Label.September",
        "CommonUI.Controls.Label.October",
        "CommonUI.Controls.Label.November",
        "CommonUI.Controls.Label.December"
    },
    DateTypeOrder = setmetatable({
        ["en-us"] = {
            [TimeUnit.Months] = 1,
            [TimeUnit.Days] = 2,
            [TimeUnit.Years] = 3
        },
        ["es-es"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        },
        ["fr-fr"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        },
        ["de-de"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        },
        ["pt-br"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        },
        ["zh-cn"] = {
            [TimeUnit.Years] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Days] = 3
        },
        ["zh-cjv"] = {
            [TimeUnit.Years] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Days] = 3
        },
        ["zh-tw"] = {
            [TimeUnit.Years] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Days] = 3
        },
        ["ko-kr"] = {
            [TimeUnit.Years] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Days] = 3
        },
        ["ja-jp"] = {
            [TimeUnit.Years] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Days] = 3
        },
        ["it-it"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        },
        ["ru-ru"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        },
        ["id-id"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        },
        ["vi-vn"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        },
        ["th-th"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        },
        ["tr-tr"] = {
            [TimeUnit.Days] = 1,
            [TimeUnit.Months] = 2,
            [TimeUnit.Years] = 3
        }
    }, {
        __index = function(_, _)
            return {
                [TimeUnit.Years] = 1,
                [TimeUnit.Months] = 2,
                [TimeUnit.Days] = 3
            }
        end
    }),
    DayAffixLocalizationKey = "CommonUI.Controls.Label.Day",
    DayAffixType = setmetatable(
        { ["zh-cn"] = "Suffix", ["zh-tw"] = "Suffix", ["ko-kr"] = "Suffix", ["ja-jp"] = "Suffix" },
        {
            __index = function(_, _): string
                return "None"
            end
        }
    ),
    YearAffixLocalizationKey = "CommonUI.Controls.Label.Year",
    YearAffixType = setmetatable(
        { ["zh-cn"] = "Suffix", ["zh-tw"] = "Suffix", ["ko-kr"] = "Suffix", ["ja-jp"] = "Suffix" },
        {
            __index = function(_, _): string
                return "None"
            end
        }
    )
}

function module.GetFormattedDayString(tbl1, num1: number, str1: string, str2: string)
    return tbl1:GetFormattedString(TimeUnit.Days, num1, str1, str2)
end

function module.GetFormattedYearString(tbl1, num1: number, str1: string, str2: string)
    return tbl1:GetFormattedString(TimeUnit.Years, num1, str1, str2)
end

function module.GetFormattedString(tbl1, str1: string, arg1, arg2, arg3)
    ArgCheck.isNotNil(str1, "timeUnit passed into DateHelper:GetFormattedString")
    ArgCheck.isNotNil(arg2, "affix passed into DateHelper:GetFormattedString")
    arg1 = ArgCheck.isType(tostring(arg1), "string", "dateValue passed into DateHelper:GetFormattedString")

    local var1 = nil
    if str1 == TimeUnit.Days then
        var1 = tbl1.DayAffixType[arg3]
    elseif str1 == TimeUnit.Years then
        var1 = tbl1.YearAffixType[arg3]
    end

    return if var1 == "Prefix" then arg2 .. arg1 elseif var1 == "Suffix" then arg1 .. arg2 else arg1
end

function module.GetFormattedFullString(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    arg2 = ArgCheck.isType(arg2, "string", "localizedMonthString passed into DateHelper:GetFormattedFullString")

    arg7 = ArgCheck.isType(arg7, "string", "divider passed into DateHelper:GetFormattedFullString")
    arg8 = ArgCheck.isType(arg8, "string", "localeKey passed into DateHelper:GetFormattedFullString")

    local var1 = arg1.DateTypeOrder[arg8]

    local formattedDayString = arg1:GetFormattedDayString(arg3, arg4, arg8)
    local formattedYearString = arg1:GetFormattedYearString(arg5, arg6, arg8)

    local str1 = ""

    local tbl1 = {}
    tbl1[var1[TimeUnit.Months]] = arg2
    tbl1[var1[TimeUnit.Days]] = formattedDayString
    tbl1[var1[TimeUnit.Years]] = formattedYearString

    for i, value in ipairs(tbl1) do
        str1 ..= value
        if i < #tbl1 then
            str1 ..= arg7
        end
    end

    return str1
end

local function getCurrentDate()
    local values = DateTime.now():GetValues()

    return {
        [TimeUnit.Months] = ArgCheck.isNonNegativeNumber(values.Month, "current month in BirthdayPicker"),
        [TimeUnit.Days] = ArgCheck.isNonNegativeNumber(values.Day, "current day in BirthdayPicker"),
        [TimeUnit.Years] = ArgCheck.isNonNegativeNumber(values.Year, "current year in BirthdayPicker")
    }
end

function module.getCurrentDate(_)
    return (getCurrentDate())
end

local function getCurrentDateWithOffset(num1: number)
    local values = DateTime.fromUnixTimestamp(DateTime.now():GetUnixTimestamp() + num1):GetValues()

    return {
        [TimeUnit.Months] = ArgCheck.isNonNegativeNumber(values.Month, "current month in BirthdayPicker"),
        [TimeUnit.Days] = ArgCheck.isNonNegativeNumber(values.Day, "current day in BirthdayPicker"),
        [TimeUnit.Years] = ArgCheck.isNonNegativeNumber(values.Year, "current year in BirthdayPicker")
    }
end

function module.isLeapYear(_, num1: number): boolean
    return num1 % 4 == 0 and (num1 % 100 ~= 0 or num1 % 400 == 0)
end

local tbl1 = ({})

function module._isFutureDate(_, arg1, num1: number, num2: number, num3: number): boolean
    if arg1[TimeUnit.Years] < num3 then
        return true
    end

    if num3 == arg1[TimeUnit.Years] and arg1[TimeUnit.Months] < num1 then
        return true
    end

    return num3 == arg1[TimeUnit.Years] and num1 == arg1[TimeUnit.Months] and arg1[TimeUnit.Days] < num2
end

function module.isFutureDate(tbl2, num1: number, num2: number, num3: number)
    return tbl2:_isFutureDate(getCurrentDate(), num1, num2, num3)
end

function module.isRecentOrFutureDate(tbl2, num1: number, num2: number, num3: number)
    return tbl2:_isFutureDate(getCurrentDateWithOffset(-172800), num1, num2, num3)
end

function module.getLastDayOfTheMonthInYear(tbl2, num1: number, num2: number)
    if tbl1[num1] and tbl1[num1][num2] then
        return tbl1[num1][num2]
    end

    local num3 = if num1 == 2 then if tbl2:isLeapYear(num2) then 29 else 28 elseif num1 % 2 == 0 and num1 < 7 or num1 % 2 == 1 and num1 > 7 then 30 else 31

    if not tbl1[num1] then
        tbl1[num1] = {}
    end
    tbl1[num1][num2] = num3

    return num3
end

function module.isInvalidDayOfTheMonth(tbl2, num1: number, num2: number, num3: number): boolean
    return tbl2:getLastDayOfTheMonthInYear(num1, num3) < num2
end

function module.isValidDate(arg1, arg2, arg3, arg4)
    if GetFFlagSignUpBirthdayPickerRequireManualSelection() and (arg2 == nil or arg3 == nil or arg4 == nil) then
        return false, arg1.ReasonDateInvalid.IsIncompleteDate
    elseif arg1:isRecentOrFutureDate(arg2, arg3, arg4) then
        return false, arg1.ReasonDateInvalid.IsFutureDate
    elseif arg1:isInvalidDayOfTheMonth(arg2, arg3, arg4) then
        return false, arg1.ReasonDateInvalid.IsInvalidDayOfMonth
    end

    return true, nil
end

local function generateCellDatas(num1: number, num2: number, num3: number?)
    local result = {}
    for value = num1, num2, num3 or 1 do
        table.insert(result, { text = tostring(value), value = value })
    end

    return result
end

function module.generateMonthCellDatas(_)
    return (generateCellDatas(1, 12))
end

function module.generateDayCellDatas(_)
    return (generateCellDatas(1, 31))
end

function module.generateYearCellDatas(_, num1: number, num2: number)
    local currentDate = getCurrentDate()
    local num3 = num2 or currentDate[TimeUnit.Years]
    local num4 = num1 or num2 - 100

    return (generateCellDatas(num3, num4, -1))
end

return module
