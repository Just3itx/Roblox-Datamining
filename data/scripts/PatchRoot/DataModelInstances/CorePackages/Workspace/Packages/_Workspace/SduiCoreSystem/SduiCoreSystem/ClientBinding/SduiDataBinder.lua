-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _ServiceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)
local DataHydration = require(SduiCoreSystemParent.DataHydration)
local _Signals = require(SduiCoreSystemParent.Signals)
local Display = require(SduiCoreSystemParent.Display)
local Responsive = require(SduiCoreSystemParent.Responsive)
local SduiDataBindingResponsiveFieldName = require(SduiCoreSystem.ClientBinding.SduiDataBindingFieldNames).SduiDataBindingResponsiveFieldName

local tryGetPathFromData = require(SduiCoreSystem.ClientBinding.tryGetPathFromData)
local SduiDataBindingContentType = require(SduiCoreSystem.ClientBinding.SduiDataBindingContentType)
local SduiDataBinderTransformUtils = require(SduiCoreSystem.ClientBinding.SduiDataBinderTransformUtils)
local getZendeskUrl = require(SduiCoreSystemParent.DiscoveryUtils).getZendeskUrl
local getSduiPolicyStore = require(SduiCoreSystem.ClientBinding.getSduiPolicyStore)
local resolveSduiPolicyField = require(SduiCoreSystem.ClientBinding.resolveSduiPolicyField)
local getSduiServiceDependenciesStore = require(SduiCoreSystem.ClientBinding.getSduiServiceDependenciesStore)
local getSduiClientPageScope = require(SduiCoreSystem.ClientBinding.getSduiClientPageScope)
local SduiCapabilities = require(SduiCoreSystem.ClientBinding.SduiCapabilities)
local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)

local SharedFlags = require(SduiCoreSystemParent.SharedFlags)
local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local FFlagSduiCommunitySectionSupport = SharedFlags.FFlagSduiCommunitySectionSupport
local FFlagLuaAppEdpKeepFullPageOnPortraitRotation = SharedFlags.FFlagLuaAppEdpKeepFullPageOnPortraitRotation
local FFlagSduiMarketplaceCatalogCategorySupport = SharedFlags.FFlagSduiMarketplaceCatalogCategorySupport
local FFlagSduiMarketplaceCatalogSortSupport = SharedFlags.FFlagSduiMarketplaceCatalogSortSupport
local FFlagSduiAddMarketplaceEntityDataHydration = SharedFlags.FFlagSduiAddMarketplaceEntityDataHydration
local FFlagSduiAddCollectibleItemDataHydration = SharedFlags.FFlagSduiAddCollectibleItemDataHydration
local FFlagSduiLeaderboardComponent = SharedFlags.FFlagSduiLeaderboardComponent
local FFlagSduiDevStoreSeeAllSupport = SharedFlags.FFlagSduiDevStoreSeeAllSupport
local FFlagSduiCapabilityBindings = SharedFlags.FFlagSduiCapabilityBindings
local FFlagSduiSupportRatingNoPercent = SharedFlags.FFlagSduiSupportRatingNoPercent
local FFlagSduiNotificationBadgeHydration = SharedFlags.FFlagSduiNotificationBadgeHydration

local FFlagSduiAddMarketplaceItemFavoriteHydration = require(SduiCoreSystem.FFlagSduiAddMarketplaceItemFavoriteHydration)
local FFlagSduiBuyRobuxHydration = SharedFlags.FFlagSduiBuyRobuxHydration

local DataStatus = DataHydration.DataHydrationTypes.DataStatus

local protobufTimestampToLocalTimeString = SduiDataBinderTransformUtils.protobufTimestampToLocalTimeString

local function updateBadgesInfoStore(badge) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Badges.getBadgeInfoStore(false).updateBadges(badge)
end

local function updateCreatorInfoStore(creator) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Creator.getCreatorInfoStore(false).updateCreatorInfos(creator)
end

local function updateGameInfos(universe) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Game.getGameInfoStore(false).updateGameInfos(universe, false)
end

local function updateAgeRecommendations(ageRecommendation) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Game.getAgeRecommendationStore(false).updateAgeRecommendations(ageRecommendation)
end

local function updateSocialLinkInfos(socialLink) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.SocialLink.getSocialLinkInfoStore(false).updateSocialLinkInfos(socialLink)
end

local function updateMediaAssetStore(mediaAsset) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.MediaAsset.getMediaAssetStore(false).updateMediaAssets(mediaAsset)
end

local function updateExperienceEventInfoStore(event) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.ExperienceEvents.getExperienceEventInfoStore(false).updateExperienceEventInfos(event)
end

local function updateMarketplaceCatalogCategoryStore(marketplaceCatalogCategory) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.MarketplaceCatalogCategory.getMarketplaceCatalogCategoryStore(false).updateMarketplaceCatalogCategories(
        marketplaceCatalogCategory
    )
end

local function updateMarketplaceCatalogSortStore(catalogSort) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.MarketplaceCatalogSort.getMarketplaceCatalogSortStore(false).updateMarketplaceCatalogSorts(catalogSort)
end

local function updateMarketplaceAssetInfoStore(marketplaceAsset) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.MarketplaceAsset.getMarketplaceAssetStore(false).updateMarketplaceAssetInfos(marketplaceAsset)
end

local function updateMarketplaceBundleInfoStore(marketplaceBundle) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.MarketplaceBundle.getMarketplaceBundleStore(false).updateMarketplaceBundleInfos(marketplaceBundle)
end

local function updateMarketplaceLookInfoStore(marketplaceLook) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.MarketplaceLook.getMarketplaceLookStore(false).updateMarketplaceLookInfos(marketplaceLook)
end

local function updateMarketplaceAssetFavoriteStore(marketplaceAssetUserFavorite) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.MarketplaceItemFavorite.getMarketplaceAssetFavoriteStore(false).updateItems(marketplaceAssetUserFavorite)
end

local function updateMarketplaceBundleFavoriteStore(marketplaceBundleUserFavorite) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.MarketplaceItemFavorite.getMarketplaceBundleFavoriteStore(false).updateItems(
        marketplaceBundleUserFavorite
    )
end

local function updateCollectibleItemInfoStore(collectibleItem) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.CollectibleItem.getCollectibleItemStore(false).updateCollectibleItemInfos(collectibleItem)
end

local function updateLeaderboardStatsStore(leaderboardStats) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.LeaderboardStats.getLeaderboardStatsStore(false).updateLeaderboardStatsBatch(leaderboardStats)
end

local function updateGamePassStore(gamePass) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Game.getGamePassStore(false).updateGamePassInfos(gamePass)
end

local function updatePlayabilityStore(playability) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Game.getPlayabilityStore(false).updatePlayabilities(playability)
end

local function updateGameDeveloperProductStore(gameDeveloperProduct) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Game.getGameDeveloperProductStore(false).updateGameDeveloperProductInfos(gameDeveloperProduct)
end

local function updateGameSubscriptionStore(gameSubscription) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Game.getGameSubscriptionStore(false).updateGameSubscriptionInfos(gameSubscription)
end

local function updateNotificationBadgeStore(notificationBadge) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.NotificationBadge.getNotificationBadgeStore(false).updateNotificationBadges(notificationBadge)
end

local function updateBuyRobuxStores(tbl1)
    local buyRobux = DataHydration.BuyRobux
    if tbl1.buyRobuxOneTimeProduct then
        buyRobux.getOneTimeProductStore(false).updateInfos(tbl1.buyRobuxOneTimeProduct)
    end
    if tbl1.buyRobuxSubscriptionProduct then
        buyRobux.getSubscriptionProductStore(false).updateInfos(tbl1.buyRobuxSubscriptionProduct)
    end
    if tbl1.buyRobuxPendingTransfer then
        buyRobux.getPendingTransferStore(false).updateInfos(tbl1.buyRobuxPendingTransfer)
    end
    if tbl1.buyRobuxBonusItem then
        buyRobux.getBonusItemStore(false).updateInfos(tbl1.buyRobuxBonusItem)
    end
end

local function updateFavoritesStore(universeUserFavorite) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Game.getFavoritesStore(false).updateItems(universeUserFavorite)
end

local function updateUserVoteStore(universeUserVote) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Game.getVotesStore(false).updateUserVoteItems(universeUserVote)
end

local function updateVoteCountsFromUniverses(universe)
    local tbl1 = ({})
    local bool1 = false

    for value, value2 in universe do
        local upVotes = tonumber(value2.totalUpVotes)
        local downVotes = tonumber(value2.totalDownVotes)

        if not (upVotes and downVotes) then
            continue
        end

        tbl1[value] = { upVotes = upVotes, downVotes = downVotes }
        bool1 = true
    end

    if bool1 then
        DataHydration.Game.getVotesStore(false).updateVoteItems(tbl1)
    end
end

local function updateCommunityInfoStore(community) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.Community.getCommunityInfoStore(false).updateCommunityInfos(community)
end

local function updateCommunityUserMembershipStore(communityUserMembership) -- Luacid: Inlined by compiler; 1 call site recovered
    DataHydration.CommunityUserMembership.getCommunityUserMembershipStore(false).updateMemberships(communityUserMembership)
end

local function calculateBadgeDerivedField(str1: string, arg1, _)
    if str1 == "created_time_formatted" then
        local var1 = arg1 and (arg1.created_time or arg1.createdTime)
        return var1 and protobufTimestampToLocalTimeString(var1)
    elseif str1 == "updated_time_formatted" then
        local var1 = arg1 and (arg1.updated_time or arg1.updatedTime)
        return var1 and protobufTimestampToLocalTimeString(var1)
    end

    if str1 ~= "awarded_time_formatted" then
        return nil
    end

    local var1 = arg1 and (arg1.awarded_time or arg1.awardedTime)
    return var1 and protobufTimestampToLocalTimeString(var1)
end

local function calculateUniverseDerivedField(str1: string, arg1, _)
    if str1 == "rating_text_formatted_brief" then
        local upVotes = tonumber(arg1.totalUpVotes) or 0
        local downVotes = tonumber(arg1.totalDownVotes) or 0
        local tbl1 = {
            upVotes = upVotes,
            downVotes = downVotes,
            rating = DataHydration.Game.VotesUtils.calculateRating(upVotes, downVotes)
        }
        return DataHydration.Game.VotesUtils.getRatingDisplayText(tbl1)
    end

    if not FFlagSduiSupportRatingNoPercent or str1 ~= "rating_text_no_percent" then
        if str1 ~= "refund_policy_learn_more_url" then
            return nil
        end

        local robloxLocaleId = LocalizationService.RobloxLocaleId
        return getZendeskUrl(nil, robloxLocaleId, arg1 and arg1.refund_article_id)
    end

    local upVotes = tonumber(arg1.totalUpVotes) or 0
    local downVotes = tonumber(arg1.totalDownVotes) or 0
    local tbl1 = {
        upVotes = upVotes,
        downVotes = downVotes,
        rating = DataHydration.Game.VotesUtils.calculateRating(upVotes, downVotes)
    }
    return DataHydration.Game.VotesUtils.getRatingDisplayText(tbl1, true)
end

local function calculateAgeRecommendationDerivedField(str1: string, arg1, _)
    if str1 == "content_rating_image" then
        local igrsRating = arg1 and arg1.igrsRating
        return igrsRating and DataHydration.Game.AgeRecommendationUtils.getIgrsImage(igrsRating)
    elseif str1 == "filtered_descriptors" then
        local ageRecommendationDerivedField = {}
        if arg1 and arg1.descriptors then
            for _, descriptor in arg1.descriptors do
                if descriptor.contains == true and descriptor.displayName and descriptor.displayName ~= "" then
                    table.insert(ageRecommendationDerivedField, { displayName = descriptor.displayName })
                end
            end
        end
        return ageRecommendationDerivedField
    else
        if str1 ~= "contains_strong_language" then
            return nil
        end

        if arg1 and arg1.descriptors then
            for _, descriptor in arg1.descriptors do
                if descriptor.contains == true and descriptor.name == "strong-language" then
                    return true
                end
            end
        end
        return false
    end
end

local function getDataObjectSignal(arg1, _, str1: string, bool1: boolean?)
    if arg1 == "badge" then
        return DataHydration.Badges.getBadgeInfoStore(false).getBadgeInfo(tostring(str1))
    elseif arg1 == "creator" then
        return DataHydration.Creator.getCreatorInfoStore(false).getCreatorInfo(str1)
    elseif arg1 == "universe" then
        if bool1 then
            return DataHydration.Game.getGameInfoStore(false).getAndFetchGameInfo(str1)
        end
        return DataHydration.Game.getGameInfoStore(false).getGameInfo(str1)
    elseif arg1 == "ageRecommendation" then
        if bool1 then
            return DataHydration.Game.getAgeRecommendationStore(false).getAndFetchAgeRecommendation(str1)
        end
        return DataHydration.Game.getAgeRecommendationStore(false).getAgeRecommendation(str1)
    elseif arg1 == "socialLink" then
        return DataHydration.SocialLink.getSocialLinkInfoStore(false).getSocialLinkInfo(str1)
    elseif arg1 == "mediaAsset" then
        return DataHydration.MediaAsset.getMediaAssetStore(false).getMediaAsset(str1)
    elseif arg1 == "playability" then
        if bool1 then
            return DataHydration.Game.getPlayabilityStore(false).getAndFetchPlayability(tostring(str1))
        end
        return DataHydration.Game.getPlayabilityStore(false).getPlayability(tostring(str1))
    elseif arg1 == SduiDataBindingContentType.universeUserVote then
        return DataHydration.Game.getVotesStore(false).getUserVote(str1)
    elseif arg1 == SduiDataBindingContentType.universeUserFavorite then
        if bool1 then
            return DataHydration.Game.getFavoritesStore(false).getAndFetchFavorite(str1)
        end
        return DataHydration.Game.getFavoritesStore(false).getFavorite(str1)
    elseif arg1 == SduiDataBindingContentType.universeUserFollow then
        if bool1 then
            return DataHydration.Game.getFollowingsStore(false).getAndFetchFollowing(str1)
        end
        return DataHydration.Game.getFollowingsStore(false).getFollowing(str1)
    elseif arg1 == SduiDataBindingContentType.universeUserVoteFeedbackMetadata then
        if bool1 then
            return DataHydration.Game.getUserVoteFeedbackMetadataStore(false).getAndFetchUserVoteFeedbackMetadata(tostring(str1))
        end
        return DataHydration.Game.getUserVoteFeedbackMetadataStore(false).getUserVoteFeedbackMetadata(tostring(str1))
    else
        if FFlagSduiCommunitySectionSupport then
            if arg1 == SduiDataBindingContentType.community then
                return DataHydration.Community.getCommunityInfoStore(false).getCommunityInfo(str1)
            end
            if arg1 == SduiDataBindingContentType.communityUserMembership then
                return DataHydration.CommunityUserMembership.getCommunityUserMembershipStore(false).getMembership(str1)
            end
        end
        if arg1 == "gamePass" then
            return DataHydration.Game.getGamePassStore(false).getGamePassInfo(tostring(str1))
        elseif arg1 == "event" then
            return DataHydration.ExperienceEvents.getExperienceEventInfoStore(false).getExperienceEventInfo(str1)
        end
        if FFlagSduiMarketplaceCatalogCategorySupport and arg1 == "marketplaceCatalogCategory" then
            return DataHydration.MarketplaceCatalogCategory.getMarketplaceCatalogCategoryStore(false).getMarketplaceCatalogCategory(str1)
        end
        if FFlagSduiMarketplaceCatalogSortSupport and arg1 == "marketplaceCatalogSort" then
            return DataHydration.MarketplaceCatalogSort.getMarketplaceCatalogSortStore(false).getMarketplaceCatalogSort(str1)
        end
        if arg1 == "song" then
            return DataHydration.Song.getSongInfoStore(false).getSongInfo(tostring(str1))
        end
        if FFlagSduiAddMarketplaceEntityDataHydration then
            if arg1 == "marketplaceAsset" then
                return DataHydration.MarketplaceAsset.getMarketplaceAssetStore(false).getMarketplaceAssetInfo(str1)
            elseif arg1 == "marketplaceBundle" then
                return DataHydration.MarketplaceBundle.getMarketplaceBundleStore(false).getMarketplaceBundleInfo(str1)
            elseif arg1 == "marketplaceLook" then
                return DataHydration.MarketplaceLook.getMarketplaceLookStore(false).getMarketplaceLookInfo(str1)
            end
        end
        if FFlagSduiAddMarketplaceItemFavoriteHydration then
            if arg1 == SduiDataBindingContentType.marketplaceAssetUserFavorite then
                local marketplaceAssetFavoriteStore = DataHydration.MarketplaceItemFavorite.getMarketplaceAssetFavoriteStore(false)
                if bool1 then
                    return (marketplaceAssetFavoriteStore.getAndFetchFavorite(tostring(str1)))
                end

                return (marketplaceAssetFavoriteStore.getFavorite(tostring(str1)))
            end
            if arg1 == SduiDataBindingContentType.marketplaceBundleUserFavorite then
                local marketplaceBundleFavoriteStore = DataHydration.MarketplaceItemFavorite.getMarketplaceBundleFavoriteStore(false)
                if bool1 then
                    return (marketplaceBundleFavoriteStore.getAndFetchFavorite(tostring(str1)))
                end

                return (marketplaceBundleFavoriteStore.getFavorite(tostring(str1)))
            end
        end
        if FFlagSduiAddCollectibleItemDataHydration and arg1 == "collectibleItem" then
            return DataHydration.CollectibleItem.getCollectibleItemStore(false).getCollectibleItemInfo(str1)
        end
        if FFlagSduiLeaderboardComponent and arg1 == "leaderboardStats" then
            return DataHydration.LeaderboardStats.getLeaderboardStatsStore(false).getLeaderboardStats(tostring(str1))
        end
        if FFlagSduiDevStoreSeeAllSupport then
            if arg1 == "gameDeveloperProduct" then
                return DataHydration.Game.getGameDeveloperProductStore(false).getGameDeveloperProductInfo(tostring(str1))
            elseif arg1 == "gameSubscription" then
                return DataHydration.Game.getGameSubscriptionStore(false).getGameSubscriptionInfo(tostring(str1))
            end
        end
        if FFlagSduiNotificationBadgeHydration and arg1 == "notificationBadge" then
            return DataHydration.NotificationBadge.getNotificationBadgeStore(false).getNotificationBadge(tostring(str1))
        end
        if FFlagSduiBuyRobuxHydration then
            if arg1 == "buyRobuxOneTimeProduct" then
                return DataHydration.BuyRobux.getOneTimeProductStore(false).getInfo(tostring(str1))
            elseif arg1 == "buyRobuxSubscriptionProduct" then
                return DataHydration.BuyRobux.getSubscriptionProductStore(false).getInfo(tostring(str1))
            elseif arg1 == "buyRobuxPendingTransfer" then
                return DataHydration.BuyRobux.getPendingTransferStore(false).getInfo(tostring(str1))
            elseif arg1 == "buyRobuxBonusItem" then
                return DataHydration.BuyRobux.getBonusItemStore(false).getInfo(tostring(str1))
            end
        end
        return nil
    end
end
local tbl1 = {
    responsive = true,
    policy = true,
    clientPageScope = true,
    capability = if FFlagSduiCapabilityBindings then true else nil
}

local function isClientContentType(arg1)
    return tbl1[arg1] or false
end

local function getFieldValueForClientContentType(arg1, tbl2, arg2, arg3)
    if arg1 == SduiDataBindingContentType.clientPageScope then
        local configKey = if arg3 then arg3.configKey else nil

        if not configKey or #tbl2 < 2 then
            return nil
        end
        local var1 = tbl2[2]
        return getSduiClientPageScope(configKey).getSignal(var1)(arg2), nil
    end

    if arg1 == SduiDataBindingContentType.responsive then
        if #tbl2 ~= 2 then
            return nil
        end
        local var1 = tbl2[2]
        if var1 == SduiDataBindingResponsiveFieldName.screenWidth then
            return Display.GetDisplayStore(arg2).getViewportSize(arg2).X
        end

        if var1 == SduiDataBindingResponsiveFieldName.screenHeight then
            return Display.GetDisplayStore(arg2).getViewportSize(arg2).Y
        end

        if var1 == SduiDataBindingResponsiveFieldName.isPortrait then
            local var2 = Display.GetDisplayStore(arg2).getViewportSize(arg2)
            return var2.X < var2.Y
        end

        if var1 == SduiDataBindingResponsiveFieldName.isSpatial then
            return Display.GetDisplayStore(arg2).getIsSpatial(arg2)
        end

        if var1 == SduiDataBindingResponsiveFieldName.lastInput then
            return Responsive.GetInputModeStore(arg2).getLastInputType(arg2)
        end

        if var1 == SduiDataBindingResponsiveFieldName.preferredInput then
            return Responsive.GetInputModeStore(arg2).getPreferredInputType(arg2)
        end

        if var1 == SduiDataBindingResponsiveFieldName.isCompactTouch then
            if FFlagLuaAppEdpKeepFullPageOnPortraitRotation then
                local var2 = Display.GetDisplayStore(arg2).getViewportSize(arg2)
                local var3 = Responsive.GetInputModeStore(arg2).getPreferredInputType(arg2)
                return Responsive.getIsCompactTouch(var2, var3)
            end
            local var2 = Display.GetDisplayStore(arg2).getViewportSize(arg2)
            local var3 = Responsive.GetInputModeStore(arg2).getPreferredInputType(arg2)
            local maxWidth = Responsive.BreakpointConfig.sizes[Responsive.Keys.Small].maxWidth
            local bool1 = var2.X < var2.Y
            return var2.X <= maxWidth and bool1 and var3 == Responsive.Input.Touch
        end

        if FFlagLuaAppMediaGalleryGamepadSupport and var1 == SduiDataBindingResponsiveFieldName.isDirectional then
            return Responsive.GetInputModeStore(arg2).getLastInputType(arg2) == Responsive.Input.Directional
        end
    end

    if FFlagSduiCapabilityBindings and arg1 == SduiDataBindingContentType.capability then
        if #tbl2 < 2 then
            return nil
        end

        return SduiCapabilities.isEnabled(tbl2[2])
    end

    if arg1 == SduiDataBindingContentType.policy then
        if #tbl2 < 2 then
            return nil
        end
        local var1 = getSduiPolicyStore().getAppPolicy(arg2)
        if var1 == nil then
            local str1 = table.concat(tbl2, ".")
            error(`Failed to find policy table when binding value {str1}`)
        end

        local var2 = tbl2[2]
        local var3, var4 = resolveSduiPolicyField(var1, var2)
        if var3 then
            return var4
        end

        local rawPolicy = var1.getRawPolicy()
        if rawPolicy then
            local var5, var6 = tryGetPathFromData(rawPolicy, tbl2, 2)
            if var5 then
                return var6
            end
            local str1 = table.concat(tbl2, ".")
            error(`Failed to find policy value for '{str1}'`)
        else
            local str1 = table.concat(tbl2, ".")
            error(`Failed to find rawPolicy table when binding value {str1}`)
        end
    end

    return nil
end

local function calculateDerivedFieldValue(universeUserVoteFeedbackMetadata, str1: string, arg1, arg2)
    if universeUserVoteFeedbackMetadata == "badge" then
        return (calculateBadgeDerivedField(str1, arg1, arg2))
    elseif universeUserVoteFeedbackMetadata == "universe" then
        return calculateUniverseDerivedField(str1, arg1, arg2)
    elseif universeUserVoteFeedbackMetadata == "ageRecommendation" then
        return (calculateAgeRecommendationDerivedField(str1, arg1, arg2))
    end
    if universeUserVoteFeedbackMetadata == SduiDataBindingContentType.universeUserVoteFeedbackMetadata then
        return DataHydration.Game.getUserVoteFeedbackMetadataStore(false).calculateDerivedField(str1, arg1, arg2)
    end
    if universeUserVoteFeedbackMetadata ~= "event" then
        return nil
    end

    local experienceEventInfoStore = DataHydration.ExperienceEvents.getExperienceEventInfoStore(false)
    local localization = getSduiServiceDependenciesStore().getDependencies("SduiDataBinder").localization
    return experienceEventInfoStore.calculateDerivedField(str1, arg1, arg2, localization)
end

local function getUniverseIcon(str1: string, arg1, arg2)
    local var1 = DataHydration.Game.getGameIconStore(false).getAndFetchGameIcon(tostring(str1), arg2)
    local var2 = var1.data(arg1)
    local var3 = var1.status(arg1)
    if var2 and var2.url then
        return var2.url, var3
    end
    return nil, var3
end

local function getUniverseVoteRatingText(str1: string, arg1, bool1: boolean?)
    local var1 = DataHydration.Game.getVotesStore(false).getVote(str1)
    local var2 = var1.data(arg1)
    local var3 = var1.status(arg1)
    local upVotes = if var2 then var2.upVotes else 0
    local downVotes = if var2 then var2.downVotes else 0

    return DataHydration.Game.VotesUtils.getRatingDisplayText(
        {
            upVotes = upVotes,
            downVotes = downVotes,
            rating = DataHydration.Game.VotesUtils.calculateRating(upVotes, downVotes)
        },
        bool1
    ), var3
end

local function resolveFieldFromData(universeUserVoteFeedbackMetadata, tbl2, arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return false, nil
    end

    local var1, var2 = tryGetPathFromData(arg1, tbl2, 2)
    if var1 then
        return true, var2
    end

    if #tbl2 ~= 2 then
        return false, nil
    end

    local derivedFieldValue = calculateDerivedFieldValue(universeUserVoteFeedbackMetadata, tbl2[2], arg1, arg2)
    return derivedFieldValue ~= nil, derivedFieldValue
end

local function getDataHydrationField(universeUserVoteFeedbackMetadata, tbl2, str1: string, arg1, bool1: boolean?)
    if #tbl2 < 2 then
        return nil, nil
    end

    local dataObjectSignal = getDataObjectSignal(universeUserVoteFeedbackMetadata, tbl2, str1, bool1)
    if not dataObjectSignal then
        local str2 = table.concat(tbl2, ".")
        error(`No available data object for {universeUserVoteFeedbackMetadata} {str2} for id: {str1}`)
    end

    local var1 = dataObjectSignal.data(arg1)
    local var2 = dataObjectSignal.status(arg1)
    if not var1 then
        return nil, var2
    end

    local var3, var4 = tryGetPathFromData(var1, tbl2, 2)
    if var3 then
        return var4, var2
    end

    if #tbl2 ~= 2 then
        return nil, var2
    end

    local var5 = tbl2[2]
    return calculateDerivedFieldValue(universeUserVoteFeedbackMetadata, var5, var1, arg1), var2
end

local tbl2 = {
    badge = getDataHydrationField,
    creator = getDataHydrationField,
    universe = function(universeUserVoteFeedbackMetadata, tbl2, str1: string, arg1, bool1: boolean?) -- name: resolveUniverseField
        if #tbl2 == 2 then
            if tbl2[2] == "icon" then
                return getUniverseIcon(str1, arg1)
            elseif tbl2[2] == "largeIcon" then
                return getUniverseIcon(str1, arg1, DataHydration.Game.GameIconSize.Large)
            elseif tbl2[2] == "rating_text_formatted_brief" then
                return getUniverseVoteRatingText(str1, arg1)
            end
            if FFlagSduiSupportRatingNoPercent and tbl2[2] == "rating_text_no_percent" then
                return getUniverseVoteRatingText(str1, arg1, true)
            end
        end

        if not bool1 then
            return getDataHydrationField(universeUserVoteFeedbackMetadata, tbl2, str1, arg1, bool1)
        end

        local gameInfoStore = DataHydration.Game.getGameInfoStore(false)
        local var1, var2 = gameInfoStore.getGameInfo(str1)
        local var3 = var1.data(arg1)
        local var4 = var1.status(arg1)
        local bool2, var5 = resolveFieldFromData(universeUserVoteFeedbackMetadata, tbl2, var3, arg1)

        if bool2 then
            return var5, var4
        end

        if not var2 then
            return nil, var4
        end

        gameInfoStore.getAndFetchGameInfo(str1)
        return nil, DataStatus.NotReady
    end,
    ageRecommendation = getDataHydrationField,
    mediaAsset = getDataHydrationField,
    socialLink = getDataHydrationField,
    event = getDataHydrationField,
    marketplaceCatalogCategory = if FFlagSduiMarketplaceCatalogCategorySupport then getDataHydrationField else nil,
    marketplaceCatalogSort = if FFlagSduiMarketplaceCatalogSortSupport then getDataHydrationField else nil,
    marketplaceAsset = if FFlagSduiAddMarketplaceEntityDataHydration then getDataHydrationField else nil,
    marketplaceBundle = if FFlagSduiAddMarketplaceEntityDataHydration then getDataHydrationField else nil,
    marketplaceLook = if FFlagSduiAddMarketplaceEntityDataHydration then getDataHydrationField else nil,
    marketplaceAssetUserFavorite = if FFlagSduiAddMarketplaceItemFavoriteHydration then getDataHydrationField else nil,
    marketplaceBundleUserFavorite = if FFlagSduiAddMarketplaceItemFavoriteHydration then getDataHydrationField else nil,
    collectibleItem = if FFlagSduiAddCollectibleItemDataHydration then getDataHydrationField else nil,
    leaderboardStats = if FFlagSduiLeaderboardComponent then getDataHydrationField else nil,
    song = getDataHydrationField,
    gamePass = getDataHydrationField,
    gameDeveloperProduct = if FFlagSduiDevStoreSeeAllSupport then getDataHydrationField else nil,
    gameSubscription = if FFlagSduiDevStoreSeeAllSupport then getDataHydrationField else nil,
    playability = getDataHydrationField,
    universeUserVote = getDataHydrationField,
    universeUserFavorite = getDataHydrationField,
    universeUserFollow = getDataHydrationField,
    universeUserVoteFeedbackMetadata = getDataHydrationField,
    userProfile = DataHydration.UserProfile and DataHydration.UserProfile.resolveField,
    community = if FFlagSduiCommunitySectionSupport then getDataHydrationField else nil,
    communityUserMembership = if FFlagSduiCommunitySectionSupport then getDataHydrationField else nil,
    notificationBadge = if FFlagSduiNotificationBadgeHydration then getDataHydrationField else nil,
    buyRobuxOneTimeProduct = if FFlagSduiBuyRobuxHydration then getDataHydrationField else nil,
    buyRobuxSubscriptionProduct = if FFlagSduiBuyRobuxHydration then getDataHydrationField else nil,
    buyRobuxPendingTransfer = if FFlagSduiBuyRobuxHydration then getDataHydrationField else nil,
    buyRobuxBonusItem = if FFlagSduiBuyRobuxHydration then getDataHydrationField else nil
}

return {
    updateDataStores = function(tbl3)
        if tbl3.badge then
            updateBadgesInfoStore(tbl3.badge)
        end
        if tbl3.creator then
            updateCreatorInfoStore(tbl3.creator)
        end
        if tbl3.universe then
            updateGameInfos(tbl3.universe)
            updateVoteCountsFromUniverses(tbl3.universe)
        end
        if tbl3.ageRecommendation then
            updateAgeRecommendations(tbl3.ageRecommendation)
        end
        if tbl3.socialLink then
            updateSocialLinkInfos(tbl3.socialLink)
        end
        if tbl3.mediaAsset then
            updateMediaAssetStore(tbl3.mediaAsset)
        end
        if tbl3.playability then
            updatePlayabilityStore(tbl3.playability)
        end
        if tbl3.universeUserFavorite then
            updateFavoritesStore(tbl3.universeUserFavorite)
        end
        if tbl3.universeUserVote then
            updateUserVoteStore(tbl3.universeUserVote)
        end
        if tbl3.userProfile then
            DataHydration.UserProfile.updateFromHydration(tbl3.userProfile)
        end
        if FFlagSduiCommunitySectionSupport then
            if tbl3.community then
                updateCommunityInfoStore(tbl3.community)
            end
            if tbl3.communityUserMembership then
                updateCommunityUserMembershipStore(tbl3.communityUserMembership)
            end
        end
        if tbl3.gamePass then
            updateGamePassStore(tbl3.gamePass)
        end
        if tbl3.event then
            updateExperienceEventInfoStore(tbl3.event)
        end
        if FFlagSduiMarketplaceCatalogCategorySupport and tbl3.marketplaceCatalogCategory then
            updateMarketplaceCatalogCategoryStore(tbl3.marketplaceCatalogCategory)
        end
        if FFlagSduiMarketplaceCatalogSortSupport and tbl3.catalogSort then
            updateMarketplaceCatalogSortStore(tbl3.catalogSort)
        end
        if tbl3.song then
            DataHydration.Song.getSongInfoStore(false).updateSongs(tbl3.song)
        end
        if FFlagSduiAddMarketplaceEntityDataHydration then
            if tbl3.marketplaceAsset then
                updateMarketplaceAssetInfoStore(tbl3.marketplaceAsset)
            end
            if tbl3.marketplaceBundle then
                updateMarketplaceBundleInfoStore(tbl3.marketplaceBundle)
            end
            if tbl3.marketplaceLook then
                updateMarketplaceLookInfoStore(tbl3.marketplaceLook)
            end
        end
        if FFlagSduiAddMarketplaceItemFavoriteHydration then
            if tbl3.marketplaceAssetUserFavorite then
                updateMarketplaceAssetFavoriteStore(tbl3.marketplaceAssetUserFavorite)
            end
            if tbl3.marketplaceBundleUserFavorite then
                updateMarketplaceBundleFavoriteStore(tbl3.marketplaceBundleUserFavorite)
            end
        end
        if FFlagSduiAddCollectibleItemDataHydration and tbl3.collectibleItem then
            updateCollectibleItemInfoStore(tbl3.collectibleItem)
        end
        if FFlagSduiLeaderboardComponent and tbl3.leaderboardStats then
            updateLeaderboardStatsStore(tbl3.leaderboardStats)
        end
        if FFlagSduiDevStoreSeeAllSupport then
            if tbl3.gameDeveloperProduct then
                updateGameDeveloperProductStore(tbl3.gameDeveloperProduct)
            end
            if tbl3.gameSubscription then
                updateGameSubscriptionStore(tbl3.gameSubscription)
            end
        end
        if FFlagSduiNotificationBadgeHydration and tbl3.notificationBadge then
            updateNotificationBadgeStore(tbl3.notificationBadge)
        end
        if FFlagSduiBuyRobuxHydration then
            updateBuyRobuxStores(tbl3)
        end
    end,
    getDataObjectSignal = getDataObjectSignal,
    getFieldValue = function(arg1, tbl3, str1: string, arg2, bool1: boolean?)
        if #tbl3 < 2 then
            return nil, nil
        end

        local var1 = tbl2[arg1]
        if var1 == nil then
            return nil, nil
        end
        return var1(arg1, tbl3, str1, arg2, bool1)
    end,
    calculateBadgeDerivedField = calculateBadgeDerivedField,
    calculateUniverseDerivedField = calculateUniverseDerivedField,
    isClientContentType = isClientContentType,
    getFieldValueForClientContentType = getFieldValueForClientContentType,
    calculateAgeRecommendationDerivedField = calculateAgeRecommendationDerivedField
}
