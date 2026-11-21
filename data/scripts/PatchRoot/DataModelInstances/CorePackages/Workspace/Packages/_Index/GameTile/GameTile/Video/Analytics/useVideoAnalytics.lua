-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent

local DiscoveryTypes = require(GameTileParent.DiscoveryTypes)
local React = require(GameTileParent.React)

local mutedError = require(GameTileParent.Loggers).mutedError
local VideoActions = require(GameTileParent.VideoUtils).AnalyticsEnums.VideoActions
local VideoLogger = require(GameTileParent.VideoUtils).VideoLogger
local DiscoveryEventErrorLogger = require(GameTileParent.DiscoveryUtils).DiscoveryEventErrorLogger

local _GameTileTypes = require(GameTile.GameTileTypes)
local getGameTileLayoutData = require(GameTile.getGameTileLayoutData)
local getLayoutDataVideo = require(GameTile.getLayoutDataVideo)

local DiscoveryAnalytics = require(GameTile.Parent.DiscoveryAnalytics)
local discoveryVideoEndEvent = DiscoveryAnalytics.Events.discoveryVideoEndEvent
local discoveryVideoLoadEvent = DiscoveryAnalytics.Events.discoveryVideoLoadEvent
local discoveryVideoLoopEvent = DiscoveryAnalytics.Events.discoveryVideoLoopEvent
local discoveryVideoPlayEvent = DiscoveryAnalytics.Events.discoveryVideoPlayEvent
local FFlagLuaAppEnableNxMRoduxApportioning = require(GameTileParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning
local FFlagLuaAppHomeMomentVideoFallback = require(GameTileParent.SharedFlags).FFlagLuaAppHomeMomentVideoFallback
local FFlagLuaAppDiscoveryMomentVideoTelemetry = require(GameTileParent.SharedFlags).FFlagLuaAppDiscoveryMomentVideoTelemetry

local OmniRecommendationsContentType = DiscoveryTypes.OmniRecommendationsContentType

local function getGameSortId(arg1, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == nil then nil elseif bool1 then arg1.topicId else arg1.gameSetTypeId
end

local function getVideoAssetId(arg1, gameSortId: string?) -- Luacid: Inlined by compiler; 4 call sites recovered
    if arg1 and arg1.primaryWideVideoAssetId then
        return arg1.primaryWideVideoAssetId
    end

    if FFlagLuaAppEnableNxMRoduxApportioning and arg1 and arg1.primaryVideoAssetId then
        return arg1.primaryVideoAssetId
    end

    local gameTileLayoutData = getGameTileLayoutData(arg1, gameSortId)

    if not FFlagLuaAppHomeMomentVideoFallback then
        return gameTileLayoutData and gameTileLayoutData.primaryMediaAsset and gameTileLayoutData.primaryMediaAsset.wideVideoAssetId
    end

    local layoutDataVideo = getLayoutDataVideo(gameTileLayoutData)
    return layoutDataVideo and layoutDataVideo.assetId
end

local function getVideoAssetIdAndIsMoment(arg1, str1: string?) -- Luacid: unused: defined but never referenced
    if FFlagLuaAppEnableNxMRoduxApportioning and arg1 and arg1.primaryVideoAssetId then
        return arg1.primaryVideoAssetId, false
    end

    local gameTileLayoutData = getGameTileLayoutData(arg1, str1)
    local layoutDataVideo = getLayoutDataVideo(gameTileLayoutData, arg1 and arg1.primaryWideVideoAssetId)

    return layoutDataVideo and layoutDataVideo.assetId, not (layoutDataVideo == nil) and layoutDataVideo.isMoment == true
end

local function useVideoAnalytics(arg1, bool1: boolean, pageContext: string, sortPos: number, tbl1)
    local gameSortId = getGameSortId(arg1, bool1)

    local reportVideoPlay = React.useCallback(function(num2: number?, videoPlaybackSessionId: string?)
        if num2 == nil or tbl1 == nil then
            return
        end

        local var1 = tbl1[num2]
        if not var1 then
            mutedError("reportVideoPlay requires a valid entry")
        end

        local var2 = nil
        local var3

        if FFlagLuaAppDiscoveryMomentVideoTelemetry then
            local var4 = gameSortId

            if FFlagLuaAppEnableNxMRoduxApportioning and var1 and var1.primaryVideoAssetId then
                var3 = var1.primaryVideoAssetId
                var2 = false
            else
                local gameTileLayoutData = getGameTileLayoutData(var1, var4)
                local layoutDataVideo = getLayoutDataVideo(gameTileLayoutData, var1 and var1.primaryWideVideoAssetId)

                var3 = layoutDataVideo and layoutDataVideo.assetId

                if layoutDataVideo == nil then
                    var2 = false
                elseif layoutDataVideo.isMoment == true then
                    var2 = true
                else
                    var2 = false
                end
            end
        else
            var3 = getVideoAssetId(var1, gameSortId)
        end
        if not var3 then
            mutedError("reportVideoPlay requires a valid videoAssetId")
        end

        local var4 = discoveryVideoPlayEvent
        local str2 = pageContext
        local tbl2 = {
            videoAssetId = var3,
            videoPlaybackSessionId = videoPlaybackSessionId or "INVALID_SESSION_ID",
            universeId = var1.universeId,
            rootPlaceId = var1.placeId,
            gameSetTypeId = gameSortId,
            sortPos = sortPos,
            nativeAdData = var1.adId,
            tileType = var1.componentType,
            contentType = var1.contentType,
            isMoment = 0
        }

        if not FFlagLuaAppDiscoveryMomentVideoTelemetry then
            var2 = nil
        end

        tbl2.isMoment = var2
        var4(str2, tbl2)
    end, {
        pageContext,
        tbl1,
        gameSortId,
        sortPos
    })
    local reportVideoLoad = React.useCallback(function(index: number?, str2: string?, totalDuration: number, loadTime: number)
        if index == nil or tbl1 == nil then
            return
        end

        local var2 = tbl1[index]
        if not var2 then
            mutedError("reportVideoLoad requires a valid entry")
        end

        local var3 = nil
        local var4

        if FFlagLuaAppDiscoveryMomentVideoTelemetry then
            local var5 = gameSortId

            if FFlagLuaAppEnableNxMRoduxApportioning and var2 and var2.primaryVideoAssetId then
                var4 = var2.primaryVideoAssetId
                var3 = false
            else
                local gameTileLayoutData = getGameTileLayoutData(var2, var5)
                local layoutDataVideo = getLayoutDataVideo(gameTileLayoutData, var2 and var2.primaryWideVideoAssetId)

                var4 = layoutDataVideo and layoutDataVideo.assetId

                if layoutDataVideo == nil then
                    var3 = false
                elseif layoutDataVideo.isMoment == true then
                    var3 = true
                else
                    var3 = false
                end
            end
        else
            var4 = getVideoAssetId(var2, gameSortId)
        end
        if not var4 then
            mutedError("reportVideoLoad requires a valid videoAssetId")
        end

        local bool2 = if FFlagLuaAppEnableNxMRoduxApportioning then var2.contentType == OmniRecommendationsContentType.AdLink else nil

        if not (var2.universeId or bool2) then
            DiscoveryEventErrorLogger.reportError(
                "UnifiedVideoEngagementEvent_MissingUniverseId",
                `reportVideoLoad: entry at index {index} is missing universeId for unified "load" on page "{pageContext}"`,
                {
                    index = index,
                    pageContext = pageContext,
                    gameSortId = gameSortId,
                    placeId = var2.placeId,
                    videoAssetId = var4
                }
            )
        end

        local var5 = discoveryVideoLoadEvent
        local str3 = pageContext
        local tbl2 = {
            videoAssetId = var4,
            videoPlaybackSessionId = str2 or "INVALID_SESSION_ID",
            totalDuration = totalDuration,
            loadTime = loadTime,
            universeId = var2.universeId,
            rootPlaceId = var2.placeId,
            gameSetTypeId = gameSortId,
            sortPos = sortPos,
            nativeAdData = var2.adId,
            tileType = var2.componentType,
            contentType = var2.contentType,
            isMoment = 0
        }

        if not FFlagLuaAppDiscoveryMomentVideoTelemetry then
            var3 = nil
        end

        tbl2.isMoment = var3
        var5(str3, tbl2)

        if not FFlagLuaAppEnableNxMRoduxApportioning then
            if var2.universeId and var4 then
                VideoLogger.reportVideoAction(VideoActions.load, pageContext, {
                    videoAssetId = var4,
                    source = "universe",
                    sourceId = tostring(var2.universeId),
                    playbackSessionId = str2 or "INVALID_SESSION_ID"
                }, { loadTime = loadTime })
            end

            return
        end

        if not var4 or not bool2 and not var2.universeId then
            return
        end

        local reportVideoAction = VideoLogger.reportVideoAction
        local load = VideoActions.load
        local str4 = pageContext
        local tbl3 = {
            videoAssetId = var4,
            source = if bool2 then "adLink" else "universe",
            sourceId = if bool2 then tostring(var2.clickoutUrl) else tostring(var2.universeId),
            playbackSessionId = str2 or "INVALID_SESSION_ID"
        }
        reportVideoAction(load, str4, tbl3, { loadTime = loadTime })
    end, {
        pageContext,
        tbl1,
        gameSortId,
        sortPos
    })

    local reportVideoLoop = React.useCallback(function(num2: number?, videoPlaybackSessionId: string?)
        if num2 == nil or tbl1 == nil then
            return
        end

        local var3 = tbl1[num2]
        if not var3 then
            mutedError("reportVideoLoop requires a valid entry")
        end

        local var4 = nil
        local var5

        if FFlagLuaAppDiscoveryMomentVideoTelemetry then
            local var6 = gameSortId

            if FFlagLuaAppEnableNxMRoduxApportioning and var3 and var3.primaryVideoAssetId then
                var5 = var3.primaryVideoAssetId
                var4 = false
            else
                local gameTileLayoutData = getGameTileLayoutData(var3, var6)
                local layoutDataVideo = getLayoutDataVideo(gameTileLayoutData, var3 and var3.primaryWideVideoAssetId)

                var5 = layoutDataVideo and layoutDataVideo.assetId

                if layoutDataVideo == nil then
                    var4 = false
                elseif layoutDataVideo.isMoment == true then
                    var4 = true
                else
                    var4 = false
                end
            end
        else
            var5 = getVideoAssetId(var3, gameSortId)
        end
        if not var5 then
            mutedError("reportVideoLoop requires a valid videoAssetId")
        end

        local var6 = discoveryVideoLoopEvent
        local str2 = pageContext
        local tbl2 = {
            videoAssetId = var5,
            videoPlaybackSessionId = videoPlaybackSessionId or "INVALID_SESSION_ID",
            universeId = var3.universeId,
            rootPlaceId = var3.placeId,
            gameSetTypeId = gameSortId,
            sortPos = sortPos,
            nativeAdData = var3.adId,
            tileType = var3.componentType,
            contentType = var3.contentType,
            isMoment = 0
        }

        if not FFlagLuaAppDiscoveryMomentVideoTelemetry then
            var4 = nil
        end

        tbl2.isMoment = var4
        var6(str2, tbl2)
    end, {
        pageContext,
        tbl1,
        gameSortId,
        sortPos
    })
    local reportVideoEnd = React.useCallback(function(num2: number?, endReason: string, videoPlaybackSessionId: string?, playbackTime: number, targetUniverseId: string?)
        if num2 == nil or tbl1 == nil then
            return
        end

        local var4 = tbl1[num2]
        if not var4 then
            mutedError("reportVideoEnd requires a valid entry")
        end

        local var5 = nil
        local var6

        if FFlagLuaAppDiscoveryMomentVideoTelemetry then
            local var7 = gameSortId

            if FFlagLuaAppEnableNxMRoduxApportioning and var4 and var4.primaryVideoAssetId then
                var6 = var4.primaryVideoAssetId
                var5 = false
            else
                local gameTileLayoutData = getGameTileLayoutData(var4, var7)
                local layoutDataVideo = getLayoutDataVideo(gameTileLayoutData, var4 and var4.primaryWideVideoAssetId)

                var6 = layoutDataVideo and layoutDataVideo.assetId

                if layoutDataVideo == nil then
                    var5 = false
                elseif layoutDataVideo.isMoment == true then
                    var5 = true
                else
                    var5 = false
                end
            end
        else
            var6 = getVideoAssetId(var4, gameSortId)
        end
        if not var6 then
            mutedError("reportVideoEnd requires a valid videoAssetId")
        end

        local var7 = discoveryVideoEndEvent
        local str2 = pageContext
        local tbl2 = {
            videoAssetId = var6,
            videoPlaybackSessionId = videoPlaybackSessionId or "INVALID_SESSION_ID",
            endReason = endReason,
            playbackTime = playbackTime,
            universeId = var4.universeId,
            rootPlaceId = var4.placeId,
            gameSetTypeId = gameSortId,
            sortPos = sortPos,
            targetUniverseId = targetUniverseId,
            nativeAdData = var4.adId,
            tileType = var4.componentType,
            contentType = var4.contentType,
            isMoment = 0
        }

        if not FFlagLuaAppDiscoveryMomentVideoTelemetry then
            var5 = nil
        end

        tbl2.isMoment = var5
        var7(str2, tbl2)
    end, {
        pageContext,
        tbl1,
        gameSortId,
        sortPos
    })
    return (React.useMemo(function()
        return {
            reportVideoPlay = reportVideoPlay,
            reportVideoLoad = reportVideoLoad,
            reportVideoLoop = reportVideoLoop,
            reportVideoEnd = reportVideoEnd
        }
    end, {
        reportVideoPlay,
        reportVideoLoad,
        reportVideoLoop,
        reportVideoEnd
    }))
end
return useVideoAnalytics
