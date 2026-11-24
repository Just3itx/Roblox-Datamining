-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local _ShareLinkMetadataStoreTypes = require(script.Parent.ShareLinkMetadataStoreTypes)

local function normalizeId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return nil
    end
    return tostring(arg1)
end

local function fetchShareLinkMetadata(linkId: string, linkType: string, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = HttpClient.fetch({
        network = tbl2.network,
        method = "POST",
        url = (tbl2.baseUrl or UrlBase.APIS) .. "/sharelinks/v1/get-metadata",
        body = { linkId = linkId, linkType = linkType },
        analyticsKey = "share-link-metadata.get",
        decode = function(arg1)
            if arg1.data == nil then
                error("Share link metadata response is missing data")
            end
            local var1 = HttpService:JSONDecode(arg1.data)
            return {
                universeId = normalizeId(var1.universeId),
                placeId = normalizeId(var1.placeId)
            }
        end
    })
    return HttpClient.asPromise(var1)
end

return fetchShareLinkMetadata
