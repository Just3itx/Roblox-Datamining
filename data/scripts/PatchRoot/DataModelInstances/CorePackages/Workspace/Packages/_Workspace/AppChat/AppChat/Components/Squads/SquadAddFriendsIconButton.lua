-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local EnumScreens = require(AppChat.EnumScreens)
local AppChatParent = AppChat.Parent

local Constants = require(AppChat.Constants)
local React = require(AppChatParent.React)
local SquadExternalContractProvider = require(AppChatParent.SquadsCore.SquadExternalContractProvider)
local UIBlox = require(AppChatParent.UIBlox)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)

local useCurrentSquadParentChannelId = require(AppChatParent.SquadsCore.Hooks).useCurrentSquadParentChannelId

local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images

local EventNames = require(AppChatParent.SquadsCore.EventNames)
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext

local SquadInvitePageNavSourceEnum = require(AppChatParent.Squads.Enums).SquadInvitePageNavSourceEnum

return function(tbl1)
    local var1 = React.useContext(SquadExternalContractContext)
    local var2 = useCurrentSquadParentChannelId() or ""

    local var3 = useGetConversationFromId(var2)
    local var4 = var3 and var3.participants or {}

    local var5 = useLocalization({
        tooManyPeopleText = {
            "Feature.Chat.Message.AddFriendsPartyLimit",
            friendNum = Constants.MAX_PARTICIPANT_COUNT,
            connectionsNum = Constants.MAX_PARTICIPANT_COUNT
        }
    })

    local onActivated = React.useCallback(function()
        if #var4 > Constants.MAX_PARTICIPANT_COUNT then
            tbl1.navigation.navigate(
                EnumScreens.RoactChatToast,
                {
                    toastProps = {
                        toastContent = {
                            toastTitle = var5.tooManyPeopleText
                        }
                    }
                }
            )
            return
        end

        var1.fireSquadAnalytics(
            EventNames.SquadInvitePageNavSource,
            {
                inviteNavSource = SquadInvitePageNavSourceEnum.SquadLobbyAddFriendsIconButtonClicked,
                parentChannelId = var2
            }
        )
        tbl1.navigation.navigate(EnumScreens.SquadInviteFriends, { conversationId = var2 })
    end, { var2, tbl1.navigation, var4 })

    return React.createElement(IconButton, {
        size = UDim2.fromOffset(0, 0),
        icon = Images["icons/actions/friends/friendAdd"],
        iconSize = IconSize.Medium,
        layoutOrder = 0,
        onActivated = onActivated
    })
end
