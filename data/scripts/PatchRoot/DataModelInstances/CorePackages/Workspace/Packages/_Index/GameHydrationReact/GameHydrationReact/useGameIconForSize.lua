-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameHydrationReactParent = script:FindFirstAncestor("GameHydrationReact").Parent

local React = require(GameHydrationReactParent.React)
local SignalsReact = require(GameHydrationReactParent.SignalsReact)
local DataHydration = require(GameHydrationReactParent.DataHydration)

local function useGameIconForSize(arg1, str1: string)
    local str2 = tostring(arg1)

    local var1 = React.useMemo(function()
        local var1 = DataHydration.Game.getGameIconStore(false).getGameIcon(str2, str1)
        return function(arg2)
            local var2 = var1.data(arg2)
            return if var2 then var2.url else nil
        end
    end, { str2, str1 })

    return SignalsReact.useSignalState(var1)
end

return useGameIconForSize
