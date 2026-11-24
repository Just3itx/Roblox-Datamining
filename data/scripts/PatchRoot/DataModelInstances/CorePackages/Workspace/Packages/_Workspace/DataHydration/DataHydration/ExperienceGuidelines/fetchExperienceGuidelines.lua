-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local _ExperienceGuidelinesStoreTypes = require(script.Parent.ExperienceGuidelinesStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local module = {}

function module.fetchDetailedGuidelines(universeId: number, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.baseUrl or UrlBase.APIS
    local var2 = fetch({
        network = tbl2.network,
        method = "POST",
        url = var1 .. "/experience-guidelines-service/v1beta1/detailed-guidelines",
        body = { universeId = universeId },
        analyticsKey = "experience-guidelines.get",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

return module
