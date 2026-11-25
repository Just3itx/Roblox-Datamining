-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)

local DiscoveryAnalytics = require(SduiSharedContentParent.DiscoveryAnalytics)
local discoveryVideoEndEvent = DiscoveryAnalytics.Events.discoveryVideoEndEvent
local discoveryVideoLoadEvent = DiscoveryAnalytics.Events.discoveryVideoLoadEvent
local discoveryVideoLoopEvent = DiscoveryAnalytics.Events.discoveryVideoLoopEvent
local discoveryVideoPlayEvent = DiscoveryAnalytics.Events.discoveryVideoPlayEvent

local DiscoveryUtils = require(SduiSharedContentParent.DiscoveryUtils)
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger
local parseBooleanString = DiscoveryUtils.parseBooleanString

local findAnalyticsFieldInAncestors = require(SduiSharedContentParent.SduiCoreSystem).findAnalyticsFieldInAncestors

local VideoUtils = require(SduiSharedContentParent.VideoUtils)
local VideoActions = VideoUtils.AnalyticsEnums.VideoActions
local VideoLogger = VideoUtils.VideoLogger

local FFlagLuaAppDiscoveryMomentVideoTelemetry = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppDiscoveryMomentVideoTelemetry

local function asOptionalString(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    if arg1 == nil then
        return nil
    end

    return tostring(arg1)
end

local function asOptionalBoolean(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) == "boolean" then
        return arg1
    elseif type(arg1) == "string" then
        return (parseBooleanString(arg1))
    end

    return nil
end

local function reportMissingVideoAssetId(actionType: string, pageContext: string, universeId: string?, placeId: string?) -- Luacid: unused: defined but never referenced
    DiscoveryEventErrorLogger.reportError(
        "UnifiedVideoEngagementEvent_MissingVideoAssetId",
        `SDUI video analytics "{actionType}" is missing videoAssetId on page "{pageContext}"`,
        {
            actionType = actionType,
            pageContext = pageContext,
            universeId = universeId,
            placeId = placeId
        }
    )
end

local function useSduiVideoAnalytics(arg1, str1: string, tbl1)
    local var1 = React.useCallback(function(videoPlaybackSessionId: string?)
        local collectionData = if arg1.getCollectionData then arg1.getCollectionData() else nil
        local videoAssetId = asOptionalString((findAnalyticsFieldInAncestors("videoAssetId", arg1)))
        local analyticsFieldInAncestors = findAnalyticsFieldInAncestors("nativeAdData", arg1) or findAnalyticsFieldInAncestors("adId", arg1)

        return {
            videoAssetId = videoAssetId,
            videoPlaybackSessionId = videoPlaybackSessionId or "INVALID_SESSION_ID",
            universeId = tbl1.universeId,
            rootPlaceId = tbl1.placeId,
            gameSetTypeId = if collectionData then asOptionalString(collectionData.collectionId) else nil,
            sortPos = if collectionData then collectionData.collectionPosition else nil,
            nativeAdData = asOptionalString(analyticsFieldInAncestors),
            tileType = asOptionalString((findAnalyticsFieldInAncestors("tileType", arg1))),
            contentType = asOptionalString((findAnalyticsFieldInAncestors("contentType", arg1))),
            isMoment = if FFlagLuaAppDiscoveryMomentVideoTelemetry then asOptionalBoolean((findAnalyticsFieldInAncestors("isMoment", arg1))) else nil
        }
    end, { arg1, tbl1.universeId, tbl1.placeId })

    local reportVideoPlay = React.useCallback(function(_: number?, str2: string?)
        local var2 = var1(str2)
        if not var2.videoAssetId then
            local pageContext = str1
            local universeId = tbl1.universeId
            local placeId = tbl1.placeId
            DiscoveryEventErrorLogger.reportError(
                "UnifiedVideoEngagementEvent_MissingVideoAssetId",
                `SDUI video analytics "play" is missing videoAssetId on page "{pageContext}"`,
                {
                    actionType = "play",
                    pageContext = pageContext,
                    universeId = universeId,
                    placeId = placeId
                }
            )
        end

        discoveryVideoPlayEvent(str1, var2)
    end, {
        var1,
        str1,
        tbl1.universeId,
        tbl1.placeId
    })
    local reportVideoLoad = React.useCallback(function(_: number?, str2: string?, totalDuration: number, loadTime: number)
        local var3 = var1(str2)
        if not var3.videoAssetId then
            local pageContext = str1
            local universeId = tbl1.universeId
            local placeId = tbl1.placeId
            DiscoveryEventErrorLogger.reportError(
                "UnifiedVideoEngagementEvent_MissingVideoAssetId",
                `SDUI video analytics "load" is missing videoAssetId on page "{pageContext}"`,
                {
                    actionType = "load",
                    pageContext = pageContext,
                    universeId = universeId,
                    placeId = placeId
                }
            )
        end

        discoveryVideoLoadEvent(str1, {
            videoAssetId = var3.videoAssetId,
            videoPlaybackSessionId = var3.videoPlaybackSessionId,
            totalDuration = totalDuration,
            loadTime = loadTime,
            universeId = var3.universeId,
            rootPlaceId = var3.rootPlaceId,
            gameSetTypeId = var3.gameSetTypeId,
            sortPos = var3.sortPos,
            nativeAdData = var3.nativeAdData,
            tileType = var3.tileType,
            contentType = var3.contentType,
            isMoment = if FFlagLuaAppDiscoveryMomentVideoTelemetry then var3.isMoment else nil
        })
        if not var3.videoAssetId or not tbl1.sourceId then
            return
        end

        VideoLogger.reportVideoAction(VideoActions.load, str1, {
            videoAssetId = var3.videoAssetId,
            source = tbl1.source,
            sourceId = tbl1.sourceId,
            playbackSessionId = var3.videoPlaybackSessionId
        }, { loadTime = loadTime })
    end, {
        var1,
        str1,
        tbl1.source,
        tbl1.sourceId,
        tbl1.universeId,
        tbl1.placeId
    })

    local reportVideoLoop = React.useCallback(function(_: number?, str2: string?)
        local var4 = var1(str2)
        if not var4.videoAssetId then
            local pageContext = str1
            local universeId = tbl1.universeId
            local placeId = tbl1.placeId
            DiscoveryEventErrorLogger.reportError(
                "UnifiedVideoEngagementEvent_MissingVideoAssetId",
                `SDUI video analytics "loop" is missing videoAssetId on page "{pageContext}"`,
                {
                    actionType = "loop",
                    pageContext = pageContext,
                    universeId = universeId,
                    placeId = placeId
                }
            )
        end

        discoveryVideoLoopEvent(str1, var4)
    end, {
        var1,
        str1,
        tbl1.universeId,
        tbl1.placeId
    })
    local reportVideoEnd = React.useCallback(function(_: number?, endReason: string, str2: string?, playbackTime: number, targetUniverseId: string?)
        local var5 = var1(str2)
        if not var5.videoAssetId then
            local pageContext = str1
            local universeId = tbl1.universeId
            local placeId = tbl1.placeId
            DiscoveryEventErrorLogger.reportError(
                "UnifiedVideoEngagementEvent_MissingVideoAssetId",
                `SDUI video analytics "end" is missing videoAssetId on page "{pageContext}"`,
                {
                    actionType = "end",
                    pageContext = pageContext,
                    universeId = universeId,
                    placeId = placeId
                }
            )
        end

        discoveryVideoEndEvent(str1, {
            videoAssetId = var5.videoAssetId,
            videoPlaybackSessionId = var5.videoPlaybackSessionId,
            endReason = endReason,
            playbackTime = playbackTime,
            universeId = var5.universeId,
            rootPlaceId = var5.rootPlaceId,
            gameSetTypeId = var5.gameSetTypeId,
            sortPos = var5.sortPos,
            targetUniverseId = targetUniverseId,
            nativeAdData = var5.nativeAdData,
            tileType = var5.tileType,
            contentType = var5.contentType,
            isMoment = if FFlagLuaAppDiscoveryMomentVideoTelemetry then var5.isMoment else nil
        })
    end, {
        var1,
        str1,
        tbl1.universeId,
        tbl1.placeId
    })

    return React.useMemo(function()
        return {
            reportVideoPlay = reportVideoPlay,
            reportVideoLoad = reportVideoLoad,
            reportVideoLoop = reportVideoLoop,
            reportVideoMute = nil,
            reportVideoEnd = reportVideoEnd
        }
    end, {
        reportVideoPlay,
        reportVideoLoad,
        reportVideoLoop,
        reportVideoEnd
    })
end
return useSduiVideoAnalytics
