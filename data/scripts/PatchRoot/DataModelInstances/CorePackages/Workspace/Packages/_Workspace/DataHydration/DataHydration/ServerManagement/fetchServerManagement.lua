-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local _ServerManagementStoreTypes = require(script.Parent.ServerManagementStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function resolveBase(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local tbl2 = tbl1 or {}
    return tbl2.network, tbl2.baseUrl or UrlBase.APIS
end

local function resolveMutatingNetwork(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (tbl1 or {}).network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
end

local module = {}

function module.fetchListRestartStatuses(num1: number, tbl1)
    local network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = network,
        method = "GET",
        url = ("%s%s/universes/%d/restarts"):format(var1, "/server-management/v1", num1),
        analyticsKey = "server-management.list-restart-statuses",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

function module.fetchForecastRestart(num1: number, tbl1)
    local network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = network,
        method = "GET",
        url = ("%s%s/universes/%d/restarts:forecast"):format(var1, "/server-management/v1", num1),
        analyticsKey = "server-management.forecast-restart",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

function module.launchRestart(num1: number, body, tbl1)
    local _network, var1 = resolveBase(tbl1)

    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "POST",
        url = ("%s%s/universes/%d/restarts"):format(var1, "/server-management/v1", num1),
        body = body or {},
        analyticsKey = "server-management.launch-restart",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

return module
