-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:11Z
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
local _WidgetListBreakPointEnum = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListBreakPointEnum)
local WidgetListBreakPointSizeMap = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListBreakPointSizeMap)
local FFlagAXPassScreenSizeToWidgetApi = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXPassScreenSizeToWidgetApi

local function getWidgetListInfo(func1: (...any) -> (...any), requestId: string, context: string?, arg1)
    local var1 = Url:makeQueryString({
        requestId = requestId,
        context = context,
        screenSize = if FFlagAXPassScreenSizeToWidgetApi and arg1 then WidgetListBreakPointSizeMap[arg1] else nil
    })

    local var2, var3 = func1(`{Url.APIS_URL}marketplace-widgets/v1/widgets?{var1}`, "GET")

    return makeAXResponseHandler(var2, normalizeWidgetListInfoResponseToWidgetListInfo, {
        modelMismatchCounter = constants.FETCH_WIDGET_INFO_MODEL_MISMATCH_COUNTER_NAME,
        latencyCounter = constants.FETCH_WIDGET_INFO_LATENCY_COUNTER_NAME
    }), var3
end

return getWidgetListInfo
