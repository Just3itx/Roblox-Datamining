-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local Players = game:GetService("Players")

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local Localization = require(ServerDrivenUiParent.Localization)
local DataHydration = require(ServerDrivenUiParent.DataHydration)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local RoactUtils = require(ServerDrivenUiParent.RoactUtils)
local gameConnectionsPlayedChipClicked = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.gameConnectionsPlayedChipClicked

local SduiTextAccessoryRow = require(ServerDrivenUiParent.SduiSharedContent).SduiTextAccessoryRow

local AvatarGroupType = Foundation.Enums.AvatarGroupType
local InputSize = Foundation.Enums.InputSize
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local Game = DataHydration.Game
local useTokens = Foundation.Hooks.useTokens

local useLocalization = Localization.Hooks.useLocalization
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useDeviceType = require(ServerDrivenUiParent.RobloxAppHooks).useDeviceType
local DeviceType = require(ServerDrivenUiParent.RobloxAppEnums).DeviceType
local NavigateDown = require(ServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown

local FFlagSignalsNavP3Dispatch = require(ServerDrivenUiParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil

return React.memo(function(tbl1) -- name: ExperienceDetailsConnectionsPlayedTextRow
    local layoutOrder = tbl1.layoutOrder
    local universeId = tbl1.universeId
    local name = tbl1.name

    local var1 = useTokens()
    local var2 = useDispatch()
    local bool1 = useDeviceType() == DeviceType.Phone

    local connectionsPlayedStore = Game.getConnectionsPlayedStore(false)
    local var3 = SignalsReact.useSignalState(connectionsPlayedStore.getConnectionsPlayed(universeId).data)
    local var4 = SignalsReact.useSignalState(Game.getGameInfoStore(false).getAndFetchGameInfo(universeId).data)

    local userIds = not var3 and {} or var3.userIds
    local var6 = not var3 and #userIds or var3.totalCount

    local var7 = useLocalization({
        connectionsRecentlyPlayed = {
            "Feature.Friends.Label.FriendsRecentlyPlayed",
            numberOfConnections = var6
        },
        connectionRecentlyPlayed = { "Feature.Friends.Label.FriendRecentlyPlayed" },
        playedByUserAndOthersPlural = {
            "Feature.Friends.Label.PlayedByUserAndOthers.FriendsRename",
            name = name or "",
            numOfOthers = var6 - 1
        },
        playedByUserAndOneOther = {
            "Feature.Friends.Label.PlayedByUserAndOneOther.FriendsRename",
            name = name or ""
        },
        playedByUser = {
            "Feature.Friends.Label.PlayedByUser",
            name = name or ""
        }
    })
    local text = if name and name ~= "" then if var6 == 1 then var7.playedByUser elseif var6 == 2 then var7.playedByUserAndOneOther else var7.playedByUserAndOthersPlural elseif var6 == 1 then var7.connectionRecentlyPlayed else var7.connectionsRecentlyPlayed
    local rootPlaceId = var4 and var4.rootPlaceId

    local onActivated = React.useCallback(function()
        if rootPlaceId then
            local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
            gameConnectionsPlayedChipClicked(
                {
                    uid = tostring(userId),
                    universeId = universeId,
                    placeId = tostring(rootPlaceId),
                    totalConnections = var6
                },
                "ExperienceDetailsConnectionsPlayedChip"
            )
        end
        local tbl2 = {
            name = AppPage.SocialProofVerticalUserListSheet,
            extraProps = {
                userIds = userIds,
                title = if var6 == 1 then var7.connectionRecentlyPlayed else var7.connectionsRecentlyPlayed
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var2(NavigateDown(tbl2))
    end, {
        var2,
        universeId,
        rootPlaceId,
        userIds,
        var6,
        var7,
        Players.LocalPlayer
    })

    local avatars = React.useMemo(function()
        return { table.unpack(userIds, 1, math.min(2, #userIds)) }
    end, { userIds })

    local backplateStyle = if bool1 then var1.Color.Surface.Surface_100 else var1.Color.Surface.Surface_0

    local leading = React.useMemo(function()
        return {
            type = "AvatarGroup",
            avatars = avatars,
            groupType = AvatarGroupType.Stacked,
            max = 2,
            size = InputSize.XSmall,
            backplateStyle = backplateStyle
        }
    end, { avatars, backplateStyle })

    local fontStyle = React.useMemo(function()
        return {
            FontSize = var1.FontSize.FontSize_300
        }
    end, { var1 })

    if var6 == 0 then
        return nil
    end

    return React.createElement(SduiTextAccessoryRow, {
        text = text,
        leading = leading,
        gap = var1.Gap.Small,
        fontStyle = fontStyle,
        onActivated = onActivated,
        layoutOrder = layoutOrder,
        testId = "--experience-details-connections-played-text-row"
    })
end)
