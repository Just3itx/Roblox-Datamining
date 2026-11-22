-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)

local _AnalyticsTypes = require(SocialCarousel.Analytics.AnalyticsTypes)

return React.createContext({
    eventIngest = function() end,
    appAnalytics = function() end,
    hideCarouselHeader = false,
    openGameJoinCardUserId = nil,
    setOpenGameJoinCardUserId = nil,
    openBuildCardUserId = nil,
    setOpenBuildCardUserId = nil,
    unifiedLogging = nil,
    sortAnalyticsData = nil,
    tiles = {},
    friendRequestCount = 0,
    friendCount = 0,
    recommendationCount = 0,
    onSuccessfulRender = function() end,
    selectionOrderBase = nil,
    source = nil,
    navigateToQRCodePage = nil,
    isLoading = false
})
