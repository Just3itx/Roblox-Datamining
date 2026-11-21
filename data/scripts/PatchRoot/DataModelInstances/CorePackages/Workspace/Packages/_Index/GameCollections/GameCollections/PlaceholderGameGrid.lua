-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollections = script:FindFirstAncestor("GameCollections")
local GameCollectionsParent = GameCollections.Parent

local React = require(GameCollectionsParent.React)
local GameTileConstants = require(GameCollectionsParent.GameTile).GameTileConstants
local Responsive = require(GameCollectionsParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local useAppPolicy = require(GameCollectionsParent.UniversalAppPolicy).useAppPolicy

local CollectionViews = require(GameCollectionsParent.CollectionViews)
local CollectionGrid = CollectionViews.CollectionGrid
local useCollectionLayout = CollectionViews.useCollectionLayout
local useGetGameTileHeight = require(GameCollections.useGetGameTileHeight)
local useGameCollectionLayoutParams = require(GameCollections.useGameCollectionLayoutParams)
local getGameTileCollectionItemSize = require(GameCollectionsParent.GameTile).getGameTileCollectionItemSize
local FFlagLuaAppCompositionAlways = require(GameCollectionsParent.SharedFlags).FFlagLuaAppCompositionAlways

local tbl1 = {}

local function renderItem(_, _, _, _)
    return nil, "placeholder"
end

return React.memo(function(tbl2) -- name: PlaceholderGameGrid
    local var1 = useAppPolicy(function(arg1)
        return arg1.useGridPageLayout()
    end)
    local var2 = usePreferredInput()
    local var3 = tbl2.isHoverSupportEnabled and var1 and var2 == Responsive.Input.Pointer

    local gameTileLayoutType = tbl2.gameTileLayoutType or "Narrow"
    local var4 = FFlagLuaAppCompositionAlways or tbl2.appCompositionEnabled
    local gameTileCollectionItemSize = if var4 then getGameTileCollectionItemSize(gameTileLayoutType) else nil
    local current, containerRef = React.useState(nil)
    React.useRef(current).current = current

    local var7 = not var1 and {
        sideMargin = tbl2.sideMargin
    } or nil

    local var8 = useGameCollectionLayoutParams(gameTileLayoutType, current, false, var7)

    local itemsPerRow = useCollectionLayout(gameTileCollectionItemSize).itemsPerRow

    if not var4 then
        itemsPerRow = var8.numColumns
    end
    local shouldHideTileTitle = tbl2.shouldHideTileTitle or false
    local shouldHideTileMetadata = tbl2.shouldHideTileMetadata or false
    local containedTile = tbl2.containedTile or false
    local titleTextLines = GameTileConstants.TileTextLines[gameTileLayoutType]
        and GameTileConstants.TileTextLines[gameTileLayoutType].titleTextLines

    local getItemHeight = useGetGameTileHeight(
        var3,
        gameTileLayoutType,
        containedTile,
        shouldHideTileMetadata,
        shouldHideTileTitle,
        nil,
        nil,
        titleTextLines
    )

    if not FFlagLuaAppCompositionAlways then
        local var10 = React.useRef(0)
        React.useEffect(function()
            if var4 or var8.numColumns == var10.current then
                return
            end

            var10.current = var8.numColumns
            if tbl2.onItemsPerRowChanged then
                tbl2.onItemsPerRowChanged(var8.numColumns)
            end
        end, {
            var8.numColumns,
            tbl2.onItemsPerRowChanged,
            var10,
            var4
        })
    end

    local num1 = math.clamp(tbl2.numRows, 0, 4)

    local items = React.useMemo(function()
        local result = {}
        for _ = 1, itemsPerRow * num1 do
            table.insert(result, tbl1)
        end
        return result
    end, { itemsPerRow, num1 })

    local createElement = React.createElement
    local fragment = React.Fragment
    local var11 = nil
    local tbl3 = { GameGrid = 0 }
    local createElement2 = React.createElement
    local var12 = CollectionGrid
    local tbl4 = {
        collectionItemSize = 0,
        title = 0,
        headerComponent = 0,
        containerRef = 0,
        verticalScrollingFrameRef = 0,
        hideHeaderButton = true,
        items = 0,
        renderItem = 0,
        getItemHeight = 0,
        numColumns = 0,
        columnGap = 0,
        sideMargin = 0
    }

    if not var4 then
        gameTileCollectionItemSize = nil
    end

    tbl4.collectionItemSize = gameTileCollectionItemSize
    tbl4.title = if num1 > 0 then tbl2.title else nil
    tbl4.headerComponent = tbl2.headerComponent
    tbl4.containerRef = containerRef
    tbl4.verticalScrollingFrameRef = tbl2.verticalScrollingFrameRef

    tbl4.items = items
    tbl4.renderItem = renderItem
    tbl4.getItemHeight = getItemHeight
    tbl4.numColumns = if var4 then nil else var8.numColumns
    tbl4.columnGap = if var4 then nil else var8.columnGap
    tbl4.sideMargin = if var4 then nil else var8.sideMargin
    tbl3.GameGrid = createElement2(var12, tbl4)
    return createElement(fragment, var11, tbl3)
end)
