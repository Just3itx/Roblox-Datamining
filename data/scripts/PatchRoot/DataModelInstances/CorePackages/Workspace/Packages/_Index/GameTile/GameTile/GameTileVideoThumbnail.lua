-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local VideoUtils = require(GameTileParent.VideoUtils)
local VideoPlayer = VideoUtils.VideoPlayer
local VideoPlaybackCoordinator = VideoUtils.VideoPlaybackCoordinator

local _GameTileTypes = require(GameTile.GameTileTypes)

local FFlagLuaAppEdpMediaGalleryFullScreen = require(GameTileParent.SharedFlags).FFlagLuaAppEdpMediaGalleryFullScreen
local FFlagLuaAppVideoTileDisableActivation = require(GameTileParent.SharedFlags).FFlagLuaAppVideoTileDisableActivation
local FFlagLuaAppVideoTileHideCenterPlayButton = require(GameTileParent.SharedFlags).FFlagLuaAppVideoTileHideCenterPlayButton
local FFlagLuaAppHomeMomentVideoFallback = require(GameTileParent.SharedFlags).FFlagLuaAppHomeMomentVideoFallback

local function GameTileVideoThumbnail(tbl1)
    local onVideoLoaded = React.useCallback(function(num1: number, num2: number)
        if tbl1.videoAnalytics then
            tbl1.videoAnalytics.reportVideoLoad(
                tbl1.itemIndex,
                if tbl1.videoPlaybackCoordinator then tbl1.videoPlaybackCoordinator.currentPlaybackSessionId else VideoPlaybackCoordinator.default.currentPlaybackSessionId,
                num1,
                num2
            )
        end
    end, { tbl1.itemIndex, tbl1.videoAnalytics, tbl1.videoPlaybackCoordinator })

    local onVideoLooped = React.useCallback(function()
        if tbl1.videoAnalytics then
            tbl1.videoAnalytics.reportVideoLoop(
                tbl1.itemIndex,
                if tbl1.videoPlaybackCoordinator then tbl1.videoPlaybackCoordinator.currentPlaybackSessionId else VideoPlaybackCoordinator.default.currentPlaybackSessionId
            )
        end
    end, { tbl1.itemIndex, tbl1.videoAnalytics, tbl1.videoPlaybackCoordinator })

    local videoAnalyticsContext = React.useMemo(function()
        return {
            videoAnalyticsData = {
                source = "universe",
                sourceId = tbl1.universeId
            },
            getPlaybackSessionId = function()
                return if tbl1.videoPlaybackCoordinator then tbl1.videoPlaybackCoordinator.currentPlaybackSessionId else VideoPlaybackCoordinator.default.currentPlaybackSessionId
            end
        }
    end, { tbl1.universeId, tbl1.videoPlaybackCoordinator })

    return React.createElement(VideoPlayer, {
        video = tbl1.video,
        accessContext = if FFlagLuaAppHomeMomentVideoFallback then tbl1.accessContext else nil,
        thumbnail = tbl1.image,
        shouldStartPlayback = tbl1.playing,
        muted = true,
        looped = tbl1.looped,
        Size = tbl1.Size,
        ScaleType = if tbl1.isTileContained then Enum.ScaleType.Tile else nil,
        ZIndex = tbl1.ZIndex,
        cornerRadius = tbl1.cornerRadius,
        hideCenterPlayButton = if FFlagLuaAppVideoTileHideCenterPlayButton then true else nil,
        disableActivation = if FFlagLuaAppVideoTileDisableActivation then true else nil,
        onVideoLoaded = onVideoLoaded,
        onVideoLooped = onVideoLooped,
        onVideoPlayerActivated = if FFlagLuaAppVideoTileDisableActivation or not FFlagLuaAppEdpMediaGalleryFullScreen then nil else tbl1.onActivated,
        videoAnalyticsContext = videoAnalyticsContext
    })
end

return GameTileVideoThumbnail
