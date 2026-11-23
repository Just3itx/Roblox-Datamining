-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local UserProfiles = require(AppChatParent.UserProfiles)
local OsaContextCardOneToOne = require(AppChat.Components.ChatConversation.ConversationCards.OsaContextCardOneToOne)
local getThumbnailsForUserIds = require(AppChat.Users.getThumbnailsForUserIds)
local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local RoduxNetworking = require(AppChat.Http.RoduxNetworking)
local var1 = require(AppChat.Logger):new(script.Name)

local useUserProfilesFetch = UserProfiles.Hooks.useUserProfilesFetch
local useProfileName = require(AppChat.Hooks.useProfileName)
local DataStatus = require(AppChatParent.DataHydration).DataStatus
local getCombinedNameFromId = UserProfiles.Selectors.getCombinedNameFromId
local getUsernameFromId = UserProfiles.Selectors.getUsernameFromId
local API = AppChatNetworking.rodux.GetConversationDetails.API

local useGetOneToOneFriendIdFromConversationId = require(AppChat.Hooks.useGetOneToOneFriendIdFromConversationId)
local useIsGuiInChatVisible = require(AppChat.Hooks.useIsGuiInChatVisible)
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)

local useRecordModalSequenceResponseForConversation = require(AppChat.Hooks.useRecordModalSequenceResponseForConversation)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useIsChatUserMessagesEnabled = require(AppChat.Hooks.useIsChatUserMessagesEnabled)

local FFlagEnableBlackbirdCheck = require(AppChatParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagAppChatUseUserProfileHydration = require(AppChat.Flags.FFlagAppChatUseUserProfileHydration)
local useIsRobloxSubscriber = UserProfiles.Hooks.useIsRobloxSubscriber

return React.memo(function(tbl1)
    local var2 = useDispatch()
    local userId = useGetOneToOneFriendIdFromConversationId(tbl1.conversationId) or ""
    local var4 = useChatPagePadding()
    local padding = React.useMemo(function()
        return {
            left = UDim.new(0, var4.left),
            right = UDim.new(0, var4.right)
        }
    end, { var4.left, var4.right })

    local isChatUserMessagesEnabled = useIsChatUserMessagesEnabled()

    local var7 = useIsRobloxSubscriber(if FFlagEnableBlackbirdCheck then if userId == "" then nil else userId else nil)

    local var8 = nil
    local var9 = nil
    if FFlagAppChatUseUserProfileHydration then
        var9 = useProfileName(userId)
    else
        var8 = useUserProfilesFetch({
            userIds = { userId },
            query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds,
            overrideRetryCount = 4
        })
    end

    local var10, var11 = React.useState(false)

    local var12 = useRecordModalSequenceResponseForConversation(tbl1.conversationId)

    local onAvatarActivated = React.useCallback(function()
        if tbl1.openViewProfile then
            tbl1.openViewProfile(userId)
        end
    end, { userId })

    local var14 = useGetConversationFromId(tbl1.conversationId)
    local var15 = var14 and var14.osaAcknowledgementStatus == AppChatNetworking.Constants.OsaAcknowledgementStatusResponse.Unacknowledged

    local ref = React.useRef(nil)
    local var17 = useIsGuiInChatVisible(ref, { ref.current })
    if not var15 then
        var17 = false
    end
    local var18 = useSelector(function(arg1)
        return AppChatNetworking.rodux.RecordModalSequenceResponse.getStatus(arg1, tbl1.conversationId)
    end)

    local var19, var20 = React.useState(nil)
    local var21, var22 = React.useState(nil)

    React.useEffect(function()
        if not var15 or not var17 or var18 == RoduxNetworking.Enum.NetworkStatus.Fetching or var10 or not var12 then
            return
        end
        var12("record_has_seen", "conversation_inline_top_modal", nil, "OsaContextCard"):andThen(function()
            var11(true)
            if var14 and var14.source ~= "friends" then
                var2(API(tbl1.conversationId))
            end
        end):catch(function(arg1)
            var1:error(
                "Error in OsaContextCardOneToOneContainer -> recordModalSequenceResponseForConversation -> record_has_seen: " .. tostring(arg1)
            )
        end)
    end, {
        var15,
        var17,
        var18,
        var12,
        var10,
        var2,
        tbl1.conversationId
    })

    local useEffect = React.useEffect

    local function func1()
        if not FFlagAppChatUseUserProfileHydration and var8.data and userId then
            local usernameFromId = getUsernameFromId(var8.data, userId)
            var20(if usernameFromId then "@" .. usernameFromId else nil)
            var22(getCombinedNameFromId(var8.data, userId))
        end
    end

    local data = if FFlagAppChatUseUserProfileHydration then nil else var8.data
    useEffect(func1, { userId, data })

    local avatarThumbnail = React.useMemo(function()
        return getThumbnailsForUserIds({ userId })[1]
    end, { userId })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "col size-full-0 auto-y align-x-center padding-top-xxlarge padding-bottom-large",
        padding = padding
    }
    local tbl3 = { OsaContextCardOneToOne = 0 }
    local createElement2 = React.createElement
    local var24 = OsaContextCardOneToOne
    local tbl4 = {
        displayName = 0,
        username = 0,
        avatarThumbnail = 0,
        onAvatarActivated = 0,
        hasError = 0,
        isChatUserMessagesEnabled = 0,
        ref = 0,
        userId = 0,
        isRobloxSubscriber = 0
    }

    if FFlagAppChatUseUserProfileHydration then
        var21 = var9.combinedName
    end

    tbl4.displayName = var21
    if FFlagAppChatUseUserProfileHydration then
        if var9.username then
            var19 = "@" .. var9.username
        else
            var19 = nil
        end
    end

    tbl4.username = var19

    tbl4.avatarThumbnail = avatarThumbnail
    tbl4.onAvatarActivated = onAvatarActivated
    tbl4.hasError = if FFlagAppChatUseUserProfileHydration then var9.status == DataStatus.Failed else not not var8.error

    tbl4.isChatUserMessagesEnabled = isChatUserMessagesEnabled
    tbl4.ref = ref
    tbl4.userId = userId
    if not FFlagEnableBlackbirdCheck then
        var7 = nil
    end

    tbl4.isRobloxSubscriber = var7
    tbl3.OsaContextCardOneToOne = createElement2(var24, tbl4)
    return createElement(view, tbl2, tbl3)
end)
