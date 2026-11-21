-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local DataHydration = require(AvatarExperienceCatalogParent.DataHydration)
local getSduiApiStore = require(AvatarExperienceCatalogParent.SduiSharedUtilities).getSduiApiStore

local _WidgetListInfo = require(AvatarExperienceCatalog.Models.WidgetListInfo)

local function asLegacyContent(content)
    if typeof(content) ~= "table" then
        return {}
    end
    local result = {}
    for _, value in content do
        if typeof(value) == "table" then
            table.insert(result, value)
        end
    end

    return result
end

local function buildOrderedWidgetsFromCatalogPage(str1: string, str2: string?)
    local orderedWidgetsFromCatalogPage = {}

    local var1 = getSduiApiStore().getInputData(str1, str2)
    if typeof(var1) ~= "table" then
        return orderedWidgetsFromCatalogPage
    end

    local entryOrder = var1.entry_order
    local entryMap = var1.entry_map
    if typeof(entryOrder) ~= "table" or typeof(entryMap) ~= "table" then
        return orderedWidgetsFromCatalogPage
    end

    local marketplaceCatalogSortStore = DataHydration.MarketplaceCatalogSort.getMarketplaceCatalogSortStore(false)

    for _, value in entryOrder do
        if typeof(value) ~= "string" or value == "" then
            continue
        end

        local var2 = entryMap[value]
        if typeof(var2) ~= "table" then
            continue
        end

        local value2 = if typeof(var2.input_data) == "table"
            and typeof(var2.input_data.kind) == "table"
            and typeof(var2.input_data.kind.value) == "table" then var2.input_data.kind.value else nil
        local id = if typeof(value2) == "table" and typeof(value2.id) == "string" then value2.id else nil

        if id == nil or id == "" then
            continue
        end

        local marketplaceCatalogSort = marketplaceCatalogSortStore.getMarketplaceCatalogSort(id)
        local var3 = if marketplaceCatalogSort and marketplaceCatalogSort.data then marketplaceCatalogSort.data(false) else nil

        if var3 then
            table.insert(
                orderedWidgetsFromCatalogPage,
                {
                    id = id,
                    type = var3.type,
                    tagId = var3.tagId,
                    content = asLegacyContent(var3.content)
                }
            )
        else
            table.insert(orderedWidgetsFromCatalogPage, { id = id, type = nil, tagId = nil, content = {} })
        end
    end

    return orderedWidgetsFromCatalogPage
end

return buildOrderedWidgetsFromCatalogPage
