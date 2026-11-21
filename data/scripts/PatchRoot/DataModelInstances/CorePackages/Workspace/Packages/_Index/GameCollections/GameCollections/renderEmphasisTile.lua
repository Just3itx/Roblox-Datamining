-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent

local GameCollectionItemTypes = require(GameCollectionsParent.DiscoveryTypes).GameCollectionItemTypes

local FFlagLuaAppEmphasisGameTileVideo = require(GameCollectionsParent.SharedFlags).FFlagLuaAppEmphasisGameTileVideo

local React = require(GameCollectionsParent.React)
local EmphasisGameTile = require(GameCollectionsParent.GameTile).EmphasisGameTile
local _VideoUtils = require(GameCollectionsParent.VideoUtils)

local var1 = React.memo(function(tbl1)
    return React.createElement(EmphasisGameTile, {
        size = tbl1.item.sizeOverride,
        index = tbl1.index,
        layoutOrder = tbl1.index,
        SelectionOrder = tbl1.SelectionOrder,
        isDisabled = tbl1.isDisabled,
        onSelectionGained = tbl1.onHoldableFocused,
        onSelectionLost = tbl1.onHoldableUnfocused,
        entry = tbl1.item,
        topicId = tbl1.topicId,
        source = tbl1.source,
        referralSource = tbl1.referralSource,
        playerCountStyle = tbl1.playerCountStyle,
        hideGameStats = tbl1.hideGameStats,
        gameTileLayoutType = tbl1.gameTileLayoutType,
        useHoverTile = tbl1.hoverTileEnabled,
        isContained = tbl1.isContained,
        reportGameDetailOpened = tbl1.reportGameDetailOpened,
        reportExperienceLaunched = tbl1.reportExperienceLaunched,
        launchExperienceEventContext = tbl1.launchExperienceEventContext,
        onPeekViewClosed = tbl1.onPeekViewClosed,
        navigateToGameDetails = tbl1.navigateToGameDetails,
        impressionsTag = tbl1.impressionsTag,
        textSizeOffset = tbl1.textSizeOffset,
        showDescription = tbl1.item.showDescription,
        zIndex = tbl1.zIndex,
        videoPlaybackContext = tbl1.videoPlaybackContext,
        appPage = if FFlagLuaAppEmphasisGameTileVideo then tbl1.appPage else nil,
        videoAnalytics = if FFlagLuaAppEmphasisGameTileVideo then tbl1.videoAnalytics else nil
    })
end)

return function(tbl1)
    return React.createElement(var1, tbl1), GameCollectionItemTypes.GameCollectionItemType.EmphasisTile
end
