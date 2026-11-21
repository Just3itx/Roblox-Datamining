-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent
local AuthCommon = require(AuthSignupParent.AuthCommon)
local ArgCheck = require(AuthSignupParent.ArgCheck)

local UsernameIssue = AuthCommon.Enums.UsernameIssue

local module = {}

function module.isLengthTooShortOrTooLong(arg1): boolean
    ArgCheck.isType(arg1, "string", "displayName passed into isLengthTooShortOrTooLong")

    local num1 = string.len(arg1)
    return num1 < 3 or num1 > 20
end

function module.hasBoundingUnderscore(arg1): boolean
    ArgCheck.isType(arg1, "string", "displayName passed into hasBoundingUnderscore")

    return string.sub(arg1, 1, 1) == "_" or string.sub(arg1, -1) == "_"
end

function module.hasMultipleUnderscores(arg1): boolean
    ArgCheck.isType(arg1, "string", "displayName passed into hasMultipleUnderscores")

    local _, var1 = string.gsub(arg1, "_", "")
    return var1 > 1
end

function module.containsInvalidCharacter(str1: string): boolean
    ArgCheck.isType(str1, "string", "displayName passed into containsInvalidCharacter")
    return utf8.len(str1) == nil
end

function module.locallyValidateDisplayName(arg1, arg2)
    ArgCheck.isType(arg2, "string", "username passed into locallyValidateDisplayName")

    local result = {}

    result[UsernameIssue.LengthTooShortOrTooLong] = arg1.isLengthTooShortOrTooLong(arg2)
    result[UsernameIssue.BoundingUnderscore] = arg1.hasBoundingUnderscore(arg2)
    result[UsernameIssue.MultipleUnderscores] = arg1.hasMultipleUnderscores(arg2)
    result[UsernameIssue.ContainsInvalidCharacter] = arg1.containsInvalidCharacter(arg2)

    return result
end

return module
