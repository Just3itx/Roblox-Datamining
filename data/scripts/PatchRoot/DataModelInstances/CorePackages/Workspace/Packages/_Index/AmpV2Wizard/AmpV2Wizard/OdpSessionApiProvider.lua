-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2WizardParent = script:FindFirstAncestor("AmpV2Wizard").Parent

local HttpService = game:GetService("HttpService")

local UrlBuilder = require(AmpV2WizardParent.UrlBuilder).UrlBuilder
local UrlBase = require(AmpV2WizardParent.UrlBuilder).UrlBase
local Promise = require(AmpV2WizardParent.Promise)

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "child-requests-api/v1/odp-requests/start-odp-session" })

local var1 = nil
local function getChallengeAwareRequest()
    if var1 == nil then
        local httpRequest = require(AmpV2WizardParent.HttpRequest)
        var1 = require(AmpV2WizardParent.GenericChallenges).Middleware.ChallengeRequestWrapper(
            httpRequest.config({
                requestFunction = function(arg1, arg2, arg3)
                    return httpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
                end
            })
        )
    end

    return var1
end

local function serializeRequest(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        requestType = tbl1.requestType,
        requestDetails = tbl1.requestDetails,
        isOdpInitiatedRequest = tbl1.isOdpInitiatedRequest == true,
        odpProfileId = tbl1.odpProfileId
    }
end

local function postForSession(str1: string, tbl1)
    return getChallengeAwareRequest()(
        str1,
        "POST",
        {
            postBody = HttpService:JSONEncode((serializeRequest(tbl1))),
            headers = { ["Content-Type"] = "application/json" }
        }
    ):andThen(
        function(arg1)
            local responseBody = arg1.responseBody
            if not responseBody or responseBody.odpSessionId == nil then
                return Promise.reject("Failed to decode ODP session response")
            end
            return {
                odpSessionId = responseBody.odpSessionId
            }
        end
    )
end

return {
    startOdpSession = function(tbl1)
        return postForSession(urlBuilder(), tbl1)
    end
}
