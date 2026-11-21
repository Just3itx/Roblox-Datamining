-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local LoginErrorCodes = require(AuthCommon.Enums.LoginErrorCodes)
local StatusCodes = require(AuthCommonParent.Http).StatusCodes

local tbl1 = {
    [LoginErrorCodes.IncorrectCValueOrPassword] = "invalidCredentials",
    [LoginErrorCodes.MultipleUsersPerCredential] = "invalidCredentials",
    [LoginErrorCodes.AccountLocked] = "passwordReset",
    [LoginErrorCodes.CTypeNotSupported] = "badRequest",
    [LoginErrorCodes.CValueAndPasswordRequired] = "badRequest",
    [LoginErrorCodes.SecurityQuestions] = "securityQuestions"
}

local tbl2 = {
    [StatusCodes.TOO_MANY_REQUESTS] = "throttled",
    [StatusCodes.REQUEST_TIMEOUT] = "timeout",
    [StatusCodes.BAD_REQUEST] = "badRequest",
    [StatusCodes.NOT_FOUND] = "notFound",
    [StatusCodes.INTERNAL_SERVER_ERROR] = "serverError"
}

local function coarseLoginErrorBucket(arg1)
    if typeof(arg1) == "table" then
        return tbl1[arg1.errorCode] or (if arg1.HttpError == Enum.HttpError.OK then tbl2[arg1.StatusCode] or "unknown" else "unknown")
    end

    return "unknown"
end

return coarseLoginErrorBucket
