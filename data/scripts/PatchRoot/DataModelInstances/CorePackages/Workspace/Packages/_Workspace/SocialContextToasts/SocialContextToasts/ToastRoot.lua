-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialContextToasts = script:FindFirstAncestor("SocialContextToasts")
local SocialContextToastsParent = SocialContextToasts.Parent
local ToastWrapper = require(SocialContextToasts.ToastWrapper)
local useSelector = require(SocialContextToastsParent.RoactUtils).Hooks.RoactRodux.useSelector
local React = require(SocialContextToastsParent.React)
local ToastTypes = require(SocialContextToasts.Enums.ToastTypes)
local ButtonType = require(SocialContextToastsParent.UIBlox).App.Button.Enum.ButtonType
local Cryo = require(SocialContextToastsParent.Cryo)

local GetFFlagEnableReferredPlayerJoinRemoteEvent = require(SocialContextToastsParent.SharedFlags).GetFFlagEnableReferredPlayerJoinRemoteEvent

local function ToastRoot(arg1)
    local var1 = useSelector(function(arg2)
        return arg2.ToastContent
    end)

    local analyticsProps = Cryo.Dictionary.join(arg1.analyticsProps, { toastType = var1.toastType })

    if var1.toastType == ToastTypes.None then
        return nil
    elseif var1.toastType == ToastTypes.YouJoinedFriends then
        local userList = var1.userList
        local toastStrings = #userList == 1
            and {
                label = {
                    "Feature.SocialContextToast.Message.YouJoinedOneFriend",
                    FRIEND_NAME = userList[1].name
                }
            }
            or #userList == 2
                and {
                    label = {
                        "Feature.SocialContextToast.Message.YouJoinedTwoFriends",
                        FRIEND_NAME_ONE = userList[1].name,
                        FRIEND_NAME_TWO = userList[2].name
                    }
                }
            or #userList > 2
                and {
                    label = {
                        "Feature.SocialContextToast.Message.YouJoinedManyFriends",
                        FRIEND_NAME = userList[1].name,
                        FRIEND_COUNT = #userList - 1
                    }
                }
            or nil

        local userIdList = {}
        for value, _ in userList do
            table.insert(userIdList, userList[value].userId)
        end
        return React.createElement(
            ToastWrapper,
            {
                toastStrings = toastStrings,
                userIdList = userIdList,
                analyticsProps = analyticsProps
            }
        )
    elseif var1.toastType == ToastTypes.FriendJoinedYou then
        return React.createElement(ToastWrapper, {
            toastStrings = {
                label = {
                    "Feature.SocialContextToast.Message.FriendJoinedYou",
                    FRIEND_NAME = var1.joinerName
                }
            },
            userIdList = { var1.joinerUserId },
            analyticsProps = analyticsProps
        })
    elseif var1.toastType == ToastTypes.FriendInNonRootPlace then
        return React.createElement(ToastWrapper, {
            toastStrings = {
                label = {
                    "Feature.SocialContextToast.Message.FriendInNonRootPlace",
                    FRIEND_NAME = var1.joinerName
                }
            },
            userIdList = { var1.joinerUserId },
            analyticsProps = analyticsProps
        })
    elseif var1.toastType == ToastTypes.FollowYourFriend then
        return React.createElement(ToastWrapper, {
            toastStrings = {
                label = {
                    "Feature.SocialContextToast.Message.FollowedFriendInOtherUniverse",
                    FRIEND_NAME = var1.joinerName,
                    EXPERIENCE_NAME = var1.experienceName
                },
                button = "Feature.SocialContextToast.Action.JoinFriend"
            },
            userIdList = { var1.joinerUserId },
            onActivated = var1.onActivated,
            buttonType = ButtonType.PrimaryContextual,
            analyticsProps = analyticsProps
        })
    elseif var1.toastType == ToastTypes.InviteBack then
        return React.createElement(ToastWrapper, {
            toastStrings = {
                label = {
                    "Feature.SocialContextToast.Message.FollowedFriendNotInGame",
                    FRIEND_NAME = var1.joinerName
                },
                button = "Feature.SocialContextToast.Action.InviteBack"
            },
            userIdList = { var1.joinerUserId },
            onActivated = var1.onActivated,
            areUsersActive = false,
            analyticsProps = analyticsProps
        })
    elseif var1.toastType == ToastTypes.InviteSuccess then
        return React.createElement(ToastWrapper, {
            toastStrings = { label = "Feature.SocialContextToast.Message.InvitationConfirmation" },
            analyticsProps = analyticsProps
        })
    elseif var1.toastType == ToastTypes.InviteFailure then
        return React.createElement(
            ToastWrapper,
            {
                toastStrings = { label = "Feature.SocialContextToast.Message.InvitationFailure" },
                analyticsProps = analyticsProps
            }
        )
    elseif GetFFlagEnableReferredPlayerJoinRemoteEvent() and var1.toastType == ToastTypes.InviteeJoinedYou then
        return React.createElement(ToastWrapper, {
            toastStrings = {
                label = {
                    "Feature.SocialContextToast.Message.InviteeJoinedYou",
                    INVITEE_NAME = var1.joinerName
                }
            },
            userIdList = { var1.joinerUserId },
            analyticsProps = analyticsProps
        })
    else
        return nil
    end
end
return ToastRoot
