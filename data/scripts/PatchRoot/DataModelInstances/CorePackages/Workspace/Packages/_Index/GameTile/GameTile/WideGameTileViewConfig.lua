-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local _UIBlox = require(GameTileParent.UIBlox)

local function getMetadataHeight(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.Size.Size_500
end

return {
    getTileHeight = function(arg1, num1: number)
        local num2 = num1 * 0.5625
        local size500 = arg1.Size.Size_500
        local size200 = arg1.Size.Size_200
        local size100 = arg1.Size.Size_100
        return num2 + (size500 + getMetadataHeight(arg1) + size200 + size100)
    end,
    getFooterHeight = function(arg1)
        local size500 = arg1.Size.Size_500
        local size200 = arg1.Size.Size_200
        local size100 = arg1.Size.Size_100
        return size500 + getMetadataHeight(arg1) + size200 + size100
    end,
    getMetadataHeight = getMetadataHeight,
    getPlayButtonHeight = function(arg1)
        return arg1.Size.Size_900
    end
}
