-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local HttpService = game:GetService("HttpService")

local UrlBuilder = require(AmpV2WizardParent.UrlBuilder).UrlBuilder
local UrlBase = require(AmpV2WizardParent.UrlBuilder).UrlBase
local Fetch = require(AmpV2WizardParent.Fetch)
local Promise = require(AmpV2WizardParent.Promise)

local fetch = Fetch.fetch
local Response = Fetch.Response

local _Types = require(AmpV2Wizard.Types)

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "amp-v2-wizard-service/v1/entrypoint" })

local urlBuilder2 = UrlBuilder.new({ base = UrlBase.APIS, path = "amp-v2-wizard-service/v1/continue" })

local function postForFragment(str1: string, input)
    return Promise.new(function(callback, callback2)
        local var1 = fetch(
            str1,
            {
                method = "POST",
                body = HttpService:JSONEncode(input),
                headers = { ["Content-Type"] = "application/json" }
            }
        ):catch(
            function()
                return Response.error()
            end
        ):expect()

        if not var1.ok then
            callback2(`Wizard flow request failed with status: {var1.status}`)
            return
        end

        local var2 = var1:json():catch(function()
            return nil
        end):expect()

        if not var2 then
            callback2("Failed to decode wizard flow response as JSON")
            return
        end

        callback(var2)
    end)
end

local function serializeEntrypoint(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        target = arg1.target,
        flow = arg1.flow,
        surface = arg1.surface,
        client = arg1.client,
        extraProps = arg1.extraProps
    }
end

local function serializeContinue(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        flowId = arg1.flowId,
        state = arg1.state,
        target = arg1.target,
        rootFlow = arg1.rootFlow,
        flowInputs = arg1.flowInputs,
        history = arg1.history,
        payload = arg1.payload
    }
end

return {
    entrypoint = function(arg1)
        return postForFragment(urlBuilder(), (serializeEntrypoint(arg1)))
    end,
    continue = function(arg1)
        return postForFragment(urlBuilder2(), (serializeContinue(arg1)))
    end
}
