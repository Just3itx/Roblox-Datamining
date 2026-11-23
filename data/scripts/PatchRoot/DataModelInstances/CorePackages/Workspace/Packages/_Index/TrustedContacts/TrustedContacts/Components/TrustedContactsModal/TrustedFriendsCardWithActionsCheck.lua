-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)
local RoactUtils = require(TrustedContactsParent.RoactUtils)

local AppPage = require(TrustedContactsParent.RobloxAppEnums).AppPage

local Foundation = require(TrustedContactsParent.Foundation)
local IconSize = Foundation.Enums.IconSize

local useNavigation = require(TrustedContactsParent.Navigation).useNavigation

local TrustedContactsModalContainer = require(script.Parent.TrustedContactsModalContainer)

local useTrustedFriendAction = require(TrustedContacts.TrustedFriendActions.useTrustedFriendAction)
local TFActionsEnum = require(TrustedContacts.TrustedFriendActions.TFActionsEnum)

local Analytics = require(TrustedContacts.Analytics)
local useTCAnalytics = Analytics.useTCAnalytics
local EventNames = Analytics.EventNames

local FFlagTFUpdateAnalytics = require(TrustedContacts.Flags.FFlagTFUpdateAnalytics)
local FFlagTFPassQRCodeSource = require(TrustedContacts.Flags.FFlagTFPassQRCodeSource)

local _Types = require(TrustedContacts.Common.Types)

local function TrustedFriendsCardWithActionsCheck(arg1)
    local var1 = useNavigation()
    local userId = arg1.userId

    local var2 = useTrustedFriendAction(
        {
            userId = userId,
            tokens = arg1.tokens,
            sentFromQrCode = if FFlagTFPassQRCodeSource then arg1.sentFromQrCode else nil
        }
    )
    local isLoading = var2.isLoading
    local enum = var2.enum
    local fireAnalyticsEvent = if FFlagTFUpdateAnalytics then useTCAnalytics({ friendId = userId, source = arg1.source, tfActionsEnum = enum }).fireAnalyticsEvent else nil

    local var3 = React.useCallback(function()
        if FFlagTFUpdateAnalytics then
            fireAnalyticsEvent(EventNames.TCUpsellAgePrecheckTriggered)
        end

        arg1.externalNavigation.openFacialAgeEstimationUpsell({
            onSuccess = function()
                if FFlagTFUpdateAnalytics then
                    fireAnalyticsEvent(EventNames.TCUpsellAgePrecheckSucceeded)
                end
                var1.replace(AppPage.TrustedFriendsUserModal, {})
            end,
            onFailure = function()
                if FFlagTFUpdateAnalytics then
                    fireAnalyticsEvent(EventNames.TCUpsellAgePrecheckFailed)
                end
                arg1.externalNavigation.closeModal()
            end
        })
    end, { var1, arg1.externalNavigation, fireAnalyticsEvent })

    local bool1 = enum == TFActionsEnum.UnlockTrustedFriendByFAE

    RoactUtils.Hooks.useEffectOnce(function()
        var3()
    end, bool1)

    if bool1 then
        return nil
    elseif isLoading then
        return React.createElement(
            Foundation.View,
            { tag = "position-center-center auto-xy" },
            {
                LoadingIcon = React.createElement(Foundation.Loading, { LayoutOrder = 1, size = IconSize.Large })
            }
        )
    end

    return React.createElement(TrustedContactsModalContainer, {
        userId = arg1.userId,
        source = arg1.source,
        tokens = arg1.tokens,
        sentFromQrCode = arg1.sentFromQrCode,
        isVerticallyConstrained = arg1.isVerticallyConstrained,
        onRequestSent = arg1.onRequestSent,
        onRequestAccepted = arg1.onRequestAccepted,
        onAcknowledged = arg1.onAcknowledged,
        externalNavigation = arg1.externalNavigation,
        tfActionsEnum = enum
    })
end

return TrustedFriendsCardWithActionsCheck
