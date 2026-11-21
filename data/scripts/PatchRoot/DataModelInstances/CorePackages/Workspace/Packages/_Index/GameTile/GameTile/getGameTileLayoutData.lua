-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local _GameTileTypes = require(GameTile.GameTileTypes)

local tbl1 = {}

local function getGameTileLayoutData(tbl2, str1: string?)
    if tbl2 and tbl2.layoutDataBySort and str1 and str1 ~= "" and tbl2.layoutDataBySort[str1] then
        return tbl2.layoutDataBySort[str1]
    end

    if tbl2 and tbl2.defaultLayoutData then
        return tbl2.defaultLayoutData
    end

    return tbl1
end

return getGameTileLayoutData
