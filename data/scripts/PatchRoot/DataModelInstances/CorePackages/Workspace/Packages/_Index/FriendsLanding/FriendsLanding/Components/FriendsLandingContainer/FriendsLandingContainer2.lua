-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")

local dependencies = require(FriendsLanding.dependencies)
local FriendsLandingParent = FriendsLanding.Parent
local IXPServiceWrapper = require(FriendsLandingParent.IXPServiceWrapper).IXPServiceWrapper
local React = require(FriendsLandingParent.React)
local Cryo = require(FriendsLandingParent.Cryo)
local useAppPolicy = require(FriendsLandingParent.UniversalAppPolicy).useAppPolicy
local useGetFriendsCountByUserId = require(FriendsLandingParent.FriendsHydrationReact).useGetFriendsCountByUserId

local getRbxthumbWithTypeSizeAndOptions = dependencies.getRbxthumbWithTypeSizeAndOptions
local UserLibConstants = dependencies.UserLibConstants

local FriendsLandingPage = require(FriendsLanding.Components.FriendsLandingPage)
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)

local PresenceType = dependencies.RoduxPresence.Enums.PresenceType

local PresenceType2 = require(FriendsLandingParent.GraphQLServer).types.PresenceType

local FriendsCommon = require(FriendsLandingParent.FriendsCommon)
local useFriendsListOrderedByPresence = FriendsCommon.Hooks.useFriendsListOrderedByPresence
local useDecoratedTrustedConnections = FriendsCommon.Hooks.useDecoratedTrustedConnections
local useLocalUserId = require(FriendsLandingParent.RobloxAppHooks).useLocalUserId
local filterStates = require(FriendsLanding.Friends.filterStates)
local FFlagFriendsLandingLayerExposure = require(FriendsLanding.Flags.FFlagFriendsLandingLayerExposure)

local AppUserLayers = require(FriendsLandingParent.ExperimentLayers).AppUserLayers
local FFlagConnectionManagementChips = require(FriendsLandingParent.SharedFlags).FFlagConnectionManagementChips
local FFlagFriendsPageUserListCtaEnabled = require(FriendsLanding.Flags.FFlagFriendsPageUserListCtaEnabled)
local EntityType = if FFlagFriendsPageUserListCtaEnabled then require(FriendsLandingParent.UserList).Enums.EntityType else nil
local pageSize = game:DefineFastInt("FriendsLandingPageSize", 50)
local tbl1 = { skipFetch = true }

local tbl2 = {
    [PresenceType2.Offline] = PresenceType.Offline,
    [PresenceType2.Online] = PresenceType.Online,
    [PresenceType2.InGame] = PresenceType.InGame,
    [PresenceType2.InStudio] = PresenceType.InStudio
}

function FriendsLandingContainer(_)
    React.useEffect(function()
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(AppUserLayers.ConnectionsHubExposureLayer)

        if FFlagFriendsLandingLayerExposure then
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(AppUserLayers.SocialFriendsLandingLayer)
        end
    end, {})

    local var1 = useLocalUserId()
    local var2 = if var1 then tostring(var1) else nil
    local totalFriendCount = useGetFriendsCountByUserId(var2, tbl1) or 0

    local enableDisplayNamePolicy = useAppPolicy(function(arg1)
        return arg1.getShowDisplayName()
    end)

    local var5 = React.useContext(FriendsLandingContext.Context)

    local var6 = useFriendsListOrderedByPresence({ userId = var1, pageSize = pageSize })

    local var7 = if FFlagConnectionManagementChips then useDecoratedTrustedConnections(var6.onlineFriends) else nil

    local var8 = React.useMemo(function()
        local var8

        if var6.onlineFriends and var6.offlineFriends then
            if var5.filter == filterStates.All then
                return (Cryo.List.join(var6.onlineFriends, var6.offlineFriends))
            end

            if var5.filter == filterStates.Offline then
                return var6.offlineFriends
            end

            if var5.filter == filterStates.Online then
                return var6.onlineFriends
            end

            if FFlagConnectionManagementChips and var5.filter == filterStates.Trusted then
                return var7 or {}
            end
            local onlineFriends = var6.onlineFriends
            var8 = Cryo.List.filter(onlineFriends, function(arg1)
                return arg1.presence and arg1.presence.userPresenceType == PresenceType2.InGame
            end)
        else
            var8 = {}
        end

        return var8
    end, FFlagConnectionManagementChips and {
        var5.filter,
        var6.onlineFriends,
        var6.offlineFriends,
        var7
    }
        or { var5.filter, var6.onlineFriends, var6.offlineFriends })

    local var9 = React.useMemo(function()
        return Cryo.List.map(var8, function(arg1, _)
            local thumbnail = getRbxthumbWithTypeSizeAndOptions(arg1.id, UserLibConstants.RbxthumbTypes.Avatar, 352)
            local userPresenceType = if arg1.presence then tbl2[arg1.presence.userPresenceType] else PresenceType.Offline
            return {
                id = arg1.id,
                type = if FFlagFriendsPageUserListCtaEnabled then EntityType.User else nil,
                username = "",
                thumbnail = thumbnail,
                userPresenceType = userPresenceType,
                universeId = if arg1.presence then arg1.presence.universeId or nil else nil,
                lastLocation = if arg1.presence then arg1.presence.lastLocation else nil
            }
        end)
    end, { var8 })

    return React.createElement(FriendsLandingPage, {
        totalFriendCount = totalFriendCount,
        friends = FFlagConnectionManagementChips and not var9 and {} or var9,
        fetchMoreFriends = if var6 and not var6.isEndOfList then var6.fetchMoreFriends else nil,
        refreshFriends = var6.refreshFriendsData,
        enableDisplayNamePolicy = enableDisplayNamePolicy,
        localUserId = var1
    })
end

return FriendsLandingContainer
