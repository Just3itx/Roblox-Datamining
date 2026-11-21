-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsHydrationReactParent = script:FindFirstAncestor("FriendsHydrationReact").Parent

local React = require(FriendsHydrationReactParent.React)
local SignalsReact = require(FriendsHydrationReactParent.SignalsReact)
local var1 = require(FriendsHydrationReactParent.DataHydration).Friends.FriendsStore.get()

local function useGetAllFriends()
    local var2 = React.useMemo(function()
        return var1.GetAllFriends()
    end, {})
    local var3 = React.useMemo(function()
        return var1.GetAllFriendsStatus()
    end, {})

    return SignalsReact.useSignalState(var2), SignalsReact.useSignalState(var3), (React.useCallback(function()
        var1.FetchMoreFriends()
    end, {}))
end

return useGetAllFriends
