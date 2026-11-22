-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local TimeZone = require(script.Parent.TimeZone)

local module = {}

function module.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    local tbl1 = {
        dateTime = DateTime.fromUniversalTime(arg1 or 1970, arg2 or 1, arg3 or 1, arg4 or 0, arg5 or 0, arg6 or 0, arg7 or 0)
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module.now()
    local tbl1 = {
        dateTime = DateTime.now()
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module.fromUnixTimestamp(arg1)
    assert(type(arg1) == "number", "Invalid argument #1 to fromUnixTimestamp, expected number.")

    local tbl1 = {
        dateTime = DateTime.fromUnixTimestampMillis(arg1 * 1000)
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module.fromUnixTimestampMillis(unixTimestampMillis: number)
    assert(type(unixTimestampMillis) == "number", "Invalid argument #1 to fromUnixTimestampMillis, expected number.")

    local tbl1 = {
        dateTime = DateTime.fromUnixTimestampMillis(unixTimestampMillis)
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module.fromIsoDate(isoDate: string)
    assert(type(isoDate) == "string", "Invalid argument #1 to DateTime.fromIsoDate, expected string.")

    local tbl1 = {
        dateTime = DateTime.fromIsoDate(isoDate)
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:Format(str1: string, arg1, arg2)
    assert(type(str1) == "string", "Invalid argument #1 to Format, expected string.")

    arg1 = arg1 or TimeZone.Current
    arg2 = arg2 or LocalizationService.RobloxLocaleId

    if arg1 == TimeZone.UTC then
        return self.dateTime:FormatUniversalTime(str1, arg2)
    end

    if arg1 == TimeZone.Current then
        return self.dateTime:FormatLocalTime(str1, arg2)
    end
    error(("Invalid TimeZone \"%s\""):format(tostring(arg1)), 2)
end

function module:GetValues(arg1)
    arg1 = arg1 or TimeZone.Current

    if arg1 == TimeZone.UTC then
        return self.dateTime:ToUniversalTime()
    end

    if arg1 == TimeZone.Current then
        return self.dateTime:ToLocalTime()
    end
    error(("Invalid TimeZone \"%s\""):format(tostring(arg1)), 2)
end

function module:GetUnixTimestamp()
    if self.dateTime:ToUniversalTime().Millisecond > 0 then
        return self.dateTime.UnixTimestamp + self.dateTime.UnixTimestampMillis % 1000 / 1000
    end

    return self.dateTime.UnixTimestamp
end

function module:GetIsoDate()
    return self.dateTime:ToIsoDate()
end

function module.GetLongRelativeTime(arg1, _, arg2, arg3)
    return arg1:Format("lll", arg2, arg3)
end

function module.GetShortRelativeTime(arg1, _, arg2, arg3)
    return arg1:Format("ll", arg2 or TimeZone.Current, arg3)
end

module.__index = module

return module
