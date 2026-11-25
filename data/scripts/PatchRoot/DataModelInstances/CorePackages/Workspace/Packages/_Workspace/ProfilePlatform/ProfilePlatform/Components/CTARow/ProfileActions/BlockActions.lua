-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Foundation = require(ProfilePlatformParent.Foundation)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local RobloxAppEnums = require(ProfilePlatformParent.RobloxAppEnums)

local ButtonVariant = Foundation.Enums.ButtonVariant
local Images = UIBlox.App.ImageSet.Images
local AppPage = RobloxAppEnums.AppPage

local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage
local myUserBlockingNetworking = require(ProfilePlatform.Networking.myUserBlockingNetworking)
local refreshProfilePlatformActionInfo = require(ProfilePlatform.Networking.refreshProfilePlatformActionInfo)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local Constants = require(ProfilePlatform.Common.Constants)
local ProfileTypes = Enums.ProfileTypes

local USER_BLOCKING_ERRORS = Constants.USER_BLOCKING_ERRORS

local module = {}
module[Enums.ProfileActions.Block] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.Block],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonBlock, { buttonSurface = arg1.buttonSurface })

        arg1.navigation.push(AppPage.BlockingModal, {
            navProps = {
                userId = arg1.profileId,
                onBlockSuccess = function()
                    arg1.dispatch(
                        SetCurrentToastMessage(
                            {
                                toastMessage = arg1.localized.userBlockedToast,
                                toastIcon = Images["icons/actions/block"],
                                isLocalized = true
                            }
                        )
                    )
                    arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
                end
            }
        })
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.Unblock] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Standard,
        text = arg1.localized[Enums.ProfileActions.Unblock],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonUnblock, { buttonSurface = arg1.buttonSurface })

        return arg1.dispatch(
            myUserBlockingNetworking.UnblockUserById.API({ userId = arg1.profileId, currentUserId = arg1.localUserId })
        ):andThen(
            function()
                return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
            end
        ):catch(
            function(arg2)
                if arg2 ~= nil and tonumber(arg2.Body) == USER_BLOCKING_ERRORS.PARENT_BLOCKED_TARGET_USER_ERROR then
                    arg1.dispatch(
                        SetCurrentToastMessage({ toastMessage = arg1.localized.unblockTargetParentManagedToast, isLocalized = true })
                    )
                elseif arg2 ~= nil and tonumber(arg2.Body) == USER_BLOCKING_ERRORS.UNBLOCK_TARGET_NOT_BLOCKED_ERROR then
                    arg1.dispatch(
                        SetCurrentToastMessage({ toastMessage = arg1.localized.unblockTargetNotBlockedToast, isLocalized = true })
                    )
                elseif arg2 ~= nil and tonumber(arg2.Body) == USER_BLOCKING_ERRORS.UNBLOCK_TARGET_BLOCKED_ON_PLATFORM then
                    arg1.dispatch(SetCurrentToastMessage({ toastMessage = arg1.localized.blockedOnPlatformToast, isLocalized = true }))
                else
                    arg1.dispatch(SetCurrentToastMessage({ toastMessage = arg1.localized.somethingIsWrongToast, isLocalized = true }))
                end
            end
        )
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
