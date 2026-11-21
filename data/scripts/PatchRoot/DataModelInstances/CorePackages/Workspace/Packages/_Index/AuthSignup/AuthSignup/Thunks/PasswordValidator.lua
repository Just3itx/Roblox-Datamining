-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent
local AuthCommon = require(AuthSignupParent.AuthCommon)

local PostPasswordValid = AuthCommon.Http.Requests.PostPasswordValid
local Promise = require(AuthSignupParent.Promise)
local PasswordIssue = AuthCommon.Enums.PasswordIssue
local IssueCondition = AuthCommon.Enums.IssueCondition

local SharedFlags = require(AuthSignupParent.SharedFlags)
local FFlagSignUpPasswordCopyV2 = SharedFlags.FFlagSignUpPasswordCopyV2
local GetFFlagPasswordErrorLength = SharedFlags.GetFFlagPasswordErrorLength
local getIssueMessageList

if FFlagSignUpPasswordCopyV2 then
    getIssueMessageList = {}

    getIssueMessageList[PasswordIssue.Length] = "Authentication.SignUp.Label.PasswordPlaceholder"
    getIssueMessageList[PasswordIssue.UsernameMatch] = "Authentication.SignUp.Label.PasswordError2.V2"
    getIssueMessageList[PasswordIssue.Simple] = "Authentication.SignUp.Label.PasswordError3.V2"
else
    getIssueMessageList = {}
    getIssueMessageList[PasswordIssue.Length] = if GetFFlagPasswordErrorLength() then "Authentication.SignUp.PasswordErrorLength" else "Authentication.SignUp.Label.PasswordError1"

    getIssueMessageList[PasswordIssue.UsernameMatch] = "Authentication.SignUp.Label.PasswordError2"
    getIssueMessageList[PasswordIssue.Simple] = "Authentication.SignUp.Label.PasswordError3"
end

local function validateFunction(arg1, username, input, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(_)
        local issueCondition = ({})
        issueCondition[PasswordIssue.Length] = IssueCondition.Resolved
        issueCondition[PasswordIssue.UsernameMatch] = IssueCondition.Resolved
        issueCondition[PasswordIssue.Simple] = arg2[PasswordIssue.Simple] ~= IssueCondition.Hidden and IssueCondition.Resolved or IssueCondition.Hidden

        if username == nil or input == nil or username == "" or input == "" or string.match(input, "%S") == nil then
            for k in pairs(issueCondition) do
                if issueCondition[k] == IssueCondition.Resolved then
                    issueCondition[k] = IssueCondition.Problematic
                end
            end

            return Promise.resolve({ Input = input, InputValid = false, IssueCondition = issueCondition })
        end

        return PostPasswordValid(arg1, username, input):andThen(function(arg3)
            local tbl3 = {}

            local code = arg3 and arg3.responseBody and arg3.responseBody.code
            if type(code) ~= "number" then
                warn("JSON failure")
            elseif code == 2 then
                issueCondition[PasswordIssue.Length] = IssueCondition.Problematic
            elseif code == 3 then
                issueCondition[PasswordIssue.UsernameMatch] = IssueCondition.Problematic
            elseif code == 4 or code == 5 then
                issueCondition[PasswordIssue.Simple] = IssueCondition.Problematic
            end

            tbl3.Input = input
            tbl3.InputValid = code == 0
            tbl3.IssueCondition = issueCondition

            return Promise.resolve(tbl3)
        end, function(_)
            return Promise.resolve({ Input = input, InputValid = true, IssueCondition = issueCondition })
        end)
    end
end

return {
    validateFunction = function(arg1, input, arg2, arg3) -- name: validateFunctionRefactor
        return validateFunction(arg1, (arg3 or {}).username, input, arg2)
    end,
    getIssueMessageList = function()
        return getIssueMessageList
    end,
    getDefaultIssues = function()
        local defaultIssues = ({})

        for k in pairs(getIssueMessageList) do
            defaultIssues[k] = IssueCondition.Problematic
        end

        return defaultIssues
    end
}
