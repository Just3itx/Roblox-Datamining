-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local _AvatarExperienceRodux = require(AvatarExperienceCatalogParent.AvatarExperienceRodux)
local DataHydration = require(AvatarExperienceCatalogParent.DataHydration)
local Promise = require(AvatarExperienceCatalogParent.Promise)
local Logging = require(AvatarExperienceCatalogParent.AppCommonLib).Logging
local _Http = require(AvatarExperienceCatalogParent.Http)
local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)
local collectDedupedHydrationContent = require(AvatarExperienceCatalog.Sdui.Utils.collectDedupedHydrationContent)
local buildHydrationReduxPayload = require(AvatarExperienceCatalog.Sdui.Utils.buildHydrationReduxPayload)

local function hydrateCatalogSortById(callback: (...any) -> (...any), arg1, func1: (...any) -> (...any), tbl1, str1: string, tbl2)
    local var1 = DataHydration.MarketplaceCatalogSort.getMarketplaceCatalogSortStore(false).getMarketplaceCatalogSort(str1)
    local var2 = if var1 and var1.data then var1.data(false) else nil

    if not (var2 and var2.content) then
        return Promise.resolve()
    end

    local tbl3 = {}
    collectDedupedHydrationContent(var2.content, tbl3, {}, nil)
    local tbl4

    if not tbl2 then
        tbl4 = tbl3
    else
        tbl4 = {}
        for _, value in tbl3 do
            local var3 = tbl2[tostring(value.type)]
            if not (var3 and var3[tostring(value.id)]) then
                table.insert(tbl4, value)
            end
        end
    end

    if #tbl4 == 0 then
        return Promise.resolve()
    end

    return tbl1.HydrateWidgetContent(arg1, tbl4):andThen(function(arg2)
        local responseBody = if arg2 then arg2.responseBody else nil
        local hydratedContent = if responseBody then responseBody.hydratedContent else nil

        if hydratedContent == nil then
            return
        end

        local hydrationReduxPayload = buildHydrationReduxPayload(hydratedContent, tbl4)
        callback(func1(hydrationReduxPayload))
    end):catch(function(arg2)
        Logging.warn("hydrateCatalogSortById: HydrateWidgetContent failed for sort " .. str1 .. ": " .. tostring(arg2))
    end)
end

return hydrateCatalogSortById
