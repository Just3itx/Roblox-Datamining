-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:08Z
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

local function getStartPreauthRegistrationUrl(): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("%sv1/passkey/start-preauth-registration", Url.AUTH_URL)
end

local function startPreauthPasskeyRegistration(arg1, username)
    local postBody = HttpService:JSONEncode({ username = username })

    return arg1(getStartPreauthRegistrationUrl(), "POST", { postBody = postBody }):andThen(function(arg2)
        return Promise.resolve(arg2[1])
    end, function(arg2)
        local body = if type(arg2) == "table" then HttpService:JSONEncode(arg2) else nil
        return Promise.reject(
            {
                body = body,
                name = PasskeyConstants.BACKEND_CREATION_ERROR_NAME,
                source = PasskeyConstants.START_STEP
            }
        )
    end)
end

local function attemptPreauthPasskeyRegistration(arg1, username)
    return startPreauthPasskeyRegistration(arg1, username):andThen(function(arg2)
        local input = HttpService:JSONDecode(arg2.creationOptions)
        local var1 = tonumber(input.publicKey.timeout)
        input.keyType = PasskeyConstants.PLATFORM
        input.deviceBoundOnly = true

        if UserInputService:GetPlatform() ~= Enum.Platform.Android then
            input.publicKey.challenge = Base64.FromUrlSafeBase64(input.publicKey.challenge)
            input.publicKey.user.id = Base64.FromUrlSafeBase64(input.publicKey.user.id)
        end

        local str1 = HttpService:JSONEncode(input)
        return default:registerCredentials(default.CredentialsTypes.FIDO2, str1, var1 / PasskeyConstants.PASSKEY_TIMEOUT_DURATION):andThen(
            function(input2: string)
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

                local str2 = HttpService:JSONEncode(input3)
                return Promise.resolve({ result = str2, sessionId = arg2.sessionId })
            end,
            function(body)
                return Promise.reject({
                    body = body,
                    name = PasskeyConstants.USER_OS_DIALOG_ERROR_NAME,
                    source = PasskeyConstants.CREDENTIALS_PROTOCOL_REGISTER_CREDENTIALS_OTHER_ERR
                })
            end
        )
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

return attemptPreauthPasskeyRegistration
