-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:41:03Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local LocalizationService = require(Foundation.Utility.Wrappers).Services.LocalizationService
local Translator = require(Foundation.Utility.Localization.Translator)

local function getDaysInMonth(num1: number, num2: number): number
    return if num1 == 2 and (num2 % 4 == 0 and num2 % 100 ~= 0 or num2 % 400 == 0) then 29 else ({
        31,
        28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31
    })[num1]
end

local function toLocalTime(dateTime) -- Luacid: Inlined by compiler; 5 call sites recovered
    return (dateTime:ToLocalTime())
end

local function roundToStartOfDay(dateTime): number -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = toLocalTime(dateTime)

    return DateTime.fromLocalTime(var1.Year, var1.Month, var1.Day).UnixTimestamp
end

local function getHoursAndMinutesFromString(str1: string)
    local var1 = str1:gsub("%s+", "")

    local var2 = string.match(var1, "^%d%d:%d%d$")
    local var3 = string.match(var1, "^%d%d?:%d%d[AP]M$")

    if not (var2 or var3) then
        return nil
    elseif var3 then
        local var4, var5 = string.match(var1, "^(%d%d?):(%d%d)[AP]M$")
        local var6 = tonumber(var4)
        local var7 = tonumber(var5)

        if not var6 or not var7 or var6 < 1 or var6 > 12 or var7 < 0 or var7 > 59 then
            return nil
        elseif string.sub(var1, -2) == "PM" and var6 ~= 12 then
            return var6 + 12, var7
        elseif string.sub(var1, -2) == "AM" and var6 == 12 then
            return 0, var7
        end
        return var6, var7
    else
        local var4, var5 = string.match(var1, "^(%d%d?):(%d%d)$")
        local var6 = tonumber(var4)
        local var7 = tonumber(var5)

        if not var6 or not var7 or var6 < 0 or var6 > 23 or var7 < 0 or var7 > 59 then
            return nil
        end

        return var6, var7
    end
end

return {
    formatLocalTime = function(dateTime, bool1: boolean?)
        local var1 = dateTime:FormatLocalTime("L", LocalizationService.RobloxLocaleId)
        if bool1 then
            var1 ..= ", " .. dateTime:FormatLocalTime("LT", LocalizationService.RobloxLocaleId)
        end

        return var1
    end,
    getDateTimeFromText = function(str1: string)
        local var1

        if string.find(str1, ",") then
            str1, var1 = str1:match("^([^,]+),%s*(.+)$")
        else
            var1 = "00:00"
        end

        if not (str1 and var1) then
            return nil
        end

        local var2 = str1:gsub("%s+", "")

        local hour, minute = getHoursAndMinutesFromString(var1)

        if str1 then
            local var3 = var2:find("[/%.%-]")

            local success, result = pcall(function(): DateTime
                if var3 == 3 then
                    local var4, var5, var6 = var2:match("^(%d%d)[/%.%-](%d%d)[/%.%-](%d%d%d%d)$")
                    return DateTime.fromLocalTime(tonumber(var6), tonumber(var4), tonumber(var5), hour, minute, 0)
                elseif var3 == 5 then
                    local var4, var5, var6 = var2:match("^(%d%d%d%d)[/%.%-](%d%d)[/%.%-](%d%d)$")
                    return DateTime.fromLocalTime(tonumber(var4), tonumber(var5), tonumber(var6), hour, minute, 0)
                end

                error("Invalid date format: " .. var2)
            end)

            if success and result then
                if os.date("*t", result.UnixTimestamp).isdst then
                    local unixTimestamp = result.UnixTimestamp
                    result = DateTime.fromUnixTimestamp(unixTimestamp - 3600)
                end
                return result
            end
        end

        return nil
    end,
    getDaysInMonth = getDaysInMonth,
    getFirstDayOfWeek = function(month: number, year: number): number
        local dateTime = DateTime.fromLocalTime(year, month, 1)

        if not dateTime then
            return 0
        end

        return tonumber((dateTime:FormatLocalTime("d", "en-us"))) or 0
    end,
    getLastDayOfWeek = function(month: number, year: number): number
        local dateTime = DateTime.fromLocalTime(year, month, (getDaysInMonth(month, year)))

        if not dateTime then
            return 0
        end

        return tonumber((dateTime:FormatLocalTime("d", "en-us"))) or 0
    end,
    getNextMonthInfo = function(num1: number, num2: number): (number, number)
        if num1 == 12 then
            return 1, num2 + 1
        end
        return num1 + 1, num2
    end,
    getPrevMonthInfo = function(num1: number, num2: number): (number, number)
        if num1 == 1 then
            return 12, num2 - 1
        end
        return num1 - 1, num2
    end,
    isDateWithinRange = function(dateTime, tbl1): boolean
        local num1 = roundToStartOfDay(tbl1.startDate)
        local num2 = roundToStartOfDay(tbl1.endDate)
        local num3 = roundToStartOfDay(dateTime)
        return num1 <= num3 and num3 <= num2
    end,
    monthMap = {
        Translator:FormatByKey("CommonUI.Controls.Label.January"),
        Translator:FormatByKey("CommonUI.Controls.Label.February"),
        Translator:FormatByKey("CommonUI.Controls.Label.March"),
        Translator:FormatByKey("CommonUI.Controls.Label.April"),
        Translator:FormatByKey("CommonUI.Controls.Label.May"),
        Translator:FormatByKey("CommonUI.Controls.Label.June"),
        Translator:FormatByKey("CommonUI.Controls.Label.July"),
        Translator:FormatByKey("CommonUI.Controls.Label.August"),
        Translator:FormatByKey("CommonUI.Controls.Label.September"),
        Translator:FormatByKey("CommonUI.Controls.Label.October"),
        Translator:FormatByKey("CommonUI.Controls.Label.November"),
        (Translator:FormatByKey("CommonUI.Controls.Label.December"))
    },
    roundDownToNearestMinute = function(dateTime): DateTime
        local var1 = toLocalTime(dateTime)

        return DateTime.fromLocalTime(var1.Year, var1.Month, var1.Day, var1.Hour, var1.Minute, 0)
    end,
    roundToStartOfDay = roundToStartOfDay,
    toLocalTime = toLocalTime,
    weekdays = {
        Translator:FormatByKey("CommonUI.Controls.Label.SundayAbbreviated"),
        Translator:FormatByKey("CommonUI.Controls.Label.MondayAbbreviated"),
        Translator:FormatByKey("CommonUI.Controls.Label.TuesdayAbbreviated"),
        Translator:FormatByKey("CommonUI.Controls.Label.WednesdayAbbreviated"),
        Translator:FormatByKey("CommonUI.Controls.Label.ThursdayAbbreviated"),
        Translator:FormatByKey("CommonUI.Controls.Label.FridayAbbreviated"),
        (Translator:FormatByKey("CommonUI.Controls.Label.SaturdayAbbreviated"))
    }
}
