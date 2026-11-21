-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local HttpService = game:GetService("HttpService")

local React = require(GameJoinCardParent.React)
local useNavigationFocus = require(GameJoinCardParent.Navigation).useNavigationFocus
local VideoUtils = require(GameJoinCardParent.VideoUtils)
local VideoLogger = VideoUtils.VideoLogger
local VideoPlaybackCoordinator = VideoUtils.VideoPlaybackCoordinator
local VideoActions = VideoUtils.AnalyticsEnums.VideoActions
local VideoEndReason = VideoUtils.AnalyticsEnums.VideoEndReason

local useAppLifecycleCallbacks = require(GameJoinCard.Hooks.useAppLifecycleCallbacks)
local _JoinCardBannerVideoView = require(script.Parent.JoinCardBannerVideoView)

local function useJoinCardBannerVideoViewModel(tbl1)
    local var1 = useNavigationFocus()
    local var2, var3 = React.useState(false)
    local var4 = if tbl1.videoPlaybackContext then tbl1.videoPlaybackContext.videoPlaybackCoordinator else VideoPlaybackCoordinator.default
    local viewportVideoAutoplayController = if tbl1.videoPlaybackContext then tbl1.videoPlaybackContext.viewportVideoAutoplayController else nil
    local var5 = "game_join_card_banner_video_" .. tbl1.videoId
    local var6, var7 = React.useState(function(): boolean
        return var4.playingVideoKey == var5
    end)
    local shouldStartPlayback = var1 and var6

    React.useEffect(function()
        local function onPlayingVideoChanged(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
            var7(str1 == var5)
        end

        local connection = var4.changed:connect(onPlayingVideoChanged)
        onPlayingVideoChanged(var4.playingVideoKey)

        return function()
            connection:disconnect()
        end
    end, { var4, var5 })

    local var9 = React.useCallback(function()
        if var4.playingVideoKey == var5 then
            return
        end
        var4:reset(VideoEndReason.OverlayTakeover)
        var4:requestPlayback(var5, false, 0)
    end, { var4, var5 })

    local var10 = React.useCallback(function()
        var4:cancelPlayback(var5, VideoEndReason.AppBackgrounded)
    end, { var4, var5 })

    React.useEffect(function()
        if not var1 then
            return nil
        end

        var9()

        local var11 = nil
        local connection = var4.changed:connect(function(str1: string?)
            if str1 == nil or str1 == var5 or var11 ~= nil then
                return
            end
            var11 = task.defer(function()
                var11 = nil
                local playingVideoKey = var4.playingVideoKey
                if playingVideoKey ~= nil and playingVideoKey ~= var5 then
                    var9()
                end
            end)
        end)

        return function()
            connection:disconnect()
            if var11 ~= nil then
                task.cancel(var11)
            end

            var4:cancelPlayback(var5, VideoEndReason.OverlayTakeover)
        end
    end, {
        var4,
        var5,
        var1,
        var9
    })
    local var11 = useAppLifecycleCallbacks
    if not var1 then
        var10 = nil
    end

    var11(var10, if var1 then var9 else nil)

    React.useEffect(function(): (() -> ())?
        return if viewportVideoAutoplayController == nil then nil else function()
            viewportVideoAutoplayController:reset("gameJoinCardClosed")
            viewportVideoAutoplayController:forceScheduleInitialWinnerUpdate()
        end
    end, { viewportVideoAutoplayController })

    local var12 = React.useMemo(function(): string
        return HttpService:GenerateGUID(false)
    end, { tbl1.videoId, shouldStartPlayback })

    React.useEffect(function()
        var3(false)
    end, { tbl1.videoId, shouldStartPlayback })

    local videoAnalyticsContext = React.useMemo(function()
        return {
            videoAnalyticsData = {
                source = "GameJoinCard",
                sourceId = tbl1.universeId
            },
            getPlaybackSessionId = function()
                return var12
            end
        }
    end, { tbl1.universeId, var12 })

    local onVideoLoaded = React.useCallback(function(videoAssetDuration: number, loadTime: number)
        var3(true)
        VideoLogger.reportVideoAction(VideoActions.load, "GameJoinCard", {
            videoAssetId = tbl1.videoId,
            source = "GameJoinCard",
            sourceId = tbl1.universeId,
            playbackSessionId = var12,
            videoAssetDuration = videoAssetDuration,
            isVisible = true,
            isAudible = false,
            volumeLevel = 0
        }, { loadTime = loadTime })
    end, { tbl1.videoId, tbl1.universeId, var12 })

    return {
        video = `rbxassetid://{tbl1.videoId}`,
        shouldStartPlayback = shouldStartPlayback,
        isVisible = shouldStartPlayback and var2,
        Size = tbl1.Size,
        cornerRadius = tbl1.cornerRadius,
        ZIndex = tbl1.ZIndex,
        onActivated = tbl1.onActivated,
        videoAnalyticsContext = videoAnalyticsContext,
        onVideoLoaded = onVideoLoaded
    }
end

return useJoinCardBannerVideoViewModel
