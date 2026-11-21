-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameHydrationReact = script:FindFirstAncestor("GameHydrationReact")
local GameHydrationReactParent = GameHydrationReact.Parent

local DataHydration = require(GameHydrationReactParent.DataHydration)
local useGameIconForSize = require(GameHydrationReact.useGameIconForSize)

local function useLargeGameIcon(arg1)
    return useGameIconForSize(arg1, DataHydration.Game.GameIconSize.Large)
end

return useLargeGameIcon
