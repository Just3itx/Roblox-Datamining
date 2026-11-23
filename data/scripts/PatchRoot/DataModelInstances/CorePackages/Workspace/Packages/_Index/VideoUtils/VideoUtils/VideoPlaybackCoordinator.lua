-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent
local AppCommonLib = require(VideoUtilsParent.AppCommonLib)
local ArgCheck = require(VideoUtilsParent.ArgCheck)
local Signal = AppCommonLib.Signal

local _VideoAnalyticsTypes = require(VideoUtils.Analytics.VideoAnalyticsTypes)
local getIsInstanceVisible = require(VideoUtils.getIsInstanceVisible)

local FFlagLuaAppEdpMediaGalleryFullScreen = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpMediaGalleryFullScreen
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(VideoUtilsParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay

local FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback

local module = {}
module.__index = module

module.preferredFramerateThrottling = false
module.isSettingFramerateThrottleAllowedByPolicy = false

local num1 = 0

function module.new()
    local tbl1 = {
        changed = Signal.new(),
        playingVideoKey = nil,
        currentPlaybackSessionId = nil,
        currentplaybackSessionStartTime = nil,
        videoAnalytics = nil,
        playingVideoItemIndex = nil,
        videoDwellTaskHandles = {}
    }

    setmetatable(tbl1, module)

    return tbl1
end

function module:__setRunServiceThrottleFramerateEnabled(enable: boolean)
    if not module.isSettingFramerateThrottleAllowedByPolicy then
        return
    end

    RunService:setThrottleFramerateEnabled(enable)
end

function module.isPlaybackAllowed(_, bool1: boolean, bool2: boolean?): boolean
    return not not (not (FFlagLuaAppEdpMediaGalleryFullScreen and bool2) and bool1)
end

function module.isPlaybackCandidate(arg1, bool1: boolean, bool2: boolean?, tbl1, tbl2, num2: number)
    if not arg1:isPlaybackAllowed(bool1, bool2) then
        return false
    end

    return getIsInstanceVisible(tbl1.current, tbl2, num2)
end

function module:forcePlayback(playingVideoKey: string, str1: string, num2: number?, arg1)
    if self.playingVideoKey == playingVideoKey then
        return
    end

    self:__cancelCurrentPlayback(str1, num2, nil, self.videoAnalytics)
    self:requestPlayback(playingVideoKey, false, 0, num2, arg1)
end

function module:requestPlayback(playingVideoKey: string, bool1: boolean, num2: number, num3: number?, arg1)
    if self.playingVideoKey == playingVideoKey then
        return
    end

    if self.videoDwellTaskHandles[playingVideoKey] ~= nil then
        return
    end

    if not bool1 then
        self:__startPlayback(playingVideoKey, num3, arg1)
        return
    end

    local var1 = task.delay(num2, function()
        self.videoDwellTaskHandles[playingVideoKey] = nil
        self:__startPlayback(playingVideoKey, num3, arg1)
    end)

    self.videoDwellTaskHandles[playingVideoKey] = var1
end

function module:__startPlayback(playingVideoKey: string, playingVideoItemIndex: number?, videoAnalytics)
    self:__setRunServiceThrottleFramerateEnabled(false)

    if self.playingVideoKey == nil then
        num1 += 1
    end

    self.playingVideoKey = playingVideoKey
    self.currentPlaybackSessionId = HttpService:GenerateGUID(false)
    self.currentPlaybackSessionStartTime = tick()
    self.videoAnalytics = videoAnalytics
    self.playingVideoItemIndex = playingVideoItemIndex

    if videoAnalytics then
        videoAnalytics.reportVideoPlay(playingVideoItemIndex, self.currentPlaybackSessionId)
    end

    self.changed:fire(playingVideoKey)
end

function module:cancelPlayback(playingVideoKey: string, str1: string, num2: number?, arg1)
    if self.playingVideoKey == playingVideoKey then
        self:__cancelCurrentPlayback(str1, num2, nil, arg1)
    elseif self.videoDwellTaskHandles[playingVideoKey] ~= nil then
        local var1 = self.videoDwellTaskHandles[playingVideoKey]
        task.cancel(var1)
        self.videoDwellTaskHandles[playingVideoKey] = nil
    end

    if num1 == 0 then
        self:__setRunServiceThrottleFramerateEnabled(module.preferredFramerateThrottling)
    end
end

function module:reset(str1: string, _: number?, str2: string?, _)
    if self.playingVideoKey ~= nil then
        self:__cancelCurrentPlayback(str1, self.playingVideoItemIndex, str2, self.videoAnalytics)
    end

    for _, value in self.videoDwellTaskHandles do
        if value ~= nil then
            task.cancel(value)
        end
    end
    self.videoDwellTaskHandles = {}

    if num1 == 0 then
        self:__setRunServiceThrottleFramerateEnabled(module.preferredFramerateThrottling)
    end

    if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback and self.onPlaybackReset then
        self.onPlaybackReset(str1, str2)
    end
end

function module:cancelPendingDwells()
    for _, value in self.videoDwellTaskHandles do
        if value ~= nil then
            task.cancel(value)
        end
    end
    self.videoDwellTaskHandles = {}
end

function module:__cancelCurrentPlayback(str1: string, num2: number?, str2: string?, arg1)
    local currentPlaybackSessionStartTime = self.currentPlaybackSessionStartTime

    if arg1 then
        local now = tick()
        ArgCheck.assert(currentPlaybackSessionStartTime and currentPlaybackSessionStartTime <= now)

        local var1 = if currentPlaybackSessionStartTime and currentPlaybackSessionStartTime <= now then now - currentPlaybackSessionStartTime else -1

        arg1.reportVideoEnd(num2, str1, self.currentPlaybackSessionId, var1, str2)
    end

    if self.playingVideoKey ~= nil then
        num1 -= 1
    end

    self.playingVideoKey = nil
    self.currentPlaybackSessionId = nil
    self.currentPlaybackSessionStartTime = nil
    self.videoAnalytics = nil
    self.playingVideoItemIndex = nil
    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        self.changed:fire(nil, str1)
        return
    end
    self.changed:fire(nil)
end

function module.setIsSettingFramerateThrottleAllowedByPolicy(_, isSettingFramerateThrottleAllowedByPolicy: boolean)
    module.isSettingFramerateThrottleAllowedByPolicy = isSettingFramerateThrottleAllowedByPolicy
end

function module.setPreferredFramerateThrottling(_, preferredFramerateThrottling: boolean)
    module.preferredFramerateThrottling = preferredFramerateThrottling
end

function module.isAnyPlaying(): boolean
    return num1 > 0
end

module.default = module.new()

return module
