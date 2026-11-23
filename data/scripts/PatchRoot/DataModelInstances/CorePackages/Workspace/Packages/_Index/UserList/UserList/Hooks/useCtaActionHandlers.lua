-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local RoactUtils = require(UserListParent.RoactUtils)
local Localization = require(UserListParent.Localization)
local SocialCommon = require(UserListParent.SocialCommon)
local Enums = require(UserList.Common.Enums)

local EnteredChatFromEntryPoint = SocialCommon.Actions.EnteredChatFromEntryPoint

local FFlagUserListCtaAnalyticsEnabled = require(UserListParent.SharedFlags).FFlagUserListCtaAnalyticsEnabled
local FFlagUserListCanonicalCtaAnalytics = require(UserList.Flags.FFlagUserListCanonicalCtaAnalytics)
local reportCtaActivated = require(UserList.Analytics.reportCtaActivated)
local FFlagUserListRowViewCta = require(UserList.Flags.FFlagUserListRowViewCta)
local useEntitySelectionHandler = require(UserList.Hooks.useEntitySelectionHandler)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local ButtonTypes = Enums.ButtonTypes

local TextKeys = require(UserList.Common.TextKeys)
local _Types = require(UserList.Common.Types)
local friendingActions = require(UserList.Cta.friendingActions)

local notificationTypeList = GuiService:GetNotificationTypeList()

local function useCtaActionHandlers(arg1)
    local dispatch = useDispatch()
    local var2 = React.useRef({})

    local localized = useLocalization({
        friendRequestSent = TextKeys.FriendRequestSent,
        friendAdded = TextKeys.FriendAdded,
        invalidTargetUserError = TextKeys.InvalidTargetUserError,
        alreadyFriendError = TextKeys.AlreadyFriendError,
        maxFriendsError = TextKeys.MaxFriendsError,
        invalidNicknameError = TextKeys.InvalidNicknameError,
        unauthorizedError = TextKeys.UnauthorizedError,
        userBannedError = TextKeys.UserBannedError,
        userBlockedError = TextKeys.UserBlockedError,
        userNotPassedCaptchaError = TextKeys.UserNotPassedCaptchaError,
        tooManyRequestsError = TextKeys.TooManyRequestsError,
        defaultFriendingError = TextKeys.DefaultFriendingError
    })
    local friendshipOriginSourceType = if arg1 then arg1.friendshipOriginSourceType else nil
    local chatEntryPoint = if arg1 then arg1.chatEntryPoint else nil
    local onCtaActivated = if FFlagUserListCtaAnalyticsEnabled then if arg1 then arg1.onCtaActivated else nil else nil

    local analytics = if FFlagUserListCanonicalCtaAnalytics then if arg1 then arg1.analytics else nil else nil

    local var4 = nil
    if FFlagUserListRowViewCta then
        local var5 = React.useMemo(function()
            return { friendshipOriginSourceType = friendshipOriginSourceType }
        end, { friendshipOriginSourceType or false })
        var4 = useEntitySelectionHandler(nil, var5)
    end

    return React.useMemo(function()
        local module = {}
        module[ButtonTypes.Chat] = function(userId: string, num1: number?)
            if FFlagUserListCtaAnalyticsEnabled and onCtaActivated ~= nil then
                onCtaActivated({ buttonType = ButtonTypes.Chat, userId = userId })
            end
            if FFlagUserListCanonicalCtaAnalytics then
                reportCtaActivated(analytics, ButtonTypes.Chat, userId, num1)
            end

            if chatEntryPoint ~= nil then
                dispatch(EnteredChatFromEntryPoint(chatEntryPoint))
            end
            GuiService:BroadcastNotification(userId, notificationTypeList.LAUNCH_CONVERSATION)
        end

        module[ButtonTypes.Add] = function(str1: string, num1: number?)
            if var2.current[str1] then
                return
            end
            var2.current[str1] = true
            if FFlagUserListCtaAnalyticsEnabled and onCtaActivated ~= nil then
                onCtaActivated({ buttonType = ButtonTypes.Add, userId = str1 })
            end
            if FFlagUserListCanonicalCtaAnalytics then
                reportCtaActivated(analytics, ButtonTypes.Add, str1, num1)
            end
            friendingActions.executeAddFriend({
                dispatch = dispatch,
                targetUserId = str1,
                friendshipOriginSourceType = friendshipOriginSourceType,
                localized = localized
            }):finally(
                function()
                    var2.current[str1] = nil
                end
            )
        end
        module[ButtonTypes.Accept] = function(str1: string, num1: number?)
            if var2.current[str1] then
                return
            end
            var2.current[str1] = true
            if FFlagUserListCtaAnalyticsEnabled and onCtaActivated ~= nil then
                onCtaActivated({ buttonType = ButtonTypes.Accept, userId = str1 })
            end
            if FFlagUserListCanonicalCtaAnalytics then
                reportCtaActivated(analytics, ButtonTypes.Accept, str1, num1)
            end
            friendingActions.executeAcceptFriendRequest({ dispatch = dispatch, targetUserId = str1, localized = localized }):finally(
                function()
                    var2.current[str1] = nil
                end
            )
        end
        module[ButtonTypes.Dismiss] = function(str1: string, num1: number?)
            if var2.current[str1] then
                return
            end
            var2.current[str1] = true
            if FFlagUserListCtaAnalyticsEnabled and onCtaActivated ~= nil then
                onCtaActivated({ buttonType = ButtonTypes.Dismiss, userId = str1 })
            end
            if FFlagUserListCanonicalCtaAnalytics then
                reportCtaActivated(analytics, ButtonTypes.Dismiss, str1, num1)
            end
            friendingActions.executeDeclineFriendRequest({ dispatch = dispatch, targetUserId = str1, localized = localized }):finally(
                function()
                    var2.current[str1] = nil
                end
            )
        end
        module[ButtonTypes.View] = FFlagUserListRowViewCta and function(userId: string, num1: number?)
            if FFlagUserListCtaAnalyticsEnabled and onCtaActivated ~= nil then
                onCtaActivated({ buttonType = ButtonTypes.View, userId = userId })
            end
            if FFlagUserListCanonicalCtaAnalytics then
                reportCtaActivated(analytics, ButtonTypes.View, userId, num1)
            end
            var4(userId, Enums.EntityType.User)
        end or nil

        return module
    end, {
        dispatch,
        localized,
        friendshipOriginSourceType,
        onCtaActivated,
        chatEntryPoint,
        analytics,
        var4
    })
end
return useCtaActionHandlers
