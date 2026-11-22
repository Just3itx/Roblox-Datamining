-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IdentityVerification = script:FindFirstAncestor("IdentityVerification")
local IdentityVerificationParent = IdentityVerification.Parent

local HttpService = game:GetService("HttpService")

local UrlBuilder = require(IdentityVerificationParent.UrlBuilder).UrlBuilder
local UrlBase = require(IdentityVerificationParent.UrlBuilder).UrlBase
local Fetch = require(IdentityVerificationParent.Fetch)
local Promise = require(IdentityVerificationParent.Promise)
local fetch = Fetch.fetch
local Response = Fetch.Response

local Cryo = require(IdentityVerificationParent.Cryo)

local UniversalFeatureRestrictions = require(IdentityVerificationParent.UniversalFeatureRestrictions)
local showFeatureRestriction = UniversalFeatureRestrictions.showFeatureRestriction
local AbuseVector = UniversalFeatureRestrictions.AbuseVector

local buildAgeVerificationFeatureRestrictionOverrides = require(IdentityVerification.Utils.buildAgeVerificationFeatureRestrictionOverrides)

local FFlagEnableFeatureRestrictionOnAgeVerificationAttempt = require(IdentityVerification.Flags.FFlagEnableFeatureRestrictionOnAgeVerificationAttempt)

local urlBuilder = UrlBuilder.new({
    base = UrlBase.APIS,
    path = "age-verification-service/v1/persona-id-verification/verified-status",
    query = { token = "{token}" }
})

local urlBuilder2 = UrlBuilder.new({ base = UrlBase.APIS, path = "age-verification-service/v1/persona-id-verification/start-verification" })

local var1 = UrlBuilder.new(
    {
        base = UrlBase.APIS,
        path = "age-verification-service/v1/persona-id-verification/start-liveness-verification"
    }
)()

local function getHttpStatusFromWrappedNetworkingError(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) == "table" then
        return arg1.StatusCode or arg1.responseCode or arg1.status or arg1.statusCode
    end

    return nil
end

local function maybeShowAgeVerificationFeatureRestriction(num1: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not FFlagEnableFeatureRestrictionOnAgeVerificationAttempt or num1 ~= 403 then
        return
    end

    showFeatureRestriction(AbuseVector.AgeVerification, buildAgeVerificationFeatureRestrictionOverrides())
end

local function startVerification(tbl1, str1: string?)
    local var2 = str1 or urlBuilder2()
    local bool1 = var2 ~= var1

    local var3 = fetch
    return Promise.new(function(callback, callback2)
        local var4 = var3(var2, {
            method = "POST",
            body = HttpService:JSONEncode(Cryo.Dictionary.join({ generatedLink = true }, tbl1 or {})),
            headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        }):catch(
            function()
                return Response.error()
            end
        ):expect()

        if not var4.ok then
            if bool1 then
                maybeShowAgeVerificationFeatureRestriction(var4.status)
            end
            callback2(string.format("Got start-verification HTTP Response: %d", var4.status))
            return
        end

        local var5 = var4:json():catch(function()
            return nil
        end):expect()

        if not var5 then
            callback2("Failed to decode HTTP response as JSON for IDV Verification")
            return
        end

        callback({
            emailSent = var5.emailSent,
            sessionIdentifier = var5.sessionIdentifier,
            daysUntilNextVerification = var5.daysUntilNextVerification,
            verificationLink = var5.verificationLink,
            sessionToken = var5.sessionToken
        })
    end)
end

return {
    startVerification = startVerification,
    startVerificationWithWrappedNetworking = function(arg1, tbl1)
        return Promise.new(function(callback, callback2)
            local var2 = urlBuilder2()

            local input = Cryo.Dictionary.join({ generatedLink = true }, tbl1 or {})

            arg1(var2, "POST", { postBody = HttpService:JSONEncode(input) }):catch(function(arg2)
                maybeShowAgeVerificationFeatureRestriction((getHttpStatusFromWrappedNetworkingError(arg2)))
                callback2("Got error on start-verificatin")
            end):andThen(function(arg2)
                if not (arg2 and arg2[1]) then
                    callback2("Got start-verification HTTP with no valid response")
                    return
                end

                local var3 = arg2[1]
                if not var3 then
                    callback2("Failed to decode HTTP response as JSON for IDV Verification")
                    return
                end

                callback({
                    emailSent = var3.emailSent,
                    sessionIdentifier = var3.sessionIdentifier,
                    daysUntilNextVerification = var3.daysUntilNextVerification,
                    verificationLink = var3.verificationLink,
                    sessionToken = var3.sessionToken
                })
            end)
        end)
    end,
    startLivenessVerification = function(tbl1)
        return startVerification(tbl1, var1)
    end,
    getVerifiedStatus = function(token)
        local var2 = fetch
        return Promise.new(function(callback, callback2)
            local var3 = urlBuilder({ token = token })
            local var4 = var2(var3, { method = "GET" }):catch(function()
                return Response.error()
            end):expect()

            if not var4.ok then
                callback2(string.format("Got verified-status verification HTTP Response: %d", var4.status))

                return
            end

            local var5 = var4:json():catch(function()
                return nil
            end):expect()

            if not var5 then
                callback2("Failed to decode HTTP response as JSON for get IDV Verification status")
                return
            end

            callback({
                isPending = var5.isPending,
                sessionStatus = var5.sessionStatus,
                sessionErrorCode = var5.sessionErrorCode,
                isVerified = var5.isVerified,
                ageEstimationNextStep = var5.ageEstimationNextStep
            })
        end)
    end
}
