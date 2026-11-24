-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local _UniverseConfigurationStoreTypes = require(script.Parent.UniverseConfigurationStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function summaryUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/v1/universes/%d"):format(str1, num1)
end

local function configurationUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/v1/universes/%d/configuration"):format(str1, num1)
end

local function patchConfigurationUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/v2/universes/%d/configuration"):format(str1, num1)
end

local function teamCreateUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return ("%s/v1/universes/%d/teamcreate"):format(str1, num1)
end

local function resolveBase(tbl1) -- Luacid: Inlined by compiler; 5 call sites recovered
    local tbl2 = tbl1 or {}
    return tbl2.network, tbl2.baseUrl or UrlBase.new("develop")
end

local function resolveMutatingNetwork(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (tbl1 or {}).network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
end

local module = {}

function module.fetchSummary(num1: number, tbl1)
    local network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = network,
        method = "GET",
        url = summaryUrl(var1, num1),
        analyticsKey = "universe-configuration.get-summary",
        legacy = true,
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

function module.fetchConfiguration(num1: number, tbl1)
    local network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = network,
        method = "GET",
        url = configurationUrl(var1, num1),
        analyticsKey = "universe-configuration.get-configuration",
        legacy = true,
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

function module.patchConfiguration(num1: number, body, tbl1)
    local _network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "PATCH",
        url = patchConfigurationUrl(var1, num1),
        body = body,
        analyticsKey = "universe-configuration.patch-configuration",
        legacy = true,
        decode = function(arg1)
            if arg1.studioAccessToApisAllowed ~= nil then
                arg1.isStudioAccessToApisAllowed = arg1.studioAccessToApisAllowed
            end
            return arg1
        end
    })
    return asPromise(var2)
end

function module.fetchTeamCreate(num1: number, tbl1)
    local network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = network,
        method = "GET",
        url = teamCreateUrl(var1, num1),
        analyticsKey = "universe-configuration.get-team-create",
        legacy = true,
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

function module.setTeamCreate(num1: number, isEnabled: boolean, tbl1)
    local _network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "PATCH",
        url = teamCreateUrl(var1, num1),
        body = { isEnabled = isEnabled },
        analyticsKey = "universe-configuration.set-team-create",
        legacy = true,
        decode = function(_)
            return { isEnabled = isEnabled }
        end
    })
    return asPromise(var2)
end

return module
