-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local LoginErrorCodes = require(AuthCommon.Enums.LoginErrorCodes)

local function isNonTerminalLoginError(arg1, tbl1): boolean
    if typeof(arg1) ~= "table" then
        return false
    end

    local tbl2 = tbl1 or {}
    local errorCode = arg1.errorCode

    if errorCode == LoginErrorCodes.Captcha then
        return true
    end

    if errorCode == LoginErrorCodes.SecurityQuestions then
        return not (tbl2.securityQuestionsEnabled == false or arg1.securityQuestionsData == nil)
            and arg1.securityQuestionsCallback ~= nil
    end

    if errorCode ~= LoginErrorCodes.MultipleUsersPerCredential then
        return (errorCode == LoginErrorCodes.EmptyAccountSwitchBlobRequired
            or errorCode == LoginErrorCodes.ParentEmptyAccountSwitchBlobRequired)
            and tbl2.accountSwitchEnabled == true
    end

    if tbl2.accountSelectorEnabled == false or arg1.usersData == nil then
        return false
    end
    if not tbl2.accountSelectorRequiresCredentials then
        return true
    end

    return not (tbl2.credentialValue == nil) and tbl2.password ~= nil
end

return isNonTerminalLoginError
