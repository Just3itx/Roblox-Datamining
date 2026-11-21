-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local _GameTileTypes = require(GameTile.GameTileTypes)

local module = {}

function module.getWideImageAssetId(arg1)
    return if arg1
        and arg1.primaryMediaAsset
        and arg1.primaryMediaAsset.wideImageAssetId
        and arg1.primaryMediaAsset.wideImageAssetId ~= "" then arg1.primaryMediaAsset.wideImageAssetId else nil
end

return module
