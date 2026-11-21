-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local getGameTileLayoutData = require(GameTile.getGameTileLayoutData)
local ItemLayoutDataParsingUtils = require(GameTile.ItemLayoutDataParsingUtils)

local function resolveWideAssetId(str1: string?, tbl1, str2: string?)
    if str1 then
        return str1
    end

    local gameTileLayoutData = getGameTileLayoutData(tbl1, str2)
    return ItemLayoutDataParsingUtils.getWideImageAssetId(gameTileLayoutData) or tbl1 and tbl1.primaryWideAssetId or nil
end

return resolveWideAssetId
