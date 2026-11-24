-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRodux = script:FindFirstAncestor("GameDetailRodux")
local GameDetailRoduxParent = GameDetailRodux.Parent

local Immutable = require(GameDetailRoduxParent.AppCommonLib).Immutable
local AddGameDetails = require(GameDetailRodux.GameDetails.AddGameDetails)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == AddGameDetails.name then
        arg1 = Immutable.JoinDictionaries(arg1, arg2.gameDetails)
    end

    return arg1
end
