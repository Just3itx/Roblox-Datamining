-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileLayoutType = require(GameTile.GameTileTypes).GameTileLayoutType

local GameTileParent = GameTile.Parent
local CollectionItemSize = require(GameTileParent.CollectionViews).CollectionViewTypes.CollectionItemSize

local function getGameTileCollectionItemSize(arg1)
    if arg1 == GameTileLayoutType.Narrow then
        return CollectionItemSize.Small
    end

    if arg1 == GameTileLayoutType.Wide then
        return CollectionItemSize.Medium
    end

    if arg1 == GameTileLayoutType.Event then
        return CollectionItemSize.Large
    end

    return CollectionItemSize.Small
end

return getGameTileCollectionItemSize
