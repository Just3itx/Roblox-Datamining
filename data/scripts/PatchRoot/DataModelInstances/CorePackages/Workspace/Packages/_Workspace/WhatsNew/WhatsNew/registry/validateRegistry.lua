-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local Constants = require(WhatsNew.Constants)
local Enums = require(WhatsNew.Enums)
local _Types = require(WhatsNew.Types)
local ScopeActions = require(script.Parent.ScopeActions)

local function appendError(tbl1, str1: string, str2: string) -- Luacid: Inlined by compiler; 14 call sites recovered
    table.insert(tbl1, `{str1}:{str2}`)
end

local function isNonEmptyString(str1: string?): boolean -- Luacid: Inlined by compiler; 7 call sites recovered
    return not (str1 == nil) and str1 ~= ""
end

local function isoDateToUnix(isoDate: string): number? -- Luacid: Inlined by compiler; 3 call sites recovered
    local dateTime = DateTime.fromIsoDate(isoDate)
    return dateTime and dateTime.UnixTimestamp or nil
end

local function getRegistryEntries(arg1, whatsNew) -- Luacid: Inlined by compiler; 3 call sites recovered
    return if whatsNew == Enums.TourType.WhatsNew then arg1.whatsNew else arg1.onboarding
end

local function validateConstants(arg1, tbl1)
    local constants = arg1.constants
    for value, value2 in {
        textMaxLength = constants.textMaxLength,
        maxTourTips = constants.maxTourTips,
        maxOptOutCount = constants.maxOptOutCount
    } do
        if typeof(value2) ~= "number" or value2 <= 0 then
            appendError(tbl1, Constants.ErrorCodes.INVALID_CONSTANTS, `{value}`)
        end
    end
end

local function validateScopeKeys(arg1, tbl1)
    for k, scopeTour in arg1.scopeTours do
        if scopeTour.id ~= k then
            appendError(tbl1, Constants.ErrorCodes.SCOPE_KEY_MISMATCH, `{k}->{scopeTour.id}`)
        end
    end
end

local function validateEntrySchedule(arg1, whatsNew, tbl1)
    local str1 = `{arg1.id} ({whatsNew})`
    local var1 = nil
    local var2 = nil

    if not isNonEmptyString(arg1.publishedTime) then
        appendError(tbl1, Constants.ErrorCodes.MISSING_PUBLISHED_TIME, str1)
    else
        var1 = isoDateToUnix(arg1.publishedTime)
        if var1 == nil then
            appendError(tbl1, Constants.ErrorCodes.INVALID_PUBLISHED_TIME, str1)
        end
    end

    if whatsNew == Enums.TourType.WhatsNew then
        if not isNonEmptyString(arg1.disabledTime) then
            appendError(tbl1, Constants.ErrorCodes.MISSING_DISABLED_TIME, str1)
        else
            var2 = isoDateToUnix(arg1.disabledTime)
            if var2 == nil then
                appendError(tbl1, Constants.ErrorCodes.INVALID_DISABLED_TIME, str1)
            end
        end
    elseif isNonEmptyString(arg1.disabledTime) then
        var2 = isoDateToUnix(arg1.disabledTime)
        if var2 == nil then
            appendError(tbl1, Constants.ErrorCodes.INVALID_DISABLED_TIME, str1)
        end
    end

    if var1 ~= nil and var2 ~= nil and var2 <= var1 then
        appendError(tbl1, Constants.ErrorCodes.INVALID_SCHEDULE_WINDOW, str1)
    end
end

local function validateEntryScopes(arg1, tbl1)
    local function validateEntries(registryEntries, whatsNew)
        for _, value in registryEntries do
            if arg1.scopeTours[value.scopeId] == nil then
                appendError(tbl1, Constants.ErrorCodes.UNKNOWN_SCOPE, `{value.id} ({whatsNew})`)
            end

            if #value.text > arg1.constants.textMaxLength then
                appendError(tbl1, Constants.ErrorCodes.TEXT_TOO_LONG, `{value.id} ({whatsNew})`)
            end

            if not (isNonEmptyString(value.title) or isNonEmptyString(value.text)) then
                appendError(tbl1, Constants.ErrorCodes.EMPTY_ENTRY_LABELS, `{value.id} ({whatsNew})`)
            end

            validateEntrySchedule(value, whatsNew, tbl1)
        end
    end

    for _, value in Enums.TourTypeList do
        validateEntries(getRegistryEntries(arg1, value), value)
    end
end

local function validateUniqueEntryIds(arg1, tbl1)
    for _, value in Enums.TourTypeList do
        local tbl2 = {}
        local registryEntries = getRegistryEntries(arg1, value)
        local var1 = nil
        local var2 = nil

        for _, value2 in registryEntries, var1, var2 do
            if tbl2[value2.id] then
                appendError(tbl1, Constants.ErrorCodes.DUPLICATE_ENTRY_ID, `{value2.id} ({value})`)
            else
                tbl2[value2.id] = true
            end
        end
    end
end

local function scopeHasEntries(scopeId: string, arg1)
    for _, value in Enums.TourTypeList do
        local registryEntries = getRegistryEntries(arg1, value)
        local var1 = nil
        local var2 = nil

        for _, value2 in registryEntries, var1, var2 do
            if value2.scopeId == scopeId then
                return true
            end
        end
    end

    return false
end

local function validateNestedScopeActions(arg1, tbl1)
    for k, scopeTour in arg1.scopeTours do
        if scopeTour.parentScopeId ~= nil
            and scopeHasEntries(k, arg1)
            and not (isNonEmptyString(scopeTour.openActionKey) and isNonEmptyString(scopeTour.closeActionKey))
        then
            appendError(tbl1, Constants.ErrorCodes.NESTED_MISSING_ACTION, k)
        end
    end
end

local function validateKnownActionKeys(arg1, scopeActions, tbl1)
    if scopeActions == nil then
        return
    end

    for _, value in ScopeActions.collectRegistryActionKeys(arg1) do
        if not scopeActions:has(value) then
            appendError(tbl1, Constants.ErrorCodes.UNKNOWN_ACTION_KEY, value)
        end
    end
end

local function validateRegistry(arg1, tbl1)
    local errors = {}

    validateConstants(arg1, errors)
    validateScopeKeys(arg1, errors)
    validateEntryScopes(arg1, errors)
    validateUniqueEntryIds(arg1, errors)
    validateNestedScopeActions(arg1, errors)
    validateKnownActionKeys(arg1, (tbl1 or {}).scopeActions, errors)
    return {
        errors = errors,
        warnings = {}
    }
end

return validateRegistry
