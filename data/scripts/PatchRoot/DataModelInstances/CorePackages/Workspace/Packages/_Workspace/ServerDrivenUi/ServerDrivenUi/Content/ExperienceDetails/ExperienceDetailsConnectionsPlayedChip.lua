-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local Players = game:GetService("Players")

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local Localization = require(ServerDrivenUiParent.Localization)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)

local Game = require(ServerDrivenUiParent.DataHydration).Game

local SduiChip = require(ServerDrivenUiParent.SduiSharedContent).SduiChip

local NavigateDown = require(ServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage

local gameConnectionsPlayedChipClicked = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.gameConnectionsPlayedChipClicked

local AvatarGroupType = Foundation.Enums.AvatarGroupType

local useLocalization = Localization.Hooks.useLocalization
local useDispatch = require(ServerDrivenUiParent.RoactUtils).Hooks.RoactRodux.useDispatch

local FFlagSignalsNavP3Dispatch = require(ServerDrivenUiParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil

return React.memo(function(tbl1) -- name: ExperienceDetailsConnectionsPlayedChip
    local layoutOrder = tbl1.layoutOrder
    local universeId = tbl1.universeId

    local var1 = useDispatch()

    local var2 = SignalsReact.useSignalState(Game.getConnectionsPlayedStore(false).getConnectionsPlayed(universeId).data)

    local var3 = SignalsReact.useSignalState(Game.getGameInfoStore(false).getAndFetchGameInfo(universeId).data)

    local userIds = not var2 and {} or var2.userIds
    local var5 = if var2 then var2.totalCount else 0

    local var6 = useLocalization({
        connectionsPlayed = { "Feature.Friends.Label.FriendsPlayed", numberOfConnections = var5 },
        connectionsRecentlyPlayed = {
            "Feature.Friends.Label.FriendsRecentlyPlayed",
            numberOfConnections = var5
        },
        connectionRecentlyPlayed = { "Feature.Friends.Label.FriendRecentlyPlayed" }
    })

    local onActivated = React.useCallback(function()
        local rootPlaceId = var3 and var3.rootPlaceId
        if rootPlaceId then
            local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
            gameConnectionsPlayedChipClicked(
                {
                    uid = tostring(userId),
                    universeId = universeId,
                    placeId = tostring(rootPlaceId),
                    totalConnections = var5
                },
                "ExperienceDetailsConnectionsPlayedChip"
            )
        end
        local tbl2 = {
            name = AppPage.SocialProofVerticalUserListSheet,
            extraProps = {
                userIds = userIds,
                title = if var5 == 1 then var6.connectionRecentlyPlayed else var6.connectionsRecentlyPlayed
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2))
    end, {
        var1,
        universeId,
        var3,
        var5,
        var6,
        Players.LocalPlayer
    })
    if var5 == 0 then
        return nil
    end

    local connectionsPlayed = var6.connectionsPlayed

    local avatars = {}
    local num1 = #userIds

    for i = 1, math.min(2, num1) do
        table.insert(avatars, userIds[i])
    end

    return React.createElement(SduiChip, {
        text = connectionsPlayed,
        leading = {
            type = "AvatarGroup",
            props = {
                avatars = avatars,
                type = AvatarGroupType.Stacked,
                max = 2
            }
        },
        onActivated = onActivated,
        layoutOrder = layoutOrder
    })
end)
