-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollections = script:FindFirstAncestor("GameCollections")
local GameCollectionsParent = GameCollections.Parent

local _Style = require(GameCollectionsParent.Style)
local CollectionViews = require(GameCollectionsParent.CollectionViews)
local GameCollectionLayoutCalculators = require(GameCollections.GameCollectionLayoutCalculators)
local CollectionItemSize = CollectionViews.CollectionViewTypes.CollectionItemSize
local useCollectionLayoutParams = CollectionViews.useCollectionLayoutParams
local GameTileLayoutType = require(GameCollectionsParent.GameTile).GameTileTypes.GameTileLayoutType

local tbl1 = {
    [GameTileLayoutType.Event] = CollectionItemSize.Large,
    [GameTileLayoutType.Wide] = CollectionItemSize.Medium,
    [GameTileLayoutType.Narrow] = CollectionItemSize.Small
}

local function useGameCollectionLayoutParams(arg1, arg2, bool1: boolean?, tbl2, vector2: Vector2?)
    local var1 = tbl1[arg1] or CollectionItemSize.Small
    return useCollectionLayoutParams(var1, arg2, bool1, tbl2, GameCollectionLayoutCalculators, vector2)
end

return useGameCollectionLayoutParams
