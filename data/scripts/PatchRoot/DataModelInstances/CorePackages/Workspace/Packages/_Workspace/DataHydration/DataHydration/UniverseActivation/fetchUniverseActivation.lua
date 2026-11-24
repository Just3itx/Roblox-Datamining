-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local _UniverseActivationStoreTypes = require(script.Parent.UniverseActivationStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function eligibilityUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/v1/universes/%d/activation-eligibility"):format(str1, num1)
end

local function activateUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/v1/universes/%d/activate"):format(str1, num1)
end

local function deactivateUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/v1/universes/%d/deactivate"):format(str1, num1)
end

local function v2ConfigurationUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return ("%s/v2/universes/%d/configuration"):format(str1, num1)
end

local function resolveBase(tbl1) -- Luacid: Inlined by compiler; 5 call sites recovered
    local tbl2 = tbl1 or {}
    return tbl2.network, tbl2.baseUrl or UrlBase.new("develop")
end

local function resolveMutatingNetwork(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return (tbl1 or {}).network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
end

local module = {}

function module.fetchEligibility(num1: number, tbl1)
    local network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = network,
        method = "GET",
        url = eligibilityUrl(var1, num1),
        analyticsKey = "universe-activation.get-eligibility",
        legacy = true,
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

function module.activate(num1: number, arg1, tbl1)
    local _network, var1 = resolveBase(tbl1)
    local body = {}
    if arg1 and arg1.versionId ~= nil then
        body.versionId = arg1.versionId
    end

    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "POST",
        url = activateUrl(var1, num1),
        body = body,
        analyticsKey = "universe-activation.activate",
        legacy = true,
        decode = function(_)
            return { isActive = true }
        end
    })
    return asPromise(var2)
end

function module.deactivate(num1: number, tbl1)
    local _network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "POST",
        url = deactivateUrl(var1, num1),
        body = {},
        analyticsKey = "universe-activation.deactivate",
        legacy = true,
        decode = function(_)
            return { isActive = false }
        end
    })
    return asPromise(var2)
end

function module.fetchAudiences(num1: number, tbl1)
    local network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = network,
        method = "GET",
        url = v2ConfigurationUrl(var1, num1),
        analyticsKey = "universe-activation.get-audiences",
        legacy = true,
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

function module.setAudiences(id: number, audiences, tbl1)
    local _network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "PATCH",
        url = v2ConfigurationUrl(var1, id),
        body = { audiences = audiences },
        analyticsKey = "universe-activation.set-audiences",
        legacy = true,
        decode = function(arg1): {[any]: any} | {audiences: {[any]: any}, id: number}
            return if arg1 and typeof(arg1) == "table" and arg1.audiences ~= nil then arg1 else {
                id = id,
                audiences = audiences
            }
        end
    })

    return asPromise(var2)
end

return module
