-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local DataHydration = require(ServerDrivenUiParent.DataHydration)
local React = require(ServerDrivenUiParent.React)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local TileVideoBlockingConfig = require(ServerDrivenUiParent.GameTile).TileVideoBlockingConfig

local VideoUtils = require(ServerDrivenUiParent.VideoUtils)
local VideoEndReason = VideoUtils.AnalyticsEnums.VideoEndReason
local isVideoEligibleForPlayability = VideoUtils.isVideoEligibleForPlayability
local useCanDevicePlayVideoPreview = VideoUtils.useCanDevicePlayVideoPreview

local SduiVideoThumbnail = require(script.Parent.SduiVideoThumbnail)
local useSduiVideoAnalytics = require(ServerDrivenUiParent.SduiSharedContent).useSduiVideoAnalytics

local FIntLuaAppGameTileVideoDwellTimeInSec = require(ServerDrivenUiParent.SharedFlags).FIntLuaAppGameTileVideoDwellTimeInSec
local FIntLuaAppGameTileVideoVisiblePercent = require(ServerDrivenUiParent.SharedFlags).FIntLuaAppGameTileVideoVisiblePercent

local function SduiGameVideoThumbnail(tbl1)
    local playabilityStore = DataHydration.Game.getPlayabilityStore(false)
    local playability = playabilityStore.getPlayability(tbl1.universeId)
    local var1 = SignalsReact.useSignalState(playability.data)
    local bool1 = SignalsReact.useSignalState(playability.status) == DataHydration.DataStatus.Ready

    local videoAnalytics = useSduiVideoAnalytics(
        tbl1.analyticsContext,
        tbl1.sduiContext.appPage,
        {
            source = "universe",
            sourceId = tbl1.universeId,
            universeId = tbl1.universeId,
            placeId = tbl1.placeId
        }
    )
    local onVideoIneligible = React.useCallback(function(str1: string?)
        if bool1 then
            videoAnalytics.reportVideoEnd(nil, VideoEndReason.PlayabilityCheckFailed, str1, -1)
        end
    end, { videoAnalytics, bool1 })

    local var4, var5 = React.useState(false)

    local var6 = useCanDevicePlayVideoPreview(TileVideoBlockingConfig, tbl1.universeId, tbl1.sduiContext.appPage)

    local onPlaybackCandidate = React.useCallback(function()
        if not bool1 then
            playabilityStore.fetchPlayability(tbl1.universeId)
        end

        var5(var6())
    end, {
        tbl1.universeId,
        bool1,
        playabilityStore,
        var6
    })

    return React.createElement(SduiVideoThumbnail, {
        sduiContext = tbl1.sduiContext,
        videoPlayer = tbl1.videoPlayer,
        imageComponent = tbl1.imageComponent,
        videoPlaybackContext = tbl1.sduiContext.videoPlaybackContext,
        isVideoEligible = isVideoEligibleForPlayability(bool1, var1, nil) and var4,
        onVideoIneligible = onVideoIneligible,
        onPlaybackCandidate = onPlaybackCandidate,
        videoAnalytics = videoAnalytics,
        videoDwellTimeInSec = FIntLuaAppGameTileVideoDwellTimeInSec,
        videoVisiblePercent = FIntLuaAppGameTileVideoVisiblePercent,
        isHovered = tbl1.isHovered,
        isSelected = tbl1.isSelected,
        cornerRadius = tbl1.cornerRadius,
        playbackCandidateRef = tbl1.playbackCandidateRef
    })
end

return SduiGameVideoThumbnail
