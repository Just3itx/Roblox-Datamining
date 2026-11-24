-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent
local Actions = scriptParentParent.State.Actions
local scriptParentParentParent = scriptParentParent.Parent

local FriendsMenu = require(scriptParentParentParent.FriendsMenu)
local React = require(scriptParentParentParent.React)
local RoactUtils = require(scriptParentParentParent.RoactUtils)

local InviteFriendContext = FriendsMenu.InviteFriendContext
local InviteStatus = FriendsMenu.InviteStatus

local GameInviteDependencies = require(scriptParentParent.GameInviteDependencies)
local GameInviteAnalyticsManager = require(scriptParentParent.analytics.GameInviteAnalyticsManager)
local FFlagGameInviteSpaceSends = require(scriptParentParent.Flags.FFlagGameInviteSpaceSends)
local spacedSender = require(scriptParentParent.utils.spacedSender)

local Throttle = require(scriptParentParentParent.NotificationsCommon).Throttle

local ReceivedUserInviteStatus = require(Actions.ReceivedUserInviteStatus)

local networkImpl = GameInviteDependencies.networkImpl
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local PostSendExperienceInvite = require(scriptParentParent.Requests.PostSendExperienceInvite)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useSignalState = require(scriptParentParentParent.SignalsReact).useSignalState
local SharedFlags = require(scriptParentParentParent.SharedFlags)
local GetFFlagFriendsMenuDummyLoadingFriendsFix = SharedFlags.GetFFlagFriendsMenuDummyLoadingFriendsFix
local FFlagUseSignalsForGameInvitesStatus = SharedFlags.FFlagUseSignalsForGameInvitesStatus
local GetGameInvitesStatusStore = if FFlagUseSignalsForGameInvitesStatus then require(scriptParentParentParent.NotificationsCommon).GetGameInvitesStatusStore else nil

return function(tbl1)
    local var1 = useDispatch()

    local var2 = React.useRef(0)

    local var3 = if FFlagUseSignalsForGameInvitesStatus then useSignalState(GetGameInvitesStatusStore(false).getGameInvitesStatus) else useSelector(function(arg1)
        return arg1.GameInvitesStatus
    end)

    local function getMaxRecipientRowNum() -- Luacid: Inlined by compiler; 1 call site recovered
        return var2.current
    end

    local inviteSingleFriend = Throttle(function(recipientUserId: string, recipientRowNumber: number)
        local var4 = var2
        var4.current = math.max(recipientRowNumber, (getMaxRecipientRowNum()))
        if GetFFlagFriendsMenuDummyLoadingFriendsFix()
            and (not recipientUserId or recipientUserId == "" or not tonumber(recipientUserId) or tonumber(recipientUserId) == 0)
            or var3[recipientUserId] and (var3[recipientUserId] ~= InviteStatus.Failed or var3[recipientUserId] == InviteStatus.Pending)
        then
            return
        end

        local var5

        if tbl1.isCoreScript then
            var5 = tostring(game.PlaceId)
        else
            local rootPlaceId = tbl1.rootPlaceId or tostring(game.PlaceId)
            var5 = rootPlaceId
        end

        if var5 == "0" then
            warn("Game Invite failed to send. Cannot send invite to unpublished Place.")
            if FFlagUseSignalsForGameInvitesStatus then
                GetGameInvitesStatusStore(false).receivedUserInviteStatus(recipientUserId, InviteStatus.Failed)
            else
                var1(ReceivedUserInviteStatus(recipientUserId, InviteStatus.Failed))
            end
            return
        end

        local isLaunchDataProvided = not (tbl1.launchData == nil) and tbl1.launchData ~= ""
        local isPromptCustomized = not (tbl1.promptMessage == nil) and tbl1.promptMessage ~= ""
        local isInviteMessageIdProvided = not (tbl1.inviteMessageId == nil) and tbl1.inviteMessageId ~= ""
        GameInviteAnalyticsManager:sendGameInviteModalEvent(tbl1.trigger, {
            action_type = GameInviteAnalyticsManager.ActionType.InviteTriggered,
            is_launch_data_provided = isLaunchDataProvided,
            is_prompt_customized = isPromptCustomized,
            is_invite_message_id_provided = isInviteMessageIdProvided,
            recipient_user_id = recipientUserId,
            recipient_row_number = recipientRowNumber
        })

        if FFlagUseSignalsForGameInvitesStatus then
            GetGameInvitesStatusStore(false).receivedUserInviteStatus(recipientUserId, InviteStatus.Pending)
        else
            var1(ReceivedUserInviteStatus(recipientUserId, InviteStatus.Pending))
        end

        local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
            return PostSendExperienceInvite(networkImpl, recipientUserId, var5, tbl1.trigger, tbl1.inviteMessageId, tbl1.launchData)
        end

        local var6 = if FFlagGameInviteSpaceSends then spacedSender.send(func2) else func2()

        var6:andThen(function(arg1)
            local localPlayer = Players.LocalPlayer
            GameInviteAnalyticsManager:onActivatedInviteSent(
                localPlayer.UserId,
                arg1.conversationId,
                { recipientUserId },
                tbl1.rootPlaceId,
                tbl1.universeId
            )
            if FFlagUseSignalsForGameInvitesStatus then
                GetGameInvitesStatusStore(false).receivedUserInviteStatus(recipientUserId, InviteStatus.Success)
                return
            end
            var1(ReceivedUserInviteStatus(recipientUserId, InviteStatus.Success))
        end, function()
            GameInviteAnalyticsManager:sendGameInviteModalEvent(tbl1.trigger, {
                action_type = GameInviteAnalyticsManager.ActionType.InviteFailure,
                is_launch_data_provided = isLaunchDataProvided,
                is_prompt_customized = isPromptCustomized,
                is_invite_message_id_provided = isInviteMessageIdProvided,
                recipient_user_id = recipientUserId,
                recipient_row_number = recipientRowNumber
            })
            if FFlagUseSignalsForGameInvitesStatus then
                GetGameInvitesStatusStore(false).receivedUserInviteStatus(recipientUserId, InviteStatus.Failed)
                return
            end
            var1(ReceivedUserInviteStatus(recipientUserId, InviteStatus.Failed))
        end)
    end)

    return React.createElement(
        InviteFriendContext.Provider,
        {
            value = {
                inviteSingleFriend = inviteSingleFriend,
                getMaxRecipientRowNum = getMaxRecipientRowNum
            }
        },
        tbl1.children
    )
end
