-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local DataHydration = require(UserListParent.DataHydration)
local ProfileCTAStore = DataHydration.Profile.ProfileCTAStore
local Requests = DataHydration.Friends.Requests
local FriendsStore = DataHydration.Friends.FriendsStore
local friendsStoreChallengeNetwork = require(UserList.Networking.friendsStoreChallengeNetwork)

local FFlagEnableFriendsStoreChallengeInterceptor = require(UserListParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor

local Images = require(UserListParent.UIBlox).App.ImageSet.Images

local SetCurrentToastMessage = require(UserListParent.ToastRodux).Actions.SetCurrentToastMessage

local FriendingErrorCodes = require(script.Parent.FriendingErrorCodes)

local iconsActionsFriendsFriendAdd = Images["icons/actions/friends/friendAdd"]

local function refreshCTA(targetUserId: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    ProfileCTAStore.get().getCTA(targetUserId, true)
end

local function getErrorToastMessage(localized, num1: number?, num2: number?)
    if num1 == 400 then
        return ({
            [FriendingErrorCodes.INVALID_TARGET_USER] = localized.invalidTargetUserError,
            [FriendingErrorCodes.ALREADY_FRIEND] = localized.alreadyFriendError,
            [FriendingErrorCodes.MAX_FRIENDS] = localized.maxFriendsError,
            [FriendingErrorCodes.INVALID_NICKNAME] = localized.invalidNicknameError
        })[num2]
    elseif num1 == 401 then
        return ({
            [FriendingErrorCodes.UNAUTHORIZED] = localized.unauthorizedError
        })[num2]
    end
    if num1 ~= 403 then
        if num1 ~= 429 then
            return nil
        end

        return ({
            [FriendingErrorCodes.TOO_MANY_REQUESTS] = localized.tooManyRequestsError
        })[num2]
    end

    return ({
        [FriendingErrorCodes.USER_BANNED] = localized.userBannedError,
        [FriendingErrorCodes.USER_BLOCKED] = localized.userBlockedError,
        [FriendingErrorCodes.USER_NOT_PASSED_CAPTCHA] = localized.userNotPassedCaptchaError
    })[num2]
end

local function showErrorToast(callback: (...any) -> (...any), localized, arg1)
    local statusCode = if type(arg1) == "table" then arg1.statusCode else nil
    local firstErrorCode = if type(arg1) == "table" then arg1.firstErrorCode else nil
    local toastMessage = getErrorToastMessage(localized, statusCode, firstErrorCode) or localized.defaultFriendingError

    callback(SetCurrentToastMessage({ toastMessage = toastMessage, isLocalized = true }))
end

return {
    executeAddFriend = function(tbl1)
        local requestFriendshipFromUserId = Requests.RequestFriendshipFromUserId
        local targetUserId = tbl1.targetUserId
        local friendshipOriginSourceType = tbl1.friendshipOriginSourceType
        local var1 = if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil

        return requestFriendshipFromUserId(targetUserId, friendshipOriginSourceType, var1):andThen(function()
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
        return FriendsStore.get().AcceptFriendRequest(tbl1.targetUserId):andThen(function()
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
    end,
    executeDeclineFriendRequest = function(tbl1)
        return FriendsStore.get().DeclineFriendRequest(tbl1.targetUserId):andThen(function()
            refreshCTA(tbl1.targetUserId)
        end):catch(function(arg1)
            showErrorToast(tbl1.dispatch, tbl1.localized, arg1)
        end)
    end
}
