-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsHydrationReactParent = script:FindFirstAncestor("FriendsHydrationReact").Parent

local React = require(FriendsHydrationReactParent.React)
local SignalsReact = require(FriendsHydrationReactParent.SignalsReact)
local Signals = require(FriendsHydrationReactParent.Signals)
local var1 = require(FriendsHydrationReactParent.DataHydration).Friends.FriendsStore.get()

local function useGetOnlineFriendsByUniverseId(str1: string)
    local var2 = React.useMemo(function()
        return var1.GetOnlineFriendsByUniverseId(str1)
    end, { str1 })

    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return var2(arg1)
        end)
    end, { var2 })

    local var4 = React.useMemo(function()
        return var1.GetOnlineFriendsStatus()
    end, {})

    return SignalsReact.useSignalState(var3), (SignalsReact.useSignalState(var4))
end

return useGetOnlineFriendsByUniverseId
