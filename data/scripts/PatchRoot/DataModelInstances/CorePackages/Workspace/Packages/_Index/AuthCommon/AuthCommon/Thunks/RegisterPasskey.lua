-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local AuthCommonParent = AuthCommon.Parent
local Base64 = require(AuthCommon.Utils.Base64)
local Promise = require(AuthCommonParent.Promise)
local Url = require(AuthCommonParent.Http).Url
local default = require(AuthCommonParent.CredentialsProtocol).CredentialsProtocol.default
local Logger = require(AuthCommonParent.Loggers).Logger
local PasskeyConstants = require(AuthCommon.Common.PasskeyConstants)

local FFlagEmitPasskeyRegistrationSourceOnFinish = require(AuthCommonParent.SharedFlags).FFlagEmitPasskeyRegistrationSourceOnFinish

local function getFinishRegistrationUrl(): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("%sv1/passkey/FinishRegistration", Url.AUTH_URL)
end

local function finishPasskeyRegistration(arg1, postBody: string)
    return arg1(getFinishRegistrationUrl(), "POST", { postBody = postBody }):andThen(function(arg2)
        return Promise.resolve(arg2)
    end, function(arg2)
        local body = if type(arg2) == "table" then HttpService:JSONEncode(arg2) else nil
        return Promise.reject(
            {
                body = body,
                name = PasskeyConstants.BACKEND_CREATION_ERROR_NAME,
                source = PasskeyConstants.FINISH_STEP
            }
        )
    end)
end

local function getStartRegistrationUrl(flow: boolean): string -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = string.format("%sv1/passkey/StartRegistration", Url.AUTH_URL)
    if flow then
        return string.format("%s?flow=%s", str1, flow)
    end
    return str1
end

local function startPasskeyRegistration(arg1, arg2, isSilentUpgrade)
    local tbl1 = {
        postBody = HttpService:JSONEncode({ isSilentUpgrade = isSilentUpgrade })
    }
    local startRegistrationUrl = getStartRegistrationUrl(false)
    if arg2 then
        startRegistrationUrl = string.format("%s?flow=%s", startRegistrationUrl, arg2)
    end

    return arg1(startRegistrationUrl, "POST", tbl1, isSilentUpgrade):andThen(function(arg3)
        return Promise.resolve(arg3[1])
    end, function(arg3)
        local body = if type(arg3) == "table" then HttpService:JSONEncode(arg3) else nil
        return Promise.reject(
            {
                body = body,
                name = PasskeyConstants.BACKEND_CREATION_ERROR_NAME,
                source = PasskeyConstants.START_STEP
            }
        )
    end)
end

local function attemptPasskeyRegistration(arg1, arg2, isSilentPasskeyUpgrade, source)
    return startPasskeyRegistration(arg1, arg2, isSilentPasskeyUpgrade):andThen(function(arg3)
        local input = HttpService:JSONDecode(arg3.creationOptions)
        local sessionId = arg3.sessionId
        local var1 = tonumber(input.publicKey.timeout)
        input.keyType = "platform"
        input.deviceBoundOnly = true
        input.isSilentPasskeyUpgrade = isSilentPasskeyUpgrade

        if UserInputService:GetPlatform() ~= Enum.Platform.Android then
            input.publicKey.challenge = Base64.FromUrlSafeBase64(input.publicKey.challenge)
            input.publicKey.user.id = Base64.FromUrlSafeBase64(input.publicKey.user.id)
        end

        local str1 = HttpService:JSONEncode(input)
        return default:registerCredentials(default.CredentialsTypes.FIDO2, str1, var1 / 1000):andThen(function(input2: string)
            local input3 = HttpService:JSONDecode(input2)
            if input3 == nil or next(input3) == nil then
                return Promise.reject({
                    body = "Null resultTable",
                    name = PasskeyConstants.USER_OS_DIALOG_ERROR_NAME,
                    source = PasskeyConstants.CREDENTIALS_PROTOCOL_REGISTER_CREDENTIALS_EMPTY_RESPONSE
                })
            end

            if input3.errorCode ~= nil then
                Logger:warning("Passkey credential signing failed. Error {} ({}) returned.", input3.errorCode, input3.errorMsg)

                return Promise.reject({
                    body = input3.errorMsg,
                    name = PasskeyConstants.USER_OS_DIALOG_ERROR_NAME,
                    source = PasskeyConstants.CREDENTIALS_PROTOCOL_REGISTER_CREDENTIALS_ERROR_CODE
                })
            end
            input3.id = Base64.ToUrlSafeBase64(input3.id)
            input3.rawId = Base64.ToUrlSafeBase64(input3.rawId)
            input3.response.attestationObject = Base64.ToUrlSafeBase64(input3.response.attestationObject)
            input3.response.clientDataJSON = Base64.ToUrlSafeBase64(input3.response.clientDataJSON)

            local attestationResponse = HttpService:JSONEncode(input3)
            local input4 = {
                sessionId = sessionId,
                credentialNickname = "Passkey",
                attestationResponse = attestationResponse,
                source = if FFlagEmitPasskeyRegistrationSourceOnFinish then source else nil
            }
            local postBody = HttpService:JSONEncode(input4)
            return finishPasskeyRegistration(arg1, postBody)
        end, function(body)
            return Promise.reject({
                body = body,
                name = PasskeyConstants.USER_OS_DIALOG_ERROR_NAME,
                source = PasskeyConstants.CREDENTIALS_PROTOCOL_REGISTER_CREDENTIALS_OTHER_ERR
            })
        end)
    end, function(body)
        if type(body) == "table" and body.name then
            return Promise.reject(body)
        end
        return Promise.reject(
            {
                body = body,
                name = PasskeyConstants.BACKEND_CREATION_ERROR_NAME,
                source = PasskeyConstants.UNKNOWN_BACKEND_ERROR
            }
        )
    end)
end

return attemptPasskeyRegistration
