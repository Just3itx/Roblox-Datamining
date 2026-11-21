-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollections = script:FindFirstAncestor("GameCollections")
local GameCollectionsParent = GameCollections.Parent

local React = require(GameCollectionsParent.React)

local Responsive = require(GameCollectionsParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller
local GameTile = require(GameCollectionsParent.GameTile)
local GameTileConstants = GameTile.GameTileConstants
local GameTileLayoutType = GameTile.GameTileTypes.GameTileLayoutType
local AppGameTile = GameTile.AppGameTile
local getTileBadgeByPositionConfigFromEntry = GameTile.getTileBadgeByPositionConfigFromEntry
local useTriggerGameTileFeedbackCallbacks = require(GameCollections.useTriggerGameTileFeedbackCallbacks)
local useTriggerFeedback = require(GameCollectionsParent.InteractionFeedback).useTriggerFeedback
local SeeAllTile = require(GameCollections.SeeAllTile)
local useNavigateToGameDetails = require(GameCollectionsParent.GameTile).useNavigateToGameDetails
local GameCollectionItemTypes = require(GameCollectionsParent.DiscoveryTypes).GameCollectionItemTypes
local _HoldToPlay = require(GameCollectionsParent.HoldToPlay)
local _VideoUtils = require(GameCollectionsParent.VideoUtils)

local FFlagLuaAppContinueSortInstantPlay = require(GameCollectionsParent.SharedFlags).FFlagLuaAppContinueSortInstantPlay
local FFlagLuaAppEnableReportExperience = require(GameCollectionsParent.SharedFlags).FFlagLuaAppEnableReportExperience
local FFlagLuaAppNarrowTileHideRating = require(GameCollectionsParent.SharedFlags).FFlagLuaAppNarrowTileHideRating
local FFlagLuaAppNarrowTileHidePlayerCount = require(GameCollectionsParent.SharedFlags).FFlagLuaAppNarrowTileHidePlayerCount
local FFlagLuaAppEnableNxMRoduxApportioning = require(GameCollectionsParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning

local FFlagLuaAppUsePrevalidatedVideoGamePlayability = require(GameCollectionsParent.SharedFlags).FFlagLuaAppUsePrevalidatedVideoGamePlayability
local FFlagLuaAppEmphasisGameTileVideo = require(GameCollectionsParent.SharedFlags).FFlagLuaAppEmphasisGameTileVideo

local FFlagLuaAppSduiGameTileInteractionFeedback = require(GameCollectionsParent.SharedFlags).FFlagLuaAppSduiGameTileInteractionFeedback

local GameCollectionItemType = GameCollectionItemTypes.GameCollectionItemType

local function useRenderGameCollectionItem(playerCountStyle, isSponsoredFooterAllowed: boolean?, gameTileLayoutType, friendFooterEnabled: boolean?, showFriendActivity: boolean?, impressionsTag: string, bool1: boolean?, reportGameDetailOpened: (...any) -> (...any), reportExperienceLaunched: (...any) -> (...any), launchExperienceEventContext: string?, referralSource: string?, source: string?, onActivated: ((...any) -> (...any))?, topicId: string?, num1: number?, hideGameStats: boolean?, playButtonStyle: string?, isContained: boolean?, hideTitle: boolean?, hideMetadata: boolean?, onSelectionGained, onSelectionLost, arg1, textSizeOffset: number?, contentTextLineCount: number?, useExperienceTileMetadata: boolean?, forceHideAgeRatings: boolean?, videoAnalytics, onPeekViewClosed: ((...any) -> (...any))?, num2: number?, enableExplicitFeedback: boolean?, tbl1, setGameHidden: ((...any) -> (...any))?, appPage: string?, sponsoredUserCohort: string?, enableSponsoredFeedback: boolean?, enableReportAd: boolean?, enableReportExperience: boolean?, maxItemIndex: number?, isSponsoredRatingFooterAllowed: boolean?, _: string?, _: boolean?, _: boolean?, compactMetadataFormat: boolean?, hideRating: boolean?, hidePlayerCount: boolean?, videoPlaybackContext, hasPrevalidatedVideoGamePlayability: boolean?, enableInstantPlay: boolean?, instantPlayTreatment: string?)
    local var1 = usePreferredInput()
    local navigateToGameDetails = useNavigateToGameDetails()
    local var3 = if FFlagLuaAppSduiGameTileInteractionFeedback then useTriggerFeedback() else nil
    local var4 = useTriggerGameTileFeedbackCallbacks

    if not FFlagLuaAppSduiGameTileInteractionFeedback then
        var3 = nil
    end

    local var5, var6 = var4(var3)
    local onGuiStateChanged = var5
    local var2 = var6

    local var9 = bool1 and var1 == Responsive.Input.Pointer
    local bool2 = if FFlagLuaAppContinueSortInstantPlay then var1 == Responsive.Input.Touch else nil
    local useGridTile = gameTileLayoutType == "Wide" or gameTileLayoutType == "Event"

    local var10 = useBreakpointXOrSmaller(Responsive.Keys.Small)
    local isNarrowScreenXSmall = useBreakpointXOrSmaller(Responsive.Keys.XSmall)
    local var12 = FFlagLuaAppNarrowTileHideRating and hideRating or FFlagLuaAppNarrowTileHidePlayerCount and hidePlayerCount
    if var10 then
        if textSizeOffset > 0 then
            var10 = not var12
        else
            var10 = false
        end
    end

    local metadataTextLineCount = if var10 then GameTileConstants.TileTextLines[gameTileLayoutType or GameTileLayoutType.Narrow].largeMetadataTextLines else GameTileConstants.TileTextLines[gameTileLayoutType or GameTileLayoutType.Narrow].metadataTextLines
    local useCallback = React.useCallback
    local function func1(entry, num3: number, arg4, rowNum: number?)
        if num1 and num3 == num1 and onActivated then
            return React.createElement(SeeAllTile, { onActivated = onActivated, size = arg4, layoutOrder = num3 }), GameCollectionItemType.SeeAllTile
        end

        local isDisabled = if arg1 then arg1(num3) else nil
        local isHidden = tbl1 and tbl1[entry.universeId]
        local selectionOrder = if num2 then num2 + num3 else nil

        if entry.customRenderFunction then
            return entry.customRenderFunction({
                item = entry,
                index = num3,
                itemSize = arg4,
                rowNum = rowNum,
                zIndex = -num3,
                maxItemIndex = maxItemIndex,
                SelectionOrder = selectionOrder,
                isDisabled = isDisabled,
                onSelectionGained = onSelectionGained,
                onSelectionLost = onSelectionLost,
                topicId = topicId,
                source = source,
                referralSource = referralSource,
                playerCountStyle = playerCountStyle,
                hideGameStats = hideGameStats,
                gameTileLayoutType = gameTileLayoutType,
                hoverTileEnabled = var9,
                isContained = isContained,
                reportGameDetailOpened = reportGameDetailOpened,
                reportExperienceLaunched = reportExperienceLaunched,
                launchExperienceEventContext = launchExperienceEventContext,
                onPeekViewClosed = onPeekViewClosed,
                navigateToGameDetails = navigateToGameDetails,
                impressionsTag = impressionsTag,
                textSizeOffset = textSizeOffset,
                appPage = appPage,
                setGameHidden = setGameHidden,
                isHidden = isHidden,
                sponsoredUserCohort = sponsoredUserCohort,
                enableSponsoredFeedback = enableSponsoredFeedback,
                enableReportAd = enableReportAd,
                enableReportExperience = if FFlagLuaAppEnableReportExperience then enableReportExperience else nil,
                enableExplicitFeedback = enableExplicitFeedback,
                videoPlaybackContext = videoPlaybackContext,
                videoAnalytics = if FFlagLuaAppEmphasisGameTileVideo or FFlagLuaAppEnableNxMRoduxApportioning then videoAnalytics else nil
            })
        end

        local badgeOverride = getTileBadgeByPositionConfigFromEntry(entry)

        return React.createElement(AppGameTile, {
            Size = arg4,
            entry = entry,
            layoutOrder = num3,
            ZIndex = -num3,
            reportGameDetailOpened = reportGameDetailOpened,
            reportExperienceLaunched = reportExperienceLaunched,
            index = num3,
            friendFooterEnabled = friendFooterEnabled,
            showFriendActivity = showFriendActivity,
            impressionsTag = impressionsTag,
            useGridTile = useGridTile,
            playerCountStyle = playerCountStyle,
            isSponsoredFooterAllowed = isSponsoredFooterAllowed,
            gameTileLayoutType = gameTileLayoutType,
            useHoverTile = var9,
            topicId = topicId,
            launchExperienceEventContext = launchExperienceEventContext,
            referralSource = referralSource,
            source = source,
            rowNum = rowNum,
            navigateToGameDetails = navigateToGameDetails,
            hideGameStats = hideGameStats,
            playButtonStyle = playButtonStyle,
            isContained = isContained,
            hideTitle = hideTitle,
            hideMetadata = hideMetadata,
            onGuiStateChanged = onGuiStateChanged,
            onActivated = var2,
            isDisabled = isDisabled,
            onSelectionGained = onSelectionGained,
            onSelectionLost = onSelectionLost,
            textSizeOffset = textSizeOffset,
            contentTextLineCount = contentTextLineCount,
            metadataTextLineCount = metadataTextLineCount,
            useExperienceTileMetadata = useExperienceTileMetadata,
            forceHideAgeRatings = forceHideAgeRatings,
            videoAnalytics = videoAnalytics,
            onPeekViewClosed = onPeekViewClosed,
            SelectionOrder = selectionOrder,
            enableExplicitFeedback = enableExplicitFeedback,
            setGameHidden = setGameHidden,
            appPage = appPage,
            isHidden = isHidden,
            isNarrowScreenXSmall = isNarrowScreenXSmall,
            sponsoredUserCohort = sponsoredUserCohort,
            enableSponsoredFeedback = enableSponsoredFeedback,
            enableReportAd = enableReportAd,
            enableReportExperience = if FFlagLuaAppEnableReportExperience then enableReportExperience else nil,
            isSponsoredRatingFooterAllowed = isSponsoredRatingFooterAllowed,
            badgeOverride = badgeOverride,
            compactMetadataFormat = compactMetadataFormat,
            hideRating = if FFlagLuaAppNarrowTileHideRating then hideRating else nil,
            hidePlayerCount = if FFlagLuaAppNarrowTileHidePlayerCount then hidePlayerCount else nil,
            hasPrevalidatedVideoGamePlayability = if FFlagLuaAppUsePrevalidatedVideoGamePlayability then hasPrevalidatedVideoGamePlayability else nil,
            videoPlaybackContext = videoPlaybackContext,
            enableInstantPlay = if FFlagLuaAppContinueSortInstantPlay then enableInstantPlay else nil,
            instantPlayTreatment = if FFlagLuaAppContinueSortInstantPlay then instantPlayTreatment else nil,
            isTouchPreferredInput = if FFlagLuaAppContinueSortInstantPlay then bool2 else nil
        }), GameCollectionItemType.GameTile
    end

    local tableValue1 = useGridTile
    local tableValue2 = friendFooterEnabled
    local tableValue3 = hideGameStats
    local tableValue4 = showFriendActivity
    local tableValue5 = impressionsTag
    local tableValue6 = playerCountStyle
    local tableValue7 = isSponsoredFooterAllowed
    local tableValue8 = gameTileLayoutType
    local tableValue9 = topicId
    local tableValue10 = reportGameDetailOpened
    local tableValue11 = reportExperienceLaunched
    local tableValue12 = onActivated
    local tableValue13 = launchExperienceEventContext
    local tableValue14 = source
    local tableValue15 = referralSource
    local tableValue16 = num1
    local tableValue17 = var9
    local tableValue18 = playButtonStyle
    local tableValue19 = isContained
    local tableValue20 = hideTitle
    local tableValue21 = hideMetadata
    local tableValue22 = textSizeOffset
    local tableValue23 = onGuiStateChanged
    local tableValue24 = var2
    local tableValue25 = onSelectionGained
    local tableValue26 = onSelectionLost
    local tableValue27 = arg1
    local tableValue28 = contentTextLineCount
    local tableValue29 = useExperienceTileMetadata
    local tableValue30 = forceHideAgeRatings
    local tableValue31 = videoAnalytics
    local tableValue32 = onPeekViewClosed
    local var14 = metadataTextLineCount
    local var15 = if FFlagLuaAppEnableReportExperience then enableReportExperience else nil
    local var16 = if FFlagLuaAppNarrowTileHideRating then hideRating else nil
    local var17 = if FFlagLuaAppNarrowTileHidePlayerCount then hidePlayerCount else nil
    local tableValue33 = tableValue1
    local tableValue34 = tableValue2
    local tableValue35 = tableValue3
    local tableValue36 = tableValue4
    local tableValue37 = tableValue5
    local tableValue38 = tableValue6
    local tableValue39 = tableValue7
    local tableValue40 = tableValue8
    local tableValue41 = tableValue9
    local tableValue42 = tableValue10
    local tableValue43 = tableValue11
    local tableValue44 = tableValue12
    local tableValue45 = tableValue13
    local tableValue46 = tableValue14
    local tableValue47 = tableValue15
    local tableValue48 = tableValue16
    local tableValue49 = tableValue17
    local tableValue50 = tableValue18
    local tableValue51 = tableValue19
    local tableValue52 = tableValue20
    local tableValue53 = tableValue21
    local tableValue54 = tableValue22
    local tableValue55 = tableValue23
    local tableValue56 = tableValue24
    local tableValue57 = tableValue25
    local tableValue58 = tableValue26
    local tableValue59 = tableValue27
    local tableValue60 = tableValue28
    local tableValue61 = tableValue29
    local tableValue62 = tableValue30
    local tableValue63 = tableValue31
    local tableValue64 = tableValue32
    local tableValue65 = num2
    local tableValue66 = var14
    local tableValue67 = enableExplicitFeedback
    local tableValue68 = tbl1
    local tableValue69 = setGameHidden
    local tableValue70 = appPage
    local tableValue71 = isNarrowScreenXSmall
    local tableValue72 = sponsoredUserCohort
    local tableValue73 = enableSponsoredFeedback
    local tableValue74 = enableReportAd
    local tableValue75 = var15
    local tableValue76 = navigateToGameDetails
    local tableValue77 = isSponsoredRatingFooterAllowed
    local tableValue78 = compactMetadataFormat
    local tableValue79 = var16
    local tableValue80 = var17
    local var18 = if FFlagLuaAppUsePrevalidatedVideoGamePlayability then hasPrevalidatedVideoGamePlayability else nil
    local var19 = if FFlagLuaAppContinueSortInstantPlay then enableInstantPlay else nil
    local var20 = if FFlagLuaAppContinueSortInstantPlay then instantPlayTreatment else nil
    local var21 = if FFlagLuaAppContinueSortInstantPlay then bool2 else nil
    return (useCallback(func1, {
        tableValue33,
        tableValue34,
        tableValue35,
        tableValue36,
        tableValue37,
        tableValue38,
        tableValue39,
        tableValue40,
        tableValue41,
        tableValue42,
        tableValue43,
        tableValue44,
        tableValue45,
        tableValue46,
        tableValue47,
        tableValue48,
        tableValue49,
        tableValue50,
        tableValue51,
        tableValue52,
        tableValue53,
        tableValue54,
        tableValue55,
        tableValue56,
        tableValue57,
        tableValue58,
        tableValue59,
        tableValue60,
        tableValue61,
        tableValue62,
        tableValue63,
        tableValue64,
        tableValue65,
        tableValue66,
        tableValue67,
        tableValue68,
        tableValue69,
        tableValue70,
        tableValue71,
        tableValue72,
        tableValue73,
        tableValue74,
        tableValue75,
        tableValue76,
        tableValue77,
        tableValue78,
        tableValue79,
        tableValue80,
        var18,
        videoPlaybackContext,
        var19,
        var20,
        var21
    }))
end
return useRenderGameCollectionItem
