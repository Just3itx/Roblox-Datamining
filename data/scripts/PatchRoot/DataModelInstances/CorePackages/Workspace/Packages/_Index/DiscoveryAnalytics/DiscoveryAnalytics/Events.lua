-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local FFlagSduiExperienceDetailsSocialProof = require(DiscoveryAnalyticsParent.SharedFlags).FFlagSduiExperienceDetailsSocialProof

return {
    gameDetailReferral = require(script.gameDetailReferral),
    gameCopyExperienceLink = require(script.gameCopyExperienceLink),
    gameCreatePrivateGame = require(script.gameCreatePrivateGame),
    gameDetailsSubpage = require(script.gameDetailsSubpage),
    gameFavorite = require(script.gameFavorite),
    gameFollow = require(script.gameFollow),
    gameJoinFriendsInGame = require(script.gameJoinFriendsInGame),
    gamePlayIntent = require(script.gamePlayIntent),
    gameShareExperienceLink = require(script.gameShareExperienceLink),
    gameVote = require(script.gameVote),
    invalidPlayIntent = require(script.invalidPlayIntent),
    sendPlayButtonLoadingDuration = require(script.sendPlayButtonLoadingDuration),
    unlockPlayIntent = require(script.unlockPlayIntent),
    sortDeeplinkFailureCounter = require(script.sortDeeplinkFailureCounter),
    gameConnectionsPlayedChipClicked = if FFlagSduiExperienceDetailsSocialProof then require(script.gameConnectionsPlayedChipClicked) else nil,
    gameTileOverflowMenuAction = require(script.gameTileOverflowMenuAction),
    sendGameDwellEvent = require(script.sendGameDwellEvent),
    discoveryVideoEndEvent = require(script.Video.discoveryVideoEndEvent),
    discoveryVideoLoadEvent = require(script.Video.discoveryVideoLoadEvent),
    discoveryVideoLoopEvent = require(script.Video.discoveryVideoLoopEvent),
    discoveryVideoPlayEvent = require(script.Video.discoveryVideoPlayEvent),
    gameDetailsPeekViewEvents = require(script.gameDetailsPeekViewEvents),
    reportGameAttributionError = require(script.reportGameAttributionError),
    sendSocialLinkClickEvent = require(script.sendSocialLinkClickEvent),
    sendSocialLinksImpressionsEvent = require(script.sendSocialLinksImpressionsEvent),
    sendOpenLeavingRobloxModalEvent = require(script.sendOpenLeavingRobloxModalEvent),
    sendSafetyResourceBannerEvent = require(script.sendSafetyResourceBannerEvent),
    sendRequestRefundClickEvent = require(script.sendRequestRefundClickEvent),
    fireInExperienceDetailsPromptOpenedEvent = require(script.fireInExperienceDetailsPromptOpenedEvent),
    fireInExperienceDetailsPromptPlayButtonClickedEvent = require(script.fireInExperienceDetailsPromptPlayButtonClickedEvent),
    fireInExperienceDetailsPromptClosedEvent = require(script.fireInExperienceDetailsPromptClosedEvent),
    fireInExperienceDetailsPromptLoadedEvent = require(script.fireInExperienceDetailsPromptLoadedEvent),
    sendMediaGalleryMediaChanged = require(script.sendMediaGalleryMediaChanged),
    openYouTubeVideoEvent = require(script.openYouTubeVideoEvent),
    sendMediaGalleryFullscreenEvent = require(script.sendMediaGalleryFullscreenEvent),
    sendPlayButtonContextualMessageImpressionEvent = require(script.sendPlayButtonContextualMessageImpressionEvent),
    showMoreClickEvent = require(script.showMoreClickEvent),
    backToTopClickEvent = require(script.backToTopClickEvent),
    openSearchResultsWithQueryDeeplink = require(script.openSearchResultsWithQueryDeeplink),
    querySuggestionClicked = require(script.querySuggestionClicked),
    aiOverviewSentiment = require(script.aiOverviewSentiment),
    aiOverviewExplicitFeedback = require(script.aiOverviewExplicitFeedback)
}
