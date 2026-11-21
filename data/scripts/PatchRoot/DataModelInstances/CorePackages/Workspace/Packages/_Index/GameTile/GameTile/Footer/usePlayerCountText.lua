-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local useAbbreviatedNumberLocalization = require(GameTileParent.Localization).Hooks.useAbbreviatedNumberLocalization

local function usePlayerCountText(num1: number?)
    local var1 = useAbbreviatedNumberLocalization(num1)
    return if var1 == nil or num1 == -1 then "--" else var1
end

return usePlayerCountText
