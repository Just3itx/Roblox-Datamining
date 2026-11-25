-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local Signals = require(SduiCoreSystemParent.Signals)
local CollectionViews = require(SduiCoreSystemParent.CollectionViews)

local SduiErrors = require(SduiCoreSystem.SduiErrors)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local _SduiPoolStoreTypes = require(SduiCoreSystem.ClientBinding.SduiPoolStoreTypes)
local SduiPoolStoreLayout = require(SduiCoreSystem.ClientBinding.SduiPoolStoreLayout)

local getMainCollectionLayoutStore = CollectionViews.getMainCollectionLayoutStore
local processOneGrid = CollectionViews.processOneGrid
local makePoolGetSpanConfig = SduiPoolStoreLayout.makePoolGetSpanConfig
local layoutToCells = SduiPoolStoreLayout.layoutToCells
local cellsEqual = SduiPoolStoreLayout.cellsEqual
local EMPTY_CELLS = SduiPoolStoreLayout.EMPTY_CELLS

local FFlagLuaAppEnableNxMRoduxApportioning = require(SduiCoreSystemParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning
local FFlagSduiCollectionGridRevealRows = require(SduiCoreSystemParent.SharedFlags).FFlagSduiCollectionGridRevealRows
local FFlagSduiSkipFeedAnalyticsPosition = require(SduiCoreSystemParent.SharedFlags).FFlagSduiSkipFeedAnalyticsPosition
local FFlagSduiPerSectionPoolSizing = require(SduiCoreSystemParent.SharedFlags).FFlagSduiPerSectionPoolSizing

local FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui = require(SduiCoreSystemParent.SharedFlags).FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui

local pendingSpanTiles = table.freeze({})

local function logSkipped(item, arg1, str1: string)
    local onSkipped = arg1 and arg1.onSkipped
    local oneByTwoTileFlowId = item and item.oneByTwoTileFlowId
    if not onSkipped or not item or typeof(oneByTwoTileFlowId) ~= "string" then
        return
    end

    local success, result = pcall(function()
        onSkipped({
            oneByTwoTileFlowId = oneByTwoTileFlowId,
            contentType = item.contentType,
            adId = item.adId,
            componentType = "OneByTwoTile",
            isSdui = true
        })

        return nil
    end)
    if not success then
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.CodeError,
            {
                name = "OneByTwoTileSkipped",
                message = SduiParseHelpers.stringifyValue(result)
            },
            str1
        )
    end
end

local function sectionConfigsEqual(tbl1, tbl2)
    if tbl1 == tbl2 then
        return true
    end
    if tbl1 == nil or tbl2 == nil then
        return false
    end

    local bool1

    if tbl1.poolId == tbl2.poolId and tbl1.numberOfRows == tbl2.numberOfRows then
        bool1 = (not FFlagSduiSkipFeedAnalyticsPosition or tbl1.doesNotAdvanceStartRow == tbl2.doesNotAdvanceStartRow)
            and (not FFlagSduiPerSectionPoolSizing or tbl1.entryCollectionItemSize == tbl2.entryCollectionItemSize)
            and (not FFlagSduiPerSectionPoolSizing or tbl1.templateCollectionItemSize == tbl2.templateCollectionItemSize)

        if bool1 then
            if tbl1.prevSectionInPoolId == tbl2.prevSectionInPoolId then
                bool1 = tbl1.prevSectionId == tbl2.prevSectionId
            else
                bool1 = false
            end
        end
    else
        bool1 = false
    end

    return bool1
end

local function getSectionCollectionItemSize(arg1, arg2, tbl1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local collectionItemSize = arg2.collectionItemSize

    if typeof(collectionItemSize) == "string" and arg1.getItemsPerRow[collectionItemSize] ~= nil then
        return collectionItemSize
    end

    local entryCollectionItemSize = tbl1.entryCollectionItemSize

    if typeof(entryCollectionItemSize) == "string" and arg1.getItemsPerRow[entryCollectionItemSize] ~= nil then
        return entryCollectionItemSize
    end

    local templateCollectionItemSize = tbl1.templateCollectionItemSize

    return if typeof(templateCollectionItemSize) == "string" and arg1.getItemsPerRow[templateCollectionItemSize] ~= nil then templateCollectionItemSize else "Medium"
end

local function createSduiPoolStore(str1: string?)
    local tbl1 = ({})
    local tbl2 = ({})
    local var2 = FFlagSduiCollectionGridRevealRows and {} or nil

    local tbl3 = ({})
    local tbl4 = ({})
    local var3 = FFlagSduiCollectionGridRevealRows and {} or nil

    local tbl5 = ({})
    local tbl6 = ({})

    local var4, var5 = Signals.createSignal(nil)
    local var6 = nil

    local function getOrCreatePoolSignal(str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local tbl7 = tbl1[str2]
        if tbl7 == nil then
            local get, set = Signals.createSignal(nil)
            tbl7 = { get = get, set = set }
            tbl1[str2] = tbl7
        end
        return tbl7
    end

    local function getOrCreateSectionConfigSignal(str2: string) -- Luacid: Inlined by compiler; 10 call sites recovered
        local tbl7 = tbl2[str2]
        if tbl7 == nil then
            local get, set = Signals.createSignal(nil, sectionConfigsEqual)
            tbl7 = { get = get, set = set }
            tbl2[str2] = tbl7
        end
        return tbl7
    end

    local var7 = nil
    var7 = FFlagSduiCollectionGridRevealRows and function(str2: string)
        local tbl7 = var2[str2]
        if tbl7 == nil then
            local get, set = Signals.createSignal(nil)
            tbl7 = { get = get, set = set }
            var2[str2] = tbl7
        end
        return tbl7
    end or var7

    local function func1(prevSectionInPoolId: string)
        local var8 = tbl3[prevSectionInPoolId]
        if var8 ~= nil then
            return var8
        end
        local computed = Signals.createComputed(function(arg1)
            local var9 = getOrCreateSectionConfigSignal(prevSectionInPoolId).get(arg1)
            if var9 == nil or var9.poolId == nil then
                return nil
            end
            local var10 = getOrCreatePoolSignal(var9.poolId).get(arg1)
            if var10 == nil or #var10.items == 0 then
                return nil
            end

            local var11 = var4(arg1) or getMainCollectionLayoutStore(arg1)
            local sectionCollectionItemSize = if FFlagSduiPerSectionPoolSizing then getSectionCollectionItemSize(var11, var10, var9) elseif typeof(var10.collectionItemSize) ~= "string" then "Medium" elseif var11.getItemsPerRow[var10.collectionItemSize] == nil then "Medium" else var10.collectionItemSize
            local var12 = var11.getItemsPerRow[sectionCollectionItemSize](arg1)
            if var12 <= 0 then
                return nil
            end

            local var13 = pendingSpanTiles
            local nextStartIndex

            if var9.prevSectionInPoolId == nil then
                nextStartIndex = 1
            else
                local var14 = func1(var9.prevSectionInPoolId)(arg1)
                if var14 == nil then
                    return nil
                end
                nextStartIndex = var14.nextStartIndex
                var13 = var14.pendingSpanTiles
            end

            local numberOfRows = var9.numberOfRows
            local var14 = numberOfRows <= 0 and math.huge or numberOfRows

            if var10.layouts == nil and #var13 == 0 then
                local num1 = math.max(0, #var10.items - nextStartIndex + 1)

                local num2 = math.min(if var14 == math.huge then num1 else var14 * var12, num1)
                if num2 == 0 then
                    return {
                        cells = EMPTY_CELLS,
                        actualRowCount = 0,
                        nextStartIndex = nextStartIndex,
                        pendingSpanTiles = pendingSpanTiles
                    }
                end
                local actualRowCount = math.ceil(num2 / var12)
                local cells = ({})
                for i = 0, num2 - 1 do
                    local realIndex = nextStartIndex + i
                    local num4 = i + 1
                    cells[num4] = {
                        item = var10.items[realIndex],
                        realIndex = realIndex
                    }
                end

                for i = num2 + 1, actualRowCount * var12 do
                    cells[i] = {}
                end
                return {
                    cells = cells,
                    actualRowCount = actualRowCount,
                    nextStartIndex = nextStartIndex + num2,
                    pendingSpanTiles = pendingSpanTiles
                }
            end

            local poolGetSpanConfig = if var10.layouts == nil then nil else makePoolGetSpanConfig(var10.layouts)
            local var15 = processOneGrid(
                var10.items,
                nextStartIndex,
                var13,
                var12,
                var14,
                poolGetSpanConfig,
                not FFlagLuaAppEnableNxMRoduxApportioning
            )

            local cells, actualRowCount = layoutToCells(var15.layout, var12, var10.items, var10.layouts)
            if FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui then
                local onPlaced = var6 and var6.onPlaced
                for value, value2 in cells do
                    local item = value2.item
                    local oneByTwoTileFlowId = item and item.oneByTwoTileFlowId
                    if not onPlaced or not item or typeof(oneByTwoTileFlowId) ~= "string" then
                        continue
                    end

                    local success, result = pcall(function()
                        onPlaced({
                            oneByTwoTileFlowId = oneByTwoTileFlowId,
                            contentType = item.contentType,
                            adId = item.adId,
                            componentType = "OneByTwoTile",
                            gridRow = math.ceil(value / var12),
                            gridCol = (value - 1) % var12 + 1,
                            isSdui = true
                        })

                        return nil
                    end)
                    if not success then
                        SduiLogger.reportError(
                            SduiErrors.SduiErrorType.CodeError,
                            {
                                name = "OneByTwoTilePlaced",
                                message = SduiParseHelpers.stringifyValue(result)
                            },
                            str1
                        )
                    end
                end

                local bool1 = false
                for value, value2 in tbl2 do
                    if value == prevSectionInPoolId then
                        continue
                    end

                    local var18 = value2.get(false)
                    if var18 and var18.prevSectionInPoolId == prevSectionInPoolId then
                        bool1 = true
                        break
                    end
                end

                if not bool1 then
                    for _, value in var15.pendingSpanTiles do
                        logSkipped(var10.items[value.index], var6, str1)
                    end
                    local tbl7 = ({})
                    for _, value in cells do
                        local item = value.item
                        local oneByTwoTileFlowId = item and item.oneByTwoTileFlowId
                        if typeof(oneByTwoTileFlowId) == "string" then
                            tbl7[oneByTwoTileFlowId] = true
                        end
                    end
                    for i = var15.nextStartIndex, #var10.items do
                        local item = var10.items[i]
                        local oneByTwoTileFlowId = item and item.oneByTwoTileFlowId
                        if typeof(oneByTwoTileFlowId) == "string" and not tbl7[oneByTwoTileFlowId] then
                            logSkipped(item, var6, str1)
                        end
                    end
                end
            end
            return {
                cells = cells,
                actualRowCount = actualRowCount,
                nextStartIndex = var15.nextStartIndex,
                pendingSpanTiles = var15.pendingSpanTiles
            }
        end)
        tbl3[prevSectionInPoolId] = computed
        return computed
    end

    local function getRowCountComputed(str2: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        local var8 = tbl4[str2]
        if var8 ~= nil then
            return var8
        end
        local computed = Signals.createComputed(function(arg1)
            local var9 = getOrCreateSectionConfigSignal(str2).get(arg1)
            if var9 == nil then
                return 0
            end
            if var9.poolId == nil or var9.numberOfRows > 0 then
                return var9.numberOfRows
            end
            local var10 = func1(str2)(arg1)
            return if var10 == nil then 0 else var10.actualRowCount
        end)
        tbl4[str2] = computed
        return computed
    end

    local function getDisplayedRowCountComputed(prevSectionId: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local var8 = var3[prevSectionId]
        if var8 ~= nil then
            return var8
        end
        local computed = Signals.createComputed(function(arg1)
            local var9 = getRowCountComputed(prevSectionId)(arg1)
            local var10 = var7(prevSectionId).get(arg1)
            if var10 == nil then
                return var9
            end
            return math.min(math.max(math.floor(var10), 0), var9)
        end)
        var3[prevSectionId] = computed
        return computed
    end

    local function func2(str2: string)
        local var8 = tbl5[str2]
        if var8 ~= nil then
            return var8
        end
        local computed = Signals.createComputed(function(arg1)
            local var9 = getOrCreateSectionConfigSignal(str2).get(arg1)
            if var9 == nil or var9.prevSectionId == nil then
                return 1
            end
            local var10 = func2(var9.prevSectionId)(arg1)
            local var11 = if FFlagSduiSkipFeedAnalyticsPosition then getOrCreateSectionConfigSignal(var9.prevSectionId).get(arg1) else nil
            return var10
                + (if FFlagSduiSkipFeedAnalyticsPosition and var11 ~= nil and var11.doesNotAdvanceStartRow then 0 elseif FFlagSduiCollectionGridRevealRows then getDisplayedRowCountComputed(var9.prevSectionId)(arg1) else getRowCountComputed(var9.prevSectionId)(arg1))
        end)
        tbl5[str2] = computed
        return computed
    end

    local function getSectionCells(str2: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local var8 = tbl6[str2]
        if var8 ~= nil then
            return var8
        end
        local computed = Signals.createComputed(function(arg1)
            local var9 = func1(str2)(arg1)
            return if var9 == nil then EMPTY_CELLS else var9.cells
        end, cellsEqual)
        tbl6[str2] = computed
        return computed
    end

    return {
        getSectionInfo = function(str2: string)
            return Signals.createComputed(function(arg1)
                if getOrCreateSectionConfigSignal(str2).get(arg1) == nil then
                    return nil
                end

                return {
                    cells = getSectionCells(str2)(arg1),
                    startRow = func2(str2)(arg1),
                    actualRowCount = getRowCountComputed(str2)(arg1)
                }
            end)
        end,
        getSectionStartRow = func2,
        getSectionRowCount = getRowCountComputed,
        getSectionCells = getSectionCells,
        setSectionDisplayedRowCount = FFlagSduiCollectionGridRevealRows and function(str2: string, num1: number?)
            var7(str2).set(num1)
        end or nil,
        setPools = function(tbl7)
            for value, value2 in tbl7 do
                getOrCreatePoolSignal(value).set(value2)
            end
        end,
        setSections = function(tbl7)
            local tbl8 = ({})
            local var8 = nil

            for _, value in tbl7 do
                local sectionId = value.sectionId
                local poolId = value.poolId
                local var9

                if poolId == nil then
                    var9 = nil
                else
                    var9 = tbl8[poolId]
                    tbl8[poolId] = sectionId
                end
                getOrCreateSectionConfigSignal(sectionId).set({
                    poolId = poolId,
                    numberOfRows = value.numberOfRows,
                    doesNotAdvanceStartRow = if FFlagSduiSkipFeedAnalyticsPosition then value.doesNotAdvanceStartRow else nil,
                    entryCollectionItemSize = value.entryCollectionItemSize,
                    templateCollectionItemSize = value.templateCollectionItemSize,
                    prevSectionInPoolId = var9,
                    prevSectionId = var8
                })
                var8 = sectionId
            end
        end,
        setLayoutStore = function(arg1)
            var5(arg1)
        end,
        setOneByTwoTileFunnelListener = FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui and function(arg1)
            var6 = arg1
        end or nil
    }
end

local var2 = (setmetatable({}, { __mode = "v" }))

return {
    getSduiPoolStore = function(str1: string)
        local var3 = var2[str1]
        if var3 ~= nil then
            return var3
        end

        local sduiPoolStore = if FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui then createSduiPoolStore(str1) else createSduiPoolStore()
        var2[str1] = sduiPoolStore
        return sduiPoolStore
    end
}
