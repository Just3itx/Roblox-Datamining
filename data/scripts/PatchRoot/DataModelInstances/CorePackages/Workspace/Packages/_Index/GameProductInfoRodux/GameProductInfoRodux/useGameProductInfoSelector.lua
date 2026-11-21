-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameProductInfoRodux = script:FindFirstAncestor("GameProductInfoRodux")
local GamesProductInfoReducer = require(GameProductInfoRodux.GamesProductInfoReducer)

local GameProductInfoRoduxParent = GameProductInfoRodux.Parent
local useSelector = require(GameProductInfoRoduxParent.RoactUtils).Hooks.RoactRodux.useSelector

local function useGameProductInfoSelector(arg1)
    return (useSelector(function(arg2)
        return arg2[GamesProductInfoReducer.key][arg1]
    end))
end
return useGameProductInfoSelector
