-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollections = script:FindFirstAncestor("GameCollections")
local GameCollectionsParent = GameCollections.Parent

local GameCollectionItemTypes = require(GameCollectionsParent.DiscoveryTypes).GameCollectionItemTypes

local calculateGridLayout = require(GameCollections.calculateGridLayout)
local renderEmphasisTile = require(GameCollections.renderEmphasisTile)
local SponsoredTiles = require(GameCollectionsParent.SponsoredTiles)
local renderTwoByOneTile = SponsoredTiles.renderTwoByOneTile
local renderOneByTwoTile = SponsoredTiles.renderOneByTwoTile
local renderBlankTile = require(GameCollections.renderBlankTile)
local Cryo = require(GameCollectionsParent.Cryo)
local _React = require(GameCollectionsParent.React)
local GridLayoutTelemetry = require(GameCollections.GridLayoutTelemetry)
local DiscoveryEventErrorLogger = require(GameCollectionsParent.DiscoveryUtils).DiscoveryEventErrorLogger
local ApportioningDiagnosticTelemetry = require(GameCollectionsParent.DiscoveryUtils).ApportioningDiagnosticTelemetry

local SharedFlags = require(GameCollectionsParent.SharedFlags)
local FFlagLuaAppEnableNxMRoduxApportioning = SharedFlags.FFlagLuaAppEnableNxMRoduxApportioning
local FFlagLuaAppEnableNxMApportioningExtraLogging = SharedFlags.FFlagLuaAppEnableNxMApportioningExtraLogging

local tbl1 = {
    [GameCollectionItemTypes.GameCollectionItemType.EmphasisTile] = renderEmphasisTile,
    [GameCollectionItemTypes.GameCollectionItemType.TwoByOneTile] = renderTwoByOneTile,
    [GameCollectionItemTypes.GameCollectionItemType.Blank] = renderBlankTile
}

if FFlagLuaAppEnableNxMRoduxApportioning then
    tbl1[GameCollectionItemTypes.GameCollectionItemType.OneByTwoTile] = renderOneByTwoTile
end

local SpanForItemType = if FFlagLuaAppEnableNxMRoduxApportioning then GameCollectionItemTypes.SpanForItemType else nil
local module = {}

function module.BuildCollectionEntries(tbl2, itemsPerRow: number, tbl3, tbl4, bool1: boolean?, pageContext: string, sortIndex: number?, topicId: string?, tbl5)
    local collectionEntries = {}

    if FFlagLuaAppEnableNxMRoduxApportioning then
        tbl4 = {}
        tbl3 = {}
        for value, value2 in tbl2 do
            if not (value2 and value2.componentType) then
                continue
            end

            if tbl1[value2.componentType] then
                tbl4[value] = value2.componentType
            end
            local var1 = SpanForItemType[value2.componentType]
            if not var1 then
                continue
            end

            local tbl6 = {
                colSpan = var1.colSpan,
                rowSpan = var1.rowSpan,
                alignmentType = value2.alignmentType,
                minRowPadding = tonumber(value2.minRowPadding) or 0
            }
            tbl3[value] = tbl6
        end
    end

    local totalCols = nil
    local totalRows

    if FFlagLuaAppEnableNxMRoduxApportioning and tbl5 then
        totalRows = #tbl5
    else
        if FFlagLuaAppEnableNxMApportioningExtraLogging and tbl3 then
            local num1 = 0
            local num2 = 0
            local num3 = 0
            for value, _ in tbl3 do
                num1 += 1
                if num3 < value then
                    num3 = value
                end

                if #tbl2 < value then
                    num2 += 1
                end
            end
            if num2 > 0 then
                ApportioningDiagnosticTelemetry.log("LegacySpanOverridesMismatch", {
                    entriesCount = #tbl2,
                    itemsPerRow = itemsPerRow,
                    spanOverrideCount = num1,
                    spanOverrideOutOfRangeCount = num2,
                    spanOverrideMaxKey = num3,
                    pageContext = pageContext,
                    sortIndex = sortIndex,
                    topicId = topicId,
                    nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
                })
            end
        end
        local gridLayout = calculateGridLayout(#tbl2, itemsPerRow, tbl3)
        tbl5 = gridLayout.layout
        totalRows = gridLayout.totalRows
        totalCols = gridLayout.totalCols
    end
    local tbl6 = ({})

    local var1 = FFlagLuaAppEnableNxMApportioningExtraLogging and {
        realTileCount = 0,
        blankStaleCount = 0,
        blankShadowOrEmptyCount = 0
    }
        or nil

    for i = 1, totalRows do
        for j = 1, itemsPerRow do
            local entryIndex = tbl5[i] and tbl5[i][j]
            if entryIndex and entryIndex > 0 then
                local var3 = if tbl4 then tbl4[entryIndex] or nil else nil
                local var4 = if FFlagLuaAppEnableNxMRoduxApportioning then tbl2[entryIndex] else nil

                if var3 then
                    tbl6[entryIndex] = true

                    if FFlagLuaAppEnableNxMRoduxApportioning then
                        local num1 = #collectionEntries + 1
                        GridLayoutTelemetry.logTilePlaced(
                            var4 and var4.adId,
                            var4 and var4.universeId,
                            var3,
                            pageContext,
                            itemsPerRow,
                            totalRows,
                            entryIndex,
                            num1,
                            sortIndex,
                            topicId,
                            nil
                        )
                    else
                        local var5 = tbl2[entryIndex]

                        local num1 = #collectionEntries + 1
                        GridLayoutTelemetry.logTilePlaced(
                            var5 and var5.adId,
                            var5 and var5.universeId,
                            var3,
                            pageContext,
                            itemsPerRow,
                            totalRows,
                            entryIndex,
                            num1,
                            sortIndex,
                            topicId,
                            totalCols
                        )
                    end
                end

                if FFlagLuaAppEnableNxMRoduxApportioning and not var4 then
                    DiscoveryEventErrorLogger.reportError(
                        "GameCollectionItemBuilder_StaleLayoutEntry",
                        "layout entryIndex points past end of entries",
                        {
                            entryIndex = entryIndex,
                            entriesCount = #tbl2,
                            pageContext = pageContext,
                            sortIndex = sortIndex,
                            topicId = topicId
                        }
                    )
                    table.insert(collectionEntries, {
                        gameCollectionItemTypeOverride = GameCollectionItemTypes.GameCollectionItemType.Blank,
                        customRenderFunction = renderBlankTile
                    })
                    if FFlagLuaAppEnableNxMApportioningExtraLogging and var1 then
                        var1.blankStaleCount += 1
                    end
                else
                    local join = Cryo.Dictionary.join
                    if not FFlagLuaAppEnableNxMRoduxApportioning then
                        var4 = tbl2[entryIndex]
                    end

                    table.insert(
                        collectionEntries,
                        join(var4, {
                            spanOverride = if tbl3 then tbl3[entryIndex] or nil else nil,
                            gameCollectionItemTypeOverride = var3,
                            tileType = var3 or GameCollectionItemTypes.GameCollectionItemType.GameTile,
                            showDescription = var3 == GameCollectionItemTypes.GameCollectionItemType.EmphasisTile and bool1 or nil,
                            customRenderFunction = var3 and tbl1[var3] or nil
                        })
                    )

                    if FFlagLuaAppEnableNxMApportioningExtraLogging and var1 then
                        var1.realTileCount += 1
                    end
                end
            else
                table.insert(collectionEntries, {
                    gameCollectionItemTypeOverride = GameCollectionItemTypes.GameCollectionItemType.Blank,
                    customRenderFunction = renderBlankTile
                })
                if FFlagLuaAppEnableNxMApportioningExtraLogging and var1 then
                    var1.blankShadowOrEmptyCount += 1
                end
            end
        end
    end

    if FFlagLuaAppEnableNxMApportioningExtraLogging and var1 then
        ApportioningDiagnosticTelemetry.log("DerivedEntriesComposed", {
            realTileCount = var1.realTileCount,
            blankStaleCount = var1.blankStaleCount,
            blankShadowOrEmptyCount = var1.blankShadowOrEmptyCount,
            entriesCount = #tbl2,
            totalRows = totalRows,
            totalCols = totalCols,
            itemsPerRow = itemsPerRow,
            pageContext = pageContext,
            sortIndex = sortIndex,
            topicId = topicId,
            nxmApportioningFlagValue = FFlagLuaAppEnableNxMRoduxApportioning
        })
    end

    if tbl4 then
        for value, value2 in tbl4 do
            if not tbl6[value] then
                local var2 = tbl2[value]
                GridLayoutTelemetry.logTileSkipped(
                    var2 and var2.adId,
                    var2 and var2.universeId,
                    value2,
                    pageContext,
                    itemsPerRow,
                    totalRows,
                    value,
                    sortIndex,
                    topicId
                )
            end
        end
    end

    return collectionEntries
end

return module
