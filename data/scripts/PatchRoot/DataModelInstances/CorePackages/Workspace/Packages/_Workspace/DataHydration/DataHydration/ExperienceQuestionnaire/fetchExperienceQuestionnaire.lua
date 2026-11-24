-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local _ExperienceQuestionnaireStoreTypes = require(script.Parent.ExperienceQuestionnaireStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function resolveBase(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl2 = tbl1 or {}
    return tbl2.network, tbl2.baseUrl or UrlBase.APIS
end

local function resolveMutatingNetwork(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (tbl1 or {}).network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
end

local function get(tbl1, str1: string, analyticsKey: string)
    local network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = network,
        method = "GET",
        url = var1 .. "/experience-questionnaire/v1" .. str1,
        analyticsKey = analyticsKey,
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

local function post(tbl1, str1: string, body, analyticsKey: string)
    local _network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "POST",
        url = var1 .. "/experience-questionnaire/v1" .. str1,
        body = body,
        analyticsKey = analyticsKey,
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

local module = {}

function module.fetchEligibility(num1: number, tbl1)
    return get(tbl1, ("/eligibility/%d"):format(num1), "experience-questionnaire.get-eligibility")
end

function module.fetchMetadataStatus(num1: number, tbl1)
    return get(tbl1, ("/metadata/%d/status"):format(num1), "experience-questionnaire.get-metadata-status")
end

function module.fetchActiveResponse(num1: number, tbl1)
    return get(tbl1, ("/responses/%d"):format(num1), "experience-questionnaire.get-active-response")
end

function module.fetchLatestQuestionnaire(num1: number, tbl1)
    return get(tbl1, ("/questionnaires/%d/latest"):format(num1), "experience-questionnaire.get-latest-questionnaire")
end

function module.fetchQuestionnaireById(str1: string, tbl1)
    return get(tbl1, "/questionnaires/" .. str1, "experience-questionnaire.get-questionnaire-by-id")
end

function module.fetchLatestSubmission(num1: number, tbl1)
    return get(tbl1, ("/responses/%d/submissions/latest"):format(num1), "experience-questionnaire.get-latest-submission")
end

function module.saveSubmission(num1: number, body, tbl1)
    return post(tbl1, ("/responses/%d/submissions"):format(num1), body, "experience-questionnaire.save-submission")
end

function module.validateResponses(body, tbl1)
    return post(tbl1, "/responses/validate", body, "experience-questionnaire.validate-responses")
end

function module.previewSubmission(body, tbl1)
    return post(tbl1, "/responses/preview", body, "experience-questionnaire.preview-submission")
end

return module
