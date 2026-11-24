-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local _CreatorEligibilityStoreTypes = require(script.Parent.CreatorEligibilityStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local module = {}

function module.fetchEligibility(num1: number, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.baseUrl or UrlBase.APIS
    local var2 = fetch({
        network = tbl2.network,
        method = "GET",
        url = ("%s/core-content/v1/creator-eligibility/%d"):format(var1, num1),
        analyticsKey = "creator-eligibility.get",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

function module.isFlagPresent(arg1, arg2): boolean
    return table.find(arg1.creatorEligibility, arg2) ~= nil
end

return module
