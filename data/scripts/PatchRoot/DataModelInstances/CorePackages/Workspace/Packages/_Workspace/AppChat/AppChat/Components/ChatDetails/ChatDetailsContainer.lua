-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local UIBlox = require(AppChatParent.UIBlox)
local Promise = require(AppChatParent.Promise)
local getDeepValue = require(AppChat.Utils.getDeepValue)
local UserProfiles = require(AppChatParent.UserProfiles)

local useCallback = React.useCallback
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount
local useIsGroupChatEnabled = require(AppChat.Hooks.useIsGroupChatEnabled)
local useState = React.useState
local useStyle = UIBlox.Core.Style.useStyle
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local Conversation = require(AppChat.Models.Conversation)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local useUserProfilesFetch = UserProfiles.Hooks.useUserProfilesFetch
local userProfilesCombinedNameAndUsernameByUserIds = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
local useIsUserPending = require(AppChat.Hooks.useIsUserPending)
local LuaAppNavigationContext = require(AppChat.LuaAppNavigationContext)
local useNavigation = require(AppChatParent.Navigation).useNavigation
local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)
local useAppPolicy = require(AppChatParent.UniversalAppPolicy).useAppPolicy
local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local useChatPlacementContext = ChatPlacementContext.useChatPlacementContext
local isPlacementInExperience = ChatPlacementContext.isPlacementInExperience

local getConversationTitle = require(AppChat.Conversations.getConversationTitle)

local selectChatUserEntryModelList = require(script.Parent.Selectors.selectChatUserEntryModelList)
local ParticipantDialogContainer = require(script.Parent.ParticipantDialog.ParticipantDialogContainer)

local ChatDetailsPage = require(script.Parent.ChatDetailsPage)
local GenericDialogType = require(script.Parent.Dialogs.GenericDialogType)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatDetailsTelemetryLayer = require(AppChat.Telemetry.Layers.ChatDetailsTelemetryLayer)
local ChatDetailsTelemetryEvents = require(AppChat.Components.ChatDetails.ChatDetailsTelemetryEvents)
local ChatConversationTelemetryState = require(AppChat.Contexts.TelemetryState.ChatConversationTelemetryState)
local ChatDetailsTelemetryState = require(AppChat.Contexts.TelemetryState.ChatDetailsTelemetryState)
local FFlagAppChatUseUserProfileHydration = require(AppChat.Flags.FFlagAppChatUseUserProfileHydration)
local useProfileNames = require(AppChat.Hooks.useProfileNames)
local getCombinedNameFromProfileNames = require(AppChat.Users.getCombinedNameFromProfileNames)
local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled

local tbl1 = {
    topBarHeight = 0,
    wideMode = false,
    participants = nil,
    isGroupConversation = nil,
    isGroupOwner = nil,
    conversationId = nil,
    conversation = nil,
    navigateBack = function() end,
    navigateToEditChatMembers = function() end,
    navigateToDialog = function() end,
    navigateToToast = function() end,
    navigateToConversation = function() end,
    navigateToChatLanding = function() end
}

local function getParticipantProfiles(arg1, participants)
    local participantProfiles = ({})
    for k, participant in participants do
        local combinedName = getCombinedNameFromProfileNames(arg1, participant)
        if not combinedName then
            continue
        end

        participantProfiles[k] = {
            names = { combinedName = combinedName }
        }
    end
    return participantProfiles
end

return function(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1 or {})
    local style = useStyle()
    local var3 = useLocalization({
        pageHeaderText = if GetFFlagIsSquadEnabled() then "Feature.Chat.Label.Details" else "Feature.Chat.Label.ChatDetails",
        generalText = "Feature.Chat.Label.General",
        titleNotSetText = "Feature.Chat.Label.NotSet",
        membersText = "Feature.Chat.Label.Members",
        addFriendsText = "Feature.Chat.Label.AddFriends",
        leaveGroupText = "Feature.Chat.Heading.LeaveGroup",
        chatGroupText = if GetFFlagIsSquadEnabled() then "Feature.Chat.Label.GroupName" else "Feature.Chat.Label.ChatGroupName",
        onlinePresenceText = "Common.Presence.Label.Online",
        offlinePresenceText = "Common.Presence.Label.Offline",
        tooManyPeopleText = {
            if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.AddFriendsPartyLimit" else "Feature.Chat.Message.AddFriendsLimit",
            friendNum = 5,
            connectionsNum = 5
        },
        networkErrorToastText = "Feature.Toast.NetworkingError.SomethingIsWrong",
        conversationTypeHeaderText = "Feature.Chat.Label.ExpandedChatFeatures",
        enabledText = "Feature.Chat.Label.Available",
        disabledText = "Feature.Chat.Label.Unavailable",
        createUnfilteredChatText = "Feature.Chat.Label.CreateUnfilteredChat",
        createUnfilteredChatSubtitleText = "Feature.Chat.Description.CreateUnfilteredChatCell"
    })

    local var4 = React.useContext(LuaAppNavigationContext)
    local var5 = useDispatch()
    local isCreateUnfilteredChatLoading, var7 = useState(false)
    local var8, var9 = useState(nil)
    local anchorRef, var11 = useState(nil)
    local var12 = useNavigation()
    local var13 = useIsGroupChatEnabled()
    local var14 = useIsChatEnabled()
    useEffect(function()
        if not var14 then
            var1.navigateToChatLanding()
        end
    end, { var14, var1.navigateToChatLanding })

    local conversation = useSelector(function(arg2)
        return getDeepValue(arg2, `ChatAppReducer.Conversations.{var1.conversationId or ""}`) or Conversation.empty()
    end)
    local var16 = useSelector(function(arg2)
        return getDeepValue(arg2, `ChatAppReducer.ParticipantMetadata.{var1.conversationId or ""}`)
    end)
    local source = conversation and conversation.source

    useEffect(function()
        if source ~= "channels" then
            return
        end
        var5(AppChatNetworking.rodux.GetConversationsParticipantsMetadata.API({ var1.conversationId })):catch(function()
            warn("Error in ChatDetailsContainer -> GetConversationsParticipantsMetadata")
        end)
    end, { var1.conversationId, var1.participants, source })

    local var17 = nil
    local var18 = nil
    if FFlagAppChatUseUserProfileHydration then
        var18 = useProfileNames(conversation.participants)
    else
        var17 = useUserProfilesFetch({ userIds = conversation.participants, query = userProfilesCombinedNameAndUsernameByUserIds })
    end

    local var19 = useTelemetry(ChatDetailsTelemetryLayer.Context)

    local var20 = nil
    local var21 = nil
    local var22 = nil
    local var23, var24, var25, var26

    if conversation then
        var20 = useSelector(function(arg2)
            return selectChatUserEntryModelList(
                arg2,
                conversation.participants,
                if FFlagAppChatUseUserProfileHydration then getParticipantProfiles(var18, conversation.participants) elseif var17 and var17.data then var17.data.userProfiles else nil
            )
        end)

        var22 = conversation.conversationType == Conversation.Type.MULTI_USER_CONVERSATION
        var21 = useSelector(function(arg2)
            return var22 and conversation.initiator == arg2.LocalUserId
        end)
        var23 = getConversationTitle(conversation)

        if var16 then
            for value, value2 in var20 do
                local join = Cryo.Dictionary.join
                local tbl2 = {
                    metadata = var16[value]
                }
                var20[value] = join(value2, tbl2)
            end
        end

        var24 = useIsUserPending(conversation)
        var25 = var22 and var24
        if var25 then
            var13 = false
        end

        if conversation.moderationType == ConversationChannels.ModerationType.TrustedComms then
            var26 = true
        else
            var26 = false
        end
    else
        var26 = nil
        var23 = nil
        var25 = nil
        var24 = nil
    end
    local num1 = var20 and #var20 or 0
    local conversationTypeText = if var26 then var3.enabledText else var3.disabledText

    if conversation.isDefaultTitle then
        var23 = var3.titleNotSetText
    end

    local function func1(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        return Promise.new(function(callback, callback2)
            if #arg2.participants > 5 then
                callback2()
                return
            end
            callback()
        end)
    end

    local function onGroupNameEntryCellActivated()
        var1.navigateToDialog(GenericDialogType.EditChatGroupNameDialog, { conversationId = var1.conversationId })
    end

    local function onLeaveGroupCellActivated()
        local isRooted = if var12 then var12.getParam("isRooted", false) else false
        var1.navigateToDialog(GenericDialogType.LeaveGroupDialog, { conversationId = var1.conversationId, isRooted = isRooted })

        var19.emit(ChatDetailsTelemetryEvents.ChatDetailsLeaveGroupBtnClicked, {})
    end
    local onConversationTypeIconActivated = useCallback(function()
        if var12 then
            var4.navigateToUnfilteredThreadsLearnMore(var12.navigate)
            return
        end
        var4.navigateToUnfilteredThreadsLearnMore()
    end, { var4, var12 })
    local onCreateUnfilteredChatCellActivated = useCallback(function()
        var19.emit(ChatDetailsTelemetryEvents.ChatDetailsCreateUnfilteredChatCellClicked, {})
        var7(true)
        var5(AppChatNetworking.rodux.DuplicateConversation.API(var1.conversationId, "trusted_comms")):andThen(function(arg2)
            local responseBody = arg2.responseBody
            local id = responseBody and responseBody.conversations and responseBody.conversations[1] and responseBody.conversations[1].id
            if id then
                var1.navigateToConversation(id)
                return
            end
            var1.navigateToToast({ toastProps = { toastContent = { toastTitle = var3.networkErrorToastText } } })
        end):catch(function()
            var1.navigateToToast({ toastProps = { toastContent = { toastTitle = var3.networkErrorToastText } } })
        end):finally(
            function()
                var7(false)
            end
        )
    end, {
        var5,
        var7,
        var1.navigateToToast,
        var1.navigateToConversation,
        var1.conversationId,
        num1,
        var21,
        var19
    })

    local function onDismiss() -- Luacid: Inlined by compiler; 1 call site recovered
        var9(nil)
        var11(nil)
    end

    local function func5(toastTitle)
        var1.navigateToToast({ toastProps = { toastContent = { toastTitle = toastTitle } } })
    end

    local function func6(tooManyPeopleText)
        func1(conversation):andThen(function()
            var1.navigateToEditChatMembers(conversation)
        end, function()
            func5(tooManyPeopleText)
        end)
        var19.emit(ChatDetailsTelemetryEvents.ChatDetailsAddFriendsBtnClicked, {})
    end

    local shouldShowConversationTypeInfo = useAppPolicy(function(arg2)
        return arg2.getWebViewSupport()
    end)
    local chatPlacement = useChatPlacementContext().chatPlacement
    local var31 = isPlacementInExperience(chatPlacement)

    local moderationType = conversation and conversation.moderationType or Cryo.None
    local userPendingStatus = conversation and conversation.userPendingStatus or Cryo.None
    local var34 = ChatConversationTelemetryState.useMergeState()
    useEffect(function()
        var34({ conversationId = var1.conversationId, moderationType = moderationType, userPendingStatus = userPendingStatus })
    end, { var1.conversationId, moderationType, userPendingStatus })
    local var35 = ChatDetailsTelemetryState.useMergeState()
    useEffect(function()
        var35({ participantsCount = #conversation.participants, isGroupOwner = var21 })
    end, { #conversation.participants, var21 })

    useEffectOnMount(function()
        var19.emit(ChatDetailsTelemetryEvents.ScreenRendered, { isGroupConversation = var22 })
    end)

    local var36 = Cryo.Dictionary.join({
        navigateBack = var1.navigateBack,
        onGroupNameEntryCellActivated = onGroupNameEntryCellActivated,
        onLeaveGroupCellActivated = onLeaveGroupCellActivated,
        onParticipantCellActivated = function(arg2, arg3)
            local str1 = tostring(arg2)

            if var8 == str1 then
                onDismiss()
                return
            end

            var9(str1)
            var11(arg3)
        end,
        onAddFriendsCellActivated = function()
            return func6(var3.tooManyPeopleText)
        end,
        onConversationTypeIconActivated = onConversationTypeIconActivated,
        onCreateUnfilteredChatCellActivated = onCreateUnfilteredChatCellActivated,
        conversationTitle = var23,
        conversation = conversation,
        conversationId = var1.conversationId,
        participants = var20,
        isGroupConversation = var22,
        wideMode = var1.wideMode,
        shouldHideGroupChatFunctionality = var25,
        shouldShowAddFriends = var13,
        shouldShowCreateUnfilteredChat = false,
        shouldShowConversationTypeInfo = shouldShowConversationTypeInfo or var31,
        conversationTypeText = conversationTypeText,
        isCreateUnfilteredChatLoading = isCreateUnfilteredChatLoading,
        topBarHeight = var1.topBarHeight,
        LayoutOrder = 2,
        style = style
    }, var3)

    var36.activeParticipantId = var8

    return React.createElement(
        "ImageButton",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Active = true,
            AutoButtonColor = false,
            Selectable = false
        },
        {
            ChatDetailsPage = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            }, {
                UIListLayout = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
                Content = React.createElement(ChatDetailsPage, var36)
            }),
            ParticipantDialog = if var8 == nil then nil else React.createElement(ParticipantDialogContainer, {
                anchorRef = anchorRef,
                conversationId = var1.conversationId,
                isWideMode = var1.wideMode,
                navigateToDialog = var1.navigateToDialog,
                onDismiss = onDismiss,
                participantId = var8,
                showRemoveUserButton = not var24 and var22 and var21
            })
        }
    )
end
