-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local resetForSquadLobbyForCompactMode = require(AppChat.Utils.resetForSquadLobbyForCompactMode)
local resetForSquadLobbyForWideMode = require(AppChat.Utils.resetForSquadLobbyForWideMode)

local ArgCheck = require(AppChatParent.ArgCheck)
local React = require(AppChatParent.React)

local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local EnumScreens = require(AppChat.EnumScreens)

local NavProps = require(AppChat.Constants).NavProps

local QuickStartSquadInviteFriendsContainer = require(AppChatParent.Squads.QuickStartSquadInviteFriendsContainer)

local var1 = React.PureComponent:extend("QuickStartSquadInviteFriendsScreen")
function var1.navigationOptions(_)
    return { backButtonEnabled = true }
end

function var1.init(arg1)
    arg1.wideMode = arg1.props.navigation.getScreenProps(NavProps.WIDE_MODE, false)

    GetTopBarStore(false).setScreenTopBar(EnumScreens.QuickStartSquadInviteFriends, {
        headerText = { raw = "Feature.Squads.Action.Party", shouldLocalize = true },
        backButtonEnabled = true,
        systemButtonText = "Feature.Squads.Action.Start"
    })

    function arg1.navigateIntoSquadLobby(arg2)
        local screenProps = arg1.props.navigation.getScreenProps(NavProps.WIDE_MODE, false)
        local squadCreateOrJoinAttemptId = arg1.props.navigation.getParam("partyAttemptId", nil)

        if screenProps then
            resetForSquadLobbyForWideMode(arg1.props.navigation, arg2, { squadCreateOrJoinAttemptId = squadCreateOrJoinAttemptId })
            return
        end

        resetForSquadLobbyForCompactMode(
            arg1.props.navigation,
            arg2,
            { squadCreateOrJoinAttemptId = squadCreateOrJoinAttemptId }
        )
    end

    function arg1.onSelectedFriendsChanged(systemButtonEnabled, systemButtonActivated)
        if not arg1.wideMode then
            return
        end

        GetTopBarStore(false).setScreenTopBar(
            EnumScreens.QuickStartSquadInviteFriends,
            {
                systemButtonEnabled = systemButtonEnabled,
                systemButtonActivated = systemButtonActivated
            }
        )
    end
end

function var1.render(arg1)
    local var2 = ArgCheck.isNotNil(arg1.props.navigation, "navigation in CreateNewChatScreen")
    local screenProps = var2.getScreenProps("topBarHeight", 0)
    local screenProps2 = var2.getScreenProps("wideMode", false)
    local partyAttemptId = arg1.props.navigation.getParam("partyAttemptId", nil)

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 1, if screenProps2 then -screenProps else 0),
            BackgroundTransparency = 1
        },
        { React.createElement(QuickStartSquadInviteFriendsContainer, {
                navigateIntoSquadLobby = arg1.navigateIntoSquadLobby,
                partyAttemptId = partyAttemptId,
                onSelectedFriendsChanged = arg1.onSelectedFriendsChanged,
                shouldHideFooterButton = arg1.wideMode
            }) }
    )
end

function var1.didMount(arg1)
    if arg1.wideMode then
        arg1.onSelectedFriendsChanged(false, nil)
    end
end

return var1
