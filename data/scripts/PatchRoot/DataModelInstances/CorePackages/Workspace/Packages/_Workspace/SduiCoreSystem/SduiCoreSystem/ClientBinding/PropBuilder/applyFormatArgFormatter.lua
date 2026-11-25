-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths

local Localization = require(SduiCoreSystemParent.Localization)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiLogger = require(SduiCoreSystem.SduiLogger)

local LocalizationService = game:GetService("LocalizationService")

local function coerceNumericArg(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if type(arg1) == "number" then
        return arg1
    elseif type(arg1) == "string" then
        return tonumber(arg1)
    end
    return nil
end

local function tryDateTimeFromIsoString(isoDate: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function(): DateTime
        return DateTime.fromIsoDate(isoDate)
    end)
    return success and result or nil
end

local function resolveDateTimeForFormat(isoDate)
    if type(isoDate) == "number" then
        return DateTime.fromUnixTimestamp(isoDate)
    elseif type(isoDate) == "string" then
        local unixTimestamp = coerceNumericArg(isoDate)

        if unixTimestamp ~= nil then
            return DateTime.fromUnixTimestamp(unixTimestamp)
        end

        return tryDateTimeFromIsoString(isoDate)
    elseif type(isoDate) == "table" and isoDate.seconds ~= nil then
        return resolveDateTimeForFormat(isoDate.seconds)
    else
        return nil
    end
end

return {
    applyFormatArgFormatter = function(arg1, tbl1, str1: string, arg2)
        if tbl1.type == "TYPE_INVALID" or tbl1.type == nil then
            local tbl2 = { message = "Formatter specified without a type" }

            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl2, arg2)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, str1)
            return nil
        end

        if tbl1.type == "TYPE_NUMBER_ABBREVIATE" then
            local var1 = coerceNumericArg(arg1)

            if var1 ~= nil then
                return Localization.NumberLocalization.abbreviate(var1, LocalizationService.RobloxLocaleId)
            end

            local tbl2 = {
                message = `Formatter TYPE_NUMBER_ABBREVIATE received incompatible type '{typeof(arg1)}'`
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl2, arg2)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, str1)
            return nil
        elseif tbl1.type == "TYPE_NUMBER_LOCALIZE" then
            local var1 = coerceNumericArg(arg1)

            if var1 ~= nil then
                return Localization.NumberLocalization.localize(var1, LocalizationService.RobloxLocaleId)
            end

            local tbl2 = {
                message = `Formatter TYPE_NUMBER_LOCALIZE received incompatible type '{typeof(arg1)}'`
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl2, arg2)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, str1)
            return nil
        end

        if tbl1.type ~= "TYPE_DATE_FORMAT" then
            local tbl2 = {
                message = `Unknown formatter type '{tbl1.type}'`
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl2, arg2)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, str1)
            return nil
        end

        local var1 = resolveDateTimeForFormat(arg1)
        if var1 ~= nil then
            local config = tbl1.config

            return var1:FormatLocalTime(
                if not config or config.type ~= "date_config" or not config.value.pattern or config.value.pattern == "" then "L" else config.value.pattern,
                LocalizationService.RobloxLocaleId
            )
        end

        local tbl2 = {
            message = `Formatter TYPE_DATE_FORMAT received incompatible type '{typeof(arg1)}'`
        }
        if FFlagSduiErrorPaths then
            addSduiErrorContextFields(tbl2, arg2)
        end
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, str1)
        return nil
    end
}
