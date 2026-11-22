-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SponsoredAdViewabilityParent = script:FindFirstAncestor("SponsoredAdViewability").Parent

local React = require(SponsoredAdViewabilityParent.React)
local _DiscoveryTypes = require(SponsoredAdViewabilityParent.DiscoveryTypes)

local sponsoredAdViewabilityRegistry = require(script.Parent.sponsoredAdViewabilityRegistry)
local _sponsoredAdViewabilityTypes = require(script.Parent.sponsoredAdViewabilityTypes)

local function useTagAsSponsoredAdViewabilityCandidate(tbl1, arg1)
    local encryptedAdTrackingData = if arg1 then arg1.encryptedAdTrackingData else nil
    local tileType = if arg1 then arg1.tileType else nil
    local mediaType = if arg1 then arg1.mediaType else nil
    local videoPlaybackStateRef = if arg1 then arg1.videoPlaybackStateRef else nil
    local videoSource = if arg1 then arg1.videoSource else nil
    local isFullscreen = if arg1 then arg1.isFullscreen else nil

    React.useEffect(function()
        if encryptedAdTrackingData == nil or tileType == nil or mediaType == nil then
            return
        end

        local current = tbl1.current
        if current == nil then
            return
        end

        return sponsoredAdViewabilityRegistry.bind(current, {
            encryptedAdTrackingData = encryptedAdTrackingData,
            tileType = tileType,
            mediaType = mediaType,
            videoPlaybackStateRef = videoPlaybackStateRef,
            videoSource = videoSource,
            isFullscreen = isFullscreen
        })
    end, {
        encryptedAdTrackingData,
        tileType,
        tbl1,
        mediaType,
        videoPlaybackStateRef,
        videoSource,
        isFullscreen
    })
end

return useTagAsSponsoredAdViewabilityCandidate
