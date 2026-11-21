-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLandingParent = script:FindFirstAncestor("FriendsLanding").Parent

local React = require(FriendsLandingParent.React)
local UserProfiles = require(FriendsLandingParent.UserProfiles)
local Dash = require(FriendsLandingParent.Dash)
local DataHydration = require(FriendsLandingParent.DataHydration)
local useSignalState = require(FriendsLandingParent.SignalsReact).useSignalState
local Signals = require(FriendsLandingParent.Signals)

local FriendTile = require(script.Parent.FriendTile)

local FFlagFriendsPageUserListEnabled = require(FriendsLandingParent.SharedFlags).FFlagFriendsPageUserListEnabled
local FFlagEnableBlackbirdCheck = require(FriendsLandingParent.SharedFlags).FFlagEnableBlackbirdCheck
local useIsRobloxSubscriber = UserProfiles.Hooks.useIsRobloxSubscriber

local var1 = DataHydration.TrustedConnections.TrustedConnectionsStore.get()

local function FriendTileContainer(arg1)
    local var2 = if FFlagFriendsPageUserListEnabled then nil else UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = { arg1.user.id },
            query = UserProfiles.Queries.userProfilesFriendsLandingQueryByUserIds
        }
    )
    local var3 = if FFlagEnableBlackbirdCheck then useIsRobloxSubscriber(if arg1.user and arg1.user.id then arg1.user.id else nil) else nil

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            if arg1.user and arg1.user.id and arg1.user.id ~= "" then
                return (var1.getIsTrustedConnection(arg1.user.id).data(arg2))
            end

            return nil
        end)
    end, { if arg1.user then arg1.user.id else nil })

    local trustedConnection = useSignalState(var4)

    local createElement = React.createElement
    local var6 = FriendTile
    local join = Dash.join
    local tbl1 = {
        userProfile = if FFlagFriendsPageUserListEnabled or not var2.data then nil else var2.data.userProfiles[1],
        trustedConnection = trustedConnection,
        isRobloxSubscriber = 0
    }

    if not FFlagEnableBlackbirdCheck then
        var3 = nil
    end

    tbl1.isRobloxSubscriber = var3
    return createElement(var6, join(arg1, tbl1))
end

return FriendTileContainer
