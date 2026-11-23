-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local RoactRodux = require(AppChatParent.RoactRodux)
local SharedFlags = require(AppChatParent.SharedFlags)

local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local EnumScreens = require(AppChat.EnumScreens)

local FFlagEnablePartyQuickStartButton = SharedFlags.FFlagEnablePartyQuickStartButton

local NavProps = require(AppChat.Constants).NavProps

local SquadInviteFriends = require(AppChatParent.Squads.SquadInviteFriends)
local SquadInviteFriendsContainer = require(AppChatParent.Squads.SquadInviteFriendsContainer)

local var1 = React.PureComponent:extend("SquadInviteFriendsScreen")

local function navigationOptions(_)
    return {}
end

var1.navigationOptions = navigationOptions
function var1.init(arg1)
    arg1.wideMode = arg1.props.navigation.getScreenProps(NavProps.WIDE_MODE, false)

    GetTopBarStore(false).setScreenTopBar(EnumScreens.SquadInviteFriends, {
        headerText = FFlagEnablePartyQuickStartButton and {
            raw = "Feature.Squads.Action.Add",
            shouldLocalize = true
        } or nil,
        backButtonEnabled = true,
        systemButtonText = "Feature.Squads.Action.Add"
    })

    function arg1.onSelectedFriendsChanged(systemButtonEnabled, systemButtonActivated)
        if not arg1.wideMode then
            return
        end

        GetTopBarStore(false).setScreenTopBar(
            EnumScreens.SquadInviteFriends,
            {
                systemButtonEnabled = systemButtonEnabled,
                systemButtonActivated = systemButtonActivated
            }
        )
    end
end

function var1.render(arg1)
    return React.createElement(
        if FFlagEnablePartyQuickStartButton then SquadInviteFriendsContainer else SquadInviteFriends,
        {
            participants = arg1.props.participants,
            onSelectedFriendsChanged = if arg1.wideMode then arg1.onSelectedFriendsChanged else nil,
            shouldHideFooterButton = arg1.wideMode
        }
    )
end

function var1.didMount(arg1)
    if arg1.wideMode then
        arg1.onSelectedFriendsChanged(false, nil)
    end
end

local var2 = RoactRodux.connect(function(arg1, arg2)
    local param = arg2.navigation.getParam("conversationId")
    local conversation = arg1.ChatAppReducer.Conversations[param]

    return {
        participants = conversation and conversation.participants or nil
    }
end)(var1)
var2.navigationOptions = navigationOptions

return var2
