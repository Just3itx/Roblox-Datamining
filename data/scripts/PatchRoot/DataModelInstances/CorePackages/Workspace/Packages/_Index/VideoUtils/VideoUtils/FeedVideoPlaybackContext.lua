-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local ViewportVideoAutoplayMode = require(VideoUtils.ViewportVideoAutoplayMode)
local VideoPlaybackCoordinator = require(VideoUtils.VideoPlaybackCoordinator)
local VideoPlaybackDetectionMethod = require(VideoUtils.VideoPlaybackDetectionMethod)
local ViewportVideoAutoplayController = require(VideoUtils.ViewportVideoAutoplayController)

local FFlagLuaAppVideoAutoplayFeedElection = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoAutoplayFeedElection
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(VideoUtilsParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay

local module = {}
module.__index = module

function module.new(bool1: boolean?, bool2: boolean?, bool3: boolean?, arg1)
    local videoPlaybackCoordinator = VideoPlaybackCoordinator.new()
    local var1 = nil
    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        if arg1 == VideoPlaybackDetectionMethod.Viewport then
            var1 = ViewportVideoAutoplayMode.AutoplayAllCandidates
        elseif arg1 == VideoPlaybackDetectionMethod.Hover then
            var1 = ViewportVideoAutoplayMode.UserIntentWithSelectiveAutoplay
        end
    end

    local viewportVideoAutoplayController = if FFlagLuaAppOneByTwoHoverIdleAutoplay and var1 ~= nil then ViewportVideoAutoplayController.new(
        videoPlaybackCoordinator,
        if FFlagLuaAppVideoAutoplayFeedElection then bool2 else nil,
        if FFlagLuaAppVideoAutoplayFeedElection then bool3 else nil,
        var1
    ) else nil

    if bool1 then
        local new2 = ViewportVideoAutoplayController.new

        if not FFlagLuaAppVideoAutoplayFeedElection then
            bool2 = nil
        end

        if not FFlagLuaAppVideoAutoplayFeedElection then
            bool3 = nil
        end

        viewportVideoAutoplayController = new2(videoPlaybackCoordinator, bool2, bool3)
    end

    local tbl1 = {
        videoPlaybackCoordinator = videoPlaybackCoordinator,
        viewportVideoAutoplayController = viewportVideoAutoplayController
    }

    setmetatable(tbl1, module)

    return tbl1
end

return module
