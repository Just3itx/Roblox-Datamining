-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:56Z
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

local function getSortedEntries(num1: number?)
    local getLastReceivedSorts = DataHydration.MarketplaceCatalogSort.getMarketplaceCatalogSortStore(false).getLastReceivedSorts
    if not getLastReceivedSorts then
        return nil
    end
    local lastReceivedSorts = getLastReceivedSorts(false)
    if not (lastReceivedSorts and next(lastReceivedSorts)) then
        return nil
    end

    local tbl1 = {}
    for id, lastReceivedSort in lastReceivedSorts do
        table.insert(tbl1, { id = id, data = lastReceivedSort })
    end
    table.sort(tbl1, function(tbl2, tbl3): boolean
        return (tbl2.data.hydrationPriority or 0) < (tbl3.data.hydrationPriority or 0)
    end)

    local tbl2

    if num1 then
        tbl2 = {}
        local num2 = #tbl1

        for i = 1, math.min(num2, num1) do
            table.insert(tbl2, tbl1[i])
        end
    else
        tbl2 = tbl1
    end

    return tbl2
end

local function collectContent(sortedEntries)
    local result = {}
    local tbl1 = {}
    for _, value in sortedEntries do
        local content = value.data.content
        if content then
            collectDedupedHydrationContent(content, result, tbl1, value.data.hydrationCount)
        end
    end

    return result
end

local function groupContentByType(tbl1)
    local result = ({})
    for _, value in tbl1 do
        local str1 = tostring(value.type)
        if not result[str1] then
            result[str1] = {}
        end
        table.insert(result[str1], value)
    end
    return result
end

local function hydrateCatalogSortEntities(callback: (...any) -> (...any), arg1, func1: (...any) -> (...any), tbl1, num1: number?)
    local sortedEntries = getSortedEntries(num1)
    if not sortedEntries then
        return Promise.resolve()
    end

    local tbl2 = collectContent(sortedEntries)
    if #tbl2 == 0 then
        return Promise.resolve()
    end

    local tbl3 = {}
    for _, value in groupContentByType(tbl2) do
        table.insert(tbl3, (tbl1.HydrateWidgetContent(arg1, value):andThen(function(arg2)
            local responseBody = if arg2 then arg2.responseBody else nil
            local hydratedContent = if responseBody then responseBody.hydratedContent else nil

            if hydratedContent == nil then
                return
            end

            local hydrationReduxPayload = buildHydrationReduxPayload(hydratedContent, value)
            callback(func1(hydrationReduxPayload))
        end):catch(function(arg2)
            Logging.warn("hydrateCatalogSortEntities: HydrateWidgetContent failed: " .. tostring(arg2))
        end)))
    end
    return Promise.allSettled(tbl3)
end

return hydrateCatalogSortEntities
