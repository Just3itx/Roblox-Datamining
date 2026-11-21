-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local getAppFeaturePolicies = require(AuthCommonParent.UniversalAppPolicy).getAppFeaturePolicies

local LoginErrorCodes = require(AuthCommon.Enums.LoginErrorCodes)
local LoginErrorCodeSSO = require(AuthCommon.Enums.LoginErrorCodeSSO)

local FFlagEnableIllegalChildAccountLinkingErrorMessageOnSSO = require(AuthCommon.Flags.FFlagEnableIllegalChildAccountLinkingErrorMessageOnSSO)

local tbl1 = {
    [LoginErrorCodes.AccountLocked] = true,
    [LoginErrorCodes.EmptyAccountSwitchBlobRequired] = true,
    [LoginErrorCodes.ParentEmptyAccountSwitchBlobRequired] = true
}

local function isXboxPlatform(str1: string?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return string.find(str1 or "", "Xbox", 1, true) ~= nil
end

local function withPlatform(str1: string, platform: string?): {string} -- Luacid: Inlined by compiler; 6 call sites recovered
    return { str1, platform = platform }
end

local function xboxErrorMessage(num1: number, platform: string?, str1: string, str2: string)
    if num1 == LoginErrorCodes.IncorrectCValueOrPassword then
        return str1
    elseif num1 == LoginErrorCodes.MoreThanOneUsername or num1 == LoginErrorCodes.MultipleUsersPerCredential then
        return "Authentication.Login.Response.MoreThanOneUsername"
    elseif num1 == LoginErrorCodes.AccountNotVerified then
        return str2
    elseif num1 == LoginErrorCodes.ServiceUnavailable then
        return "Authentication.Login.Response.ServiceUnavailable"
    elseif num1 == LoginErrorCodeSSO.FloodedXbox then
        return "Authentication.TwoStepVerification.Response.TooManyAttempts"
    elseif num1 == LoginErrorCodeSSO.RobloxAccountAlreadyConnectedXbox then
        return withPlatform("Authentication.Login.Response.AlreadyLinked", platform)
    elseif num1 == LoginErrorCodeSSO.ExternalIdentityAlreadyConnectedXbox then
        return withPlatform("Authentication.Login.Response.PlatformAlreadyLinked", platform)
    end

    return if FFlagEnableIllegalChildAccountLinkingErrorMessageOnSSO and num1 == LoginErrorCodes.IllegalChildAccountLinking then "Authentication.Login.LinkIllegalChildAccountLinking" else "Authentication.Login.Response.SomethingWentWrong"
end

local function playstationErrorMessage(num1: number, platform: string?, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 == LoginErrorCodeSSO.IncorrectCValueOrPassword then
        return str1
    elseif num1 == LoginErrorCodeSSO.ExternalIdentityAlreadyConnected then
        return withPlatform("Authentication.Login.Response.PlatformAlreadyLinked", platform)
    elseif num1 == LoginErrorCodeSSO.FloodedPS then
        return "Authentication.TwoStepVerification.Response.TooManyAttempts"
    elseif num1 == LoginErrorCodeSSO.Require2FA then
        return "Authentication.Login.Response.Require2FAGeneric"
    elseif num1 == LoginErrorCodeSSO.RelinkingCooldown then
        return withPlatform("Authentication.Login.Response.RelinkingFreeze", platform)
    end

    return "Authentication.Login.Response.SomethingWentWrong"
end

return {
    getMessage = function(num1: number, str1: string, str2: string) -- name: GetLoginByCredentialSsoErrorMessage
        local var1 = getAppFeaturePolicies().getPlatformAccountName()

        if isXboxPlatform(var1) then
            return (xboxErrorMessage(num1, var1, str1, str2))
        end

        return playstationErrorMessage(num1, var1, str1)
    end,
    getUiErrorCode = function(num1: number): number?
        return if isXboxPlatform((getAppFeaturePolicies().getPlatformAccountName())) and tbl1[num1] then num1 else nil
    end
}
