-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local Responsive = require(VideoUtilsParent.Responsive)

local VideoPlaybackDetectionMethod = require(VideoUtils.VideoPlaybackDetectionMethod)

local function getPlaybackDetectionMethod(str1: string?, bool1: boolean?)
    if bool1 then
        return VideoPlaybackDetectionMethod.Hover
    end

    if str1 == Responsive.Input.Touch then
        return VideoPlaybackDetectionMethod.Viewport
    end

    if str1 == Responsive.Input.Directional then
        return VideoPlaybackDetectionMethod.Selection
    end

    return nil
end

return getPlaybackDetectionMethod
