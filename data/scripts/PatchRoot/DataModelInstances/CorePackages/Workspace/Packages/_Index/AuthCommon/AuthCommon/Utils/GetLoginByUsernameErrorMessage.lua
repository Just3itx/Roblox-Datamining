-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local getAppFeaturePolicies = require(AuthCommonParent.UniversalAppPolicy).getAppFeaturePolicies

local LoginErrorCodes = require(AuthCommon.Enums.LoginErrorCodes)
local LoginErrorCodeSSO = require(AuthCommon.Enums.LoginErrorCodeSSO)

local FFlagEnableIllegalChildAccountLinkingErrorMessageOnSSO = require(AuthCommon.Flags.FFlagEnableIllegalChildAccountLinkingErrorMessageOnSSO)

local platform = getAppFeaturePolicies().getPlatformAccountName()

local tbl1 = {
    [LoginErrorCodeSSO.AuthError] = "Authentication.Login.Response.SomethingWentWrong",
    [LoginErrorCodeSSO.ExternalIdentityAlreadyConnected] = {
        "Authentication.Login.Response.PlatformAlreadyLinked",
        platform = platform
    },
    [LoginErrorCodeSSO.IncorrectCValueOrPassword] = "Authentication.Login.Response.IncorrectUsernamePassword",
    [LoginErrorCodeSSO.FloodedPS] = "Authentication.TwoStepVerification.Response.TooManyAttempts",
    [LoginErrorCodeSSO.Require2FA] = "Authentication.Login.Response.Require2FAGeneric",
    [LoginErrorCodeSSO.RelinkingCooldown] = {
        "Authentication.Login.Response.RelinkingFreeze",
        platform = platform
    },
    [LoginErrorCodes.IncorrectCValueOrPassword] = "Authentication.Login.Response.IncorrectUsernamePassword",
    [LoginErrorCodeSSO.FloodedXbox] = "Authentication.TwoStepVerification.Response.TooManyAttempts",
    [LoginErrorCodeSSO.RobloxAccountAlreadyConnectedXbox] = {
        "Authentication.Login.Response.AlreadyLinked",
        platform = platform
    },
    [LoginErrorCodeSSO.ExternalIdentityAlreadyConnectedXbox] = {
        "Authentication.Login.Response.PlatformAlreadyLinked",
        platform = platform
    }
}

if FFlagEnableIllegalChildAccountLinkingErrorMessageOnSSO then
    tbl1[LoginErrorCodes.IllegalChildAccountLinking] = "Authentication.Login.LinkIllegalChildAccountLinking"
end

local function GetLoginByUsernameErrorMessage(arg1)
    return if tbl1[arg1] then tbl1[arg1] else "Authentication.Login.Response.SomethingWentWrong"
end

return GetLoginByUsernameErrorMessage
