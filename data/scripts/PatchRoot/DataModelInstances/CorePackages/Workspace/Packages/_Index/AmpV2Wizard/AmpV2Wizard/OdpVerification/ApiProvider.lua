-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local HttpService = game:GetService("HttpService")

local UrlBuilder = require(AmpV2WizardParent.UrlBuilder).UrlBuilder
local UrlBase = require(AmpV2WizardParent.UrlBuilder).UrlBase
local Fetch = require(AmpV2WizardParent.Fetch)
local Promise = require(AmpV2WizardParent.Promise)

local _Types = require(AmpV2Wizard.OdpVerification.Types)

local fetch = Fetch.fetch
local Response = Fetch.Response

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "age-verification-service/v1/age-verification/start-odp-verification" })

return {
    startOdpVerification = function(tbl1)
        return Promise.new(function(callback, callback2)
            local var1 = fetch(urlBuilder(), {
                method = "POST",
                body = HttpService:JSONEncode({ sessionId = tbl1.sessionId, verificationType = tbl1.verificationType }),
                headers = { ["Content-Type"] = "application/json" }
            }):catch(
                function()
                    return Response.error()
                end
            ):expect()

            if not var1.ok then
                callback2(`start-odp-verification failed with status: {var1.status}`)
                return
            end

            local var2 = var1:json():catch(function()
                return nil
            end):expect()

            if not var2 then
                callback2("Failed to decode start-odp-verification response")
                return
            end

            callback({ sessionIdentifier = var2.sessionIdentifier, verificationLink = var2.verificationLink })
        end)
    end
}
