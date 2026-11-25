-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local SduiPolicyFieldKey = require(SduiCoreSystem.ClientBinding.SduiPolicyFieldKey)
local _UniversalAppPolicy = require(SduiCoreSystemParent.UniversalAppPolicy)

local function resolveSduiPolicyField(arg1, str1: string)
    if str1 == SduiPolicyFieldKey.SearchBar then
        return true, arg1.getSearchBar()
    elseif str1 == SduiPolicyFieldKey.GameDetailsMorePage then
        return true, arg1.getGameDetailsMorePage()
    elseif str1 == SduiPolicyFieldKey.GameDetailsSubtitle then
        return true, arg1.getGameDetailsSubtitle()
    elseif str1 == SduiPolicyFieldKey.GameDetailsPlayWithFriends then
        return true, arg1.getGameDetailsPlayWithFriends()
    elseif str1 == SduiPolicyFieldKey.ShowGlobalCounters then
        return true, arg1.getShowGlobalCounters()
    elseif str1 == SduiPolicyFieldKey.GameInfoList then
        return true, arg1.getGameInfoList()
    elseif str1 == SduiPolicyFieldKey.GamePlaysAndRatings then
        return true, arg1.getGamePlaysAndRatings()
    elseif str1 == SduiPolicyFieldKey.GameReportingDisabled then
        return true, arg1.getGameReportingDisabled()
    elseif str1 == SduiPolicyFieldKey.RecommendedGames then
        return true, arg1.getRecommendedGames()
    elseif str1 == SduiPolicyFieldKey.SocialLinks then
        return true, arg1.getSocialLinks()
    elseif str1 == SduiPolicyFieldKey.SocialGroupLinks then
        return true, arg1.getSocialGroupLinks()
    elseif str1 == SduiPolicyFieldKey.CommunityLinksEnabled then
        return true, arg1.getCommunityLinksEnabled()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowBadges then
        return true, arg1.getGameInfoShowBadges()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowCreated then
        return true, arg1.getGameInfoShowCreated()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowGamepasses then
        return true, arg1.getGameInfoShowGamepasses()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowGenre then
        return true, arg1.getGameInfoShowGenre()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowSubgenre then
        return true, arg1.getGameInfoShowSubgenre()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowMaxPlayers then
        return true, arg1.getGameInfoShowMaxPlayers()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowServers then
        return true, arg1.getGameInfoShowServers()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowUpdated then
        return true, arg1.getGameInfoShowUpdated()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowAgeRecommendation then
        return true, arg1.getGameInfoShowAgeRecommendation()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowVoiceAndChatFeatures then
        return true, arg1.getGameInfoShowVoiceAndChatFeatures()
    elseif str1 == SduiPolicyFieldKey.GameInfoShowChatFeatures then
        return true, arg1.getGameInfoShowChatFeatures()
    elseif str1 == SduiPolicyFieldKey.GameInfoListDeveloper then
        return true, arg1.getGameInfoListDeveloper()
    elseif str1 == SduiPolicyFieldKey.GameInfoListShowRNVDeveloper then
        return true, arg1.getGameInfoListShowRNVDeveloper()
    elseif str1 == SduiPolicyFieldKey.ShowPassesOnExperienceDetails then
        return true, arg1.getShowPassesOnExperienceDetails()
    elseif str1 == SduiPolicyFieldKey.EnableAggregateLikesFavoritesCount then
        return true, arg1.getEnableAggregateLikesFavoritesCount()
    elseif str1 == SduiPolicyFieldKey.ExperienceDetailsNoticeType then
        return true, arg1.getExperienceDetailsNoticeType()
    elseif str1 == SduiPolicyFieldKey.NotificationsCanReceiveExperience then
        return true, arg1.getNotificationsCanReceiveExperience()
    elseif str1 == SduiPolicyFieldKey.InviteFriendsDisabled then
        return true, arg1.getInviteFriendsDisabled()
    elseif str1 == SduiPolicyFieldKey.WebViewSupport then
        return true, arg1.getWebViewSupport()
    elseif str1 == SduiPolicyFieldKey.UseRoundedCorners then
        return true, arg1.getUseRoundedCorners()
    elseif str1 == SduiPolicyFieldKey.RenameFriendsToConnections then
        return true, arg1.getRenameFriendsToConnections()
    elseif str1 == SduiPolicyFieldKey.UseLuafiedReportFlow then
        return true, arg1.getUseLuafiedReportFlow()
    elseif str1 == SduiPolicyFieldKey.ExperienceInviteShareLinkEnabled then
        return true, arg1.getExperienceInviteShareLinkEnabled()
    elseif str1 == SduiPolicyFieldKey.ExperienceChatAvailability then
        return true, arg1.getExperienceChatAvailability()
    elseif str1 == SduiPolicyFieldKey.DisableIAPEntryPoint then
        return true, arg1.getDisableIAPEntryPoint()
    elseif str1 == SduiPolicyFieldKey.PurchasePromptIncludingWarning then
        return true, arg1.getPurchasePromptIncludingWarning()
    elseif str1 == SduiPolicyFieldKey.DisableResellingCollectiblesForCompliance then
        return true, arg1.getDisableResellingCollectiblesForCompliance()
    elseif str1 == SduiPolicyFieldKey.CatalogPremiumCategory then
        return true, arg1.getCatalogPremiumCategory()
    elseif str1 == SduiPolicyFieldKey.CatalogPremiumContent then
        return true, arg1.getShowCatalogPremiumContent()
    elseif str1 == SduiPolicyFieldKey.ShowVNGTosForRobuxUpsell then
        return true, arg1.getShowVNGTosForRobuxUpsell()
    elseif str1 == SduiPolicyFieldKey.ShouldUseDMCCALegalDisclosureInApp then
        return true, arg1.getShouldUseDMCCALegalDisclosureInApp()
    elseif str1 == SduiPolicyFieldKey.RedirectBuyRobuxToVNG then
        return true, arg1.getRedirectBuyRobuxToVNG()
    elseif str1 == SduiPolicyFieldKey.RobuxUpsellFlowMobile then
        return true, arg1.getRobuxUpsellFlowMobile()
    elseif str1 == SduiPolicyFieldKey.EnablePremiumUserFeatures then
        return true, arg1.getEnablePremiumUserFeatures()
    elseif str1 == SduiPolicyFieldKey.DisablePremiumEntrypoint then
        return true, arg1.getDisablePremiumEntrypoint()
    end
    return false, nil
end

return resolveSduiPolicyField
