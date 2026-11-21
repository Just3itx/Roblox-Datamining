-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local Url = require(AvatarExperienceCatalogParent.Http).Url
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local normalizeWidgetListInfoResponseToWidgetListInfo = require(script.Parent.normalizeWidgetListInfoResponseToWidgetListInfo)
local constants = require(script.Parent.constants)
local _WidgetListInfo = require(AvatarExperienceCatalog.Models.WidgetListInfo)
local makeAXResponseHandler = require(AvatarExperienceCatalog.Utils.makeAXResponseHandler)

local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)

local FFlagAXAvatarTabLooksYouMayAlsoLike = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXAvatarTabLooksYouMayAlsoLike

local function getLooksFromWidgetListInfo(func1: (...any) -> (...any), requestId: string, query: string?, arg1, str1: string?)
    local var1 = if arg1 and arg1.LooksWidgetContextForOrganicContent then arg1.LooksWidgetContextForOrganicContent else "avatarTab"

    if FFlagAXAvatarTabLooksYouMayAlsoLike then
        var1 = str1 or var1
    end

    local var2 = Url:makeQueryString({ query = query, context = var1, requestId = requestId })

    local var3, var4 = func1(`{Url.APIS_URL}marketplace-widgets/v1/widgets?{var2}`, "GET")

    return makeAXResponseHandler(var3, normalizeWidgetListInfoResponseToWidgetListInfo, {
        modelMismatchCounter = constants.FETCH_WIDGET_INFO_MODEL_MISMATCH_COUNTER_NAME,
        latencyCounter = constants.FETCH_WIDGET_INFO_LATENCY_COUNTER_NAME
    }), var4
end

return getLooksFromWidgetListInfo
