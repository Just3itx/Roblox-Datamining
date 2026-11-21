-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local _Foundation = require(GameTileParent.Foundation)

local FFlagLuaAppMigrateGameTileFixConsoleMetadataText = require(GameTileParent.SharedFlags).FFlagLuaAppMigrateGameTileFixConsoleMetadataText

local function getGameTileMetadataFont(bool1: boolean?, arg1, arg2, bool2: boolean?, bool3: boolean?)
    if bool2 and arg2 then
        if bool3 or FFlagLuaAppMigrateGameTileFixConsoleMetadataText and bool1 == false then
            return arg2.Typography.BodySmall
        end

        return arg2.Typography.BodyMedium
    end

    if bool1 then
        return arg1.Typography.BodyLarge
    end

    return arg1.Typography.CaptionMedium
end

return getGameTileMetadataFont
