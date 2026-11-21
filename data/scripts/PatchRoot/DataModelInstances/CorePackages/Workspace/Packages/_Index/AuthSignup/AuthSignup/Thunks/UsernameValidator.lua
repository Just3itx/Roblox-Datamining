-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignup = script:FindFirstAncestor("AuthSignup")
local AuthSignupParent = AuthSignup.Parent
local AuthCommon = require(AuthSignupParent.AuthCommon)

local Cryo = require(AuthSignupParent.Cryo)
local ArgCheck = require(AuthSignupParent.ArgCheck)
local Promise = require(AuthSignupParent.Promise)

local UsernameIssue = AuthCommon.Enums.UsernameIssue
local IssueCondition = AuthCommon.Enums.IssueCondition
local PostUsernameValid = AuthCommon.Http.Requests.PostUsernameValid
local SharedFlags = require(AuthSignupParent.SharedFlags)

local LocalSignUpUsernameValidator = require(AuthSignup.Util.LocalSignUpUsernameValidator)

local FFlagAllowCurrentUsernameOnSignup = SharedFlags.FFlagAllowCurrentUsernameOnSignup
local GetFFlagFixUsernameValidationAlreadyInUse = SharedFlags.GetFFlagFixUsernameValidationAlreadyInUse
local GetFFlagFixUsernameValidationBackendCriteria = SharedFlags.GetFFlagFixUsernameValidationBackendCriteria

local tbl1 = {
    [0] = UsernameIssue.None,
    [1] = UsernameIssue.AlreadyInUse,
    [2] = UsernameIssue.Inappropriate,
    [3] = UsernameIssue.LengthTooShortOrTooLong,
    [4] = UsernameIssue.BoundingUnderscore,
    [5] = UsernameIssue.MultipleUnderscores,
    [6] = UsernameIssue.ContainsSpaces,
    [7] = UsernameIssue.ContainsInvalidCharacter,
    [10] = UsernameIssue.ContainsPII
}

local getIssueMessageList = {
    [UsernameIssue.ContainsInvalidCharacter] = "Authentication.SignUp.Label.UsernameError1",
    [UsernameIssue.LengthTooShortOrTooLong] = "Authentication.SignUp.Label.UsernameError2",
    [UsernameIssue.AlreadyInUse] = "Authentication.SignUp.Label.UsernameError3",
    [UsernameIssue.Inappropriate] = "Authentication.SignUp.Label.UsernameError4",
    [UsernameIssue.BoundingUnderscore] = "Authentication.SignUp.Label.UsernameError5",
    [UsernameIssue.MultipleUnderscores] = "Authentication.SignUp.Label.UsernameError6",
    [UsernameIssue.ContainsPII] = "Authentication.SignUp.Label.UsernameError7"
}

local function resetNonHiddenIssuesToProblematic(arg1)
    local var1 = Cryo.Dictionary.join(arg1)

    for k, value in pairs(var1) do
        if value ~= IssueCondition.Hidden then
            var1[k] = IssueCondition.Problematic
        end
    end

    return var1
end

local function validateFunction(arg1, input, birthday, arg2, context) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(_)
        ArgCheck.isType(input, "string", "username passed into UsernameValidator.validateFunction")
        ArgCheck.isType(birthday, "string", "birthday passed into UsernameValidator.validateFunction")
        ArgCheck.isType(arg2, "table", "previousIssues passed into UsernameValidator.validateFunction")

        if input == "" then
            return Promise.resolve({ Input = input, InputValid = false, IssueCondition = resetNonHiddenIssuesToProblematic(arg2) })
        end

        local issueCondition = Cryo.Dictionary.join(arg2)

        local var2 = LocalSignUpUsernameValidator:locallyValidateUsername(input)
        local bool1 = false
        for _, value in pairs(var2) do
            if value then
                bool1 = true
                break
            end
        end

        if bool1 then
            for k, value in pairs(arg2) do
                local var3 = var2[k]

                if value == IssueCondition.Hidden and var3 then
                    issueCondition[k] = IssueCondition.Problematic
                elseif value ~= IssueCondition.Hidden then
                    if GetFFlagFixUsernameValidationBackendCriteria() and var3 == nil then
                        issueCondition[k] = IssueCondition.Hidden
                    elseif not GetFFlagFixUsernameValidationAlreadyInUse() or var3 ~= nil then
                        issueCondition[k] = var3 == false and IssueCondition.Resolved or IssueCondition.Problematic
                    end
                end
            end

            return Promise.resolve({ Input = input, InputValid = false, IssueCondition = issueCondition })
        end

        for k, value in pairs(issueCondition) do
            issueCondition[k] = value == IssueCondition.Hidden and IssueCondition.Hidden or IssueCondition.Resolved
        end

        return PostUsernameValid(arg1, input, birthday, context):andThen(function(arg3)
            local code = arg3 and arg3.responseBody and arg3.responseBody.code
            local var3 = tbl1[code]

            if var3 then
                if var3 == UsernameIssue.ContainsSpaces then
                    issueCondition[UsernameIssue.ContainsInvalidCharacter] = IssueCondition.Problematic
                elseif var3 ~= UsernameIssue.None then
                    issueCondition[var3] = IssueCondition.Problematic
                end
            else
                warn("UsernameValidator.validateFunction() Received unrecognized response code: ", code)
            end

            return Promise.resolve({ Input = input, InputValid = var3 == UsernameIssue.None, IssueCondition = issueCondition })
        end, function(_)
            return Promise.resolve({ Input = input, InputValid = true, IssueCondition = issueCondition })
        end)
    end
end

local function isKeptCurrentUsername(arg1, currentUsername): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (currentUsername == nil or currentUsername == "") and string.lower(arg1) == string.lower(currentUsername)
end

local function resolveAlreadyInUseIfKeptCurrentUsername(arg1)
    if arg1.IssueCondition[UsernameIssue.AlreadyInUse] ~= IssueCondition.Problematic then
        return arg1
    end

    local issueCondition = Cryo.Dictionary.join(arg1.IssueCondition)
    issueCondition[UsernameIssue.AlreadyInUse] = IssueCondition.Resolved

    local bool1 = true
    for _, value in pairs(issueCondition) do
        if value == IssueCondition.Problematic then
            bool1 = false
            break
        end
    end

    return Cryo.Dictionary.join(arg1, { InputValid = bool1, IssueCondition = issueCondition })
end

return {
    validateFunction = function(arg1, input, arg2, arg3) -- name: validateFunctionRefactor
        arg3 = arg3 or {}

        local func1 = validateFunction(arg1, input, arg3.birthday, arg2, arg3.context)

        return if FFlagAllowCurrentUsernameOnSignup and isKeptCurrentUsername(input, arg3.currentUsername) then function(arg4)
            return func1(arg4):andThen(resolveAlreadyInUseIfKeptCurrentUsername)
        end else func1
    end,
    getIssueMessageList = function()
        return getIssueMessageList
    end,
    getDefaultIssues = function()
        local defaultIssues = ({})

        for k in pairs(getIssueMessageList) do
            if k == UsernameIssue.ContainsInvalidCharacter
                or k == UsernameIssue.LengthTooShortOrTooLong
                or k == UsernameIssue.AlreadyInUse
            then
                defaultIssues[k] = IssueCondition.Problematic
            else
                defaultIssues[k] = IssueCondition.Hidden
            end
        end

        return defaultIssues
    end
}
