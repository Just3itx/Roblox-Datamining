-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local decodeBuildSuggestionsResponse = require(script.Parent.decodeBuildSuggestionsResponse)
local getDefaultAuthHeaders = require(script.Parent.Parent.Acp.getDefaultAuthHeaders)
local resolveAcpUrl = require(script.Parent.Parent.Env.resolveAcpUrl)
local withCsrfRetry = require(DataHydration.withCsrfRetry)

local function resolveBuildSuggestionsUrl() -- Luacid: Inlined by compiler; 1 call site recovered
    local sitetestNumber = resolveAcpUrl.resolveCreatorAgentAcp().sitetestNumber
    if sitetestNumber ~= nil then
        return `https://apis.sitetest{sitetestNumber}.robloxlabs.com/creator-agents-service/v1/build/suggestions`
    end
    return UrlBase.APIS .. "/creator-agents-service/v1/build/suggestions"
end

local function requestBuildSuggestions(tbl1)
    local var1 = tbl1.getAuthHeaders or getDefaultAuthHeaders
    local selectedChip = tbl1.selectedChip ~= nil and {
        value = tbl1.selectedChip
    } or nil

    local tbl2 = {
        method = "POST",
        url = tbl1.url or resolveBuildSuggestionsUrl(),
        headers = var1(),
        body = {
            prompt = tbl1.prompt,
            selected_chip = selectedChip
        },
        network = tbl1.network or withCsrfRetry(HttpClient.createRequestInternalNetwork()),
        analyticsKey = "cas.build-suggestions",
        decode = decodeBuildSuggestionsResponse
    }
    return HttpClient.fetch(tbl2)
end

return requestBuildSuggestions
