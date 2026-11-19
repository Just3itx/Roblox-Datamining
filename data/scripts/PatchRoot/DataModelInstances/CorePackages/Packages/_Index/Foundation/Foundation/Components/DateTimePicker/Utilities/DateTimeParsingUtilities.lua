-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:41:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DateTimeEqualityUtilities = require(script.Parent.DateTimeEqualityUtilities)
local DateTimePickerVariant = require(Foundation.Enums.DateTimePickerVariant)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local function parseTimeFromText(str1: string)
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

local function adjustForDaylightSaving(dateTime)
    local var1 = os.date("*t", dateTime.UnixTimestamp)
    if var1 and var1.isdst then
        return DateTime.fromUnixTimestamp(dateTime.UnixTimestamp - 3600)
    end
    return dateTime
end

local function parseDateTimeFromText(str1: string)
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
    local hour, minute = parseTimeFromText(var1)
    if hour == nil or minute == nil then
        return nil
    end

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
        return adjustForDaylightSaving(result)
    end

    return nil
end

local function trimInputText(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    return (str1:gsub("^%s*(.-)%s*$", "%1"))
end

return {
    adjustForDaylightSaving = adjustForDaylightSaving,
    formatInputText = function(tbl1)
        local var1 = tbl1.dates[1]
        if not var1 then
            return ""
        elseif tbl1.variant == DateTimePickerVariant.Dual or tbl1.variant == DateTimePickerVariant.DualWithPresets then
            local var2 = tbl1.dates[2]
            return `{DateTimeUtilities.formatLocalTime(var1)} - {if var2 then DateTimeUtilities.formatLocalTime(var2) else ""}`
        else
            local bool1 = tbl1.variant == DateTimePickerVariant.SingleWithTime
            return DateTimeUtilities.formatLocalTime(var1, bool1)
        end
    end,
    parseDateTimeFromText = parseDateTimeFromText,
    parseDualInputEndpoints = function(str1: string)
        local tbl1 = str1:split(" - ")
        local var1 = if tbl1[1] then parseDateTimeFromText((trimInputText(tbl1[1]))) else nil

        if tbl1[2] then
            return var1, (parseDateTimeFromText((trimInputText(tbl1[2]))))
        end

        return var1, nil
    end,
    parseInputToDraftDates = function(str1: string, arg1)
        if #str1:split(" - ") ~= 2 then
            return nil
        end

        local tbl1 = str1:split(" - ")
        local var1 = if tbl1[1] then parseDateTimeFromText((trimInputText(tbl1[1]))) else nil
        local var2 = if tbl1[2] then parseDateTimeFromText((trimInputText(tbl1[2]))) else nil

        if not (var1 and var2) then
            return nil
        end

        if not (DateTimeUtilities.roundToStartOfDay(var1) > DateTimeUtilities.roundToStartOfDay(var2)) then
            local var3 = var1
            var1 = var2
            var2 = var3
        end

        return if arg1 and not DateTimeEqualityUtilities.isRangeWithinSelectableRange({ startDate = var2, endDate = var1 }, arg1) then nil else { var2, var1 }
    end,
    trimInputText = trimInputText
}
