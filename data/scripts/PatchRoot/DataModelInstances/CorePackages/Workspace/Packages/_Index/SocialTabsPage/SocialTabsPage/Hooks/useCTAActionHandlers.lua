-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local RoactUtils = require(SocialTabsPageParent.RoactUtils)
local RobloxAppHooks = require(SocialTabsPageParent.RobloxAppHooks)
local SocialCommon = require(SocialTabsPageParent.SocialCommon)
local Localization = require(SocialTabsPageParent.Localization)
local FriendsNetworking = require(SocialTabsPageParent.FriendsNetworking)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalUserId = RobloxAppHooks.useLocalUserId
local useLocalization = Localization.Hooks.useLocalization
local EnteredChatFromEntryPoint = require(SocialTabsPageParent.AppChat.EnteredChatFromEntryPoint)
local ChatEntryPointNames = SocialCommon.Enums.ChatEntryPointNames
local FriendshipOriginSourceType = FriendsNetworking.Enums.FriendshipOriginSourceType

local ButtonTypes = require(SocialTabsPageParent.UserList).Enums.ButtonTypes

local TextKeys = require(SocialTabsPage.Common.TextKeys)
local _Types = require(SocialTabsPage.Common.Types)
local friendingActions = require(SocialTabsPage.Utils.friendingActions)

local notificationTypeList = GuiService:GetNotificationTypeList()

local function useCTAActionHandlers()
    local dispatch = useDispatch()
    local currentUserId = useLocalUserId()
    local var3 = React.useRef({})

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

    return React.useMemo(function()
        local module = {}
        module[ButtonTypes.Chat] = function(str1: string)
            dispatch(EnteredChatFromEntryPoint(ChatEntryPointNames.SocialTab))
            GuiService:BroadcastNotification(str1, notificationTypeList.LAUNCH_CONVERSATION)
        end

        module[ButtonTypes.Add] = function(targetUserId: string)
            if var3.current[targetUserId] then
                return
            end
            var3.current[targetUserId] = true
            friendingActions.executeAddFriend({
                dispatch = dispatch,
                currentUserId = currentUserId,
                targetUserId = targetUserId,
                friendshipOriginSourceType = FriendshipOriginSourceType.UserProfile.rawValue(),
                localized = localized
            }):finally(
                function()
                    var3.current[targetUserId] = nil
                end
            )
        end
        module[ButtonTypes.Accept] = function(targetUserId: string)
            if var3.current[targetUserId] then
                return
            end
            var3.current[targetUserId] = true
            friendingActions.executeAcceptFriendRequest(
                {
                    dispatch = dispatch,
                    currentUserId = currentUserId,
                    targetUserId = targetUserId,
                    localized = localized
                }
            ):finally(
                function()
                    var3.current[targetUserId] = nil
                end
            )
        end

        return module
    end, { dispatch, currentUserId, localized })
end

return useCTAActionHandlers
