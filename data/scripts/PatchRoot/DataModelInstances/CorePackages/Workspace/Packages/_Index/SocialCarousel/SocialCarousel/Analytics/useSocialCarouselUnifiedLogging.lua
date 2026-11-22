-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local Cryo = require(SocialCarouselParent.Cryo)
local RoactUtils = require(SocialCarouselParent.RoactUtils)
local CollectionViews = require(SocialCarouselParent.CollectionViews)
local UnifiedLogging = require(SocialCarouselParent.UnifiedLogging)
local Impressions = require(SocialCarouselParent.Impressions)
local SharedFlags = require(SocialCarouselParent.SharedFlags)

local Tile = require(SocialCarousel.Common.Enums).Tile
local TopicContentsReducer = require(SocialCarouselParent.TopicContentsRodux).TopicContentsReducer
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useCollectionImpressionsSignal = CollectionViews.useCollectionImpressionsSignal
local ScreenSizeImpressionsTracker = Impressions.ScreenSizeImpressionsTracker
local FrameBoundsImpressionsTracker = Impressions.FrameBoundsImpressionsTracker
local ImpressionsTagUtility = Impressions.ImpressionsTagUtility
local SendItemImpressions = UnifiedLogging.SendItemImpressions

local FFlagLuaAppHomeFriendsRemoveItemImpressions = SharedFlags.FFlagLuaAppHomeFriendsRemoveItemImpressions
local FFlagLuaAppUseFrameBoundsImpressions = SharedFlags.FFlagLuaAppUseFrameBoundsImpressions

return function(arg1, arg2, tbl1, arg3, tbl2)
    if not (arg3 and arg3.tiles and tbl1) then
        return nil
    end

    local scrollViewPositionChangedSignal, onCollectionViewabilityChanged = useCollectionImpressionsSignal(tbl1.scrollViewPositionChangedSignal)

    local useCallback = React.useCallback
    local function func1(arg4)
        if FFlagLuaAppHomeFriendsRemoveItemImpressions and tbl1.skipItemImpressionsLog then
            return
        end

        local var3 = Cryo.Dictionary.map(arg3.tiles, function(arg5)
            return Cryo.Dictionary.join(arg5, { isFriend = arg5.tileType == Tile.Friend })
        end)

        SendItemImpressions.sendFromFriendsCarousel(
            arg2,
            arg1,
            arg4,
            var3,
            tbl1.appPage,
            tbl1.sortIndex,
            tbl1.sortId,
            tbl1.impressionTag
        )
    end

    local tiles = arg3.tiles
    local appPage = tbl1.appPage
    local sortIndex = tbl1.sortIndex
    local sortId = tbl1.sortId
    local impressionTag = tbl1.impressionTag
    local skipItemImpressionsLog = if FFlagLuaAppHomeFriendsRemoveItemImpressions then tbl1.skipItemImpressionsLog else nil
    local sendImpressions = useCallback(func1, { arg2, arg1, tiles, appPage, sortIndex, sortId, impressionTag, skipItemImpressionsLog })

    local current = useSelector(function(arg4)
        if tbl1.sortId then
            return arg4.Personalization
                and arg4.Personalization[TopicContentsReducer.key]
                and arg4.Personalization[TopicContentsReducer.key][tbl1.sortId]
                and arg4.Personalization[TopicContentsReducer.key][tbl1.sortId].updatedTimestamp
        end

        return nil
    end)

    React.useEffect(function()
        if current then
            tbl2.current = current
        end
    end, { current })

    return {
        onCollectionViewabilityChanged = onCollectionViewabilityChanged,
        tagTileForImpressions = React.useCallback(function(arg4, arg5)
            ImpressionsTagUtility.AddTag(arg4, tbl1.impressionTag, arg5)

            return function()
                ImpressionsTagUtility.RemoveTag(arg4, tbl1.impressionTag, arg5)
            end
        end, { tbl1.impressionTag }),
        renderImpressionsTrackerComponent = React.useCallback(function(parentRef)
            return React.createElement(
                if FFlagLuaAppUseFrameBoundsImpressions then FrameBoundsImpressionsTracker else ScreenSizeImpressionsTracker,
                {
                    pageContext = tbl1.appPage,
                    parentRef = parentRef,
                    impressionsTag = tbl1.impressionTag,
                    scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
                    sendImpressions = sendImpressions,
                    dataUpdatedTimestamp = tbl2.current
                }
            )
        end, {
            tbl1.impressionTag,
            scrollViewPositionChangedSignal,
            tbl1.appPage,
            sendImpressions
        })
    }
end
