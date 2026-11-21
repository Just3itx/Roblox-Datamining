-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CollectionViewTypes = require(script.CollectionViewTypes)

local CollectionGrid = require(script.Grid.CollectionGrid)

local calculateSpanAwareGrids = require(script.calculateSpanAwareGrids)
local calculateSpanAwareGrids2 = calculateSpanAwareGrids.calculateSpanAwareGrids
local processOneGrid = calculateSpanAwareGrids.processOneGrid

local FFlagLuaAppLayoutParamsInContext = require(script.Parent.SharedFlags).FFlagLuaAppLayoutParamsInContext

return {
    ["jest.config"] = script["jest.config"],
    ["jest.bench.config"] = script["jest.bench.config"],
    CollectionCarousel = require(script.Carousel.CollectionCarousel),
    CollectionGrid = CollectionGrid,
    CollectionViewTypes = CollectionViewTypes,
    CollectionLayoutCalculators = require(script.CollectionLayoutCalculators),
    calculateItemWidth = require(script.calculateItemWidth),
    calculateNumColumns = require(script.calculateNumColumns),
    useCollectionLayoutParams = require(script.useCollectionLayoutParams),
    useCollectionLayoutConfig = if FFlagLuaAppLayoutParamsInContext then require(script.useCollectionLayoutConfig) else nil,
    useCollectionImpressionsSignal = require(script.useCollectionImpressionsSignal),
    usePageSideMargin = require(script.usePageSideMargin),
    useCollectionSizeBindings = require(script.useCollectionSizeBindings),
    maybeForceDarkTheme = require(script.maybeForceDarkTheme),
    CarouselScrollButtons = require(script.Carousel.CarouselScrollButtons),
    CollectionHeader = require(script.CollectionHeader),
    checkAndFormatPossibleLink = require(script.checkAndFormatPossibleLink),
    CollectionItemSize = CollectionViewTypes.CollectionItemSize,
    useCollectionLayout = require(script.CollectionLayoutStore.useCollectionLayout),
    CollectionLayoutStoreProvider = require(script.CollectionLayoutStore.CollectionLayoutStoreProvider),
    CollectionLayoutStoreContext = require(script.CollectionLayoutStore.CollectionLayoutStoreContext),
    createColumnSpanCollectionLayoutStore = require(script.CollectionLayoutStore.createColumnSpanCollectionLayoutStore),
    getItemsPerRow = require(script.CollectionLayoutStore.CollectionBreakpointConfig).getItemsPerRow,
    getMainCollectionLayoutStore = require(script.CollectionLayoutStore.getMainCollectionLayoutStore),
    calculateSpanAwareGrids = calculateSpanAwareGrids2,
    processOneGrid = processOneGrid
}
