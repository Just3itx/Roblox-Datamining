-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local TopicContentsRoduxParent = script:FindFirstAncestor("TopicContentsRodux").Parent
local DiscoveryTypes = require(TopicContentsRoduxParent.DiscoveryTypes)
local parseBooleanString = require(TopicContentsRoduxParent.DiscoveryUtils).parseBooleanString
local OmniRecommendationsContentType = DiscoveryTypes.OmniRecommendationsContentType
local Result = require(TopicContentsRoduxParent.Result)

local FFlagEnableTopSongsSort = require(TopicContentsRoduxParent.SharedFlags).FFlagEnableTopSongsSort
local FFlagLuaAppEnableNxMRoduxApportioning = require(TopicContentsRoduxParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning

local FFlagLuaAppEnableOneByTwoTileFunnelTelemetry = require(TopicContentsRoduxParent.SharedFlags).FFlagLuaAppEnableOneByTwoTileFunnelTelemetry
local FFlagLuaAppSponsoredGamePreviewVideo = require(TopicContentsRoduxParent.SharedFlags).FFlagLuaAppSponsoredGamePreviewVideo

local var1 = FFlagLuaAppEnableOneByTwoTileFunnelTelemetry and {} or nil

local module = {}

function module.new()
    return {}
end

function module.mock(contentId: string?)
    local tbl1 = {
        contentType = OmniRecommendationsContentType.Game,
        contentId = contentId or "149757",
        isSponsored = false
    }
    tbl1.isShowSponsoredLabel = tbl1.isSponsored
    tbl1.adId = nil
    tbl1.payerName = nil
    tbl1.logoAssetId = nil
    tbl1.logoAspectRatio = nil
    tbl1.headline = nil
    tbl1.subtitle = nil
    tbl1.ctaText = nil
    tbl1.tileVariant = nil
    tbl1.badgePosition = nil
    tbl1.badgeAnalyticsId = nil
    tbl1.badgeType = nil
    tbl1.badgeText = nil
    tbl1.badgeIcon = nil
    tbl1.badgeComponentType = nil
    tbl1.componentType = nil
    tbl1.alignmentType = nil
    tbl1.minRowPadding = nil
    tbl1.placeIdOverride = nil
    tbl1.launchDataOverride = nil
    tbl1.analyticsData = nil
    tbl1.primaryWideImageAssetId = nil
    tbl1.primaryWideImageListId = nil
    tbl1.primaryWideVideoAssetId = nil
    tbl1.sponsoredGamePreviewVideoEligible = nil
    tbl1.primaryImageAssetId = nil
    tbl1.primaryVideoAssetId = nil
    tbl1.attributionThumbnailAssetId = nil
    tbl1.clickoutUrl = nil
    if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then
        tbl1.oneByTwoTileFlowId = nil
        tbl1.recommendationsRequestId = nil
    end
    return tbl1
end

function module.fromGamesApiData(arg1)
    if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
        return Result.error("TopicContentsEntryModel.fromGamesApiData expects universeId to be a number or a string")
    end

    local module2 = module.new()
    module2.contentType = OmniRecommendationsContentType.Game
    module2.contentId = tostring(arg1.universeId)
    module2.isSponsored = arg1.isSponsored
    module2.isShowSponsoredLabel = nil

    if arg1.isShowSponsoredLabel == nil then
        module2.isShowSponsoredLabel = true
    else
        module2.isShowSponsoredLabel = arg1.isShowSponsoredLabel
    end
    module2.adId = arg1.nativeAdData

    if arg1.contentMetadata then
        local contentMetadata = arg1.contentMetadata
        module2.badgePosition = contentMetadata.badgePosition
        module2.badgeAnalyticsId = contentMetadata.badgeAnalyticsId
        module2.badgeType = contentMetadata.badgeType
        module2.badgeText = contentMetadata.badgeText
        module2.badgeIcon = contentMetadata.badgeIcon
        module2.badgeComponentType = contentMetadata.badgeComponentType
    end

    return Result.success(module2)
end

function module.fromOmniAutocompleteApi(arg1)
    if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
        return Result.error("TopicContentsEntryModel.fromOmniAutocomplete expects universeId to be a number or a string")
    end

    local module2 = module.new()
    module2.contentType = OmniRecommendationsContentType.Game
    module2.contentId = tostring(arg1.universeId)

    if arg1.contentMetadata then
        local contentMetadata = arg1.contentMetadata
        module2.badgePosition = contentMetadata.badgePosition
        module2.badgeAnalyticsId = contentMetadata.badgeAnalyticsId
        module2.badgeType = contentMetadata.badgeType
        module2.badgeText = contentMetadata.badgeText
        module2.badgeIcon = contentMetadata.badgeIcon
        module2.badgeComponentType = contentMetadata.badgeComponentType
    end

    return Result.success(module2)
end

function module.fromExploreApiData(arg1)
    if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
        return Result.error("TopicContentsEntryModel.fromExploreApiData expects universeId to be a number or a string")
    end

    local module2 = module.new()
    module2.contentType = OmniRecommendationsContentType.Game
    module2.contentId = tostring(arg1.universeId)
    module2.isSponsored = arg1.isSponsored
    module2.adId = arg1.nativeAdData
    module2.isShowSponsoredLabel = nil

    if arg1.contentMetadata then
        local contentMetadata = arg1.contentMetadata
        module2.badgePosition = contentMetadata.badgePosition
        module2.badgeAnalyticsId = contentMetadata.badgeAnalyticsId
        module2.badgeType = contentMetadata.badgeType
        module2.badgeText = contentMetadata.badgeText
        module2.badgeIcon = contentMetadata.badgeIcon
        module2.badgeComponentType = contentMetadata.badgeComponentType
    end

    return Result.success(module2)
end

if FFlagEnableTopSongsSort then
    function module.songFromExploreApiData(arg1)
        if type(arg1.assetId) ~= "number" and type(arg1.assetId) ~= "string" then
            return Result.error("TopicContentsEntryModel.songFromExploreApiData expects assetId to be a number or a string")
        end

        local module2 = module.new()
        module2.contentType = OmniRecommendationsContentType.Song
        module2.contentId = tostring(arg1.assetId)
        module2.isSponsored = false
        return Result.success(module2)
    end
end

function module.fromOmniRecommendations(arg1, recommendationsRequestId: string?)
    local module2 = module.new()
    module2.contentType = arg1.contentType
    module2.contentId = tostring(arg1.contentId)

    if arg1.contentMetadata then
        module2.adId = arg1.contentMetadata.EncryptedAdTrackingData or nil
        module2.isSponsored = not (module2.adId == nil) and module2.adId ~= ""
        module2.isShowSponsoredLabel = nil
        module2.payerName = arg1.contentMetadata.PayerName or nil

        module2.logoAssetId = arg1.contentMetadata.LogoAssetId
        module2.logoAspectRatio = arg1.contentMetadata.LogoAspectRatio
        module2.headline = arg1.contentMetadata.Headline
        module2.subtitle = arg1.contentMetadata.Subtitle
        module2.ctaText = arg1.contentMetadata.CtaText
        module2.tileVariant = arg1.contentMetadata.TileVariant
        module2.badgePosition = arg1.contentMetadata.badgePosition
        module2.badgeAnalyticsId = arg1.contentMetadata.badgeAnalyticsId
        module2.badgeType = arg1.contentMetadata.badgeType
        module2.badgeText = arg1.contentMetadata.badgeText
        module2.badgeIcon = arg1.contentMetadata.badgeIcon
        module2.badgeComponentType = arg1.contentMetadata.badgeComponentType
        module2.componentType = arg1.contentMetadata.ComponentType
        module2.alignmentType = arg1.contentMetadata.AlignmentType
        module2.minRowPadding = arg1.contentMetadata.MinRowPadding
        local var2 = if arg1.contentMetadata.PlaceIdOverride then tostring(arg1.contentMetadata.PlaceIdOverride) else nil
        module2.placeIdOverride = var2

        module2.launchDataOverride = arg1.contentMetadata.LaunchDataOverride
        module2.primaryWideImageAssetId = if arg1.contentMetadata.PrimaryWideImageAssetId and arg1.contentMetadata.PrimaryWideImageAssetId ~= "" then arg1.contentMetadata.PrimaryWideImageAssetId else nil

        module2.primaryWideImageListId = arg1.contentMetadata.PrimaryWideImageListId
        module2.primaryWideVideoAssetId = arg1.contentMetadata.PrimaryWideVideoAssetId
        if FFlagLuaAppSponsoredGamePreviewVideo then
            local sponsoredGamePreviewVideoEligible = arg1.contentMetadata.SponsoredGamePreviewVideoEligible
            module2.sponsoredGamePreviewVideoEligible = if sponsoredGamePreviewVideoEligible then parseBooleanString(sponsoredGamePreviewVideoEligible) == true else false
        end

        module2.primaryImageAssetId = if FFlagLuaAppEnableNxMRoduxApportioning then arg1.contentMetadata.PrimaryImageAssetId else nil

        module2.primaryVideoAssetId = if FFlagLuaAppEnableNxMRoduxApportioning then arg1.contentMetadata.PrimaryVideoAssetId else nil

        module2.attributionThumbnailAssetId = if FFlagLuaAppEnableNxMRoduxApportioning then arg1.contentMetadata.AttributionThumbnailAssetId else nil

        module2.clickoutUrl = if FFlagLuaAppEnableNxMRoduxApportioning then arg1.contentMetadata.ClickoutUrl else nil
    else
        module2.adId = nil
        module2.isSponsored = false
        module2.isShowSponsoredLabel = nil
        module2.payerName = nil
        module2.placeIdOverride = nil
        module2.launchDataOverride = nil
    end

    module2.analyticsData = arg1.analyticsData
    if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then
        local contentMetadata = arg1.contentMetadata
        if contentMetadata and contentMetadata.ComponentType == "OneByTwoTile" then
            local format = string.format

            local contentId = arg1.contentId
            local var2 = format("%s:%s:%s", recommendationsRequestId or "", tostring(contentId), contentMetadata.EncryptedAdTrackingData or "")

            local var3 = var1[var2]
            if var3 == nil then
                var3 = HttpService:GenerateGUID(false):lower()
                var1[var2] = var3
            end
            module2.oneByTwoTileFlowId = var3
            module2.recommendationsRequestId = recommendationsRequestId
        end
    end

    return Result.success(module2)
end

return module
