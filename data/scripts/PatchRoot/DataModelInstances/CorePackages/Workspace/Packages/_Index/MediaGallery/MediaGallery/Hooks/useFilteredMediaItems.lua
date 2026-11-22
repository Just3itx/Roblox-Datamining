-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local React = require(MediaGalleryParent.React)

local VideoUtils = require(MediaGalleryParent.VideoUtils)
local useCanDevicePlayVideoPreview = VideoUtils.useCanDevicePlayVideoPreview
local EdpVideoBlockingConfig = VideoUtils.EdpVideoBlockingConfig

local useIsVideoEligible = require(MediaGalleryParent.GameTile).useIsVideoEligible
local useAppPolicy = require(MediaGalleryParent.UniversalAppPolicy).useAppPolicy

local LoggingProtocol = require(MediaGalleryParent.LoggingProtocol)
local reportWarning = require(MediaGalleryParent.DiscoveryAnalytics).Points.reportWarning

local isYouTubeVideo = require(MediaGallery.isYouTubeVideo)
local isValidIdentifier = require(MediaGallery.isValidIdentifier)

local _MediaGalleryTypes = require(MediaGallery.MediaGalleryTypes)

local function useFilteredMediaItems(tbl1, str1: string, appPage: string)
    local var1 = useAppPolicy(function(arg1)
        return arg1.getShowVideoThumbnails()
    end)

    local var2 = useIsVideoEligible(str1)
    local var3 = not isValidIdentifier(str1) or var2

    local var4 = useCanDevicePlayVideoPreview(EdpVideoBlockingConfig, str1, appPage)

    return React.useMemo(function()
        local var5 = var4() and var3

        local bool1 = false
        for _, value in tbl1 do
            if isValidIdentifier(value.videoId) and not isYouTubeVideo(value.assetTypeId) then
                bool1 = true
                break
            end
        end

        local var6 = bool1 and var3

        local result = {}
        for _, value in tbl1 do
            if isYouTubeVideo(value.assetTypeId) then
                if not var6 and var1 then
                    table.insert(result, value)
                end
            elseif isValidIdentifier(value.videoId) then
                if var5 then
                    table.insert(result, value)
                end
            elseif not isValidIdentifier(value.imageId) then
                reportWarning(LoggingProtocol.default, "MediaGallery", "Dropping non-video MediaItem with invalid imageId", {
                    appPage = appPage,
                    assetTypeId = tostring(value.assetTypeId),
                    hasVideoId = tostring(isValidIdentifier(value.videoId)),
                    hasVideoHash = tostring(isValidIdentifier(value.videoHash)),
                    hasVideoTitle = tostring(not (value.videoTitle == nil) and value.videoTitle ~= "")
                })
            else
                table.insert(result, value)
            end
        end

        return result
    end, {
        tbl1,
        var1,
        var3,
        var4,
        appPage
    })
end

return useFilteredMediaItems
