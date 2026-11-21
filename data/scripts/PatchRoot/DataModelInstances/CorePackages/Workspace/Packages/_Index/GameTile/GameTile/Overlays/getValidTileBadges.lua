-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local mutedError = require(GameTileParent.Loggers).mutedError
local flaggedMutedError = require(GameTileParent.Loggers).flaggedMutedError

local _GameTileTypes = require(GameTile.GameTileTypes)
local TileBadgePositionCalculators = require(GameTile.GameTileConstants).TileBadgePositionCalculators

local function isValidTileBadgePosition(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1 = TileBadgePositionCalculators[arg1] ~= nil

    if not bool1 then
        flaggedMutedError("GameTileOverlayBadgeInvalidPositionError", `Unsupported game tile badge position: {arg1}`)
    end

    return bool1
end

local function getValidTileBadges(arg1)
    local validTileBadges = ({})

    for value, value2 in arg1 do
        if not (isValidTileBadgePosition(value) and #value2 > 0) then
            continue
        end
        local var1 = value2[1]

        if var1.tileBadgeType and var1.analyticsId then
            validTileBadges[value] = { value2[1] }
        else
            mutedError("Invalid tile badge metadata.")
        end
    end

    return validTileBadges
end

return getValidTileBadges
