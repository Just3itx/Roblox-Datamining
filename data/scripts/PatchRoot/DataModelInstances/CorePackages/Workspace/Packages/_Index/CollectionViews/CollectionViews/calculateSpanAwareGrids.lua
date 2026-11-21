-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local DiscoveryTypes = require(CollectionViewsParent.DiscoveryTypes)
local DiscoveryUtils = require(CollectionViewsParent.DiscoveryUtils)
local SharedFlags = require(CollectionViewsParent.SharedFlags)

local ApportioningDiagnosticTelemetry = DiscoveryUtils.ApportioningDiagnosticTelemetry
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger
local GameCollectionItemTypes = DiscoveryTypes.GameCollectionItemTypes
local GameCollectionItemType = GameCollectionItemTypes.GameCollectionItemType
local SpanForItemType = GameCollectionItemTypes.SpanForItemType

local FFlagLuaAppEnableNxMRoduxApportioning = SharedFlags.FFlagLuaAppEnableNxMRoduxApportioning
local FFlagLuaAppEnableNxMApportioningExtraLogging = SharedFlags.FFlagLuaAppEnableNxMApportioningExtraLogging

local tbl1 = {
    [GameCollectionItemType.TwoByOneTile] = { colSpan = 2, rowSpan = 1 }
}
local function defaultGetSpanConfig(arg1): {alignmentType: number, colSpan: any, minRowPadding: number, rowSpan: any}?
    local var1 = arg1 and (if FFlagLuaAppEnableNxMRoduxApportioning then SpanForItemType[arg1.componentType] else tbl1[arg1.componentType])

    if not var1 then
        return nil
    end
    return {
        colSpan = var1.colSpan,
        rowSpan = if FFlagLuaAppEnableNxMRoduxApportioning then var1.rowSpan else 1,
        minRowPadding = tonumber(arg1.minRowPadding) or 0,
        alignmentType = arg1.alignmentType
    }
end

local function processOneGrid(tbl2, num1: number, tbl3, itemsPerRow: number, maxRows: number, func1: ((...any) -> (...any))?, bool1: boolean?)
    local totalCells = maxRows * itemsPerRow
    local placedIndices = {}
    local pendingSpanTiles = {}

    local num3 = 0
    local num4 = 1

    local tbl6 = ({})

    local function nextFreePosition(num5: number): number
        repeat
            local num6 = math.floor(num5 / itemsPerRow) + 1
            local num7 = num5 % itemsPerRow + 1
            local bool2 = not tbl6[num6] or tbl6[num6][num7] ~= -1
            if not bool2 then
                num5 += 1
            end
        until bool2
        return num5
    end

    local function writeLayoutCell(row: number, col: number, num5: number)
        if maxRows < row then
            DiscoveryEventErrorLogger.reportError(
                "CalculateSpanAwareGrids_LayoutWritePastMaxRows",
                "writeLayoutCell attempted to write past maxRows",
                { row = row, col = col, maxRows = maxRows, itemsPerRow = itemsPerRow }
            )

            return
        end
        if not tbl6[row] then
            tbl6[row] = {}
        end
        tbl6[row][col] = num5
    end

    local function tryPlaceSpanTile(originalIndex: number, tbl7)
        local colSpan = tbl7.colSpan
        local rowSpan = if FFlagLuaAppEnableNxMRoduxApportioning or bool1 then tbl7.rowSpan else nil
        local minRowPadding = tbl7.minRowPadding
        local alignmentType = tbl7.alignmentType
        local num5 = if FFlagLuaAppEnableNxMRoduxApportioning or bool1 then nextFreePosition(num3) else num3
        local var1 = if FFlagLuaAppEnableNxMRoduxApportioning or bool1 then math.floor(num5 / itemsPerRow) + 1 else math.ceil((num3 + 1) / itemsPerRow)
        local currentColumn = num5 % itemsPerRow + 1

        if var1 < num4 then
            if FFlagLuaAppEnableNxMApportioningExtraLogging then
                ApportioningDiagnosticTelemetry.log("SpanDeferred", {
                    reason = "padding_constraint",
                    originalIndex = originalIndex,
                    colSpan = colSpan,
                    rowSpan = rowSpan,
                    alignmentType = alignmentType,
                    minRowPadding = minRowPadding,
                    currentRow = var1,
                    currentColumn = currentColumn,
                    nextAllowedRow = num4,
                    nextScanPosition = num3,
                    itemsPerRow = itemsPerRow,
                    maxRows = maxRows,
                    nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                })
            end
            return false
        end

        if not (FFlagLuaAppEnableNxMRoduxApportioning or bool1) and num3 + colSpan > totalCells then
            if FFlagLuaAppEnableNxMApportioningExtraLogging then
                ApportioningDiagnosticTelemetry.log("SpanDeferred", {
                    reason = "totalcells_exceeded_legacy",
                    originalIndex = originalIndex,
                    colSpan = colSpan,
                    rowSpan = rowSpan,
                    alignmentType = alignmentType,
                    minRowPadding = minRowPadding,
                    nextScanPosition = num3,
                    totalCells = totalCells,
                    itemsPerRow = itemsPerRow,
                    maxRows = maxRows,
                    nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                })
            end
            return false
        end

        if alignmentType == "LeftPin" and currentColumn ~= 1 then
            if FFlagLuaAppEnableNxMApportioningExtraLogging then
                ApportioningDiagnosticTelemetry.log("SpanDeferred", {
                    reason = "left_pin_misaligned",
                    originalIndex = originalIndex,
                    colSpan = colSpan,
                    rowSpan = rowSpan,
                    alignmentType = alignmentType,
                    currentRow = var1,
                    currentColumn = currentColumn,
                    nextScanPosition = num3,
                    itemsPerRow = itemsPerRow,
                    maxRows = maxRows,
                    nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                })
            end
            return false
        end

        if alignmentType == "RightPin" and currentColumn + colSpan - 1 ~= itemsPerRow then
            if FFlagLuaAppEnableNxMApportioningExtraLogging then
                ApportioningDiagnosticTelemetry.log("SpanDeferred", {
                    reason = "right_pin_misaligned",
                    originalIndex = originalIndex,
                    colSpan = colSpan,
                    rowSpan = rowSpan,
                    alignmentType = alignmentType,
                    currentRow = var1,
                    currentColumn = currentColumn,
                    nextScanPosition = num3,
                    itemsPerRow = itemsPerRow,
                    maxRows = maxRows,
                    nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                })
            end
            return false
        end

        if currentColumn + colSpan - 1 > itemsPerRow then
            if FFlagLuaAppEnableNxMApportioningExtraLogging then
                ApportioningDiagnosticTelemetry.log("SpanDeferred", {
                    reason = "horizontal_wrap",
                    originalIndex = originalIndex,
                    colSpan = colSpan,
                    rowSpan = rowSpan,
                    alignmentType = alignmentType,
                    currentRow = var1,
                    currentColumn = currentColumn,
                    nextScanPosition = num3,
                    itemsPerRow = itemsPerRow,
                    maxRows = maxRows,
                    nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                })
            end
            return false
        end

        if (FFlagLuaAppEnableNxMRoduxApportioning or bool1) and var1 + rowSpan - 1 > maxRows then
            if FFlagLuaAppEnableNxMApportioningExtraLogging then
                ApportioningDiagnosticTelemetry.log("SpanDeferred", {
                    reason = "vertical_overflow",
                    originalIndex = originalIndex,
                    colSpan = colSpan,
                    rowSpan = rowSpan,
                    alignmentType = alignmentType,
                    currentRow = var1,
                    currentColumn = currentColumn,
                    nextScanPosition = num3,
                    itemsPerRow = itemsPerRow,
                    maxRows = maxRows,
                    nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                })
            end
            return false
        end

        if (FFlagLuaAppEnableNxMRoduxApportioning or bool1) and rowSpan > 1 and #tbl2 - originalIndex < currentColumn - 1 then
            if FFlagLuaAppEnableNxMApportioningExtraLogging then
                ApportioningDiagnosticTelemetry.log("SpanDeferred", {
                    reason = "insufficient_trailing_entries",
                    originalIndex = originalIndex,
                    colSpan = colSpan,
                    rowSpan = rowSpan,
                    alignmentType = alignmentType,
                    currentRow = var1,
                    currentColumn = currentColumn,
                    allEntriesCount = #tbl2,
                    nextScanPosition = num3,
                    itemsPerRow = itemsPerRow,
                    maxRows = maxRows,
                    nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                })
            end
            return false
        end

        if FFlagLuaAppEnableNxMRoduxApportioning or bool1 then
            for i = 0, rowSpan - 1 do
                for j = 0, colSpan - 1 do
                    local collidingRow = var1 + i
                    local collidingCol = currentColumn + j
                    if not tbl6[collidingRow] or tbl6[collidingRow][collidingCol] == nil then
                        continue
                    end

                    if FFlagLuaAppEnableNxMApportioningExtraLogging then
                        ApportioningDiagnosticTelemetry.log("SpanDeferred", {
                            reason = "span_cell_collision",
                            originalIndex = originalIndex,
                            colSpan = colSpan,
                            rowSpan = rowSpan,
                            alignmentType = alignmentType,
                            currentRow = var1,
                            currentColumn = currentColumn,
                            collidingRow = collidingRow,
                            collidingCol = collidingCol,
                            collidingValue = tbl6[collidingRow][collidingCol],
                            itemsPerRow = itemsPerRow,
                            maxRows = maxRows,
                            nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                        })
                    end
                    return false
                end
            end
        end

        if FFlagLuaAppEnableNxMRoduxApportioning or bool1 then
            for i = 0, rowSpan - 1 do
                for j = 0, colSpan - 1 do
                    writeLayoutCell(var1 + i, currentColumn + j, -1)
                end
            end
            writeLayoutCell(var1, currentColumn, originalIndex)
            num3 = num5 + colSpan
            num4 = var1 + rowSpan - 1 + minRowPadding
        else
            table.insert(placedIndices, originalIndex)
            num3 += colSpan
            num4 = var1 + minRowPadding
        end
        return true
    end

    local function tryPlaceDeferredSpanTiles()
        while #pendingSpanTiles > 0 do
            local var1 = pendingSpanTiles[1]
            if not tryPlaceSpanTile(var1.index, var1.spanConfig) then
                break
            end

            table.remove(pendingSpanTiles, 1)
        end
    end

    for _, value in tbl3 do
        if #pendingSpanTiles > 0 or not tryPlaceSpanTile(value.index, value.spanConfig) then
            table.insert(pendingSpanTiles, value)
        end
    end

    for i = num1, #tbl2 do
        local var1 = tbl2[i]
        if not var1 then
            DiscoveryEventErrorLogger.reportError(
                "CalculateSpanAwareGrids_InvalidEntry",
                "calculateSpanAwareGrids called with an invalid entry",
                {
                    allEntriesCount = #tbl2,
                    indexInAllEntries = i,
                    itemsPerRow = itemsPerRow
                }
            )
            num1 = i + 1
        else
            if totalCells <= num3 then
                if FFlagLuaAppEnableNxMApportioningExtraLogging then
                    ApportioningDiagnosticTelemetry.log("GridFull", {
                        nextScanPosition = num3,
                        totalCells = totalCells,
                        itemsPerRow = itemsPerRow,
                        maxRows = maxRows,
                        remainingEntries = #tbl2 - i + 1,
                        deferredCount = #pendingSpanTiles,
                        stoppedAtIndex = i,
                        allEntriesCount = #tbl2,
                        nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                    })
                end

                break
            end

            local spanConfig = if func1 ~= nil then func1(var1, i) else defaultGetSpanConfig(var1)

            if spanConfig then
                if #pendingSpanTiles > 0 or not tryPlaceSpanTile(i, spanConfig) then
                    table.insert(pendingSpanTiles, { index = i, spanConfig = spanConfig })
                end

                num1 = i + 1
            else
                if FFlagLuaAppEnableNxMRoduxApportioning or bool1 then
                    local num5 = nextFreePosition(num3)
                    if totalCells <= num5 then
                        break
                    end

                    local num6 = num5 / itemsPerRow
                    writeLayoutCell(math.floor(num6) + 1, num5 % itemsPerRow + 1, i)
                    num3 = num5 + 1
                else
                    table.insert(placedIndices, i)
                    num3 += 1
                end
                tryPlaceDeferredSpanTiles()
                num1 = i + 1
            end
        end
    end
    return {
        placedIndices = placedIndices,
        pendingSpanTiles = pendingSpanTiles,
        nextStartIndex = num1,
        layout = if FFlagLuaAppEnableNxMRoduxApportioning or bool1 then tbl6 else nil
    }
end

return {
    calculateSpanAwareGrids = function(tbl2, tbl3, itemsPerRow: number, func1: ((...any) -> (...any))?, bool1: boolean?)
        if not tbl2 then
            DiscoveryEventErrorLogger.reportError(
                "CalculateSpanAwareGrids_MissingEntries",
                "calculateSpanAwareGrids called without entries",
                {
                    gridConfigsCount = #tbl3,
                    itemsPerRow = itemsPerRow
                }
            )
            return {}
        end

        if #tbl2 == 0 then
            DiscoveryEventErrorLogger.reportError(
                "CalculateSpanAwareGrids_EmptyEntries",
                "calculateSpanAwareGrids called with empty entries",
                {
                    allEntriesCount = #tbl2,
                    gridConfigsCount = #tbl3,
                    itemsPerRow = itemsPerRow
                }
            )
            return {}
        end

        if #tbl3 == 0 then
            return {}
        end

        if not itemsPerRow then
            DiscoveryEventErrorLogger.reportError(
                "CalculateSpanAwareGrids_MissingItemsPerRow",
                "calculateSpanAwareGrids called without itemsPerRow",
                {
                    allEntriesCount = #tbl2,
                    gridConfigsCount = #tbl3
                }
            )
            return {}
        end

        if itemsPerRow <= 0 then
            DiscoveryEventErrorLogger.reportError(
                "CalculateSpanAwareGrids_InvalidItemsPerRow",
                "calculateSpanAwareGrids called with invalid itemsPerRow",
                {
                    allEntriesCount = #tbl2,
                    gridConfigsCount = #tbl3,
                    itemsPerRow = itemsPerRow
                }
            )
            return {}
        end

        local spanAwareGrids = ({})
        local num1 = 1
        local tbl4 = {}

        for _, value in tbl3 do
            local maxRows = value.maxRows
            local maxRows2 = maxRows and not (maxRows <= 0) and maxRows or math.huge

            local tbl5 = processOneGrid(tbl2, num1, tbl4, itemsPerRow, maxRows2, func1, bool1)

            local sortKey = value.sortKey
            spanAwareGrids[sortKey] = {
                entryIndices = if FFlagLuaAppEnableNxMRoduxApportioning or bool1 then nil else tbl5.placedIndices,
                layout = if FFlagLuaAppEnableNxMRoduxApportioning or bool1 then tbl5.layout else nil
            }
            num1 = tbl5.nextStartIndex
            tbl4 = tbl5.pendingSpanTiles
        end

        return spanAwareGrids
    end,
    processOneGrid = processOneGrid
}
