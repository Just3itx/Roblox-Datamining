-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local resolveAcpUrl = require(script.Parent.Parent.Env.resolveAcpUrl)
local decodePreviewSpecs = require(script.Parent.decodePreviewSpecs)
local _PreviewSpecsTypes = require(script.Parent.PreviewSpecsTypes)

local function getDefaultBaseUrl() -- Luacid: Inlined by compiler; 1 call site recovered
    local sitetestNumber = resolveAcpUrl.resolveCreatorAgentAcp().sitetestNumber
    if sitetestNumber ~= nil then
        return `https://apis.sitetest{sitetestNumber}.robloxlabs.com`
    end
    return UrlBase.APIS
end

local function fetchPreviewSpecs(tbl1)
    local tbl2 = tbl1 or {}
    local var1 = HttpClient.fetch({
        network = tbl2.network,
        method = "GET",
        url = (tbl2.baseUrl or getDefaultBaseUrl()) .. "/build-internal-dashboard-api/v1/preview-specs",
        analyticsKey = "build-preview-specs.get",
        retry = false,
        decode = decodePreviewSpecs
    })
    return HttpClient.asPromise(var1)
end

return fetchPreviewSpecs
