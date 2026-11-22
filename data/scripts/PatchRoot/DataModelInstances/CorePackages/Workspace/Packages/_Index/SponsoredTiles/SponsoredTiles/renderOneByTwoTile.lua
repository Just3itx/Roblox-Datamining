-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SponsoredTiles = script:FindFirstAncestor("SponsoredTiles")
local SponsoredTilesParent = SponsoredTiles.Parent

local GameCollectionItemTypes = require(SponsoredTilesParent.DiscoveryTypes).GameCollectionItemTypes
local React = require(SponsoredTilesParent.React)
local GameTile = require(SponsoredTilesParent.GameTile)
local OneByTwoTile = require(SponsoredTiles.OneByTwoTile)
local getTileBadgeByPositionConfigFromEntry = GameTile.getTileBadgeByPositionConfigFromEntry
local _VideoUtils = require(SponsoredTilesParent.VideoUtils)

local SharedFlags = require(SponsoredTilesParent.SharedFlags)
local FFlagLuaAppEnableReportExperience = SharedFlags.FFlagLuaAppEnableReportExperience
local FFlagLuaAppEnableOneByTwoTileFunnelTelemetry = SharedFlags.FFlagLuaAppEnableOneByTwoTileFunnelTelemetry

local var1 = React.memo(function(tbl1)
    local badgeOverride = getTileBadgeByPositionConfigFromEntry(tbl1.item)

    local var1 = -((tbl1.maxItemIndex or 0) + 1)
    if tbl1.zIndex then
        var1 = tbl1.zIndex + var1
    end
    local hoverKey = `OneByTwoTile_{tbl1.impressionsTag or ""}_{tbl1.index or "0"}_{tbl1.item.universeId or tbl1.item.clickoutUrl}`

    local onSelectionGained = React.useCallback(function()
        if tbl1.onSelectionGained then
            tbl1.onSelectionGained(tbl1.item, tbl1.index, tbl1.item.universeId)
        end
    end, { tbl1.onSelectionGained, tbl1.item, tbl1.index })

    return React.createElement(OneByTwoTile, {
        size = tbl1.item.sizeOverride,
        alignmentType = if tbl1.item.spanOverride == nil then nil else tbl1.item.spanOverride.alignmentType,
        zIndex = var1,
        hoverKey = hoverKey,
        contentType = tbl1.item.contentType,
        universeId = tbl1.item.universeId,
        placeId = tbl1.item.placeId,
        placeIdOverride = tbl1.item.placeIdOverride,
        launchDataOverride = tbl1.item.launchDataOverride,
        referralSource = tbl1.appPage,
        reportGameDetailOpened = tbl1.reportGameDetailOpened,
        reportExperienceLaunched = tbl1.reportExperienceLaunched,
        launchExperienceEventContext = tbl1.launchExperienceEventContext,
        topicId = tbl1.topicId,
        badgeOverride = badgeOverride,
        primaryImageAssetId = tbl1.item.primaryImageAssetId,
        primaryVideoAssetId = tbl1.item.primaryVideoAssetId,
        attributionThumbnailAssetId = tbl1.item.attributionThumbnailAssetId,
        logoImageAssetId = tbl1.item.logoAssetId,
        logoAspectRatio = tbl1.item.logoAspectRatio,
        headline = tbl1.item.headline,
        subtitle = tbl1.item.subtitle,
        ctaText = tbl1.item.ctaText or "",
        adId = tbl1.item.adId,
        impressionsTag = tbl1.impressionsTag,
        index = tbl1.index,
        clickoutUrl = tbl1.item.clickoutUrl,
        videoPlaybackContext = tbl1.videoPlaybackContext,
        videoAnalytics = tbl1.videoAnalytics,
        pageContext = tbl1.appPage,
        payerName = tbl1.item.payerName,
        appPage = tbl1.appPage,
        sponsoredUserCohort = tbl1.sponsoredUserCohort,
        setGameHidden = tbl1.setGameHidden,
        enableSponsoredFeedback = tbl1.enableSponsoredFeedback,
        enableReportAd = tbl1.enableReportAd,
        enableReportExperience = if FFlagLuaAppEnableReportExperience then tbl1.enableReportExperience else nil,
        enableExplicitFeedback = tbl1.enableExplicitFeedback,
        onSelectionGained = onSelectionGained,
        onSelectionLost = tbl1.onSelectionLost,
        SelectionOrder = tbl1.SelectionOrder,
        oneByTwoTileFlowId = if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then tbl1.item.oneByTwoTileFlowId else nil,
        recommendationsRequestId = if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then tbl1.item.recommendationsRequestId else nil,
        isSdui = not FFlagLuaAppEnableOneByTwoTileFunnelTelemetry and nil
    })
end)

return function(tbl1)
    return React.createElement(var1, tbl1), GameCollectionItemTypes.GameCollectionItemType.OneByTwoTile
end
