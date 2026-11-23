-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local Dash = require(UserSearchParent.Dash)

local UIBlox = require(UserSearchParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle

local _LocalTypes = require(UserSearch.Common.LocalTypes)
local useRelationshipSelector = require(script.Parent.useRelationshipSelector)
local EventNames = require(UserSearch.Analytics.EventNames)
local RoactUtils = require(UserSearchParent.RoactUtils)
local FriendsNetworking = require(UserSearch.Networking.FriendsNetworking)
local Enums = require(UserSearchParent.FriendsNetworking).Enums
local useJoinUserInExperience = require(UserSearchParent.SocialExperienceJoin).useJoinUserInExperience
local Contexts = require(UserSearchParent.SocialLuaAnalytics).Analytics.Enums.Contexts
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalUserId = require(UserSearchParent.RobloxAppHooks).useLocalUserId
local SetCurrentToastMessage = require(UserSearchParent.ToastRodux).Actions.SetCurrentToastMessage
local PresenceHelpers = require(UserSearch.Utils.PresenceHelpers)

local FocusNavigationEventNameEnum = require(UserSearchParent.FocusNavigationUtils).FocusNavigationEventNameEnum

local FFlagUserSearchAddFocusActionsSupport = require(UserSearchParent.SharedFlags).FFlagUserSearchAddFocusActionsSupport
local FFlagSduiUserSearchTile = require(UserSearchParent.SharedFlags).FFlagSduiUserSearchTile

local FFlagUserSearchHideFriendActionsForBlockedUsers = require(UserSearch.Flags.FFlagUserSearchHideFriendActionsForBlockedUsers)
local FFlagMigrateFriendshipStatusesUserSearch = require(UserSearch.Flags.FFlagMigrateFriendshipStatusesUserSearch)
local FFlagUserSearchJoinPassStorePresence = require(UserSearch.Flags.FFlagUserSearchJoinPassStorePresence)
local useIsUserBlocked = if FFlagUserSearchHideFriendActionsForBlockedUsers then require(script.Parent.useIsUserBlocked) else nil
local friendsStoreChallengeNetwork = require(UserSearch.Networking.friendsStoreChallengeNetwork)

local FFlagEnableFriendsStoreChallengeInterceptor = require(UserSearchParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor
local var1 = require(UserSearchParent.DataHydration).Friends.FriendsStore.get()
local Enums2 = require(UserSearchParent.DataHydration).Friends.Enums

local var2 = FFlagMigrateFriendshipStatusesUserSearch or FFlagSduiUserSearchTile

return function(arg1, callback: ((...any) -> (...any))?)
    local currentUserId = useLocalUserId()
    local var4 = useDispatch()
    local var5 = useRelationshipSelector(arg1.userId)
    local var6 = useStyle()
    local var7 = if FFlagUserSearchHideFriendActionsForBlockedUsers then useIsUserBlocked(arg1.userId) else false
    local var8 = useJoinUserInExperience(arg1.userId, {
        analyticProps = {
            context = Contexts.PlayerSearch,
            subpage = arg1.subpage
        },
        presence = if FFlagUserSearchJoinPassStorePresence then arg1.userPresence else nil
    })
    local icon = if arg1.shouldUseCompactTiles then Images["icons/common/plus_small"] else Images["icons/actions/friends/friendAdd"]
    local var3 = if arg1.shouldUseCompactTiles then Images["icons/common/plus_small"] else Images["icons/actions/friends/friendpending"]
    local iconsCommonPlay = Images["icons/common/play"]

    if FFlagUserSearchHideFriendActionsForBlockedUsers and var7 then
        return nil
    end

    if var5.status == Enum.FriendStatus.Friend
        and arg1.shouldUseCompactTiles
        and PresenceHelpers.isUserInGame(arg1.userPresence)
    then
        local tbl1 = {
            icon = iconsCommonPlay,
            isSecondary = false,
            isDisabled = var8.isLoading,
            onActivated = function()
                var8.joinExperience()
            end,
            imageColor = var6.Theme.ContextualPrimaryContent.Color,
            backgroundColor = var6.Theme.OnlineStatus.Color,
            focusEventName = if FFlagUserSearchAddFocusActionsSupport and arg1.shouldAddFocusEventName then FocusNavigationEventNameEnum.HoldToPlay else nil
        }

        return { tbl1 }
    end

    if var5.isMyself or var5.status == Enum.FriendStatus.Friend then
        return nil
    end

    if var5.status == Enum.FriendStatus.FriendRequestReceived then
        local tbl1 = {
            icon = icon,
            isSecondary = false,
            isDisabled = false,
            focusEventName = if FFlagUserSearchAddFocusActionsSupport and arg1.shouldAddFocusEventName then FocusNavigationEventNameEnum.HoldToAcceptFriendRequest else nil,
            onActivated = 0
        }

        function tbl1.onActivated()
            local var11 = if var2 then var1.AcceptFriendRequest(arg1.userId) else var4(FriendsNetworking.AcceptFriendRequestFromUserId.API({ targetUserId = arg1.userId, currentUserId = currentUserId }))

            var11:andThen(function()
                var4(SetCurrentToastMessage({ toastMessage = "Feature.Friends.Action.FriendAdded" }))
            end):catch(function()
                var4(SetCurrentToastMessage({ toastMessage = "Feature.Toast.NetworkingError.SomethingIsWrong" }))
            end)

            if callback then
                callback(EventNames.PlayerFriendAccept)
            end
        end

        return { tbl1 }
    end

    if var5.status == Enum.FriendStatus.FriendRequestSent then
        return {{
            icon = var3,
            isSecondary = false,
            isDisabled = true,
            onActivated = Dash.noop()
        }}
    end
    if var5.status and var5.status ~= Enum.FriendStatus.NotFriend then
        return nil
    end

    local tbl1 = {
        icon = icon,
        isSecondary = false,
        isDisabled = false,
        focusEventName = if FFlagUserSearchAddFocusActionsSupport and arg1.shouldAddFocusEventName then FocusNavigationEventNameEnum.HoldToAddFriend else nil,
        onActivated = 0
    }

    function tbl1.onActivated()
        local var11

        if var2 then
            var11 = var1.RequestFriendship(
                arg1.userId,
                Enums2.FriendshipOriginSourceType.PlayerSearch,
                nil,
                if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil
            )
        else
            var11 = var4(
                FriendsNetworking.RequestFriendshipFromUserId.API({
                    targetUserId = arg1.userId,
                    currentUserId = currentUserId,
                    friendshipOriginSourceType = Enums.FriendshipOriginSourceType.PlayerSearch.rawValue()
                })
            )
        end

        var11:andThen(function()
            var4(SetCurrentToastMessage({ toastMessage = "Feature.Friends.Action.FriendRequestSent" }))
        end):catch(function()
            var4(SetCurrentToastMessage({ toastMessage = "Feature.Toast.NetworkingError.SomethingIsWrong" }))
        end)

        if callback then
            callback(EventNames.PlayerFriendRequest)
        end
    end

    return { tbl1 }
end
