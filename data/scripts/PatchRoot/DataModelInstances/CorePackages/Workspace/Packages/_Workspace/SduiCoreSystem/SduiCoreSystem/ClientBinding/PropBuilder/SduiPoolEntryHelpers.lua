-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _Signals = require(SduiCoreSystemParent.Signals)

local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local SduiPoolStore = require(SduiCoreSystem.ClientBinding.SduiPoolStore)
local _SduiPoolStoreTypes = require(SduiCoreSystem.ClientBinding.SduiPoolStoreTypes)
local _SduiListEntryNormalizer = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiListEntryNormalizer)
local SduiListEntryRenderer = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiListEntryRenderer)
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)
local analyticsConstants = require(SduiCoreSystem.Analytics.analyticsConstants)

local FFlagSduiCollectionGridRevealRows = require(SduiCoreSystemParent.SharedFlags).FFlagSduiCollectionGridRevealRows
local FFlagSduiSkipFeedAnalyticsPosition = require(SduiCoreSystemParent.SharedFlags).FFlagSduiSkipFeedAnalyticsPosition
local FFlagSduiPerSectionPoolSizing = require(SduiCoreSystemParent.SharedFlags).FFlagSduiPerSectionPoolSizing

local FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui = require(SduiCoreSystemParent.SharedFlags).FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui
local FFlagSduiSamePoolFeedItemSpacing = require(SduiCoreSystemParent.SharedFlags).FFlagSduiSamePoolFeedItemSpacing

local var1 = FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui and {} or nil

local function getOneByTwoTileFlowId(arg1, arg2, tbl1, kind)
    local nativeAdData = tbl1.native_ad_data
    local var2 = string.format(
        "%s:%s:%s:%s",
        tostring(arg1),
        tostring(arg2),
        tostring(tbl1.universe_id or ""),
        if typeof(nativeAdData) ~= "string" then "" else nativeAdData
    )
    local var3 = var1[var2]
    if var3 == nil then
        var3 = HttpService:GenerateGUID(false):lower()
        var1[var2] = var3
    end
    if typeof(nativeAdData) ~= "string" or nativeAdData == "" then
        nativeAdData = nil
    end

    local type = kind and kind.type
    return var3, nativeAdData, if type == "universe" then "Game" elseif type == "ad_link" then "AdLink" else nil
end

local var2 = FFlagSduiSkipFeedAnalyticsPosition and function(arg1): boolean
    if typeof(arg1) ~= "table" then
        return false
    end
    local value = arg1.kind and arg1.kind.value
    local shared = value and value.shared
    local analyticsData = shared and shared.analytics_data
    local var2 = analyticsData and analyticsData[analyticsConstants.DoesNotAdvanceStartRow]
    local kind = var2 and var2.kind
    return kind ~= nil and kind.type == "literal" and kind.value == "true"
end or nil

local function normalizePoolData(tbl1)
    if tbl1 == nil or next(tbl1) == nil then
        return nil
    end
    local result = ({})
    for value, value2 in tbl1 do
        local items = ({})
        local tbl3 = ({})
        local bool1 = false
        if typeof(value2.items) == "table" then
            for k, item in value2.items do
                if typeof(item) ~= "table" then
                    continue
                end

                local kind = item.kind
                local value3 = if typeof(kind) == "table" then kind.value else nil

                if typeof(value3) == "table" then
                    items[k] = value3
                end
                local layout = item.layout
                if typeof(layout) ~= "table" then
                    continue
                end

                local colSpan = layout.colSpan or layout.col_span
                local rowSpan = layout.rowSpan or layout.row_span
                local alignmentType = layout.alignmentType or layout.alignment_type
                local minRowPadding = tonumber(layout.minRowPadding or layout.min_row_padding)

                if (colSpan == nil or colSpan == 1)
                    and (rowSpan == nil or rowSpan == 1)
                    and (alignmentType == nil or alignmentType == "")
                    and (minRowPadding == nil or not (minRowPadding > 0))
                then
                    continue
                end

                tbl3[k] = {
                    colSpan = colSpan,
                    rowSpan = rowSpan,
                    alignmentType = alignmentType,
                    minRowPadding = minRowPadding
                }
                bool1 = true

                if not FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui
                    or typeof(value3) ~= "table"
                    or (colSpan or 1) ~= 1
                    or (rowSpan or 1) ~= 2
                then
                    continue
                end
                local oneByTwoTileFlowId, adId, contentType = getOneByTwoTileFlowId(value, k, value3, kind)
                local var10 = table.clone(value3)
                var10.oneByTwoTileFlowId = oneByTwoTileFlowId
                if adId ~= nil then
                    var10.adId = adId
                end
                if contentType ~= nil then
                    var10.contentType = contentType
                end
                items[k] = var10
            end
        end

        local collectionItemSize = value2.collection_item_size

        if typeof(collectionItemSize) ~= "string" or collectionItemSize == "" then
            collectionItemSize = nil
        end

        local tbl4 = { items = items, layouts = 0, collectionItemSize = 0 }
        if not bool1 then
            tbl3 = nil
        end

        tbl4.layouts = tbl3
        tbl4.collectionItemSize = collectionItemSize
        result[value] = tbl4
    end

    return result
end

local function poolSectionFromEntry(arg1, tbl1): {continuesPreviousSection: number, doesNotAdvanceStartRow: number, entryCollectionItemSize: number, numberOfRows: any, poolId: any, sectionId: string, templateCollectionItemSize: number}?
    local identifier = arg1.identifier
    if typeof(identifier) ~= "string" then
        return nil
    end

    local collectionItemSize = nil
    local var3 = nil
    local item = arg1.item
    local poolId, maxVisibleRows

    if typeof(item) == "table" then
        local inputData = item.input_data
        if inputData and inputData.kind and inputData.kind.value then
            item = inputData.kind.value
        end
        poolId = item.pool_id
        maxVisibleRows = item.max_visible_rows
        if FFlagSduiPerSectionPoolSizing then
            if typeof(item.collection_item_size) == "string" and item.collection_item_size ~= "" then
                collectionItemSize = item.collection_item_size
            else
                collectionItemSize = nil
            end
        end
        if FFlagSduiSamePoolFeedItemSpacing then
            if item.continues_previous_section == true then
                var3 = true
            else
                var3 = nil
            end
        end
    else
        poolId = nil
        maxVisibleRows = nil
    end

    local collectionItemSize2 = nil
    if FFlagSduiPerSectionPoolSizing and poolId ~= nil and tbl1 ~= nil then
        local var4 = tbl1[poolId]
        if var4 ~= nil then
            collectionItemSize2 = var4.collectionItemSize
        end
    end

    local numberOfRows = if maxVisibleRows == -1 and poolId ~= nil then -1 elseif typeof(maxVisibleRows) ~= "number" or not (maxVisibleRows > 0) then 1 else maxVisibleRows
    local var5 = if FFlagSduiSkipFeedAnalyticsPosition then var2(arg1.template) else nil
    local tbl2 = {
        sectionId = identifier,
        poolId = poolId,
        numberOfRows = numberOfRows,
        doesNotAdvanceStartRow = 0,
        entryCollectionItemSize = 0,
        templateCollectionItemSize = 0,
        continuesPreviousSection = 0
    }

    if not FFlagSduiSkipFeedAnalyticsPosition then
        var5 = nil
    end

    tbl2.doesNotAdvanceStartRow = var5
    if not FFlagSduiPerSectionPoolSizing then
        collectionItemSize = nil
    end

    tbl2.entryCollectionItemSize = collectionItemSize
    if not FFlagSduiPerSectionPoolSizing then
        collectionItemSize2 = nil
    end

    tbl2.templateCollectionItemSize = collectionItemSize2
    if not FFlagSduiSamePoolFeedItemSpacing then
        var3 = nil
    end

    tbl2.continuesPreviousSection = var3
    return tbl2
end

local function applyPoolEntryConfigs(tbl1, tbl2)
    if FFlagSduiPerSectionPoolSizing or tbl2 == nil then
        return
    end
    for value, value2 in tbl2 do
        local var3 = tbl1[value]
        if var3 ~= nil and var3.collectionItemSize == nil and value2.collectionItemSize ~= nil then
            var3.collectionItemSize = value2.collectionItemSize
        end
    end
end

local function ingestPoolSections(tbl1, tbl2, arg1, tbl3)
    local configKey = arg1.configKey
    if configKey == nil or #tbl1 == 0 then
        return nil
    end
    local sduiPoolStore = SduiPoolStore.getSduiPoolStore(configKey)
    sduiPoolStore.setSections(tbl1)
    local var3 = if tbl2 == nil then nil else normalizePoolData(tbl2)

    if var3 ~= nil then
        applyPoolEntryConfigs(var3, tbl3)
        sduiPoolStore.setPools(var3)
    end
    return sduiPoolStore
end

return {
    resolvePoolDataGetter = function(str1: string?, arg1, arg2, arg3)
        if str1 == nil or str1 == "" then
            return nil
        end
        local var3 = SduiPropUtils.generateDynamicBindingPropValue(str1, arg1, arg2, arg3)

        return function(arg4)
            return var3(arg4).data
        end
    end,
    buildPoolEntryConfigs = function(arg1)
        if typeof(arg1) ~= "table" then
            return nil
        end
        local entries = arg1.entries
        if typeof(entries) ~= "table" then
            return nil
        end
        local tbl1 = ({})
        local bool1 = false
        for value, value2 in entries do
            if typeof(value) ~= "string" or typeof(value2) ~= "table" then
                continue
            end

            local collectionItemSize = value2.collection_item_size
            if typeof(collectionItemSize) ~= "string" or collectionItemSize == "" then
                collectionItemSize = nil
            end

            if collectionItemSize ~= nil then
                tbl1[value] = { collectionItemSize = collectionItemSize }
                bool1 = true
            end
        end

        return if bool1 then tbl1 else nil
    end,
    applyPoolEntryConfigs = applyPoolEntryConfigs,
    normalizePoolData = normalizePoolData,
    getOneByTwoTileFlowIdsFromPools = FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui and function(tbl1) -- name: getOneByTwoTileFlowIdsFromPools
        local oneByTwoTileFlowIdsFromPools = {}
        if tbl1 == nil then
            return oneByTwoTileFlowIdsFromPools
        end
        for value, value2 in tbl1 do
            if typeof(value2) ~= "table" then
                continue
            end

            for value3, value4 in value2.items or {} do
                if typeof(value4) ~= "table" then
                    continue
                end

                local kind = value4.kind
                local value5 = kind and kind.value
                local layout = value4.layout
                if typeof(value5) ~= "table"
                    or typeof(layout) ~= "table"
                    or (layout.col_span or layout.colSpan or 1) ~= 1
                    or (layout.row_span or layout.rowSpan or 1) ~= 2
                then
                    continue
                end
                local oneByTwoTileFlowId, adId, contentType = getOneByTwoTileFlowId(value, value3, value5, kind)
                table.insert(oneByTwoTileFlowIdsFromPools, {
                    oneByTwoTileFlowId = oneByTwoTileFlowId,
                    contentType = contentType,
                    adId = adId,
                    alignmentType = layout.alignment_type or layout.alignmentType
                })
            end
        end

        return oneByTwoTileFlowIdsFromPools
    end or nil,
    poolSectionFromEntry = poolSectionFromEntry,
    computePoolSections = function(tbl1, tbl2)
        local result = {}
        for _, value in tbl1 do
            local var3 = poolSectionFromEntry(value, if FFlagSduiPerSectionPoolSizing then tbl2 else nil)
            if var3 ~= nil then
                table.insert(result, var3)
            end
        end
        return result
    end,
    sectionsHaveMultiRow = function(tbl1)
        for _, value in tbl1 do
            if value.numberOfRows ~= 1 then
                return true
            end
        end
        return false
    end,
    ingestPoolSections = ingestPoolSections,
    createPoolEntryFns = function(tbl1, arg1, arg2, arg3, arg4, tbl2, tbl3)
        local var3 = ingestPoolSections(tbl1, tbl2, arg3, tbl3)
        local var4, func1

        if var3 == nil then
            var4 = nil
            func1 = nil
        else
            local tbl4 = {}
            for _, value in tbl1 do
                if value.poolId ~= nil then
                    tbl4[value.sectionId] = true
                end
            end

            local tbl5 = {}
            if FFlagSduiSamePoolFeedItemSpacing then
                for _, value in tbl1 do
                    if value.continuesPreviousSection then
                        tbl5[value.sectionId] = true
                    end
                end
            end

            func1 = function(arg5, _): {_requiresDataBinding: boolean, continuesPreviousSection: number, numberOfRowsGetter: any, setDisplayedRowCount: ((number?) -> ())?, startRowGetter: any}?
                local identifier = arg5.identifier
                if typeof(identifier) ~= "string" then
                    return nil
                end
                return {
                    startRowGetter = var3.getSectionStartRow(identifier),
                    numberOfRowsGetter = var3.getSectionRowCount(identifier),
                    setDisplayedRowCount = FFlagSduiCollectionGridRevealRows and function(num1: number?)
                        var3.setSectionDisplayedRowCount(identifier, num1)
                    end or nil,
                    continuesPreviousSection = if FFlagSduiSamePoolFeedItemSpacing then tbl5[identifier] else nil,
                    _requiresDataBinding = true
                }
            end

            var4 = function(arg5): {_section: {cells: any}}?
                local identifier = arg5.identifier
                return if typeof(identifier) == "string" and tbl4[identifier] then {
                    _section = {
                        cells = var3.getSectionCells(identifier)
                    }
                } else nil
            end
        end

        return {
            inputSlicer = SduiListEntryRenderer.createInputSlicer(arg1, arg2, arg3, arg4, var4),
            entryConfigExtrasFn = func1
        }
    end
}
