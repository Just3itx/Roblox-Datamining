-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local _IsPrivatePlaytesterStoreTypes = require(script.Parent.IsPrivatePlaytesterStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function isPrivatePlaytesterUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/universes/v1/universes/%d/is-private-playtester"):format(str1, num1)
end

local function fetchIsPrivatePlaytester(num1: number, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.baseUrl or UrlBase.APIS

    local var2 = fetch({
        network = tbl2.network,
        method = "GET",
        url = isPrivatePlaytesterUrl(var1, num1),
        analyticsKey = "universe-private-playtester.get",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

return fetchIsPrivatePlaytester
