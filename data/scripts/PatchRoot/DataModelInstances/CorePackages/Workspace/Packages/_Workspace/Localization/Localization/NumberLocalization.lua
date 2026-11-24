-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoundingBehaviour = require(script.Parent.RoundingBehaviour)

local Logger = require(script.Parent.Logger)

game:DefineFastFlag("AllowNumberLocalizationSigFigParam", false)

local tbl1 = {}

tbl1["en-us"] = {
    decimalSeparator = ".",
    groupDelimiter = ",",
    { 1, "" },
    { 1000, "K" },
    { 1000000, "M" },
    { 1000000000, "B" }
}

tbl1["es-es"] = {
    decimalSeparator = ",",
    groupDelimiter = ".",
    { 1, "" },
    { 1000, " mil" },
    { 1000000, " M" }
}

tbl1["fr-fr"] = {
    decimalSeparator = ",",
    groupDelimiter = " ",
    { 1, "" },
    { 1000, " k" },
    { 1000000, " M" },
    { 1000000000, " Md" }
}

tbl1["de-de"] = {
    decimalSeparator = ",",
    groupDelimiter = " ",
    { 1, "" },
    { 1000, " Tsd." },
    { 1000000, " Mio." },
    { 1000000000, " Mrd." }
}

tbl1["pt-br"] = {
    decimalSeparator = ",",
    groupDelimiter = ".",
    { 1, "" },
    { 1000, " mil" },
    { 1000000, " mi" },
    { 1000000000, " bi" }
}

tbl1["zh-cn"] = {
    decimalSeparator = ".",
    groupDelimiter = ",",
    { 1, "" },
    { 1000, "千" },
    { 10000, "万" },
    { 100000000, "亿" }
}

tbl1["zh-cjv"] = {
    decimalSeparator = ".",
    groupDelimiter = ",",
    { 1, "" },
    { 1000, "千" },
    { 10000, "万" },
    { 100000000, "亿" }
}

tbl1["zh-tw"] = {
    decimalSeparator = ".",
    groupDelimiter = ",",
    { 1, "" },
    { 1000, "千" },
    { 10000, "萬" },
    { 100000000, "億" }
}

tbl1["ko-kr"] = {
    decimalSeparator = ".",
    groupDelimiter = ",",
    { 1, "" },
    { 1000, "천" },
    { 10000, "만" },
    { 100000000, "억" }
}

tbl1["ja-jp"] = {
    decimalSeparator = ".",
    groupDelimiter = ",",
    { 1, "" },
    { 1000, "千" },
    { 10000, "万" },
    { 100000000, "億" }
}

tbl1["it-it"] = {
    decimalSeparator = ",",
    groupDelimiter = " ",
    { 1, "" },
    { 1000, " mila" },
    { 1000000, " Mln" },
    { 1000000000, " Mld" }
}

tbl1["ru-ru"] = {
    decimalSeparator = ",",
    groupDelimiter = ".",
    { 1, "" },
    { 1000, " тыс" },
    { 1000000, " млн" },
    { 1000000000, " млрд" }
}

tbl1["id-id"] = {
    decimalSeparator = ",",
    groupDelimiter = ".",
    { 1, "" },
    { 1000, " rb" },
    { 1000000, " jt" },
    { 1000000000, " M" }
}

tbl1["vi-vn"] = {
    decimalSeparator = ".",
    groupDelimiter = " ",
    { 1, "" },
    { 1000, " N" },
    { 1000000, " Tr" },
    { 1000000000, " T" }
}

tbl1["tr-tr"] = {
    decimalSeparator = ",",
    groupDelimiter = ".",
    { 1, "" },
    { 1000, " B" },
    { 1000000, " Mn" },
    { 1000000000, " Mr" }
}

tbl1["en-gb"] = tbl1["en-us"]
tbl1["es-mx"] = tbl1["es-es"]
tbl1["th-th"] = tbl1["en-us"]

local function findDecimalPointIndex(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return string.find(str1, "%.") or #str1 + 1
end

local function findDecimalOffset(arg1): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == 0 then
        return 0
    end

    return -(math.floor(math.log10(math.abs(arg1))) + 1)
end

local function roundToSignificantDigits(arg1, arg2, truncate) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = 10 ^ (arg2 + findDecimalOffset(arg1))
    local var2 = if truncate == RoundingBehaviour.Truncate then math.modf(arg1 * var1) else math.floor(arg1 * var1 + 0.5)
    return var2 / var1
end

local function addGroupDelimiters(arg1, groupDelimiter)
    local str1 = string.format("%%1%s%%2", groupDelimiter)

    repeat
        local var1
        arg1, var1 = string.gsub(arg1, "^(-?%d+)(%d%d%d)", str1)
    until var1 == 0

    return arg1
end

local function findDenominationEntry<T>(tbl2: {{T}}, arg1, truncate)
    local var1 = tbl2[1]
    local num1 = math.abs(arg1)
    for i = #tbl2, 2, -1 do
        local var2 = tbl2[i]

        if (if truncate == RoundingBehaviour.Truncate then var2[1] else var2[1] - tbl2[i - 1][1] / 2) <= num1 then
            return var2
        end
    end
    return var1
end

local module = {}

function module.localize(arg1, arg2)
    if arg1 == 0 then
        return "0"
    end

    local var1 = tbl1[arg2]
    if not var1 then
        var1 = tbl1["en-us"]

        Logger:warning(string.format("Warning: Locale not found: '%s', reverting to '%s' instead.", tostring(arg2), "en-us"))
    end

    if var1.groupDelimiter then
        return (addGroupDelimiters(arg1, var1.groupDelimiter))
    end

    return arg1
end

function module.abbreviate(arg1, arg2, arg3, arg4)
    if arg1 == 0 then
        return "0"
    end

    if arg3 == nil then
        arg3 = RoundingBehaviour.RoundToClosest
    end

    arg4 = if game:GetFastFlag("AllowNumberLocalizationSigFigParam") then if arg4 == nil then 3 else arg4 else 3

    local var1 = tbl1[arg2]
    if not var1 then
        var1 = tbl1["en-us"]

        Logger:warning(string.format("Warning: Locale not found: '%s', reverting to '%s' instead.", tostring(arg2), "en-us"))
    end

    local denominationEntry = findDenominationEntry(var1, arg1, arg3)
    local var2 = denominationEntry[1]
    local var3 = denominationEntry[2]

    local var4 = roundToSignificantDigits(arg1 / var2, arg4, arg3)
    local var5 = if arg3 == RoundingBehaviour.Truncate then math.modf(var4 * 10) / 10 else math.floor(var4 * 10 + 0.5) / 10
    local str1 = tostring(var5)
    local decimalPointIndex = findDecimalPointIndex(str1)
    local str2 = string.sub(str1, 1, decimalPointIndex - 1)
    local str3 = string.sub(str1, decimalPointIndex + 1, #str1)

    if var1.groupDelimiter then
        str2 = addGroupDelimiters(str2, var1.groupDelimiter)
    end

    if #str3 > 0 then
        return str2 .. var1.decimalSeparator .. str3 .. var3
    end

    return str2 .. var3
end

function module.localizeDecimal(arg1, arg2, arg3)
    if arg1 == 0 then
        return "0"
    end

    arg3 = if arg3 == nil then 2 else arg3

    local var1 = tbl1[arg2]
    if not var1 then
        var1 = tbl1["en-us"]

        Logger:warning(string.format("Warning: Locale not found: '%s', reverting to '%s' instead.", tostring(arg2), "en-us"))
    end

    local var2 = 10 ^ arg3
    local var3 = math.floor(math.abs(arg1) * var2 + 0.5) / var2

    local str1 = arg1 < 0 and (if var3 == 0 then "" else "-") or ""

    local str2 = string.format(string.format("%%.%df", arg3), var3)
    local decimalPointIndex = findDecimalPointIndex(str2)
    local str3 = string.sub(str2, 1, decimalPointIndex - 1)
    local str4 = string.sub(str2, decimalPointIndex + 1, #str2)

    if var1.groupDelimiter then
        str3 = addGroupDelimiters(str3, var1.groupDelimiter)
    end

    local var4 = string.gsub(str4, "0+$", "")

    if #var4 > 0 then
        return str1 .. str3 .. var1.decimalSeparator .. var4
    end

    return str1 .. str3
end

function module.abbreviateDecimal(arg1, arg2, arg3)
    local var1 = tbl1[arg2] or tbl1["en-us"]
    local denominationEntry = findDenominationEntry(var1, arg1, RoundingBehaviour.RoundToClosest)
    return module.localizeDecimal(arg1 / denominationEntry[1], arg2, arg3) .. denominationEntry[2]
end

module.logger = Logger

return module
