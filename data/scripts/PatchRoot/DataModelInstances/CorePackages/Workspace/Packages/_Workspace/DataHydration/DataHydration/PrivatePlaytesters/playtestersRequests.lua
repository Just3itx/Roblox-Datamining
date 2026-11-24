-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function playtestersUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return ("%s/v1/universes/%d/configuration/playtesters"):format(str1, num1)
end

local function resolveBase(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local tbl2 = tbl1 or {}
    return tbl2.network, tbl2.baseUrl or UrlBase.new("develop")
end

local function resolveMutatingNetwork(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (tbl1 or {}).network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
end

local function decodePlaytesterIds(arg1)
    local result = {}
    local playtesters = if type(arg1) == "table" then arg1.playtesters else nil

    if type(playtesters) == "table" then
        for _, playtester in playtesters do
            if type(playtester) == "number" then
                table.insert(result, playtester)
            elseif type(playtester) == "table" then
                local var1 = playtester.userId or playtester.id
                if type(var1) == "number" then
                    table.insert(result, var1)
                end
            end
        end
    end
    return result
end

local module = {}

function module.fetchPlaytesters(num1: number, tbl1)
    local network, var1 = resolveBase(tbl1)
    local var2 = fetch({
        network = network,
        method = "GET",
        url = playtestersUrl(var1, num1),
        analyticsKey = "private-playtesters.fetch",
        legacy = true,
        decode = decodePlaytesterIds
    })
    return asPromise(var2)
end

function module.addPlaytester(num1: number, playtesters, tbl1)
    local _network, var1 = resolveBase(tbl1)
    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "POST",
        url = playtestersUrl(var1, num1),
        body = { playtesters = playtesters },
        analyticsKey = "private-playtesters.add",
        legacy = true,
        decode = decodePlaytesterIds
    })
    return asPromise(var2)
end

function module.removePlaytester(num1: number, num2: number, tbl1)
    local _network, var1 = resolveBase(tbl1)
    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "DELETE",
        url = playtestersUrl(var1, num1),
        body = {
            playtesters = { num2 }
        },
        analyticsKey = "private-playtesters.remove",
        legacy = true,
        decode = decodePlaytesterIds
    })
    return asPromise(var2)
end

return module
