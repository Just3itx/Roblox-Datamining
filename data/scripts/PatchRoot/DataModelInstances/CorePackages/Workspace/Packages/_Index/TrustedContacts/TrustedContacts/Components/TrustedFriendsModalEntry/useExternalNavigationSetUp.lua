-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)

local NotificationModalsManager = require(TrustedContactsParent.NotificationModalsManager)

local default = require(TrustedContactsParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local AmpUpsell = require(TrustedContactsParent.AmpUpsell)
local OpenAmpWizardContainer = AmpUpsell.OpenAmpWizardContainer
local InExpAmpWizardController = AmpUpsell.InExpAmpWizardController
local GetFFlagEnableAmpWizardVPCNavigationFix = AmpUpsell.GetFFlagEnableAmpWizardVPCNavigationFix
local NavigateBack = require(TrustedContactsParent.NavigationRodux).Thunks.NavigateBack
local useDispatch = require(TrustedContactsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useOpenWebView = require(TrustedContactsParent.WebViewUtils).useOpenWebView
local FFlagSignalsNavP3Dispatch = require(TrustedContactsParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(TrustedContactsParent.RobloxAppNavigation).NavigationCommands else nil
local SocialUpsell = require(TrustedContactsParent.SocialUpsell)
local useSocialUpsellOverlayController = SocialUpsell.Hooks.useSocialUpsellOverlayController
local SocialUpsellType = SocialUpsell.Enums.SocialUpsellType
local UpsellEntrySurfaceType = SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType
local UpsellComponent = SocialUpsell.Analytics.Enum.UpsellComponent

local bool1 = game:DefineFastFlag("TCOpenAmpInGame", false)

local FFlagEnableTrustedFriendsWizardVPCPrologue = require(TrustedContacts.Flags.FFlagEnableTrustedFriendsWizardVPCPrologue)

local _Types = require(TrustedContacts.Common.Types)

local function useExternalNavigationSetUp(tbl1)
    local var1 = useDispatch()

    local bool2 = game.GameId ~= 0
    local var2 = useSocialUpsellOverlayController(bool2)

    local showToast = React.useCallback(function(toastTitle: string)
        NotificationModalsManager.SetUIBloxToast({ sequenceNumber = DateTime.now().UnixTimestamp, toastTitle = toastTitle })
    end, {})

    local openWebView = useOpenWebView()

    local openAmpWizard = React.useCallback(function(arg1)
        local function func1(arg2, arg3)
            if not (bool1 or GetFFlagEnableAmpWizardVPCNavigationFix()) then
                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.back(true)
                else
                    var1(NavigateBack(true))
                end
            end
            arg1.completionCallback(arg2, arg3)
        end

        if FFlagEnableTrustedFriendsWizardVPCPrologue then
            if bool1 then
                InExpAmpWizardController.OpenAmpWizardContainerInExp(
                    arg1.featureName,
                    func1,
                    arg1.recourseData,
                    arg1.entryPointEventCtx,
                    arg1.extraParameters,
                    arg1.nameSpace,
                    nil,
                    nil,
                    nil,
                    arg1.usePrologue,
                    arg1.prologueOptions
                )
                return
            end

            var1(
                OpenAmpWizardContainer(
                    arg1.featureName,
                    func1,
                    arg1.recourseData,
                    arg1.entryPointEventCtx,
                    arg1.extraParameters,
                    arg1.nameSpace,
                    nil,
                    nil,
                    nil,
                    arg1.usePrologue,
                    arg1.prologueOptions
                )
            )
        elseif bool1 then
            InExpAmpWizardController.OpenAmpWizardContainerInExp(
                arg1.featureName,
                func1,
                arg1.recourseData,
                arg1.entryPointEventCtx,
                arg1.extraParameters,
                arg1.nameSpace
            )
        else
            var1(
                OpenAmpWizardContainer(
                    arg1.featureName,
                    func1,
                    arg1.recourseData,
                    arg1.entryPointEventCtx,
                    arg1.extraParameters,
                    arg1.nameSpace
                )
            )
        end
    end, { var1 })

    local var6 = React.useCallback(function()
        if tbl1.onClosed then
            tbl1.onClosed()
        elseif tbl1.navigation then
            tbl1.navigation.pop()
        end
    end, { tbl1, tbl1.navigation })

    local shareUrl = React.useCallback(function(arg1)
        default:shareUrl(arg1)
    end, {})

    return {
        closeModal = var6,
        openAmpWizard = openAmpWizard,
        openFacialAgeEstimationUpsell = React.useCallback(function(arg1)
            local upsellEntrySurface = if bool2 then UpsellEntrySurfaceType.TrustedFriendsInExperience else UpsellEntrySurfaceType.TrustedFriends
            var2.openSocialOverlay(SocialUpsellType.FacialAgeEstimation, {
                upsellEntrySurface = upsellEntrySurface,
                upsellEntryComponent = UpsellComponent.Modal,
                entryPointEventCtx = SocialUpsellType.FacialAgeEstimation .. upsellEntrySurface,
                shouldIncludeVPC = true,
                onSuccess = arg1 and arg1.onSuccess,
                onFailure = arg1 and arg1.onFailure,
                onAccept = arg1 and arg1.onAccept,
                onDismiss = var6
            })
        end, { var6, bool2, var2.openSocialOverlay }),
        showToast = showToast,
        openWebView = openWebView,
        shareUrl = shareUrl
    }
end

return useExternalNavigationSetUp
