-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)
local useNavigation = require(TrustedContactsParent.Navigation).useNavigation
local AppPage = require(TrustedContactsParent.RobloxAppEnums).AppPage

local DataHydration = require(TrustedContactsParent.DataHydration)
local Contexts = require(TrustedContactsParent.SocialLuaAnalytics).Analytics.Enums.Contexts
local useAppPolicy = require(TrustedContactsParent.UniversalAppPolicy).useAppPolicy
local UserProfiles = require(TrustedContactsParent.UserProfiles)
local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization
local AmpUpsell = require(TrustedContactsParent.AmpUpsell)

local EventNames = require(TrustedContacts.Analytics).EventNames

local FFlagTCUpdateProfileCTAButton = require(TrustedContactsParent.SharedFlags).FFlagTCUpdateProfileCTAButton
local FFlagTrustedFriendsLinkVPC = require(TrustedContacts.Flags.FFlagTrustedFriendsLinkVPC)
local FFlagTFUpdateAnalytics = require(TrustedContacts.Flags.FFlagTFUpdateAnalytics)

local fFlagEnableAmpWizardVPCNavigationFix = require(TrustedContacts.Flags.FFlagEnableTrustedFriendsWizardVPCPrologue)
    and AmpUpsell.GetFFlagEnableAmpVPCPrologue()
    and AmpUpsell.GetFFlagEnableReusableVPCPrologue()
    and AmpUpsell.GetFFlagEnableAmpWizardVPCNavigationFix()

local FStringConnectionGraphCoreAmpNameSpace = require(TrustedContactsParent.SharedFlags).FStringConnectionGraphCoreAmpNameSpace

local _Types = require(TrustedContacts.Common.Types)

local var1 = DataHydration.TrustedConnections.TrustedConnectionsStore.get()

local function useGetTFActionsCallbacks(str1: string, tbl1)
    local fireAnalyticsEvent = tbl1.fireAnalyticsEvent

    local var2 = useNavigation()
    local var3 = useAppPolicy(function(arg1)
        return arg1.getShareSheetEnabled()
    end)

    local var4 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = { str1 },
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds
        }
    )
    local name = var4 and var4.data and UserProfiles.Selectors.getCombinedNameFromId(var4.data, str1) or ""

    local var5 = useLocalization({
        isATrustedConnectionNowToast = {
            "Feature.Friends.TrustedFriend.Toast.IsATrustedFriendNow",
            name = name
        },
        linkCopiedToast = "Feature.Catalog.Toast.LinkCopied",
        trustedConnectionRequestSentToast = "Feature.Friends.TrustedFriend.Toast.TrustedFriendRequestSent",
        ask = if fFlagEnableAmpWizardVPCNavigationFix then "Feature.Friends.Label.Ask" else nil,
        askYourParent = if fFlagEnableAmpWizardVPCNavigationFix then "Feature.Friends.Label.AskYourParent" else nil,
        vpcRequired = if fFlagEnableAmpWizardVPCNavigationFix then "Feature.Friends.Label.AddFriendVPC" else nil
    })

    local onOkButtonPress = React.useCallback(function()
        fireAnalyticsEvent(EventNames.TrustedFriendsModalOkClicked)
        if tbl1.onAcknowledged then
            tbl1.onAcknowledged()
        end
        tbl1.closeModal()
    end, { tbl1.closeModal, tbl1.onAcknowledged, fireAnalyticsEvent })

    local useCallback = React.useCallback
    local function func1()
        fireAnalyticsEvent(EventNames.TrustedFriendsVPCPrologueOpened)

        local var7 = nil
        if FFlagTCUpdateProfileCTAButton then
            if tbl1.onRequestSent then
                var7 = tbl1.onRequestSent
            elseif tbl1.onRequestAccepted then
                var7 = tbl1.onRequestAccepted
            end
        end

        local dismissModal = tbl1.dismissModal
        local openAmpWizard = tbl1.openAmpWizard
        if not fFlagEnableAmpWizardVPCNavigationFix then
            var2.replace(AppPage.TrustedFriendsVPCPrologue, { userId = str1, completionCallback = var7 })
            return
        end

        local tbl2 = {
            featureName = "TriggerTrustedFriendVPCRecourse",
            completionCallback = function()
                if var7 then
                    var7()
                end
            end,
            recourseData = { targetUserId = str1 },
            entryPointEventCtx = Contexts.TrustedFriendsVPCPrologue,
            extraParameters = {{ name = "targetUser", type = "UserId", value = str1 }},
            nameSpace = FStringConnectionGraphCoreAmpNameSpace,
            usePrologue = true,
            prologueOptions = {
                config = {
                    titleText = var5.askYourParent,
                    bodyText = var5.vpcRequired,
                    confirmText = var5.ask
                },
                onConfirm = function()
                    fireAnalyticsEvent(EventNames.TrustedFriendsVPCAskClicked)
                end,
                onCancel = function()
                    fireAnalyticsEvent(EventNames.TrustedFriendsVPCCancelClicked)
                end
            }
        }
        dismissModal()
        openAmpWizard(tbl2)
    end

    local onRequestSent = if FFlagTCUpdateProfileCTAButton then tbl1.onRequestSent else nil
    local onRequestAccepted = if FFlagTCUpdateProfileCTAButton then tbl1.onRequestAccepted else nil
    local dismissModal = if fFlagEnableAmpWizardVPCNavigationFix then tbl1.dismissModal else nil
    local openAmpWizard = if fFlagEnableAmpWizardVPCNavigationFix then tbl1.openAmpWizard else nil
    local var7 = if fFlagEnableAmpWizardVPCNavigationFix then var5 else nil
    local onOpenVpcProloguePress = useCallback(
        func1,
        {
            fireAnalyticsEvent,
            var2,
            str1,
            onRequestSent,
            onRequestAccepted,
            dismissModal,
            openAmpWizard,
            var7
        }
    )

    local var9 = React.useCallback(function()
        if FFlagTFUpdateAnalytics then
            fireAnalyticsEvent(EventNames.TCUpsellIsATrustedConnectionNowToastShown)
        else
            fireAnalyticsEvent(EventNames.TCUpsellAcceptTrustedConnectionClicked)
        end
        tbl1.showToast(var5.isATrustedConnectionNowToast)
    end, { var5.isATrustedConnectionNowToast, fireAnalyticsEvent, tbl1.showToast })

    local onCancelButtonPress = React.useCallback(function()
        fireAnalyticsEvent(EventNames.TCUpsellCancelClicked)
        tbl1.closeModal()
    end, { tbl1.closeModal, fireAnalyticsEvent })

    local onAddViaLinkButtonPress = React.useCallback(function()
        fireAnalyticsEvent(EventNames.TCUpsellAddViaLinkClicked)
        var1.createTrustedFriendLink(str1):andThen(function(arg1)
            tbl1.shareUrl({ url = arg1.responseBody.link, context = Contexts.TCUpsellModal })
        end):andThen(function()
            return tbl1.onRequestSent and tbl1.onRequestSent()
        end):andThen(function()
            if not var3 then
                tbl1.showToast(var5.linkCopiedToast)
            end
            tbl1.closeModal()
        end):catch(function()
            tbl1.showGenericErrorModal()
            tbl1.closeModal()
        end)
    end, {
        tbl1.closeModal,
        tbl1.showGenericErrorModal,
        tbl1.onRequestSent,
        fireAnalyticsEvent,
        str1,
        var5,
        var3,
        tbl1.shareUrl,
        tbl1.showToast
    })

    local onAcceptRequestReceived = React.useCallback(function()
        if FFlagTFUpdateAnalytics then
            fireAnalyticsEvent(EventNames.TCUpsellAcceptTrustedConnectionClicked)
        end

        var1.acceptTrustedConnectionRequest(str1):andThen(function()
            var9()
        end):andThen(function()
            return tbl1.onRequestAccepted and tbl1.onRequestAccepted()
        end):andThen(function()
            tbl1.closeModal()
        end):catch(function()
            tbl1.showGenericErrorModal()
        end)
    end, {
        tbl1,
        str1,
        var9,
        fireAnalyticsEvent
    })
    local onAddTrustedFriendFromLink = React.useCallback(function()
        if FFlagTFUpdateAnalytics then
            fireAnalyticsEvent(EventNames.TCUpsellAcceptTrustedConnectionClicked)
        end

        var1.addTrustedFriendFromLink(str1, tbl1.tokens or {}):andThen(function()
            var9()
        end):andThen(FFlagTCUpdateProfileCTAButton and function()
            return tbl1.onRequestAccepted and tbl1.onRequestAccepted()
        end or nil):andThen(function()
            tbl1.closeModal()
        end):catch(function()
            tbl1.showGenericErrorModal()
        end)
    end, {
        tbl1,
        str1,
        var9,
        fireAnalyticsEvent
    })
    local onSendTrustedConnectionRequest = React.useCallback(function()
        if FFlagTFUpdateAnalytics then
            fireAnalyticsEvent(EventNames.TCUpsellAddTrustedConnectionClicked)
        end

        var1.sendTrustedConnectionRequest(str1, if tbl1.sentFromQrCode then "qr" else nil):andThen(function()
            if not FFlagTFUpdateAnalytics then
                fireAnalyticsEvent(EventNames.TCUpsellAddTrustedConnectionClicked)
            end
            tbl1.showToast(var5.trustedConnectionRequestSentToast)
        end):andThen(function()
            return tbl1.onRequestSent and tbl1.onRequestSent()
        end):andThen(
            function()
                tbl1.closeModal()
            end
        ):catch(
            function()
                tbl1.showGenericErrorModal()
            end
        )
    end, {
        tbl1,
        str1,
        var5,
        fireAnalyticsEvent,
        tbl1.showToast
    })

    local var15 = if FFlagTrustedFriendsLinkVPC then React.useCallback(function()
        if FFlagTFUpdateAnalytics then
            fireAnalyticsEvent(EventNames.TCUpsellAcceptTrustedConnectionClicked)
        end

        var1.addTrustedFriendFromLink(str1, tbl1.tokens or {}):andThen(function()
            onOpenVpcProloguePress()
        end):catch(function()
            tbl1.showGenericErrorModal()
        end)
    end, {
        str1,
        tbl1.tokens,
        onOpenVpcProloguePress,
        tbl1.showGenericErrorModal,
        fireAnalyticsEvent
    }) else nil

    local tbl2 = {
        onOkButtonPress = onOkButtonPress,
        onOpenVPCProloguePress = onOpenVpcProloguePress,
        onCancelButtonPress = onCancelButtonPress,
        onAcceptRequestReceived = onAcceptRequestReceived,
        onAddTrustedFriendFromLink = onAddTrustedFriendFromLink,
        onSendTrustedConnectionRequest = onSendTrustedConnectionRequest,
        onAddViaLinkButtonPress = onAddViaLinkButtonPress,
        onAddTrustedFriendFromLinkWithVPC = 0
    }

    if not FFlagTrustedFriendsLinkVPC then
        var15 = nil
    end

    tbl2.onAddTrustedFriendFromLinkWithVPC = var15
    return tbl2
end

return useGetTFActionsCallbacks
