-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local HttpService = game:GetService("HttpService")

local DataHydration = require(AvatarExperienceCatalogParent.DataHydration)
local Logging = require(AvatarExperienceCatalogParent.AppCommonLib).Logging

local FFlagSduiMarketplaceCatalogSortSupport = require(AvatarExperienceCatalogParent.SharedFlags).FFlagSduiMarketplaceCatalogSortSupport
local FFlagAXSduiSeeAllPageRequestId = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXSduiSeeAllPageRequestId

local _WidgetListInfo = require(AvatarExperienceCatalog.Models.WidgetListInfo)

local function mapCardFootersToItemFooters(cardFooters)
    if not cardFooters then
        return nil
    end
    local result = {}
    for _, cardFooter in cardFooters do
        table.insert(result, { contentType = cardFooter.contentType })
    end
    return result
end

local function mapCardStyle(cardStyle): {thumbnailAspectRatio: any}? -- Luacid: Inlined by compiler; 1 call site recovered
    return if cardStyle then {
        thumbnailAspectRatio = cardStyle.thumbnailAspectRatio
    } else nil
end

local function buildTemplate(arg1, tbl1)
    return {
        type = "ItemGroup",
        title = nil,
        localizedTitle = tbl1.title or arg1.title,
        description = nil,
        localizedDescription = tbl1.description or arg1.description,
        itemFooters = mapCardFootersToItemFooters(arg1.cardFooters),
        cardStyle = mapCardStyle(arg1.cardStyle),
        previewColumns = arg1.previewColumns and {
            default = arg1.previewColumns
        } or nil,
        previewRows = { default = 1 }
    }
end

local function buildFocusedSortWidgetInfo(id: string, str2: string, tbl1, requestId: string?): {requestId: number, widgetInfo: {[any]: any}}?
    if id == nil or id == "" then
        Logging.warn("buildFocusedSortWidgetInfo: missing sortId; bailing")
        return nil
    end
    if str2 == nil or str2 == "" then
        Logging.warn("buildFocusedSortWidgetInfo: missing context for sortId=" .. id .. "; bailing")
        return nil
    end
    local marketplaceCatalogSortStore = DataHydration.MarketplaceCatalogSort.getMarketplaceCatalogSortStore(false)
    local var1 = if FFlagSduiMarketplaceCatalogSortSupport then marketplaceCatalogSortStore.getNormalizedMarketplaceCatalogSort(id) else marketplaceCatalogSortStore.getMarketplaceCatalogSort(id)
    local var2 = if var1 and var1.data then var1.data(false) else nil

    if not var2 then
        Logging.warn("buildFocusedSortWidgetInfo: sort not in cache for sortId=" .. id .. " context=" .. str2)
        return nil
    end

    local tbl2 = {
        widgetInfo = {
            [str2] = {
                id = id,
                type = var2.type,
                content = var2.content,
                template = buildTemplate(var2, tbl1),
                tagId = var2.tagId
            }
        },
        requestId = 0
    }

    if not FFlagAXSduiSeeAllPageRequestId or requestId == nil or requestId == "" then
        requestId = HttpService:GenerateGUID(true)
    end

    tbl2.requestId = requestId
    return tbl2
end

return buildFocusedSortWidgetInfo
