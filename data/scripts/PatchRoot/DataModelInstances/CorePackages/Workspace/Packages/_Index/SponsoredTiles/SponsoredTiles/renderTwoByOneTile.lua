-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SponsoredTiles = script:FindFirstAncestor("SponsoredTiles")
local SponsoredTilesParent = SponsoredTiles.Parent

local GameCollectionItemTypes = require(SponsoredTilesParent.DiscoveryTypes).GameCollectionItemTypes

local React = require(SponsoredTilesParent.React)
local GameTile = require(SponsoredTilesParent.GameTile)
local TwoByOneGameTile = require(SponsoredTiles.TwoByOneGameTile)
local getTileBadgeByPositionConfigFromEntry = GameTile.getTileBadgeByPositionConfigFromEntry
local resolveWideAssetId = GameTile.resolveWideAssetId
local _VideoUtils = require(SponsoredTilesParent.VideoUtils)
local FFlagLuaAppEnableReportExperience = require(SponsoredTilesParent.SharedFlags).FFlagLuaAppEnableReportExperience

local var1 = React.memo(function(tbl1)
    local var1 = -((tbl1.maxItemIndex or 0) + 1)
    if tbl1.zIndex then
        var1 = tbl1.zIndex + var1
    end
    local onSelectionGained = React.useCallback(function()
        if tbl1.onSelectionGained then
            tbl1.onSelectionGained(tbl1.item, tbl1.index, tbl1.item.universeId)
        end
    end, { tbl1.onSelectionGained, tbl1.item, tbl1.index })

    local badgeOverride = getTileBadgeByPositionConfigFromEntry(tbl1.item)

    return React.createElement(TwoByOneGameTile, {
        size = tbl1.item.sizeOverride,
        layoutOrder = tbl1.index,
        zIndex = var1,
        universeId = tbl1.item.universeId,
        placeId = tbl1.item.placeId,
        topicId = tbl1.topicId,
        logoImageAssetId = tbl1.item.logoAssetId,
        logoAspectRatio = tbl1.item.logoAspectRatio,
        headline = tbl1.item.headline,
        subtitle = tbl1.item.subtitle,
        ctaText = tbl1.item.ctaText,
        tileVariant = tbl1.item.tileVariant,
        badgeOverride = badgeOverride,
        payerName = tbl1.item.payerName,
        adId = tbl1.item.adId,
        isSponsored = tbl1.item.isSponsored,
        sponsoredUserCohort = tbl1.sponsoredUserCohort,
        appPage = tbl1.appPage,
        setGameHidden = tbl1.setGameHidden,
        isHidden = tbl1.isHidden,
        hoverKey = `TwoByOneTile_{tbl1.impressionsTag or ""}_{tbl1.index or "0"}_{tbl1.item.universeId}`,
        impressionsTag = tbl1.impressionsTag,
        index = tbl1.index,
        reportGameDetailOpened = tbl1.reportGameDetailOpened,
        reportExperienceLaunched = tbl1.reportExperienceLaunched,
        enableSponsoredFeedback = tbl1.enableSponsoredFeedback,
        enableReportAd = tbl1.enableReportAd,
        enableReportExperience = if FFlagLuaAppEnableReportExperience then tbl1.enableReportExperience else nil,
        enableExplicitFeedback = tbl1.enableExplicitFeedback,
        placeIdOverride = tbl1.item.placeIdOverride,
        launchDataOverride = tbl1.item.launchDataOverride,
        onSelectionGained = onSelectionGained,
        onSelectionLost = tbl1.onSelectionLost,
        wideAssetId = resolveWideAssetId(tbl1.item.primaryWideImageAssetId, tbl1.item, tbl1.topicId),
        ageRatingLabel = tbl1.item.ageRecommendationDisplayName,
        videoPlaybackContext = tbl1.videoPlaybackContext,
        SelectionOrder = tbl1.SelectionOrder
    })
end)

return function(tbl1)
    return React.createElement(var1, tbl1), GameCollectionItemTypes.GameCollectionItemType.TwoByOneTile
end
