-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Url = require(DataHydrationParent.Http).Url
local HttpClient = require(DataHydrationParent.HttpClient)
local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder
local IXPServiceWrapper = require(DataHydrationParent.IxpServiceWrapper).IXPServiceWrapper
local AppUserLayers = require(DataHydrationParent.ExperimentLayers).AppUserLayers
local GameIconConstants = require(script.Parent.GameIconConstants)
local sizeString = GameIconConstants.sizeString

local SharedFlags = require(DataHydrationParent.SharedFlags)
local FFlagGetGameIconsFromThumbnailsDeliveryApiIxp = SharedFlags.FFlagGetGameIconsFromThumbnailsDeliveryApiIxp
local FFlagForceGetGameIconsFromThumbnailsDeliveryApi = SharedFlags.FFlagForceGetGameIconsFromThumbnailsDeliveryApi
local FIntGameIconSmallSizePx = GameIconConstants.FIntGameIconSmallSizePx

local function resolveThumbnailHost() -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagForceGetGameIconsFromThumbnailsDeliveryApi then
        return Url.THUMBNAILSDELIVERY_URL
    end

    if FFlagGetGameIconsFromThumbnailsDeliveryApiIxp then
        local layerData = IXPServiceWrapper:GetLayerData(AppUserLayers.ServeThumbnailsFromEdge)
        if layerData and layerData.get_gamesicons_from_edge then
            return Url.THUMBNAILSDELIVERY_URL
        end
    end
    return Url.THUMBNAILS_URL
end

local function fetchGameIcons(tbl1, size: string?, tbl2)
    local tbl3 = tbl2 or {}
    local addQueryString = UrlBuilder.addQueryString
    local format = string.format
    local var1 = resolveThumbnailHost()
    local url = addQueryString(
        format("%sv1/games/icons", var1),
        {
            universeIds = table.concat(tbl1, ","),
            format = "png",
            size = size or sizeString(FIntGameIconSmallSizePx)
        }
    )
    local var3 = fetch({
        network = tbl3.network,
        method = "GET",
        url = url,
        analyticsKey = "games-icons.get",
        decode = function(arg1)
            return arg1.data or {}
        end
    })
    return asPromise(var3)
end

return fetchGameIcons
