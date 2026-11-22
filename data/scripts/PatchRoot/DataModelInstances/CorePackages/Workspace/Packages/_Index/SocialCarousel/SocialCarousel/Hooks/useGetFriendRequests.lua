-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarouselParent = script:FindFirstAncestor("SocialCarousel").Parent

local DataHydration = require(SocialCarouselParent.DataHydration)
local React = require(SocialCarouselParent.React)
local Signals = require(SocialCarouselParent.Signals)
local SignalsReact = require(SocialCarouselParent.SignalsReact)
local FriendsRequests = require(SocialCarouselParent.DataHydration.FriendsRequests)

local var1 = DataHydration.Friends.FriendsStore.get()
local var2 = FriendsRequests.FriendsRequestsStore.get()

local tbl1 = { skipFetch = true }

local function useGetFriendRequests(bool1: boolean?)
    local var3 = React.useMemo(function()
        if bool1 == false then
            return nil
        end

        return (var2.getFriendsRequests())
    end, { bool1 })

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var4 = if var3 then var3.data(arg1) else nil

            if not var4 then
                return {}
            end

            local result = {}

            for _, request in var4.requests do
                local friendshipStatus = var1.GetFriendshipStatus(request.id, tbl1)
                local var5 = if friendshipStatus then friendshipStatus.data(arg1) else nil

                if var5 == nil or var5 == Enum.FriendStatus.FriendRequestReceived then
                    table.insert(result, request)
                end
            end

            return result
        end)
    end, { var3 })
    return SignalsReact.useSignalState(var4)
end

return useGetFriendRequests
