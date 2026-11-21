-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local SignalsReact = require(GameDetailParent.SignalsReact)
local DataHydration = require(GameDetailParent.DataHydration)

local function useGameInfo(str1: string)
    return SignalsReact.useSignalState(DataHydration.Game.getGameInfoStore(false).getGameInfo(str1).data)
end

return useGameInfo
