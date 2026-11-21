-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local GameInfosReducer = require(GameTileParent.GameInfosRodux).GameInfosReducer
local React = require(GameTileParent.React)

local useSelector = require(GameTileParent.RoactUtils).Hooks.RoactRodux.useSelector

local getGameTileLayoutData = require(GameTile.getGameTileLayoutData)
local getValidTileBadges = require(GameTile.Overlays.getValidTileBadges)
local _GameTileTypes = require(GameTile.GameTileTypes)

local function useValidTileBadges(str1: string, str2: string?, arg1)
    local var1 = useSelector(function(arg2)
        return arg2.Personalization[GameInfosReducer.key][str1]
    end)

    local gameTileLayoutData = getGameTileLayoutData(var1, str2)

    return (React.useMemo(function()
        local tileBadgesByPosition = nil

        if arg1 then
            tileBadgesByPosition = arg1
        elseif gameTileLayoutData and gameTileLayoutData.tileBadgesByPosition then
            tileBadgesByPosition = gameTileLayoutData.tileBadgesByPosition
        end

        if tileBadgesByPosition then
            return getValidTileBadges(tileBadgesByPosition)
        end

        return nil
    end, { gameTileLayoutData, arg1 }))
end

return useValidTileBadges
