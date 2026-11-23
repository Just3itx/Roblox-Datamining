-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)
local RoactUtils = require(TrustedContactsParent.RoactUtils)
local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization
local Sources = require(TrustedContactsParent.SocialLuaAnalytics).Analytics.Enums.Sources

local TrustedConnectionStatus = require(TrustedContacts.Enums).TrustedConnectionStatus
local useModalTexts = require(script.Parent.useModalTexts)
local useModalButtonActions = require(script.Parent.useModalButtonActions)

local _TFActionsEnum = require(TrustedContacts.TrustedFriendActions.TFActionsEnum)

local Analytics = require(script.Parent.Parent.Parent.Analytics)
local useTCAnalytics = Analytics.useTCAnalytics
local EventNames = Analytics.EventNames

local TrustedContactsModal = require(script.Parent.TrustedContactsModal)

local normalizeTFActionsEnumToModalVariant = require(TrustedContacts.TrustedFriendActions.normalizeTFActionsEnumToModalVariant)

local FFlagTCLearnMoreLink = require(TrustedContacts.Flags.FFlagTCLearnMoreLink)
local FFlagTFUpdateAnalytics = require(TrustedContacts.Flags.FFlagTFUpdateAnalytics)

local FFlagEnableTrustedFriendsWizardVPCPrologue = require(TrustedContacts.Flags.FFlagEnableTrustedFriendsWizardVPCPrologue)

local _Types = require(TrustedContacts.Common.Types)

local str1 = game:DefineFastString("TrustedConnectionsLearnMoreLink", "https://help.roblox.com/hc/articles/37725513985812")

local tbl1 = { TrustedConnectionStatus.Friends, TrustedConnectionStatus.RequestReceived, TrustedConnectionStatus.TrustedFriends }

return function(arg1)
    local tfActionsEnum = arg1.tfActionsEnum
    local modalVariant = React.useMemo(function()
        if tfActionsEnum then
            return (normalizeTFActionsEnumToModalVariant(tfActionsEnum))
        end

        return nil
    end, { tfActionsEnum })

    local fireAnalyticsEvent = useTCAnalytics({
        friendId = arg1.userId,
        modalVariant = modalVariant,
        source = arg1.source,
        tfActionsEnum = if FFlagTFUpdateAnalytics then tfActionsEnum else nil
    }).fireAnalyticsEvent

    local var2 = React.useCallback(function()
        fireAnalyticsEvent(EventNames.TCUpsellCloseClicked)
        arg1.externalNavigation.closeModal()
    end, { fireAnalyticsEvent, arg1.externalNavigation })

    local var3 = useLocalization({
        somethingIsWrongToast = "Feature.Toast.NetworkingError.SomethingIsWrong",
        linkCopiedToast = "Feature.Catalog.Toast.LinkCopied",
        learnMoreText = if FFlagTCLearnMoreLink then "Feature.Friends.LinkText.LearnMore" else nil
    })

    React.useEffect(function()
        if modalVariant then
            fireAnalyticsEvent(EventNames.TCUpsellModalSeen)
        end
    end, { modalVariant, fireAnalyticsEvent })

    local showGenericErrorModal = React.useCallback(function()
        arg1.externalNavigation.showToast(var3.somethingIsWrongToast)
    end, { var3.somethingIsWrongToast, arg1.externalNavigation })
    local bool1 = not (modalVariant and table.find(tbl1, modalVariant))

    RoactUtils.Hooks.useEffectOnce(function()
        if FFlagTFUpdateAnalytics then
            fireAnalyticsEvent(EventNames.TCUpsellInvalidTrustedFriendState)
        end
        var2()
        showGenericErrorModal()
    end, bool1)

    local var5 = useModalTexts(modalVariant)

    local modalButtonActions = useModalButtonActions(arg1.userId, arg1.source, tfActionsEnum, {
        closeModal = var2,
        onRequestSent = arg1.onRequestSent,
        onRequestAccepted = arg1.onRequestAccepted,
        onAcknowledged = arg1.onAcknowledged,
        sentFromQrCode = arg1.sentFromQrCode,
        tokens = arg1.tokens,
        showGenericErrorModal = showGenericErrorModal,
        isShareLinkSender = arg1.modalVariantOverride == Sources.ShareLinkSender,
        showToast = arg1.externalNavigation.showToast,
        shareUrl = arg1.externalNavigation.shareUrl,
        openAmpWizard = if FFlagEnableTrustedFriendsWizardVPCPrologue then arg1.externalNavigation.openAmpWizard else nil,
        dismissModal = if FFlagEnableTrustedFriendsWizardVPCPrologue then arg1.externalNavigation.closeModal else nil,
        fireAnalyticsEvent = fireAnalyticsEvent
    })

    local var7 = if FFlagTCLearnMoreLink then React.useCallback(function()
        fireAnalyticsEvent(EventNames.TCUpsellLearnMoreClicked)
        arg1.externalNavigation.openWebView(str1, "")
    end, { fireAnalyticsEvent, arg1.externalNavigation }) else nil

    local var8 = modalVariant and table.find(tbl1, modalVariant)

    if var8 then
        local createElement = React.createElement
        local var9 = TrustedContactsModal
        local tbl2 = {
            isVerticallyConstrained = arg1.isVerticallyConstrained,
            userId = arg1.userId,
            source = arg1.source,
            headerText = var5.header,
            descriptionText = var5.description,
            modalButtonActions = modalButtonActions,
            onCloseModal = var2,
            learnMoreText = if FFlagTCLearnMoreLink then var3.learnMoreText else nil,
            onLearnMoreClick = 0
        }

        if not FFlagTCLearnMoreLink then
            var7 = nil
        end

        tbl2.onLearnMoreClick = var7
        var8 = createElement(var9, tbl2)
    end

    return var8
end
