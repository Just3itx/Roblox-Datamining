-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local buildOrderedWidgetsFromCatalogPage = require(AvatarExperienceCatalog.Sdui.buildOrderedWidgetsFromCatalogPage)
local collectDedupedHydrationContent = require(AvatarExperienceCatalog.Sdui.Utils.collectDedupedHydrationContent)
local getCatalogConfigKey = require(AvatarExperienceCatalog.Sdui.Utils.getCatalogConfigKey)
local getCatalogPageIdentifier = require(AvatarExperienceCatalog.Sdui.Utils.getCatalogPageIdentifier)
local GetAXMarketplaceWidgetStore = require(AvatarExperienceCatalog.Stores.GetAXMarketplaceWidgetStore)
local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)

local function getCatalogPageThumbnailPrefetchItems(str1: string, num1: number, num2: number)
    local var1 = GetAXMarketplaceWidgetStore(false).getDebouncedScreenSize(false)

    local catalogPageThumbnailPrefetchItems = {}
    local tbl1 = {}
    local num3 = 0

    for _, value in (buildOrderedWidgetsFromCatalogPage(getCatalogConfigKey(str1, var1), getCatalogPageIdentifier(str1))) do
        if num1 <= num3 then
            break
        end

        if #value.content ~= 0 then
            collectDedupedHydrationContent(value.content, catalogPageThumbnailPrefetchItems, tbl1, num2)
            num3 += 1
        end
    end
    return catalogPageThumbnailPrefetchItems
end

return getCatalogPageThumbnailPrefetchItems
