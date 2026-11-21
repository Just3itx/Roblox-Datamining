-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameHydrationReactParent = script:FindFirstAncestor("GameHydrationReact").Parent

local React = require(GameHydrationReactParent.React)
local SignalsReact = require(GameHydrationReactParent.SignalsReact)
local DataHydration = require(GameHydrationReactParent.DataHydration)

local function useGameInfo(arg1)
    local str1 = tostring(arg1)

    local var1 = React.useMemo(function()
        return DataHydration.Game.getGameInfoStore(false).getGameInfo(str1).data
    end, { str1 })

    return SignalsReact.useSignalState(var1)
end

return useGameInfo
