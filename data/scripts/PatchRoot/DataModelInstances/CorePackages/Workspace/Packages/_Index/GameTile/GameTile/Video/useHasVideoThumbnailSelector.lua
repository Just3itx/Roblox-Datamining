-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local GameInfosReducer = require(GameTileParent.GameInfosRodux).GameInfosReducer

local useSelector = require(GameTileParent.RoactUtils).Hooks.RoactRodux.useSelector

local getGameTileLayoutData = require(GameTile.getGameTileLayoutData)
local getLayoutDataVideo = require(GameTile.getLayoutDataVideo)

local FFlagLuaAppHomeMomentVideoFallback = require(GameTileParent.SharedFlags).FFlagLuaAppHomeMomentVideoFallback

local function useHasVideoThumbnailSelector(str1: string, str2: string?): boolean
    local var1 = useSelector(function(arg1)
        return arg1.Personalization[GameInfosReducer.key][str1]
    end)

    local gameTileLayoutData = getGameTileLayoutData(var1, str2)
    if not FFlagLuaAppHomeMomentVideoFallback then
        return (gameTileLayoutData and gameTileLayoutData.primaryMediaAsset and gameTileLayoutData.primaryMediaAsset.wideVideoAssetId) ~= nil
    end

    local layoutDataVideo = getLayoutDataVideo(gameTileLayoutData)
    return not (layoutDataVideo == nil) and layoutDataVideo.assetId ~= nil
end

return useHasVideoThumbnailSelector
