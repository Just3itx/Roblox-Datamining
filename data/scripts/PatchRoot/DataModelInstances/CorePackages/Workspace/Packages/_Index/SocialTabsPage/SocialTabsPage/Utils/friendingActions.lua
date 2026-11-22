-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local DataHydration = require(SocialTabsPageParent.DataHydration)
local ProfileCTAStore = DataHydration.Profile.ProfileCTAStore
local friendsStoreChallengeNetwork = require(SocialTabsPage.Networking.friendsStoreChallengeNetwork)

local FFlagEnableFriendsStoreChallengeInterceptor = require(SocialTabsPageParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor
local var1 = DataHydration.Friends.FriendsStore.get()

local FriendingErrorCodes = require(SocialTabsPage.Enums.FriendingErrorCodes)

local Images = require(SocialTabsPageParent.UIBlox).App.ImageSet.Images

local SetCurrentToastMessage = require(SocialTabsPageParent.ToastRodux).Actions.SetCurrentToastMessage
local NetworkingFriends = require(SocialTabsPage.Networking.NetworkingFriends)

local FFlagMigrateFriendshipStatusesRemainingActions = require(SocialTabsPageParent.SharedFlags).FFlagMigrateFriendshipStatusesRemainingActions

local iconsActionsFriendsFriendAdd = Images["icons/actions/friends/friendAdd"]

local function refreshCTA(targetUserId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    ProfileCTAStore.get().getCTA(targetUserId, true)
end

local function getErrorToastMessage(localized, statusCode: number?, num1: number?)
    if statusCode == 400 then
        return ({
            [FriendingErrorCodes.INVALID_TARGET_USER] = localized.invalidTargetUserError,
            [FriendingErrorCodes.ALREADY_FRIEND] = localized.alreadyFriendError,
            [FriendingErrorCodes.MAX_FRIENDS] = localized.maxFriendsError,
            [FriendingErrorCodes.INVALID_NICKNAME] = localized.invalidNicknameError
        })[num1]
    elseif statusCode == 401 then
        return ({
            [FriendingErrorCodes.UNAUTHORIZED] = localized.unauthorizedError
        })[num1]
    end
    if statusCode ~= 403 then
        if statusCode ~= 429 then
            return nil
        end

        return ({
            [FriendingErrorCodes.TOO_MANY_REQUESTS] = localized.tooManyRequestsError
        })[num1]
    end

    return ({
        [FriendingErrorCodes.USER_BANNED] = localized.userBannedError,
        [FriendingErrorCodes.USER_BLOCKED] = localized.userBlockedError,
        [FriendingErrorCodes.USER_NOT_PASSED_CAPTCHA] = localized.userNotPassedCaptchaError
    })[num1]
end

local function showErrorToast(callback: (...any) -> (...any), localized, arg1)
    local defaultFriendingError = localized.defaultFriendingError

    if arg1 ~= nil then
        local statusCode = arg1.StatusCode
        local success, result = pcall(function()
            if arg1.Body then
                return (HttpService:JSONDecode(arg1.Body))
            end

            return nil
        end)

        local code = if success and result and result.errors and result.errors[1] and result.errors[1].code then result.errors[1].code else nil
        defaultFriendingError = getErrorToastMessage(localized, statusCode, code) or defaultFriendingError
    end

    callback(SetCurrentToastMessage({ toastMessage = defaultFriendingError, isLocalized = true }))
end

return {
    executeAddFriend = function(tbl1)
        local var2

        if FFlagMigrateFriendshipStatusesRemainingActions then
            var2 = var1.RequestFriendship(
                tbl1.targetUserId,
                tbl1.friendshipOriginSourceType,
                nil,
                if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil
            )
        else
            var2 = tbl1.dispatch(
                NetworkingFriends.RequestFriendshipFromUserId.API({
                    currentUserId = tbl1.currentUserId,
                    targetUserId = tbl1.targetUserId,
                    friendshipOriginSourceType = tbl1.friendshipOriginSourceType
                })
            )
        end

        return var2:andThen(function()
            refreshCTA(tbl1.targetUserId)
            tbl1.dispatch(
                SetCurrentToastMessage(
                    {
                        toastMessage = tbl1.localized.friendRequestSent,
                        toastIcon = iconsActionsFriendsFriendAdd,
                        isLocalized = true
                    }
                )
            )
        end):catch(function(arg1)
            showErrorToast(tbl1.dispatch, tbl1.localized, arg1)
        end)
    end,
    executeAcceptFriendRequest = function(tbl1)
        local var2 = if FFlagMigrateFriendshipStatusesRemainingActions then var1.AcceptFriendRequest(tbl1.targetUserId) else tbl1.dispatch(
            NetworkingFriends.AcceptFriendRequestFromUserId.API(
                {
                    currentUserId = tbl1.currentUserId,
                    targetUserId = tbl1.targetUserId
                }
            )
        )

        return var2:andThen(function()
            refreshCTA(tbl1.targetUserId)
            tbl1.dispatch(
                SetCurrentToastMessage(
                    {
                        toastMessage = tbl1.localized.friendAdded,
                        toastIcon = iconsActionsFriendsFriendAdd,
                        isLocalized = true
                    }
                )
            )
        end):catch(function(arg1)
            showErrorToast(tbl1.dispatch, tbl1.localized, arg1)
        end)
    end
}
