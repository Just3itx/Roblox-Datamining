-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local createGameTileHiddenStore = require(GameTile.HiddenGameTile.createGameTileHiddenStore)

local tbl1 = ({})

local function getGameTileHiddenStore(str1: string)
    local var1 = tbl1[str1]
    if var1 == nil then
        tbl1[str1] = createGameTileHiddenStore()
        var1 = tbl1[str1]
    end
    return var1
end

return getGameTileHiddenStore
