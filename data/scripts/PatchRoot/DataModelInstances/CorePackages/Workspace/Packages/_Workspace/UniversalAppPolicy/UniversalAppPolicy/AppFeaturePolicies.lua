-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local scriptParentParent = script.Parent.Parent

local IsVRAppBuild = require(scriptParentParent.AppCommonLib).IsVRAppBuild
local isTenFootInterface = require(scriptParentParent.AppCommonLib).isTenFootInterface

local Cryo = require(scriptParentParent.Cryo)
local ColorMode = require(scriptParentParent.Foundation).Enums.ColorMode
local var1 = Cryo.Dictionary.values(ColorMode)
local CrossPlayCapabilities = require(script.Parent.Enum.CrossPlayCapabilities)

local SharedFlags = require(scriptParentParent.SharedFlags)
local isSubjectToDesktopPolicies = SharedFlags.isSubjectToDesktopPolicies
local isRunningInStudio = require(scriptParentParent.AppCommonLib).isRunningInStudio
local GetFFlagDisableCDLQrCodeForMaquettes = SharedFlags.GetFFlagDisableCDLQrCodeForMaquettes
local GetFFlagUseEnablePremiumUserFeaturesAppPolicy = SharedFlags.GetFFlagUseEnablePremiumUserFeaturesAppPolicy
local GetFFlagLuafiedReportEntryPoints = SharedFlags.GetFFlagLuafiedReportEntryPoints
local GetFFlagEnableAbuseReport10ft = SharedFlags.GetFFlagEnableAbuseReport10ft
local GetFFlagUseExternalBrowserForAgeGuidelines10ft = SharedFlags.GetFFlagUseExternalBrowserForAgeGuidelines10ft
local GetFFlagEnableGateNotificationPreferencesTab = SharedFlags.GetFFlagEnableGateNotificationPreferencesTab
local GetFFlagEnableSupportCenter = SharedFlags.GetFFlagEnableSupportCenter
local FFlagLuaAppHomeVngAppUpsell = SharedFlags.FFlagLuaAppHomeVngAppUpsell
local FFlagVngAppUpsellPcLayout = SharedFlags.FFlagVngAppUpsellPcLayout
local FFlagLuaAppParentUpsellPolicy = SharedFlags.FFlagLuaAppParentUpsellPolicy
local FFlagRenameParentEmailForVerificationUpsell = SharedFlags.FFlagRenameParentEmailForVerificationUpsell
local GetFFlagSeamlessVoiceConsentToastPolicy = SharedFlags.GetFFlagSeamlessVoiceConsentToastPolicy
local GetFFlagEnableMultiPageSignup = SharedFlags.GetFFlagEnableMultiPageSignup

local GetFIntExclusiveFallbackExclusiveUnderageCutoffForMultiPageSignup = SharedFlags.GetFIntExclusiveFallbackExclusiveUnderageCutoffForMultiPageSignup
local FFlagEnableMicrosoftStorePaymentsPlatform = SharedFlags.FFlagEnableMicrosoftStorePaymentsPlatform
local FFlagEnableMilkyWayPaymentsPlatformV2 = SharedFlags.FFlagEnableMilkyWayPaymentsPlatformV2
local FFlagAppIaScrollAwayGuac = SharedFlags.FFlagAppIaScrollAwayGuac
local FFlagEnableScreentimeMoreTimeOption = SharedFlags.FFlagEnableScreentimeMoreTimeOption
local FFlagEnableFriendsRenamingForAll = SharedFlags.FFlagEnableFriendsRenamingForAll
local GetFFlagExpChatGuacChatDisabledReason = SharedFlags.GetFFlagExpChatGuacChatDisabledReason
local FFlagGuacCanRenderTransferOnProfile = SharedFlags.FFlagGuacCanRenderTransferOnProfile
local FFlagEnableFaceIDTextOnAddAuthMethodPage = SharedFlags.FFlagEnableFaceIDTextOnAddAuthMethodPage
local FFlagEnableMorePageExitButtonSupport = SharedFlags.FFlagEnableMorePageExitButtonSupport
local FFlagEnableMorePageDirectionalLayoutRolloutFix = SharedFlags.FFlagEnableMorePageDirectionalLayoutRolloutFix
local FFlagAEGIS2UseGuacToShowEnabledMessage = SharedFlags.FFlagAEGIS2UseGuacToShowEnabledMessage
local FFlagAEGIS2UseGuacToShowFAEUpsell = SharedFlags.FFlagAEGIS2UseGuacToShowFAEUpsell
local fFlagMacMenuBarContentUpdates = SharedFlags.GetFFlagMacMenuBarContentUpdates()

local bool1 = game:DefineFastFlag("LuaAppEnableRecommendedCarouselForDesktop", false)
local bool2 = game:DefineFastFlag("DisableWebViewSupportInStudio", false)
local FFlagUsesCancelSearchAppPolicy = SharedFlags.FFlagUsesCancelSearchAppPolicy
local bool3 = game:DefineFastFlag("DebugUseLegacyCrossPlayApi", false)
local str1 = game:DefineFastString("DebugOverrideCrossPlaySettingsKey", "")
local str2 = game:DefineFastString("DebugOverrideCrossPlayQueryParam", "")
local bool4 = game:DefineFastFlag("DebugCrossPlaySystemUi", false)
local str3 = game:DefineFastString("DebugOverrideCrossPlayUri", "")
local str4 = game:DefineFastString("DebugMomentsFeatureList", "")
local bool5 = game:DefineFastFlag("GuacAppPolicyDisableSignupCheckbox", false)
local bool6 = game:DefineFastFlag("FlyoutDisablePremiumEntrypoint1", false)
local bool7 = game:DefineFastFlag("GuacDisableBlackbirdEntrypoints", false)
local bool8 = game:DefineFastFlag("FlyoutEnableGiftcardsWithRedeem", false)

local bool9 = game:DefineFastFlag("DebugForceShowIllegalContentReportingUI", false)
local FFlagExpChatUseGuacForFOMOUpsell = SharedFlags.FFlagExpChatUseGuacForFOMOUpsell
local FFlagExpChatUseGuacForCrossAgeChat = SharedFlags.FFlagExpChatUseGuacForCrossAgeChat
local FFlagEnableAndroidTvAppPolicies = SharedFlags.FFlagEnableAndroidTvAppPolicies
local FFlagEnableCoreContentAccountType = SharedFlags.FFlagEnableCoreContentAccountType
local FFlagEnableCoreContentBadge = SharedFlags.FFlagEnableCoreContentBadge
local FFlagEnableFlyoutUncheckedBadge = SharedFlags.FFlagEnableFlyoutUncheckedBadge
local FFlagEnableNonFlyoutUncheckedBadge = SharedFlags.FFlagEnableNonFlyoutUncheckedBadge
local GetFFlagEnableAccountSwitcherUncheckedBadge = SharedFlags.GetFFlagEnableAccountSwitcherUncheckedBadge
local FFlagShowGameAgeRating = SharedFlags.FFlagShowGameAgeRating
local FFlagDefaultKidsToDarkTheme = SharedFlags.FFlagDefaultKidsToDarkTheme
local FFlagLuaAppSupportDisablePlayableWhenLoading = SharedFlags.FFlagLuaAppSupportDisablePlayableWhenLoading
local FFlagAppNavMyStatsTab = SharedFlags.FFlagAppNavMyStatsTab
local FFlagAppChatOnConsoles = SharedFlags.FFlagAppChatOnConsoles
local bool10 = game:DefineFastFlag("UseOriginalPlatformChatPolicy", false)
local FFlagFriendsChatEnableConversationConsent = SharedFlags.FFlagFriendsChatEnableConversationConsent
local FFlagFriendsChatDiscloseUpdateSecondVersion = SharedFlags.FFlagFriendsChatDiscloseUpdateSecondVersion
local FFlagFriendsChatHasFriendsGate = SharedFlags.FFlagFriendsChatHasFriendsGate
local FFlagAddPinExperienceTargetDestinationGUACPolicy = SharedFlags.FFlagAddPinExperienceTargetDestinationGUACPolicy
local FFlagFlyoutGateLearnPlace = SharedFlags.FFlagFlyoutGateLearnPlace

game:DefineFastFlag("BehaviorCollectionControlEnabled", false)

game:DefineFastFlag("LuaAppPromotionalEmailsCheckboxEnabledInAppPolicy", false)

local GetFFlagNotificationsComplianceShouldRestrictStream = SharedFlags.GetFFlagNotificationsComplianceShouldRestrictStream

local function AppFeaturePolicies(getRawPolicy)
    local function getVRDefaultPolicy(arg2, arg3) -- Luacid: unused: defined but never referenced
        return if getRawPolicy[arg2] == nil then if IsVRAppBuild() then arg3 else not arg3 else getRawPolicy[arg2]
    end

    return {
        getFriendFinder = function()
            return getRawPolicy.FriendFinder or false
        end,
        getGameDetailsMorePage = function()
            return getRawPolicy.GameDetailsMorePage or false
        end,
        getGameDetailsSubtitle = function()
            return getRawPolicy.GameDetailsSubtitle or false
        end,
        getShowGlobalCounters = function()
            return getRawPolicy.GameDetailsShowGlobalCounters or false
        end,
        getGameDetailsPlayWithFriends = function()
            return getRawPolicy.GameDetailsPlayWithFriends or false
        end,
        getGameInfoList = function()
            return getRawPolicy.GameInfoList or false
        end,
        getGamePlaysAndRatings = function()
            return getRawPolicy.GamePlaysAndRatings or false
        end,
        getNotifications = function()
            return getRawPolicy.Notifications or false
        end,
        getRecommendedGames = function()
            if bool1 then
                return getRawPolicy.RecommendedGames or false
            end

            if isSubjectToDesktopPolicies() then
                return false
            end

            return getRawPolicy.RecommendedGames or false
        end,
        getSearchBar = function()
            return getRawPolicy.SearchBar or false
        end,
        getMorePageContent = function()
            return if bool10 then getRawPolicy.MorePageContent elseif FFlagAppChatOnConsoles then getRawPolicy.MorePageContent2 else getRawPolicy.MorePageContent
        end,
        getAboutPageType = function()
            return getRawPolicy.AboutPageType or "CJVAbout"
        end,
        getSettingsPageType = function()
            return getRawPolicy.SettingsPageType or "Settings"
        end,
        getSocialLinks = function()
            return getRawPolicy.SocialLinks or false
        end,
        getSocialGroupLinks = function()
            return getRawPolicy.SocialGroupLinks or false
        end,
        getCommunityLinksEnabled = function()
            return getRawPolicy.CommunityLinksEnabled or false
        end,
        getGameInfoShowBadges = function()
            return getRawPolicy.GameInfoShowBadges or false
        end,
        getGameInfoShowCreated = function()
            return getRawPolicy.GameInfoShowCreated or false
        end,
        getGameInfoShowGamepasses = function()
            return getRawPolicy.GameInfoShowGamepasses or false
        end,
        getGameInfoShowGenre = function()
            return getRawPolicy.GameInfoShowGenre or false
        end,
        getGameInfoShowSubgenre = function()
            return getRawPolicy.GameInfoShowSubgenre or false
        end,
        getGameInfoShowMaxPlayers = function()
            return getRawPolicy.GameInfoShowMaxPlayers or false
        end,
        getGameInfoShowServers = function()
            return getRawPolicy.GameInfoShowServers or false
        end,
        getGameInfoShowUpdated = function()
            return getRawPolicy.GameInfoShowUpdated or false
        end,
        getGameInfoShowAgeRecommendation = function()
            return getRawPolicy.GameInfoShowAgeRecommendation == nil or getRawPolicy.GameInfoShowAgeRecommendation
        end,
        getGameInfoShowVoiceAndChatFeatures = function()
            return getRawPolicy.GameInfoShowVoiceAndChatFeatures == nil or getRawPolicy.GameInfoShowVoiceAndChatFeatures
        end,
        getSiteMessageBanner = function()
            return getRawPolicy.SiteMessageBanner or false
        end,
        getAlertRateLimit = function()
            return getRawPolicy.AlertRateLimit or 300
        end,
        getSearchAutoComplete = function()
            return getRawPolicy.SearchAutoComplete or false
        end,
        getShowStudioCTA = function()
            return getRawPolicy.ShowStudioCTA or false
        end,
        getAppIaScrollAwayEnabled = FFlagAppIaScrollAwayGuac and function()
            return getRawPolicy.AppIaScrollAwayEnabled or false
        end or nil,
        getUseOmniRecommendation = function()
            return getRawPolicy.UseOmniRecommendation == nil or getRawPolicy.UseOmniRecommendation
        end,
        getUseWidthBasedFormFactorRule = function()
            return getRawPolicy.UseWidthBasedFormFactorRule or false
        end,
        getShowYouTubeAgeAlert = function()
            return getRawPolicy.ShowYouTubeAgeAlert == nil or getRawPolicy.ShowYouTubeAgeAlert
        end,
        getShowVideoThumbnails = function()
            return getRawPolicy.ShowVideoThumbnails or false
        end,
        getHomeIcon = function()
            return getRawPolicy.HomeIcon or "LuaApp/icons/ic-roblox-close"
        end,
        getGameInfoListShowRNVDeveloper = function()
            return getRawPolicy.GameInfoListShowRNVDeveloper or false
        end,
        getGameInfoListDeveloper = function()
            return getRawPolicy.GameInfoListDeveloper or false
        end,
        getShowDisplayName = function()
            return getRawPolicy.ShowDisplayName == nil or getRawPolicy.ShowDisplayName
        end,
        getShowAlias = function()
            return getRawPolicy.ShowUserAlias == nil or getRawPolicy.ShowUserAlias
        end,
        getCatalogReportingDisabled = function()
            return getRawPolicy.CatalogReportingDisabled or false
        end,
        getGameReportingDisabled = function()
            return getRawPolicy.GameReportingDisabled or false
        end,
        getGamesPageCreationCenterTitle = function()
            return getRawPolicy.GamesPageCreationCenterTitle or false
        end,
        shouldUseExternalBrowserForDisclaimerLinks = function()
            return getRawPolicy.UseExternalBrowserForDisclaimerLinks or false
        end,
        shouldUseExternalBrowserForMorePageItem = function()
            return getRawPolicy.UseExternalBrowserForMoreLinks or false
        end,
        getCatalogShow3dView = function()
            return getRawPolicy.CatalogShow3dView or false
        end,
        getItemDetailsFullView = function()
            return getRawPolicy.ItemDetailsFullView or false
        end,
        getCatalogCommunityCreations = function()
            return getRawPolicy.CatalogCommunityCreations or false
        end,
        getCatalogPremiumCategory = function()
            return getRawPolicy.CatalogPremiumCategory or false
        end,
        getShowCatalogPremiumContent = function()
            return getRawPolicy.CatalogPremiumContent or false
        end,
        getRobloxCreatedItemsCreatedByLuobu = function()
            return getRawPolicy.RobloxCreatedItemsCreatedByLuobu == nil or getRawPolicy.RobloxCreatedItemsCreatedByLuobu
        end,
        getHomePageFriendSection = function()
            return getRawPolicy.HomePageFriendSection or false
        end,
        getHomePageProfileLink = function()
            return getRawPolicy.HomePageProfileLink or false
        end,
        getPurchasePromptIncludingWarning = function()
            return getRawPolicy.PurchasePromptIncludingWarning == nil or getRawPolicy.PurchasePromptIncludingWarning
        end,
        getCheckUserAgreementsUpdatedOnLogin = function()
            return getRawPolicy.CheckUserAgreementsUpdatedOnLogin == nil or getRawPolicy.CheckUserAgreementsUpdatedOnLogin
        end,
        getAddUserAgreementIdsToSignupRequest = function()
            return getRawPolicy.AddUserAgreementIdsToSignupRequest or false
        end,
        RequireExplicitVoiceConsent = function()
            return getRawPolicy.RequireExplicitVoiceConsent or false
        end,
        getRequireExplicitAvatarVideoConsent = function()
            return getRawPolicy.RequireExplicitAvatarVideoConsent or false
        end,
        getShowVoiceUpsellV2 = function()
            return getRawPolicy.ShowVoiceUpsellV2 or false
        end,
        getShouldShowGroupsTile = function()
            return getRawPolicy.ShouldShowGroupsTile or false
        end,
        useLuobuAuthentication = function()
            return getRawPolicy.UseLuobuAuthentication or false
        end,
        useWechatQQAuthentication = function()
            return getRawPolicy.UseWechatQQAuthentication or false
        end,
        useMSDKWebAuthentication = function()
            return getRawPolicy.UseMSDKWebAuthentication or false
        end,
        getQrFriendingEnabled = function()
            return getRawPolicy.QrFriendingEnabled or false
        end,
        getShouldShowCameraPermissionInAgreementsPrompt = function()
            return getRawPolicy.ShouldShowCameraPermissionInAgreementsPrompt or false
        end,
        getExperienceInviteShareLinkEnabled = function()
            return getRawPolicy.ExperienceInviteShareLinkEnabled or false
        end,
        getCsatSurveyRestrictTextInput = function()
            return getRawPolicy.CsatSurveyRestrictTextInput or false
        end,
        useGridPageLayout = function()
            if IsVRAppBuild() then
                if getRawPolicy.UseGridPageLayout == nil then
                    return not not IsVRAppBuild()
                end

                return getRawPolicy.UseGridPageLayout
            elseif getRawPolicy.UseGridPageLayout == nil then
                return isSubjectToDesktopPolicies()
            else
                return getRawPolicy.UseGridPageLayout
            end
        end,
        usePhoneSearchDiscoverEntry = function()
            return if getRawPolicy.UsePhoneSearchDiscoverEntry == nil then not isSubjectToDesktopPolicies() else getRawPolicy.UsePhoneSearchDiscoverEntry
        end,
        getShouldSystemBarUsuallyBePresent = function()
            if IsVRAppBuild() then
                if getRawPolicy.ShouldSystemBarUsuallyBePresentForVR == nil then
                    return not not IsVRAppBuild()
                end

                return getRawPolicy.ShouldSystemBarUsuallyBePresentForVR
            end

            if isTenFootInterface() then
                return true
            end

            return getRawPolicy.ShouldSystemBarUsuallyBePresent or false
        end,
        getContactImporterEnabled = function()
            return not isSubjectToDesktopPolicies() and (getRawPolicy.ContactImporterEnabled or false)
        end,
        getShouldShowSettingsPermissionsAdditionalInstructions = function()
            return getRawPolicy.shouldShowSettingsPermissionsAdditionalInstructions or false
        end,
        getUseVRFTUXPanel = function()
            if getRawPolicy.UseVRFTUXPanel == nil then
                return not not IsVRAppBuild()
            end

            return getRawPolicy.UseVRFTUXPanel
        end,
        getWebViewSupport = function()
            if isRunningInStudio() then
                return not bool2
            end

            if getRawPolicy.EnableWebViewSupport == nil then
                return not IsVRAppBuild()
            end

            return getRawPolicy.EnableWebViewSupport
        end,
        getUseLuafiedReportFlow = function()
            if IsVRAppBuild() and GetFFlagLuafiedReportEntryPoints() then
                if getRawPolicy.UseLuafiedReportFlow == nil then
                    return not not IsVRAppBuild()
                end

                return getRawPolicy.UseLuafiedReportFlow
            end

            if GetFFlagEnableAbuseReport10ft() then
                return getRawPolicy.UseLuafiedReportFlow or false
            end

            return nil
        end,
        getThrottleFramerate = function()
            return if getRawPolicy.ThrottleFramerate == nil then not IsVRAppBuild() else getRawPolicy.ThrottleFramerate
        end,
        getUseRoundedCorners = function()
            return if IsVRAppBuild() then if getRawPolicy.UseRoundedCorners == nil then not not IsVRAppBuild() else getRawPolicy.UseRoundedCorners else false
        end,
        getGameInfoShowChatFeatures = function(): boolean
            return false
        end,
        getDisplayCheckboxInVoiceConsent = function()
            return if GetFFlagSeamlessVoiceConsentToastPolicy() then getRawPolicy.DisplayCheckboxInVoiceConsent or false else false
        end,
        getExperienceChatAvailability = function()
            return if GetFFlagExpChatGuacChatDisabledReason() then getRawPolicy.ExperienceChatAvailability or "unknown" else "unknown"
        end,
        getInCommsRegionBubble = function()
            return if FFlagAEGIS2UseGuacToShowEnabledMessage then getRawPolicy.InCommsRegionBubble or false else false
        end,
        getShowInExpFAEUpsell = function()
            return if FFlagAEGIS2UseGuacToShowFAEUpsell then getRawPolicy.ShowInExpFAEUpsell or false else false
        end,
        getUseAmpV2WizardForVpc = function()
            return getRawPolicy.UseAmpV2WizardForVpc or false
        end,
        getAmpV2VpcExcludedRequestTypes = function()
            return getRawPolicy.AmpV2VpcExcludedRequestTypes or {}
        end,
        getShowFOMOUpsell = function()
            return if FFlagExpChatUseGuacForFOMOUpsell then getRawPolicy.ShowFOMOUpsell or false else false
        end,
        getShowCrossAgeChat = function()
            return if FFlagExpChatUseGuacForCrossAgeChat then getRawPolicy.ShowCrossAgeExpChat or false else false
        end,
        getCanSeeChatTerminology = function()
            return getRawPolicy.canSeeChatTerminology or false
        end,
        getAllowCameraMovements = function()
            return if getRawPolicy.AllowCameraMovements == nil then not IsVRAppBuild() else getRawPolicy.AllowCameraMovements
        end,
        getShouldSkipAvatarLandingPage = function()
            if getRawPolicy.ShouldSkipAvatarLandingPage == nil then
                return not not IsVRAppBuild()
            end

            return getRawPolicy.ShouldSkipAvatarLandingPage
        end,
        getShowPassesOnExperienceDetails = function()
            return getRawPolicy.ShowPassesOnExperienceDetails or false
        end,
        getDisableCDLQrCodeForMaquettes = function()
            return if GetFFlagDisableCDLQrCodeForMaquettes() then getRawPolicy.DisableCDLQrCodeForMaquettes else false
        end,
        getDisableIAPEntryPoint = function()
            return getRawPolicy.DisableIAPEntryPoint or false
        end,
        getEnforceAgeRestrictedLogin = function()
            return getRawPolicy.EnforceAgeRestrictedLogin or false
        end,
        getUrlAuthRoutes = function()
            local routes = getRawPolicy.Routes or {}

            return if routes then routes.auth or {} else {}
        end,
        getShowDisconnectButton = function()
            return getRawPolicy.ShowDisconnectButton or false
        end,
        getUseSingleSignOn = function()
            return not isRunningInStudio() and (getRawPolicy.UseSingleSignOn or false)
        end,
        getGridCarouselSeeAllTilesEnabled = function()
            return getRawPolicy.UseGridCarouselSeeAllTiles or false
        end,
        getSearchWithoutNavigatingEnabled = function()
            return not isTenFootInterface() and (getRawPolicy.SingleSearchPageNoNavigation or false)
        end,
        getGameListCategoryScrollListEnabled = function()
            return getRawPolicy.GetGamesListCategoryTabs or false
        end,
        getForceTheme = function()
            local var2 = Cryo.List.map(var1, function(arg2)
                return arg2:lower()
            end)
            return if getRawPolicy.ForceTheme and Cryo.List.find(var2, getRawPolicy.ForceTheme:lower()) then getRawPolicy.ForceTheme else nil
        end,
        enableExperienceDetailsPanel = function()
            return getRawPolicy.EnableExperienceDetailsPanel or false
        end,
        getDisableRegularLogin = function(): boolean
            return not (getRawPolicy.EnableWebViewSupport or getRawPolicy.EnableRegularLoginWithoutWebViewSupport)
        end,
        getAllowPlatformAccountSwitching = function()
            return getRawPolicy.AllowPlatformAccountSwitching or false
        end,
        useLegacyCrossPlayApi = function()
            return bool3 or getRawPolicy.useLegacyCrossPlayApi or false
        end,
        useCrossPlaySystemUi = function()
            return bool4 or getRawPolicy.useCrossPlaySystemUi or false
        end,
        getCrossPlayUri = function()
            return if str3 == "" then getRawPolicy.crossPlayUri or "" else str3
        end,
        getCrossPlayCapabilities = function()
            return Cryo.List.foldLeft(getRawPolicy.crossPlayCapabilities or {}, function(arg2, arg3)
                if Cryo.List.find(arg2, arg3) then
                    return arg2
                end
                return Cryo.List.join(arg2, { CrossPlayCapabilities[arg3] })
            end, {})
        end,
        getCrossPlaySettingsKey = function()
            return if str1 == "" then getRawPolicy.crossPlaySettingsKey or "" else str1
        end,
        getCrossPlayQueryParam = function()
            return if str2 == "" then getRawPolicy.crossPlayQueryParam or "" else str2
        end,
        getPromotionalEmailsCheckboxEnabled = function()
            return if game:GetFastFlag("LuaAppPromotionalEmailsCheckboxEnabledInAppPolicy") then getRawPolicy.PromotionalEmailsCheckboxEnabled or false else false
        end,
        getPromotionalEmailsOptInByDefault = function()
            return if game:GetFastFlag("LuaAppPromotionalEmailsCheckboxEnabledInAppPolicy") then getRawPolicy.PromotionalEmailsOptInByDefault or false else false
        end,
        getSupportsOverscan = function()
            return getRawPolicy.SupportsOverscan or false
        end,
        getUseConsoleGameJoinCard = function()
            return getRawPolicy.UseConsoleGameJoinCard or false
        end,
        getPlatformDisplayName = function()
            return getRawPolicy.platformDisplayName or ""
        end,
        getPlatformAccountName = function()
            return getRawPolicy.platformAccountName or nil
        end,
        getSupportsProfileSwitching = function()
            return getRawPolicy.supportsProfileSwitching or false
        end,
        getMountAllOmniFeedItems = function()
            return getRawPolicy.mountAllOmniFeedItems or false
        end,
        getFriendCodeQrCodeScannerEnabled = function()
            return getRawPolicy.FriendCodeQrCodeScannerEnabled or false
        end,
        getInviteFriendsDisabled = function()
            return getRawPolicy.InviteFriendsDisabled or false
        end,
        getRealNamesInDisplayNamesEnabled = function()
            return getRawPolicy.RealNamesInDisplayNamesEnabled or false
        end,
        getProfileShareLinkEnabled = function()
            return getRawPolicy.ProfileShareLinkEnabled
        end,
        getProfileCopyLinkEnabled = function()
            return getRawPolicy.ProfileCopyLinkEnabled
        end,
        getEnablePremiumUserFeatures = function()
            return if GetFFlagUseEnablePremiumUserFeaturesAppPolicy() then getRawPolicy.EnablePremiumUserFeatures or false else nil
        end,
        getEnableDualLogin = function()
            return getRawPolicy.enableDualLogin or false
        end,
        getUseExternalBrowserForAgeGuidelines = function()
            return if GetFFlagUseExternalBrowserForAgeGuidelines10ft() then getRawPolicy.UseExternalBrowserForAgeGuidelines or false else nil
        end,
        getEnableHomePageAgeBlock = function()
            return getRawPolicy.EnableHomePageAgeBlock or false
        end,
        getEnableUAppAccessBlock = function()
            return getRawPolicy.EnableUAppAccessBlock or false
        end,
        getUAppBlockPageTextMapKey = function()
            return getRawPolicy.UAppBlockPageTextMapKey or nil
        end,
        getUAppBlockPageShouldDisableLogOut = function()
            return getRawPolicy.UAppBlockPageShouldDisableLogOut or nil
        end,
        getContactsToastEnabled = function()
            return getRawPolicy.ContactsToastEnabled or false
        end,
        getEnableProfileQrCode = function()
            return getRawPolicy.EnableProfileQrCode or false
        end,
        getCanRenderTransferOnProfile = function()
            return if FFlagGuacCanRenderTransferOnProfile then getRawPolicy.CanRenderTransferOnProfile or false else false
        end,
        getShowVNGLoginWithExistingAccountQuickLoginButton = function()
            return getRawPolicy.ShowVNGLoginWithExistingAccountQuickLoginButton or false
        end,
        getUseCrossDeviceLoginByDefault = function()
            return getRawPolicy.UseCrossDeviceLoginByDefault or false
        end,
        getShowVNGAge12Badge = function()
            return getRawPolicy.ShowVNGAge12Badge or false
        end,
        getShowBrazilContentRatingLogo = function()
            return getRawPolicy.ShowBrazilContentRatingLogo or false
        end,
        getUseVNGUserAgreementPopup = function()
            return getRawPolicy.UseVNGUserAgreementPopup or false
        end,
        getRedirectBuyRobuxToVNG = function()
            return getRawPolicy.RedirectBuyRobuxToVNG or false
        end,
        getShowVNGTosForRobuxUpsell = function()
            return getRawPolicy.ShowVNGTosForRobuxUpsell or false
        end,
        getBlockVNGU12SignUpOnClientSide = function()
            return getRawPolicy.BlockVNGU12SignUpOnClientSide or false
        end,
        getMetaSignupMinimumAge = function()
            if not IsVRAppBuild() then
                return nil
            end
            return tonumber(getRawPolicy.MetaSignupMinimumAge) or 10
        end,
        getUseAgeInput = function()
            return getRawPolicy.UseAgeInput or false
        end,
        getLoginUsernameOnly = function()
            return getRawPolicy.LoginUsernameOnly or false
        end,
        getDisableEmailOTPLogin = function()
            return getRawPolicy.DisableEmailOTPLogin or false
        end,
        getDisableLoginForgotButton = function()
            return getRawPolicy.DisableLoginForgotButton or false
        end,
        getDisableLogOutEmailUpsell = function()
            return getRawPolicy.DisableLogOutEmailUpsell or false
        end,
        getVerifiedSignupCountry = function()
            return getRawPolicy.verifiedSignupCountry or false
        end,
        getParentalConsentAgreementId = function()
            return getRawPolicy.parentalConsentAgreementId or ""
        end,
        getIsStrictComplianceEnabled = function()
            return getRawPolicy.isStrictComplianceEnabled or false
        end,
        getUseKoreaKISAUserAgreementPopup = function()
            return getRawPolicy.useKoreaKISAUserAgreementPopup or false
        end,
        getEnableNotificationPreferencesPage = function()
            return if GetFFlagEnableGateNotificationPreferencesTab() then getRawPolicy.EnableNotificationPreferencesPage or false else nil
        end,
        getVNGFormRequired = function()
            return getRawPolicy.VNGFormRequired or false
        end,
        getUpsellVoiceForPhoneVerification = function()
            return getRawPolicy.UpsellVoiceForPhoneVerification or false
        end,
        getIsLinkedVRModeAvailable = function(): boolean
            local platform = UserInputService:GetPlatform()
            return platform == Enum.Platform.Windows or platform == Enum.Platform.UWP
        end,
        getShouldShowPhoneUpsell = function()
            return getRawPolicy.ShouldShowPhoneUpsell or false
        end,
        getTermsOfUseLink = function()
            return getRawPolicy.TermsOfUseLink or ""
        end,
        getPrivacyPolicyLink = function()
            return getRawPolicy.PrivacyPolicyLink or ""
        end,
        getVngAppUpsell = function()
            return if FFlagLuaAppHomeVngAppUpsell then getRawPolicy.VngAppUpsell or false else false
        end,
        getVngAppUpsellPcLayout = FFlagVngAppUpsellPcLayout and function()
            return getRawPolicy.VngAppUpsellPcLayout or false
        end or nil,
        getShouldHideContactImporterUpsell = function()
            return getRawPolicy.ShouldHideContactImporterUpsell or false
        end,
        getContactImporterEncouraged = function()
            return getRawPolicy.contactImporterEncouraged or false
        end,
        getFriendRequestNicknamesEnabled = function(): boolean
            return false
        end,
        getShouldShowVpcPlayButtonUpsells = FFlagLuaAppParentUpsellPolicy and function()
            return getRawPolicy.shouldShowVpcPlayButtonUpsells or false
        end or nil,
        getDisablePlayableWhenLoading = FFlagLuaAppSupportDisablePlayableWhenLoading and function()
            return getRawPolicy.DisablePlayableWhenLoading or false
        end or nil,
        getRenamePaymentsToSpendingTab = function()
            return getRawPolicy.renamePaymentsToSpendingTab or false
        end,
        getNotificationsCanReceiveStream = function()
            return if GetFFlagNotificationsComplianceShouldRestrictStream() then getRawPolicy.notificationsCanAccessStream or false else nil
        end,
        getNotificationsCanReceivePush = function()
            return getRawPolicy.notificationsCanAccessPush or false
        end,
        getPushNotificationsUpsell = function()
            return getRawPolicy.ShouldShowPushNotificationsUpsell or false
        end,
        getNotificationsCanReceiveExperience = function()
            return getRawPolicy.notificationsCanAccessExperience == nil or getRawPolicy.notificationsCanAccessExperience
        end,
        getDisableResellingCollectiblesForCompliance = function()
            return getRawPolicy.DisableResellingCollectiblesForCompliance or false
        end,
        getShowIllegalContentReportingUI = function()
            return bool9 or getRawPolicy.ShowIllegalContentReportingUI or false
        end,
        getEligibleForContentPostFeed = function()
            return getRawPolicy.EligibleForContentPostFeed or false
        end,
        getEligibleForExternalContentSharing = function()
            return getRawPolicy.EligibleForExternalContentSharing or false
        end,
        getEnableContinuousLoad = function()
            return getRawPolicy.EnableContinuousLoad or false
        end,
        getEnableAggregateLikesFavoritesCount = function()
            return getRawPolicy.EnableAggregateLikesFavoritesCount or false
        end,
        getShowUpdatedCameraPath = function()
            return getRawPolicy.showUpdatedCameraPath or false
        end,
        getRenameParentEmailForVerificationUpsell = function()
            return if FFlagRenameParentEmailForVerificationUpsell() then getRawPolicy.renameParentEmailForVerificationUpsell or false else false
        end,
        getKeystrokeCollectionEnabled = function()
            return if game:GetFastFlag("BehaviorCollectionControlEnabled") then getRawPolicy.EnableKeystrokeCollection or false else false
        end,
        getCanUsePlatformChat = function()
            if bool10 then
                return getRawPolicy.CanUsePlatformChat or false
            end

            if FFlagAppChatOnConsoles then
                return getRawPolicy.CanUsePlatformChat2 or false
            end

            return getRawPolicy.CanUsePlatformChat or false
        end,
        getCanSeeChatTab = function()
            if bool10 then
                return getRawPolicy.CanSeeChatTab or false
            end

            if FFlagAppChatOnConsoles then
                return getRawPolicy.CanSeeChatTab2 or false
            end

            return getRawPolicy.CanSeeChatTab or false
        end,
        getCanSeeFriendsTab = function()
            local tbl1 = {
                ContextCard = true,
                ContextCardUkCopy = FFlagFriendsChatDiscloseUpdateSecondVersion,
                ConversationConsent = FFlagFriendsChatEnableConversationConsent,
                FriendCountGate = FFlagFriendsChatHasFriendsGate,
                VR = false,
                Console = false,
                Gamepad = false
            }

            for _, value in getRawPolicy.FriendsTabRequiredCapabilities or {} do
                if not tbl1[value] then
                    return false
                end
            end
            return true
        end,
        getHidesGamesTab = function()
            return if FFlagEnableAndroidTvAppPolicies then getRawPolicy.HidesGamesTab or false else false
        end,
        getShowDisclaimerLinkForUnderageSignupsOnAllSignupPages = function()
            return not GetFFlagEnableMultiPageSignup()
                or getRawPolicy.ShowTermsAndPrivacyPolicyLinksForAllPagesU13Signup == nil
                or getRawPolicy.ShowTermsAndPrivacyPolicyLinksForAllPagesU13Signup
        end,
        getAgeCutoffForShowDisclaimerLinkForUnderageSignupsOnAllSignupPages = function()
            local fIntExclusiveFallbackExclusiveUnderageCutoffForMultiPageSignup = GetFIntExclusiveFallbackExclusiveUnderageCutoffForMultiPageSignup()

            if GetFFlagEnableMultiPageSignup() then
                if getRawPolicy.AgeCutoffForShowDisclaimerLinkForUnderageSignupsOnAllSignupPages == nil then
                    return fIntExclusiveFallbackExclusiveUnderageCutoffForMultiPageSignup
                end

                return getRawPolicy.AgeCutoffForShowDisclaimerLinkForUnderageSignupsOnAllSignupPages
            end

            return fIntExclusiveFallbackExclusiveUnderageCutoffForMultiPageSignup
        end,
        getRobuxUpsellFlowMobile = function()
            return getRawPolicy.useMobileRobuxUpsellFlow or false
        end,
        getUsePaymentPlatformMicrosoftStore = function()
            return if FFlagEnableMicrosoftStorePaymentsPlatform then getRawPolicy.usePaymentPlatformMicrosoftStore or false else false
        end,
        getMicSettingsDirectionsLocaleKey = function()
            return getRawPolicy.micSettingsDirectionsLocaleKey or nil
        end,
        getMicSettingsDeeplinkDirectionsLocaleKey = function()
            return getRawPolicy.micSettingsDeeplinkDirectionsLocaleKey or nil
        end,
        getRequiresAppRestartOnMicAccessChange = function()
            return getRawPolicy.requiresAppRestartOnMicAccessChange or false
        end,
        getRenameFriendsToConnections = function()
            return if FFlagEnableFriendsRenamingForAll then true else getRawPolicy.renameFriendsToConnections or false
        end,
        getShareSheetEnabled = function()
            return getRawPolicy.shareSheetEnabled or false
        end,
        getShowAppIconSetting = function()
            return getRawPolicy.ShowAppIconSetting or false
        end,
        getCanAccessTrustedContacts = function()
            return getRawPolicy.canAccessTrustedContacts or false
        end,
        getExperienceDetailsNoticeType = function()
            return getRawPolicy.experienceDetailsNoticeType or nil
        end,
        getRequiresOSAFriendingEducation = function()
            return getRawPolicy.requiresOSAFriendingEducation or false
        end,
        getSocialGraphSyncEnabled = function()
            return getRawPolicy.SocialGraphSyncEnabled or false
        end,
        getAccountDisambiguationDisabled = function()
            return getRawPolicy.AccountDisambiguationDisabled or false
        end,
        getHasWebViewSupportForFAE = function()
            return getRawPolicy.hasWebViewSupportForFAE or false
        end,
        getLinkedAuthEndpointsEnabled = function()
            return getRawPolicy.LinkedAuthEndpointsEnabled or false
        end,
        getLinkingPlatform = function()
            return getRawPolicy.LinkingPlatform or nil
        end,
        getUsePaymentPlatformMilkyWayStore = function()
            return if FFlagEnableMilkyWayPaymentsPlatformV2 then getRawPolicy.usePaymentPlatformMilkyWayStore or false else false
        end,
        getScreentimeMoreTimeOptionEnabled = function()
            return if FFlagEnableScreentimeMoreTimeOption then getRawPolicy.ScreentimeMoreTimeOptionEnabled or false else false
        end,
        getDisablePremiumEntrypoint = function()
            return if bool6 then getRawPolicy.DisablePremiumEntrypoint or getRawPolicy.DisablePremiumEntryPoint or false else false
        end,
        getDisableBlackbirdEntrypoints = function()
            return if bool7 then getRawPolicy.DisableBlackbirdEntrypoints or false else false
        end,
        getEnableGiftcardsWithRedeem = function()
            return if bool8 then getRawPolicy.EnableGiftcardsWithRedeem or false else false
        end,
        getGiftCardSourceRefOverride = function()
            return getRawPolicy.GiftCardSourceRefOverride or ""
        end,
        getSignupCheckboxDisabled = function()
            return if bool5 then getRawPolicy.DisableSignupCheckbox or false else false
        end,
        getShouldShowFaceIDText = function()
            return if FFlagEnableFaceIDTextOnAddAuthMethodPage then getRawPolicy.ShouldShowFaceIDText or false else false
        end,
        getExcludeCrossDeviceSignIn = function()
            return getRawPolicy.ExcludeCrossDeviceSignIn or false
        end,
        getExcludePasskeyLogin = function()
            return getRawPolicy.ExcludePasskeyLogin or false
        end,
        getExcludeExternalIdentityLogin = function(): boolean
            return getRawPolicy.ExcludeExternalIdentityLogin ~= false
        end,
        getExternalIdentityAppleUsesBrowserSignIn = function()
            return getRawPolicy.ExternalIdentityAppleUsesBrowserSignIn or false
        end,
        getExcludeExternalIdentityOtherSignInOptions = function(): boolean
            return getRawPolicy.ExcludeExternalIdentityOtherSignInOptions ~= false
        end,
        getExcludeUsernamePasswordSignIn = function()
            return getRawPolicy.ExcludeUsernamePasswordSignIn or false
        end,
        getExcludeEmailPasswordSignIn = function()
            return getRawPolicy.ExcludeEmailPasswordSignIn or false
        end,
        getExcludePhoneNumberPasswordSignIn = function()
            return getRawPolicy.ExcludePhoneNumberPasswordSignIn or false
        end,
        getExcludeAccountSwitcher = function()
            return getRawPolicy.ExcludeAccountSwitcher or false
        end,
        getAccountSwitcherEnabled = function()
            return getRawPolicy.AccountSwitcherEnabled or false
        end,
        getAccountPickerEnabled = function()
            return getRawPolicy.AccountPickerEnabled or false
        end,
        getExcludeUsernameUpdateModeration = function()
            return getRawPolicy.ExcludeUsernameUpdateModeration or false
        end,
        getMorePageExitButtonEnabled = FFlagEnableMorePageExitButtonSupport and function()
            return getRawPolicy.MorePageExitButtonEnabled or false
        end or nil,
        getMoreGridDirectionalLayoutPreferred = FFlagEnableMorePageDirectionalLayoutRolloutFix and function()
            return getRawPolicy.MoreGridDirectionalLayoutPreferred or false
        end or nil,
        getShouldUseDMCCALegalDisclosureInApp = function()
            return getRawPolicy.ShouldUseDMCCALegalDisclosureInApp or false
        end,
        getCanAccessParty = function()
            return getRawPolicy.CanAccessParty == nil or getRawPolicy.CanAccessParty
        end,
        getRedeemTileEnabled = function()
            return getRawPolicy.RedeemTileEnabled or false
        end,
        getMomentsFeatureList = function()
            if str4 and str4 ~= "" then
                return string.split(str4, ",")
            end
            return if getRawPolicy.MomentsFeatureList == nil then {} else getRawPolicy.MomentsFeatureList
        end,
        getShowInContextPersonalizedRecommendationsMomentsFeed = function()
            return getRawPolicy.showInContextPersonalizedRecommendationsMomentsFeed or false
        end,
        getSupportCenterEnabled = GetFFlagEnableSupportCenter() and function()
            return getRawPolicy.SupportCenterEnabled or false
        end or nil,
        getShouldUseVibrationInsteadOfHaptics = function()
            return getRawPolicy.ShouldUseVibrationInsteadOfHaptics or false
        end,
        getRawPolicy = function()
            return getRawPolicy
        end,
        getStickyShortcutBarEnabled = function()
            return getRawPolicy.StickyShortcutBarEnabled or false
        end,
        getAccountType = FFlagEnableCoreContentAccountType and function()
            return getRawPolicy.AccountType
        end or nil,
        getCoreContentBadgeText = FFlagEnableCoreContentBadge and function()
            return getRawPolicy.CoreContentBadgeText
        end or nil,
        getShowUncheckedBadge = FFlagEnableFlyoutUncheckedBadge and function()
            return getRawPolicy.ShowUncheckedBadge
        end or FFlagEnableNonFlyoutUncheckedBadge and function()
            return getRawPolicy.ShowUncheckedBadge
        end or nil,
        getShowUncheckedBadgeForAccountSwitcher = function()
            return if GetFFlagEnableAccountSwitcherUncheckedBadge() then getRawPolicy.ShowUncheckedBadge else false
        end,
        getShowGameAgeRating = FFlagShowGameAgeRating and function()
            return getRawPolicy.ShowGameAgeRating or false
        end or nil,
        getShowBadgeOver12 = not FFlagShowGameAgeRating and function()
            return getRawPolicy.ShowBadgeOver12 or false
        end or nil,
        getDefaultTheme = FFlagDefaultKidsToDarkTheme and function()
            return getRawPolicy.DefaultTheme
        end or nil,
        getDevicePreferencesPersistentPresenceVariant = fFlagMacMenuBarContentUpdates and function()
            return getRawPolicy.DevicePreferencesPersistentPresenceVariant
        end or nil,
        getCancelSearchOnLostFocus = FFlagUsesCancelSearchAppPolicy and function()
            return getRawPolicy.CancelSearchOnLostFocus == nil or getRawPolicy.CancelSearchOnLostFocus
        end or nil,
        getCanViewBuild = FFlagAppNavMyStatsTab and function()
            return getRawPolicy.CanViewBuild or false
        end or nil,
        getCanUseBuild = FFlagAppNavMyStatsTab and function()
            return getRawPolicy.CanUseBuild or false
        end or nil,
        getShouldFullscreenElementsIgnoreSafeArea = function()
            return getRawPolicy.ShouldFullscreenElementsIgnoreSafeArea or false
        end,
        getPinExperienceTargetDestination = FFlagAddPinExperienceTargetDestinationGUACPolicy and function()
            return getRawPolicy.PinExperienceTargetDestination or "HomeScreen"
        end or nil,
        getFlyoutSidePanelEnabled = function()
            return getRawPolicy.FlyoutSidePanelEnabled or false
        end,
        getLearnPlaceEnabled = function()
            return not FFlagFlyoutGateLearnPlace or getRawPolicy.LearnPlaceEnabled or false
        end
    }
end

return AppFeaturePolicies
