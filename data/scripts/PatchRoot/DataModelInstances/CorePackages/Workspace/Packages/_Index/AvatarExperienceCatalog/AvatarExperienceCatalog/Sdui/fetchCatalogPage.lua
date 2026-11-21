-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local Promise = require(AvatarExperienceCatalogParent.Promise)
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)
local SduiSharedUtilities = require(AvatarExperienceCatalogParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local SduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
local AvatarScreen = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation).Enums.AvatarScreen

local FFlagAXFetchCatalogPageReturnsPromise = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXFetchCatalogPageReturnsPromise

local getCatalogPageUrl = require(script.Parent.Utils.getCatalogPageUrl)
local getCatalogConfigKey = require(script.Parent.Utils.getCatalogConfigKey)
local normalizeScreenSizeForWire = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Utils.normalizeScreenSizeForWire

local function fetchCatalogPage(tbl1, loadTimer, tbl2)
    local marketplaceCatalogPage = require(AvatarExperienceCatalogParent.ServiceContractsProto).apppageplatform.marketplacecatalog.marketplace_catalog_page

    local body = table.clone(tbl1)
    body.screenSize = normalizeScreenSizeForWire(tbl1.screenSize)
    local bool1 = not (tbl2 == nil) and tbl2.forceRefresh == true
    local var2 = getSduiApiStore().fetchIfNeeded({
        responseType = SduiResponseType.Protobuf,
        url = getCatalogPageUrl(),
        surfaceKey = AvatarScreen.Catalog,
        configKey = getCatalogConfigKey(body.context, body.screenSize),
        loadTimer = loadTimer,
        apiProto = marketplaceCatalogPage.MarketplaceCatalogPageResponse,
        postConfig = {
            body = body,
            contentType = SduiApiStorePostConfigContentType.Json
        }
    }, bool1)

    if FFlagAXFetchCatalogPageReturnsPromise then
        return var2 or Promise.resolve()
    end

    return nil
end

return fetchCatalogPage
