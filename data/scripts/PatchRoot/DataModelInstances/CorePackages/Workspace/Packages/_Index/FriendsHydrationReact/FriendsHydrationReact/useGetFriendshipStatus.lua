-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsHydrationReactParent = script:FindFirstAncestor("FriendsHydrationReact").Parent

local React = require(FriendsHydrationReactParent.React)
local SignalsReact = require(FriendsHydrationReactParent.SignalsReact)
local Signals = require(FriendsHydrationReactParent.Signals)
local DataHydration = require(FriendsHydrationReactParent.DataHydration)

local var1 = DataHydration.Friends.FriendsStore.get()
local DataStatus = DataHydration.DataStatus

local function useGetFriendshipStatus(str1: string?, tbl1)
    local str2 = if str1 then tostring(str1) else ""

    local var2 = React.useMemo(function()
        if str2 == "" then
            return nil
        end
        return var1.GetFriendshipStatus(str2, tbl1)
    end, { str2, tbl1 })

    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if var2 then
                return (var2.data(arg1))
            end

            return nil
        end)
    end, { var2 })

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if var2 then
                return (var2.status(arg1))
            end

            return DataStatus.NotReady
        end)
    end, { var2 })

    return SignalsReact.useSignalState(var3), (SignalsReact.useSignalState(var4))
end

return useGetFriendshipStatus
