-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameHydrationReact = script:FindFirstAncestor("GameHydrationReact")
local GameHydrationReactParent = GameHydrationReact.Parent

local _DataHydration = require(GameHydrationReactParent.DataHydration)
local useGameIconsForSize = require(GameHydrationReact.useGameIconsForSize)

local function useGameIcons(tbl1, arg1)
    return useGameIconsForSize(tbl1, arg1)
end

return useGameIcons
