-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local AuthCommonParent = AuthCommon.Parent
local Base64 = require(AuthCommon.Utils.Base64)
local Promise = require(AuthCommonParent.Promise)
local Url = require(AuthCommonParent.Http).Url

local PasskeyConstants = require(AuthCommon.Common.PasskeyConstants)

local FFlagEmitPasskeyRegistrationSourceOnFinish = require(AuthCommonParent.SharedFlags).FFlagEmitPasskeyRegistrationSourceOnFinish

local function getFinishRegistrationUrl(): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("%sv1/passkey/finish-ar-preauth-registration", Url.AUTH_URL)
end

local function finishARPreauthPasskeyRegistration(arg1, postBody: string)
    return arg1(getFinishRegistrationUrl(), "POST", { postBody = postBody }):andThen(function(arg2)
        return Promise.resolve(arg2)
    end, function(arg2)
        local body = if type(arg2) == "table" then HttpService:JSONEncode(arg2) else nil
        return Promise.reject({ body = body, name = PasskeyConstants.BACKEND_CREATION_ERROR_NAME })
    end)
end

local function attemptFinishARPreauthPasskeyRegistration(arg1, recoverySession, passkeySessionId, userId, input: string, isPostRecovery, source)
    local input2 = HttpService:JSONDecode(input)
    input2.id = Base64.ToUrlSafeBase64(input2.id)
    input2.rawId = Base64.ToUrlSafeBase64(input2.rawId)
    input2.response.attestationObject = Base64.ToUrlSafeBase64(input2.response.attestationObject)
    input2.response.clientDataJSON = Base64.ToUrlSafeBase64(input2.response.clientDataJSON)

    local input3 = {
        recoverySession = recoverySession,
        passkeySessionId = passkeySessionId,
        passkeyRegistrationResponse = HttpService:JSONEncode(input2),
        userId = userId,
        isPostRecovery = isPostRecovery,
        source = 0
    }

    if not FFlagEmitPasskeyRegistrationSourceOnFinish then
        source = nil
    end

    input3.source = source

    local postBody = HttpService:JSONEncode(input3)
    return finishARPreauthPasskeyRegistration(arg1, postBody)
end

return attemptFinishARPreauthPasskeyRegistration
